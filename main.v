module main

import os
import datatypes
import wayland { Listener, Wl_seat_capability }
import wlr
import wlr.util { Wlr_edges }
import wlr.render
import wlr.types { Wlr_keyboard_modifier }
import xkb

enum CursorMode {
	passthrough
	move
	resize
}

@[heap]
pub struct Keyboard {
pub:
	wlr_keyboard &C.wlr_keyboard
pub mut:
	sr        &Server
	modifiers Listener
	key       Listener
	destroy   Listener
}

@[heap]
pub struct Output {
pub:
	wlr_output &C.wlr_output
pub mut:
	sr            &Server
	frame         Listener
	request_state Listener
	destroy       Listener
}

@[heap]
pub struct Toplevel {
pub:
	xdg_toplevel &C.wlr_xdg_toplevel
pub mut:
	sr                 &Server
	scene_tree         &C.wlr_scene_tree
	map                Listener
	unmap              Listener
	commit             Listener
	destroy            Listener
	request_move       Listener
	request_resize     Listener
	request_maximize   Listener
	request_fullscreen Listener
}

fn (toplevel &Toplevel) focus() {
	mut sr := toplevel.sr

	prev_surface := sr.seat.keyboard_state.focused_surface
	surface := toplevel.xdg_toplevel.base.surface
	unsafe { // v does not have a pointer compare so I need to do this
		if i64(prev_surface) - i64(surface) == 0 {
			return
		}
	}
	// deactivate previous surface
	if prev_surface != unsafe { nil } {
		prev_toplevel := C.wlr_xdg_toplevel_try_from_wlr_surface(prev_surface)
		if prev_toplevel != unsafe { nil } {
			C.wlr_xdg_toplevel_set_activated(prev_toplevel, false)
		}
	}

	// move toplevel to top
	C.wlr_scene_node_raise_to_top(&toplevel.scene_tree.node)
	if ix := sr.toplevels.index(toplevel) {
		sr.toplevels.delete(ix)
		sr.toplevels.push_front(toplevel)
	}

	C.wlr_xdg_toplevel_set_activated(toplevel.xdg_toplevel, true)

	// give keyboard focus to surface
	keyboard := C.wlr_seat_get_keyboard(sr.seat)
	if keyboard != unsafe { nil } {
		C.wlr_seat_keyboard_notify_enter(sr.seat, surface, keyboard.keycodes, keyboard.num_keycodes,
			&keyboard.modifiers)
	}
}

@[heap]
pub struct Popup {
pub:
	xdg_popup &C.wlr_xdg_popup
pub mut:
	commit  Listener
	destroy Listener
}

@[heap; noinit]
pub struct Server {
pub:
	display      &C.wl_display
	backend      &C.wlr_backend
	renderer     &C.wlr_renderer
	allocator    &C.wlr_allocator
	scene        &C.wlr_scene
	scene_layout &C.wlr_scene_output_layout

	output_layout &C.wlr_output_layout

	xdg_shell &C.wlr_xdg_shell

	cursor     &C.wlr_cursor
	cursor_mgr &C.wlr_xcursor_manager

	seat &C.wlr_seat
pub mut:
	outputs    datatypes.DoublyLinkedList[&Output] = datatypes.DoublyLinkedList[&Output]{}
	new_output Listener
	new_input  Listener

	toplevels        datatypes.DoublyLinkedList[&Toplevel] = datatypes.DoublyLinkedList[&Toplevel]{}
	new_xdg_toplevel Listener
	new_xdg_popup    Listener

	grabbed_toplevel ?&Toplevel

	cursor_mode            CursorMode = .passthrough
	cursor_motion          Listener
	cursor_motion_absolute Listener
	cursor_button          Listener
	cursor_axis            Listener
	cursor_frame           Listener

	request_cursor        Listener
	pointer_focus_change  Listener
	request_set_selection Listener
	grab_x                f64
	grab_y                f64
	grab_geobox           C.wlr_box
	resize_edges          u32

	keyboards datatypes.DoublyLinkedList[&Keyboard] = datatypes.DoublyLinkedList[&Keyboard]{}
}

fn Server.new() &Server {
	display := C.wl_display_create()
	backend := C.wlr_backend_autocreate(C.wl_display_get_event_loop(display), unsafe { nil })
	renderer := C.wlr_renderer_autocreate(backend)
	allocator := C.wlr_allocator_autocreate(backend, renderer)

	C.wlr_renderer_init_wl_display(renderer, display)

	C.wlr_compositor_create(display, 5, renderer)
	C.wlr_subcompositor_create(display)
	C.wlr_data_device_manager_create(display)

	mut output_layout := C.wlr_output_layout_create(display)
	scene := C.wlr_scene_create()
	scene_layout := C.wlr_scene_attach_output_layout(scene, output_layout)

	xdg_shell := C.wlr_xdg_shell_create(display, 3)

	cursor := C.wlr_cursor_create()
	C.wlr_cursor_attach_output_layout(cursor, output_layout)
	xcursor_mgr := C.wlr_xcursor_manager_create(unsafe { nil }, 24)
	C.wlr_xcursor_manager_load(xcursor_mgr, 1.0)

	seat := C.wlr_seat_create(display, c'seat0')
	C.wlr_seat_set_capabilities(seat, u32(Wl_seat_capability.pointer))
	C.wlr_seat_pointer_clear_focus(seat)

	mut sr := &Server{
		display:       display
		backend:       backend
		renderer:      renderer
		allocator:     allocator
		output_layout: output_layout
		scene:         scene
		scene_layout:  scene_layout
		xdg_shell:     xdg_shell
		cursor:        cursor
		cursor_mgr:    xcursor_mgr
		seat:          seat
	}

	// backend listeners
	sr.new_output = Listener.new(fn [mut sr] (listener &C.wl_listener, data voidptr) {
		wlr_output := unsafe { &C.wlr_output(data) }

		C.wlr_output_init_render(wlr_output, sr.allocator, sr.renderer)

		mut state := C.wlr_output_state{}
		C.wlr_output_state_init(&state)
		C.wlr_output_state_set_enabled(&state, true)

		mode := C.wlr_output_preferred_mode(wlr_output)
		if mode != unsafe { nil } {
			C.wlr_output_state_set_mode(&state, mode)
		}

		C.wlr_output_commit_state(wlr_output, &state)
		C.wlr_output_state_finish(&state)

		mut outr := &Output{ wlr_output: wlr_output, sr: sr }
		sr.outputs.push_back(outr)

		// xdg_output listeners
		outr.frame = Listener.new(fn [sr, wlr_output] (listener &C.wl_listener, data voidptr) {
			scene_output := C.wlr_scene_get_scene_output(sr.scene, wlr_output)

			C.wlr_scene_output_commit(scene_output, unsafe { nil })

			now := C.timespec{}
			C.clock_gettime(.monotonic, &now)
			C.wlr_scene_output_send_frame_done(scene_output, &now)
		}, &wlr_output.events.frame)

		outr.request_state = Listener.new(fn [wlr_output] (listener &C.wl_listener, data voidptr) {
			event := unsafe { &C.wlr_output_event_request_state(data) }
			C.wlr_output_commit_state(wlr_output, event.state)
		}, &wlr_output.events.request_state)

		outr.destroy = Listener.new(fn [outr, mut sr] (listener &C.wl_listener, data voidptr) {
			outr.frame.destroy()
			outr.request_state.destroy()
			outr.destroy.destroy()

			if ix := sr.outputs.index(outr) {
				sr.outputs.delete(ix)
			}
		}, &wlr_output.events.destroy)

		l_output := C.wlr_output_layout_add_auto(sr.output_layout, wlr_output)
		scene_output := C.wlr_scene_output_create(sr.scene, wlr_output)
		C.wlr_scene_output_layout_add_output(sr.scene_layout, l_output, scene_output)
	}, &backend.events.new_output)

	sr.new_input = Listener.new(fn [mut sr] (listener &C.wl_listener, data voidptr) {
		device := unsafe { &C.wlr_input_device(data) }
		match device.type {
			.keyboard {
				wlr_keyboard := C.wlr_keyboard_from_input_device(device)

				mut kr := &Keyboard{
					wlr_keyboard: wlr_keyboard
					sr:           sr
				}

				// setup keymap for keyboard
				mut context := C.xkb_context_new(.no_flags)
				keymap := C.xkb_keymap_new_from_names(context, unsafe { nil }, .no_flags)

				C.wlr_keyboard_set_keymap(wlr_keyboard, keymap)
				C.xkb_keymap_unref(keymap)
				C.xkb_context_unref(context)
				C.wlr_keyboard_set_repeat_info(wlr_keyboard, 25, 600)

				// keyboard listeners
				kr.modifiers = Listener.new(fn [sr, kr] (listener &C.wl_listener, data voidptr) {
					C.wlr_seat_set_keyboard(sr.seat, kr.wlr_keyboard)
					C.wlr_seat_keyboard_notify_modifiers(sr.seat, &kr.wlr_keyboard.modifiers)
				}, &wlr_keyboard.events.modifiers)

				kr.key = Listener.new(fn [mut sr, kr] (listener &C.wl_listener, data voidptr) {
					mut event := unsafe { &C.wlr_keyboard_key_event(data) }

					keycode := event.keycode + 8
					syms := &u32(unsafe { nil })
					nsyms := C.xkb_state_key_get_syms(kr.wlr_keyboard.xkb_state, keycode,
						&syms)

					mut handled := false

					modifiers := C.wlr_keyboard_get_modifiers(kr.wlr_keyboard)
					if Wlr_keyboard_modifier.alt.matches(modifiers) && event.state == .pressed {
						for i := 0; i < nsyms; i++ {
							handled = sr.handle_keybinding(unsafe { xkb.Keysym(syms[i]) })
						}
					}

					if !handled {
						C.wlr_seat_set_keyboard(sr.seat, kr.wlr_keyboard)
						C.wlr_seat_keyboard_notify_key(sr.seat, event.time_msec, event.keycode,
							u32(event.state))
					}
				}, &wlr_keyboard.events.key)

				kr.destroy = Listener.new(fn [mut sr, mut kr] (listener &C.wl_listener, data voidptr) {
					kr.modifiers.destroy()
					kr.key.destroy()
					kr.destroy.destroy()

					if ix := sr.keyboards.index(kr) {
						sr.keyboards.delete(ix)
					}
				}, &wlr_keyboard.base.events.destroy)

				sr.keyboards.push_back(kr)
			}
			.pointer {
				C.wlr_cursor_attach_input_device(sr.cursor, device)
			}
			else {}
		}

		caps := if sr.keyboards.len > 0 {
			Wl_seat_capability.combine(.keyboard, .pointer)
		} else {
			u32(Wl_seat_capability.pointer)
		}

		C.wlr_seat_set_capabilities(sr.seat, caps)
	}, &backend.events.new_input)

	// xdg_shell listeners
	sr.new_xdg_toplevel = Listener.new(fn [mut sr] (listener &C.wl_listener, data voidptr) {
		mut xdg_toplevel := unsafe { &C.wlr_xdg_toplevel(data) }

		mut tlr := &Toplevel{
			sr:           sr
			xdg_toplevel: xdg_toplevel
			scene_tree:   C.wlr_scene_xdg_surface_create(&sr.scene.tree, xdg_toplevel.base)
		}
		tlr.scene_tree.node.data = tlr
		xdg_toplevel.base.data = tlr.scene_tree

		// toplevel listeners
		tlr.map = Listener.new(fn [mut sr, mut tlr] (listener &C.wl_listener, data voidptr) {
			sr.toplevels.push_back(tlr)

			tlr.focus()
		}, &xdg_toplevel.base.surface.events.map)

		tlr.unmap = Listener.new(fn [mut sr, mut tlr] (listener &C.wl_listener, data voidptr) {
			if grabbed := sr.grabbed_toplevel {
				if tlr == grabbed {
					sr.reset_cursor_mode()
				}
			}

			if ix := sr.toplevels.index(tlr) {
				sr.toplevels.delete(ix)
			}
		}, &xdg_toplevel.base.surface.events.unmap)

		tlr.commit = Listener.new(fn [mut tlr] (listener &C.wl_listener, data voidptr) {
			if tlr.xdg_toplevel.base.initial_commit {
				C.wlr_xdg_toplevel_set_size(tlr.xdg_toplevel, 0, 0)
			}
		}, &xdg_toplevel.base.surface.events.commit)

		tlr.destroy = Listener.new(fn [mut sr, mut tlr] (listener &C.wl_listener, data voidptr) {
			tlr.map.destroy()
			tlr.unmap.destroy()
			tlr.commit.destroy()
			tlr.destroy.destroy()
			tlr.request_move.destroy()
			tlr.request_resize.destroy()
			tlr.request_maximize.destroy()
			tlr.request_fullscreen.destroy()
			free(tlr)
		}, &xdg_toplevel.events.destroy)

		tlr.request_move = Listener.new(fn [mut sr, mut tlr] (listener &C.wl_listener, data voidptr) {
			sr.begin_interactive(tlr, .move, 0)
		}, &xdg_toplevel.events.request_move)

		tlr.request_resize = Listener.new(fn [mut sr, mut tlr] (listener &C.wl_listener, data voidptr) {
			event := unsafe { &C.wlr_xdg_toplevel_resize_event(data) }
			sr.begin_interactive(tlr, .resize, event.edges)
		}, &xdg_toplevel.events.request_resize)

		tlr.request_maximize = Listener.new(fn [mut tlr] (listener &C.wl_listener, data voidptr) {
			if tlr.xdg_toplevel.base.initialized {
				C.wlr_xdg_surface_schedule_configure(tlr.xdg_toplevel.base)
			}
		}, &xdg_toplevel.events.request_maximize)

		tlr.request_fullscreen = Listener.new(fn [mut tlr] (listener &C.wl_listener, data voidptr) {
			if tlr.xdg_toplevel.base.initialized {
				C.wlr_xdg_surface_schedule_configure(tlr.xdg_toplevel.base)
			}
		}, &xdg_toplevel.events.request_fullscreen)
	}, &xdg_shell.events.new_toplevel)

	sr.new_xdg_popup = Listener.new(fn [mut sr] (listener &C.wl_listener, data voidptr) {
		mut xdg_popup := unsafe { &C.wlr_xdg_popup(data) }

		parent := C.wlr_xdg_surface_try_from_wlr_surface(xdg_popup.parent)
		if parent == unsafe { nil } {
			panic('popup parent is nil')
		}

		parent_tree := unsafe { &C.wlr_scene_tree(parent.data) }
		xdg_popup.base.data = C.wlr_scene_xdg_surface_create(parent_tree, xdg_popup.base)

		mut pr := &Popup{
			xdg_popup: xdg_popup
		}

		pr.commit = Listener.new(fn [mut pr] (listener &C.wl_listener, data voidptr) {
			if pr.xdg_popup.base.initial_commit {
				C.wlr_xdg_surface_schedule_configure(pr.xdg_popup.base)
			}
		}, &xdg_popup.base.surface.events.commit)

		pr.destroy = Listener.new(fn [mut pr] (listener &C.wl_listener, data voidptr) {
			pr.commit.destroy()
			pr.destroy.destroy()
		}, &xdg_popup.events.destroy)
	}, &xdg_shell.events.new_popup)

	// cursor listeners
	sr.cursor_motion = Listener.new(fn [mut sr] (listener &C.wl_listener, data voidptr) {
		event := unsafe { &C.wlr_pointer_motion_event(data) }

		C.wlr_cursor_move(sr.cursor, &event.pointer.base, event.delta_x, event.delta_y)
		sr.process_cursor_motion(event.time_msec)
	}, &sr.cursor.events.motion)

	sr.cursor_motion_absolute = Listener.new(fn [mut sr] (listener &C.wl_listener, data voidptr) {
		event := unsafe { &C.wlr_pointer_motion_absolute_event(data) }

		C.wlr_cursor_warp_absolute(sr.cursor, &event.pointer.base, event.x, event.y)
		sr.process_cursor_motion(event.time_msec)
	}, &sr.cursor.events.motion_absolute)

	sr.cursor_button = Listener.new(fn [mut sr] (listener &C.wl_listener, data voidptr) {
		event := unsafe { &C.wlr_pointer_button_event(data) }

		C.wlr_seat_pointer_notify_button(sr.seat, event.time_msec, event.button, event.state)
		if event.state == .released {
			sr.reset_cursor_mode()
		} else {
			if node, _, _ := sr.scene_node_at(sr.cursor.x, sr.cursor.y) {
				if mut toplevel := sr.scene_node_get_toplevel(node) {
					toplevel.focus()
				}
			}
		}
	}, &sr.cursor.events.button)

	sr.cursor_axis = Listener.new(fn [mut sr] (listener &C.wl_listener, data voidptr) {
		event := unsafe { &C.wlr_pointer_axis_event(data) }
		C.wlr_seat_pointer_notify_axis(sr.seat, event.time_msec, event.orientation, event.delta,
			event.delta_discrete, event.source, event.relative_direction)
	}, &sr.cursor.events.axis)

	sr.cursor_frame = Listener.new(fn [mut sr] (listener &C.wl_listener, data voidptr) {
		C.wlr_seat_pointer_notify_frame(sr.seat)
	}, &sr.cursor.events.frame)

	// seat listeners
	sr.request_cursor = Listener.new(fn [mut sr] (listener &C.wl_listener, data voidptr) {
		event := unsafe { &C.wlr_seat_pointer_request_set_cursor_event(data) }

		focused_client := sr.seat.pointer_state.focused_client
		if focused_client == event.seat_client {
			C.wlr_cursor_set_surface(sr.cursor, event.surface, event.hotspot_x, event.hotspot_y)
		}
	}, &sr.seat.events.request_set_cursor)

	sr.pointer_focus_change = Listener.new(fn [mut sr] (listener &C.wl_listener, data voidptr) {
		event := unsafe { &C.wlr_seat_pointer_focus_change_event(data) }
		if event.new_surface == unsafe { nil } {
			C.wlr_cursor_set_xcursor(sr.cursor, sr.cursor_mgr, c'default')
		}
	}, &sr.seat.pointer_state.events.focus_change)

	sr.request_set_selection = Listener.new(fn [mut sr] (listener &C.wl_listener, data voidptr) {
		event := unsafe { &C.wlr_seat_request_set_selection_event(data) }

		C.wlr_seat_set_selection(sr.seat, event.source, event.serial)
	}, &sr.seat.events.request_set_selection)

	return sr
}

fn (mut server Server) begin_interactive(toplevel &Toplevel, cursor_mode CursorMode, resize_edges u32) {
	server.grabbed_toplevel = toplevel
	server.cursor_mode = cursor_mode
	if cursor_mode == .move {
		server.grab_x = server.cursor.x - toplevel.scene_tree.node.x
		server.grab_y = server.cursor.y - toplevel.scene_tree.node.y
	} else {
		geo_box := toplevel.xdg_toplevel.base.geometry

		ox := if Wlr_edges.right.matches(resize_edges) { geo_box.width } else { 0 }
		border_x := toplevel.scene_tree.node.x + geo_box.x + ox

		oy := if Wlr_edges.bottom.matches(resize_edges) { geo_box.height } else { 0 }
		border_y := toplevel.scene_tree.node.y + geo_box.y + oy

		server.grab_x = server.cursor.x - border_x
		server.grab_y = server.cursor.y - border_y

		server.grab_geobox = geo_box
		server.grab_geobox.x += toplevel.scene_tree.node.x
		server.grab_geobox.y += toplevel.scene_tree.node.y
		server.resize_edges = resize_edges
	}
}

fn (mut server Server) handle_keybinding(sym xkb.Keysym) bool {
	match sym {
		.escape {
			C.wl_display_terminate(server.display)
		}
		else {
			return false
		}
	}
	return true
}

fn (mut server Server) reset_cursor_mode() {
	server.cursor_mode = .passthrough
	server.grabbed_toplevel = none
}

fn (server Server) scene_node_at(lx f64, ly f64) ?(&C.wlr_scene_node, f64, f64) {
	mut sx := f64(0)
	mut sy := f64(0)
	node := C.wlr_scene_node_at(&server.scene.tree.node, lx, ly, &sx, &sy)
	if node == unsafe { nil } || node.type != .buffer {
		return none
	}
	return node, sx, sy
}

fn (server Server) scene_node_get_surface(node &C.wlr_scene_node) ?&C.wlr_surface {
	if node.type != .buffer {
		return none
	}
	scene_buffer := C.wlr_scene_buffer_from_node(node)
	scene_surface := C.wlr_scene_surface_try_from_buffer(scene_buffer)
	if scene_surface == unsafe { nil } {
		return none
	}

	surface := scene_surface.surface

	if surface.resource == unsafe { nil } {
		return none
	}

	return surface
}

fn (server Server) scene_node_get_toplevel(node &C.wlr_scene_node) ?&Toplevel {
	mut tree := node.parent
	for tree != unsafe { nil } && tree.node.data == unsafe { nil } {
		tree = tree.node.parent
	}

	if tree.node.data == unsafe { nil } {
		return none
	}

	data_ptr := tree.node.data
	if usize(data_ptr) < 4096 {
		return none
	}

	return unsafe { &Toplevel(data_ptr) }
}

fn (mut server Server) process_cursor_motion(time u32) {
	match server.cursor_mode {
		.move {
			if toplevel := server.grabbed_toplevel {
				C.wlr_scene_node_set_position(&toplevel.scene_tree.node, server.cursor.x - server.grab_x,
					server.cursor.y - server.grab_y)
			}
		}
		.resize {
			if toplevel := server.grabbed_toplevel {
				border_x := server.cursor.x - server.grab_x
				border_y := server.cursor.y - server.grab_y
				mut new_left := server.grab_geobox.x
				mut new_right := server.grab_geobox.x + server.grab_geobox.width
				mut new_top := server.grab_geobox.y
				mut new_bottom := server.grab_geobox.y + server.grab_geobox.height

				if Wlr_edges.top.matches(server.resize_edges) {
					new_top = int(border_y)
					if new_top >= new_bottom {
						new_top = new_bottom - 1
					}
				} else if Wlr_edges.bottom.matches(server.resize_edges) {
					new_bottom = int(border_y) + 1
					if new_bottom <= new_top {
						new_bottom = new_top + 1
					}
				}

				if Wlr_edges.left.matches(server.resize_edges) {
					new_left = int(border_x)
					if new_left >= new_right {
						new_left = new_right - 1
					}
				} else if Wlr_edges.right.matches(server.resize_edges) {
					new_right = int(border_x)
					if new_right <= new_left {
						new_right = new_left + 1
					}
				}

				geo_box := &toplevel.xdg_toplevel.base.geometry
				C.wlr_scene_node_set_position(&toplevel.scene_tree.node, new_left - geo_box.x,
					new_top - geo_box.y)
				C.wlr_xdg_toplevel_set_size(toplevel.xdg_toplevel, new_right - new_left,
					new_bottom - new_top)
			}
		}
		else {
			if node, sx, sy := server.scene_node_at(server.cursor.x, server.cursor.y) {
				if server.scene_node_get_toplevel(node) == none {
					C.wlr_cursor_set_xcursor(server.cursor, server.cursor_mgr, c'default')
				}

				if surface := server.scene_node_get_surface(node) {
					C.wlr_seat_pointer_notify_enter(server.seat, surface, sx, sy)
					C.wlr_seat_pointer_notify_motion(server.seat, time, sx, sy)
					return
				}
			}

			C.wlr_seat_pointer_clear_focus(server.seat)
		}
	}
}

fn (server Server) run() int {
	socket := C.wl_display_add_socket_auto(server.display)
	if socket == unsafe { nil } {
		C.wlr_backend_destroy(server.backend)
		return 1
	}

	if !C.wlr_backend_start(server.backend) {
		C.wlr_backend_destroy(server.backend)
		C.wl_display_destroy(server.display)
		return 1
	}

	os.setenv('WAYLAND_DISPLAY', unsafe { socket.vstring() }, true)

	if os.fork() == 0 {
		os.execute('foot')
	}

	C.wl_display_run(server.display)
	return 0
}

fn (server Server) destroy() {
	C.wl_display_destroy_clients(server.display)

	server.new_xdg_toplevel.destroy()
	server.new_xdg_popup.destroy()

	server.cursor_motion.destroy()
	server.cursor_motion_absolute.destroy()
	server.cursor_button.destroy()
	server.cursor_axis.destroy()
	server.cursor_frame.destroy()

	server.new_input.destroy()
	server.request_cursor.destroy()
	server.pointer_focus_change.destroy()
	server.request_set_selection.destroy()

	server.new_output.destroy()

	C.wlr_scene_node_destroy(&server.scene.tree.node)

	C.wlr_xcursor_manager_destroy(server.cursor_mgr)
	C.wlr_cursor_destroy(server.cursor)

	C.wlr_allocator_destroy(server.allocator)
	C.wlr_renderer_destroy(server.renderer)
	C.wlr_backend_destroy(server.backend)
	C.wl_display_destroy(server.display)
}

fn main() {
	C.wlr_log_init(.debug, unsafe { nil })

	server := Server.new()
	code := server.run()
	if code != 0 {
		exit(code)
	}
	server.destroy()
}
