module src

import os
import ctime
import datatypes
import wl { Listener, Wl_seat_capability }
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

pub fn Server.new() &Server {
	display := C.wl_display_create()
	backend := C.wlr_backend_autocreate(C.wl_display_get_event_loop(display), unsafe { nil })
	renderer := C.wlr_renderer_autocreate(backend)
	allocator := C.wlr_allocator_autocreate(backend, renderer)

	C.wlr_renderer_init_wl_display(renderer, display)

	C.wlr_compositor_create(display, 5, renderer)
	C.wlr_subcompositor_create(display)
	C.wlr_data_device_manager_create(display)
	C.wlr_viewporter_create(display)

	mut output_layout := C.wlr_output_layout_create(display)
	scene := C.wlr_scene_create()
	scene_layout := C.wlr_scene_attach_output_layout(scene, output_layout)

	xdg_shell := C.wlr_xdg_shell_create(display, 3)

	cursor := C.wlr_cursor_create()
	C.wlr_cursor_attach_output_layout(cursor, output_layout)
	xcursor_mgr := C.wlr_xcursor_manager_create(unsafe { nil }, 24)

	seat := C.wlr_seat_create(display, c'seat0')

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
	sr.new_output = Listener.new(fn [mut sr] (_ &C.wl_listener, wlr_output &C.wlr_output) {
		C.wlr_output_init_render(wlr_output, sr.allocator, sr.renderer)

		mut state := C.wlr_output_state{}
		C.wlr_output_state_init(&state)
		C.wlr_output_state_set_enabled(&state, true)

		mode := C.wlr_output_preferred_mode(wlr_output)
		if !is_nullptr(mode) {
			C.wlr_output_state_set_mode(&state, mode)
		}

		C.wlr_output_commit_state(wlr_output, &state)
		C.wlr_output_state_finish(&state)

		mut outr := &Output{ wlr_output: wlr_output, sr: sr }
		outr.wlr_output.data = outr
		sr.outputs.push_back(outr)

		// xdg_output listeners
		outr.frame = Listener.new(fn [sr, wlr_output] (_ &C.wl_listener, _ voidptr) {
			scene_output := C.wlr_scene_get_scene_output(sr.scene, wlr_output)

			C.wlr_scene_output_commit(scene_output, unsafe { nil })

			now := C.timespec{}
			C.clock_gettime(.monotonic, &now)
			C.wlr_scene_output_send_frame_done(scene_output, &now)
		}, &wlr_output.events.frame)

		outr.request_state = Listener.new(fn [wlr_output] (_ &C.wl_listener, event &C.wlr_output_event_request_state) {
			C.wlr_output_commit_state(wlr_output, event.state)
		}, &wlr_output.events.request_state)

		outr.destroy = Listener.new(fn [outr, mut sr] (_ &C.wl_listener, _ voidptr) {
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
	}, &sr.backend.events.new_output)

	sr.new_input = Listener.new(fn [mut sr] (_ &C.wl_listener, device &C.wlr_input_device) {
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
				kr.modifiers = Listener.new(fn [sr, kr] (_ &C.wl_listener, _ voidptr) {
					C.wlr_seat_set_keyboard(sr.seat, kr.wlr_keyboard)
					C.wlr_seat_keyboard_notify_modifiers(sr.seat, &kr.wlr_keyboard.modifiers)
				}, &wlr_keyboard.events.modifiers)

				kr.key = Listener.new(fn [mut sr, kr] (_ &C.wl_listener, event &C.wlr_keyboard_key_event) {
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

				kr.destroy = Listener.new(fn [mut sr, mut kr] (_ &C.wl_listener, _ voidptr) {
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
	}, &sr.backend.events.new_input)

	// xdg_shell listeners
	sr.new_xdg_toplevel = Listener.new(fn [mut sr] (_ &C.wl_listener, mut xdg_toplevel &C.wlr_xdg_toplevel) {
		mut tlr := &Toplevel{
			sr:           sr
			xdg_toplevel: xdg_toplevel
			scene_tree:   C.wlr_scene_xdg_surface_create(&sr.scene.tree, xdg_toplevel.base)
		}
		tlr.scene_tree.node.data = tlr
		xdg_toplevel.base.data = tlr.scene_tree

		// toplevel listeners
		tlr.map = Listener.new(fn [mut sr, mut tlr] (_ &C.wl_listener, _ voidptr) {
			sr.toplevels.push_back(tlr)

			tlr.focus()
		}, &xdg_toplevel.base.surface.events.map)

		tlr.unmap = Listener.new(fn [mut sr, mut tlr] (_ &C.wl_listener, _ voidptr) {
			if grabbed := sr.grabbed_toplevel {
				if tlr == grabbed {
					sr.reset_cursor_mode()
				}
			}

			if ix := sr.toplevels.index(tlr) {
				sr.toplevels.delete(ix)
			}
		}, &xdg_toplevel.base.surface.events.unmap)

		tlr.commit = Listener.new(fn [mut tlr] (_ &C.wl_listener, _ voidptr) {
			if tlr.xdg_toplevel.base.initial_commit {
				C.wlr_xdg_toplevel_set_size(tlr.xdg_toplevel, 0, 0)
			}
		}, &xdg_toplevel.base.surface.events.commit)

		tlr.destroy = Listener.new(fn [mut tlr] (_ &C.wl_listener, _ voidptr) {
			tlr.map.destroy()
			tlr.unmap.destroy()
			tlr.commit.destroy()
			tlr.destroy.destroy()
			tlr.request_move.destroy()
			tlr.request_resize.destroy()
			tlr.request_maximize.destroy()
			tlr.request_fullscreen.destroy()
		}, &xdg_toplevel.events.destroy)

		tlr.request_move = Listener.new(fn [mut sr, mut tlr] (_ &C.wl_listener, _ voidptr) {
			sr.begin_interactive(mut tlr, .move, 0)
		}, &xdg_toplevel.events.request_move)

		tlr.request_resize = Listener.new(fn [mut sr, mut tlr] (_ &C.wl_listener, event &C.wlr_xdg_toplevel_resize_event) {
			sr.begin_interactive(mut tlr, .resize, event.edges)
		}, &xdg_toplevel.events.request_resize)

		tlr.request_maximize = Listener.new(fn [mut tlr] (_ &C.wl_listener, _ voidptr) {
			tlr.maximize(tlr.xdg_toplevel.requested.maximized)
		}, &xdg_toplevel.events.request_maximize)

		tlr.request_fullscreen = Listener.new(fn [mut tlr] (_ &C.wl_listener, _ voidptr) {
			if tlr.xdg_toplevel.base.initialized {
				C.wlr_xdg_surface_schedule_configure(tlr.xdg_toplevel.base)
			}
		}, &xdg_toplevel.events.request_fullscreen)
	}, &xdg_shell.events.new_toplevel)

	sr.new_xdg_popup = Listener.new(fn (_ &C.wl_listener, mut xdg_popup &C.wlr_xdg_popup) {
		parent := C.wlr_xdg_surface_try_from_wlr_surface(xdg_popup.parent)
		if is_nullptr(parent) {
			panic('popup parent is nil')
		}

		parent_tree := unsafe { &C.wlr_scene_tree(parent.data) }
		xdg_popup.base.data = C.wlr_scene_xdg_surface_create(parent_tree, xdg_popup.base)

		mut pr := &Popup{
			xdg_popup: xdg_popup
		}

		pr.commit = Listener.new(fn [mut pr] (_ &C.wl_listener, _ voidptr) {
			if pr.xdg_popup.base.initial_commit {
				C.wlr_xdg_surface_schedule_configure(pr.xdg_popup.base)
			}
		}, &xdg_popup.base.surface.events.commit)

		pr.destroy = Listener.new(fn [mut pr] (_ &C.wl_listener, _ voidptr) {
			pr.commit.destroy()
			pr.destroy.destroy()
		}, &xdg_popup.events.destroy)
	}, &xdg_shell.events.new_popup)

	// cursor listeners
	sr.cursor_motion = Listener.new(fn [mut sr] (_ &C.wl_listener, event &C.wlr_pointer_motion_event) {
		C.wlr_cursor_move(sr.cursor, &event.pointer.base, event.delta_x, event.delta_y)
		sr.process_cursor_motion(event.time_msec)
	}, &sr.cursor.events.motion)

	sr.cursor_motion_absolute = Listener.new(fn [mut sr] (_ &C.wl_listener, event &C.wlr_pointer_motion_absolute_event) {
		C.wlr_cursor_warp_absolute(sr.cursor, &event.pointer.base, event.x, event.y)
		sr.process_cursor_motion(event.time_msec)
	}, &sr.cursor.events.motion_absolute)

	sr.cursor_button = Listener.new(fn [mut sr] (_ &C.wl_listener, event &C.wlr_pointer_button_event) {
		C.wlr_seat_pointer_notify_button(sr.seat, event.time_msec, event.button, event.state)
		if event.state == .released {
			sr.reset_cursor_mode()
		} else {
			if node, _, _ := sr.scene_node_at(sr.cursor.x, sr.cursor.y) {
				if toplevel := sr.scene_node_get_toplevel(node) {
					toplevel.focus()
				}
			}
		}
	}, &sr.cursor.events.button)

	sr.cursor_axis = Listener.new(fn [mut sr] (_ &C.wl_listener, event &C.wlr_pointer_axis_event) {
		C.wlr_seat_pointer_notify_axis(sr.seat, event.time_msec, event.orientation, event.delta,
			event.delta_discrete, event.source, event.relative_direction)
	}, &sr.cursor.events.axis)

	sr.cursor_frame = Listener.new(fn [mut sr] (_ &C.wl_listener, _ voidptr) {
		C.wlr_seat_pointer_notify_frame(sr.seat)
	}, &sr.cursor.events.frame)

	// seat listeners
	sr.request_cursor = Listener.new(fn [mut sr] (_ &C.wl_listener, event &C.wlr_seat_pointer_request_set_cursor_event) {
		focused_client := sr.seat.pointer_state.focused_client
		if ptr_eq(focused_client, event.seat_client) {
			C.wlr_cursor_set_surface(sr.cursor, event.surface, event.hotspot_x, event.hotspot_y)
		}
	}, &sr.seat.events.request_set_cursor)

	sr.pointer_focus_change = Listener.new(fn [mut sr] (_ &C.wl_listener, event &C.wlr_seat_pointer_focus_change_event) {
		if is_nullptr(event.new_surface) {
			C.wlr_cursor_set_xcursor(sr.cursor, sr.cursor_mgr, c'default')
		}
	}, &sr.seat.pointer_state.events.focus_change)

	sr.request_set_selection = Listener.new(fn [mut sr] (_ &C.wl_listener, event &C.wlr_seat_request_set_selection_event) {
		C.wlr_seat_set_selection(sr.seat, event.source, event.serial)
	}, &sr.seat.events.request_set_selection)

	return sr
}

fn (mut server Server) begin_interactive(mut toplevel Toplevel, cursor_mode CursorMode, resize_edges u32) {
	server.grabbed_toplevel = toplevel
	server.cursor_mode = cursor_mode
	if cursor_mode == .move {
		if toplevel.maximized {
			toplevel.saved_geometry.y = int(server.cursor.y)
			toplevel.saved_geometry.x = int(server.cursor.x - (f32(toplevel.saved_geometry.width) / 2.0))
			toplevel.maximize(false)
		}

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
	if is_nullptr(node) || node.type != .buffer {
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
	if is_nullptr(scene_surface) {
		return none
	}

	surface := scene_surface.surface

	if is_nullptr(surface.resource) {
		return none
	}

	return surface
}

fn (server Server) scene_node_get_toplevel(node &C.wlr_scene_node) ?&Toplevel {
	mut tree := node.parent
	for !is_nullptr(tree) && is_nullptr(tree.node.data) {
		tree = tree.node.parent
	}

	if is_nullptr(tree.node.data) {
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
				new_width := new_right - new_left
				new_height := new_bottom - new_top

				new_x := if Wlr_edges.left.matches(server.resize_edges) {
					(new_left - geo_box.x) - (geo_box.width - new_width)
				} else {
					new_left - geo_box.x
				}
				new_y := if Wlr_edges.top.matches(server.resize_edges) {
					(new_top - geo_box.y) - (geo_box.height - new_height)
				} else {
					new_top - geo_box.y
				}

				C.wlr_scene_node_set_position(&toplevel.scene_tree.node, new_x, new_y)
				C.wlr_xdg_toplevel_set_size(toplevel.xdg_toplevel, new_width, new_height)
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

fn (server Server) output_at(x f64, y f64) ?&Output {
	wlr_output := C.wlr_output_layout_output_at(server.output_layout, x, y)
	if is_nullptr(wlr_output) {
		return none
	}

	return unsafe { &Output(wlr_output.data) }
}

fn (server Server) focused_output() ?&Output {
	return server.output_at(server.cursor.x, server.cursor.y)
}

pub fn (server Server) run(startup_cmd string) int {
	socket := C.wl_display_add_socket_auto(server.display)
	if is_nullptr(socket) {
		eprintln('failed to add socket')
		C.wlr_backend_destroy(server.backend)
		return 1
	}
	socket_str := unsafe { socket.vstring() }

	if !C.wlr_backend_start(server.backend) {
		eprintln('failed to start backend')
		C.wlr_backend_destroy(server.backend)
		C.wl_display_destroy(server.display)
		return 1
	}

	os.setenv('WAYLAND_DISPLAY', socket_str, true)

	if os.fork() == 0 {
		if startup_cmd.len > 0 {
			println('running startup command: ${startup_cmd}')
			os.execute(startup_cmd)
		}
		exit(0)
	}

	println('running wayland compositor on WAYLAND_DISPLAY=${socket_str}')
	C.wl_display_run(server.display)
	return 0
}

pub fn (server Server) destroy() {
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
