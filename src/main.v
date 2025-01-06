module main

import wlr

enum Comp_cursor_mode {
	passthrough
	move
	resize
}

@[heap]
struct Comp_server {
mut:
	wl_display   &C.wl_display              = unsafe { nil }
	backend      &C.wlr_backend             = unsafe { nil }
	renderer     &C.wlr_renderer            = unsafe { nil }
	allocator    &C.wlr_allocator           = unsafe { nil }
	scene        &C.wlr_scene               = unsafe { nil }
	scene_layout &C.wlr_scene_output_layout = unsafe { nil }

	xdg_shell        &C.wlr_xdg_shell = unsafe { nil }
	new_xdg_toplevel C.wl_listener
	new_xdg_popup    C.wl_listener
	toplevels        C.wl_list

	cursor                 &C.wlr_cursor          = unsafe { nil }
	cursor_mgr             &C.wlr_xcursor_manager = unsafe { nil }
	cursor_motion          C.wl_listener
	cursor_motion_absolute C.wl_listener
	cursor_button          C.wl_listener
	cursor_axis            C.wl_listener
	cursor_frame           C.wl_listener

	seat                  &C.wlr_seat = unsafe { nil }
	new_input             C.wl_listener
	request_cursor        C.wl_listener
	request_set_selection C.wl_listener
	keyboards             C.wl_list
	cursor_mode           Comp_cursor_mode
	grabbed_toplevel      &Comp_toplevel = unsafe { nil }
	grab_x                f64
	grab_y                f64
	grab_geobox           C.wlr_box
	resize_edges          u32

	output_layout &C.wlr_output_layout = unsafe { nil }
	outputs       C.wl_list
	new_output    C.wl_listener
}

struct Comp_output {
	link          C.wl_list
	server        &Comp_server
	wlr_output    &C.wlr_output
	frame         C.wl_listener
	request_state C.wl_listener
	destroy       C.wl_listener
}

struct Comp_toplevel {
	link         C.wl_list
	server       &Comp_server
	xdg_toplevel &C.wlr_xdg_toplevel
	scene_tree   &C.wlr_scene_tree

	map                C.wl_listener
	unmap              C.wl_listener
	commit             C.wl_listener
	destroy            C.wl_listener
	request_move       C.wl_listener
	request_resize     C.wl_listener
	request_maximize   C.wl_listener
	request_fullscreen C.wl_listener
}

pub struct Comp_popup {
	xdg_popup &C.wlr_xdg_popup
mut:
	commit  C.wl_listener
	destroy C.wl_listener
}

struct Comp_keyboard {
	link   C.wl_list
	server &Comp_server
	device &C.wlr_input_device

	modifiers C.wl_listener
	key       C.wl_listener
	destroy   C.wl_listener
}

fn focus_toplevel(toplevel &Comp_toplevel) {
	if toplevel == unsafe { nil } {
		return
	}

	server := toplevel.server
	seat := server.seat
	prev_surface := seat.keyboard_state.focused_surface
	surface := toplevel.xdg_toplevel.base.surface

	if prev_surface == surface {
		return
	}

	if prev_surface != unsafe { nil } {
		prev_toplevel := C.wlr_xdg_toplevel_try_from_wlr_surface(prev_surface)
		if prev_toplevel != unsafe { nil } {
			C.wlr_xdg_toplevel_set_activated(prev_toplevel, false)
		}
	}

	keyboard := C.wlr_seat_get_keyboard(seat)

	C.wlr_scene_node_raise_to_top(&toplevel.scene_tree.node)
	C.wl_list_remove(&toplevel.link)
	C.wl_list_insert(&server.toplevels, &toplevel.link)
	C.wlr_xdg_toplevel_set_activated(toplevel.xdg_toplevel, true)

	if keyboard != unsafe { nil } {
		C.wlr_seat_keyboard_notify_enter(seat, surface, keyboard.keycodes, keyboard.num_keycodes,
			&keyboard.modifiers)
	}
}

fn (server Comp_server) desktop_toplevel_at(lx f64, ly f64, mut surface C.wlr_surface, sx &f64, sy &f64) ?&Comp_toplevel {
	node := C.wlr_scene_node_at(&server.scene.tree.node, lx, ly, sx, sy)
	if node == unsafe { nil } || node.type != wlr.Scene_node_type.buffer {
		return none
	}

	scene_buffer := C.wlr_scene_buffer_from_node(node)
	scene_surface := C.wlr_scene_surface_try_from_buffer(scene_buffer)
	if scene_surface == unsafe { nil } {
		return none
	}

	unsafe {
		*surface = scene_surface.surface
	}
	mut tree := node.parent
	for tree != unsafe { nil } && tree.node.data == unsafe { nil } {
		tree = tree.node.parent
	}

	return tree.node.data
}

fn (mut server Comp_server) reset_cursor_mode() {
	server.cursor_mode = .passthrough
	server.grabbed_toplevel = unsafe { nil }
}

fn (server Comp_server) process_cursor_move() {
	toplevel := server.grabbed_toplevel
	C.wlr_scene_node_set_position(&toplevel.scene_tree.node, server.cursor.x - server.grab_x,
		server.cursor.y - server.grab_y)
}

fn (server Comp_server) process_cursor_resize() {
	toplevel := server.grabbed_toplevel

	border_x := server.cursor.x - server.grab_x
	border_y := server.cursor.y - server.grab_y

	mut new_left := server.grab_geobox.x
	mut new_right := server.grab_geobox.x + server.grab_geobox.width

	mut new_top := server.grab_geobox.y
	mut new_bottom := server.grab_geobox.y + server.grab_geobox.height

	if server.resize_edges & u32(wlr.Edges.top) > 0 {
		new_top = int(border_y)
		if new_top >= new_bottom {
			new_top = new_bottom - 1
		}
	} else if server.resize_edges & u32(wlr.Edges.bottom) > 0 {
		new_bottom = int(border_y)
		if new_bottom <= new_top {
			new_bottom = new_top + 1
		}
	}

	if server.resize_edges & u32(wlr.Edges.left) > 0 {
		new_left = int(border_x)
		if new_left >= new_right {
			new_left = new_right - 1
		}
	} else if server.resize_edges & u32(wlr.Edges.right) > 0 {
		new_right = int(border_x)
		if new_right <= new_left {
			new_right = new_left + 1
		}
	}

	geo_box := &toplevel.xdg_toplevel.base.geometry
	C.wlr_scene_node_set_position(&toplevel.scene_tree.node, new_left - geo_box.x, new_top - geo_box.y)
	C.wlr_xdg_toplevel_set_size(toplevel.xdg_toplevel, new_right - new_left, new_bottom - new_top)
}

fn (server Comp_server) process_cursor_motion(time u32) {
	if server.cursor_mode == .move {
		server.process_cursor_move()
		return
	} else if server.cursor_mode == .resize {
		server.process_cursor_resize()
		return
	}

	sx := f64(0)
	sy := f64(0)

	mut surface := &C.wlr_surface(unsafe { nil })
	toplevel := server.desktop_toplevel_at(server.cursor.x, server.cursor.y, mut surface,
		&sx, &sy)

	if toplevel == none {
		C.wlr_cursor_set_xcursor(server.cursor, server.cursor_mgr, 'default'.str)
	}

	if surface != unsafe { nil } {
		C.wlr_seat_pointer_notify_enter(server.seat, surface, sx, sy)
		C.wlr_seat_pointer_notify_motion(server.seat, time, sx, sy)
	} else {
		C.wlr_seat_pointer_clear_focus(server.seat)
	}
}

fn (server Comp_server) server_cursor_motion(listener &C.wl_listener, data voidptr) {
	unsafe {
		event := &C.wlr_pointer_motion_event(data)

		C.wlr_cursor_move(server.cursor, &event.pointer.base, &event.delta_x, &event.delta_y)
		server.process_cursor_motion(event.time_msec)
	}
}

fn (server Comp_server) server_cursor_motion_absolute(listener &C.wl_listener, data voidptr) {
	unsafe {
		event := &C.wlr_pointer_motion_absolute_event(data)

		C.wlr_cursor_warp_absolute(server.cursor, &event.pointer.base, event.x, event.y)
		server.process_cursor_motion(event.time_msec)
	}
}

fn (mut server Comp_server) server_cursor_button(listener &C.wl_listener, data voidptr) {
	event := unsafe { &C.wlr_pointer_button_event(data) }
	C.wlr_seat_pointer_notify_button(server.seat, event.time_msec, &event.button, event.state)

	if event.state == .released {
		server.reset_cursor_mode()
	} else {
		sx := f64(0)
		sy := f64(0)
		mut surface := &C.wlr_surface(unsafe { nil })
		if toplevel := server.desktop_toplevel_at(server.cursor.x, server.cursor.y, mut
			surface, &sx, &sy)
		{
			focus_toplevel(toplevel)
		}
	}
}

fn xdg_popup_commit(listener &C.wl_listener, mut data voidptr) {
	comp_popup := &Comp_popup(data)
	// popup := wlr.wl_container_of(comp_popup, listener, __offsetof(Comp_popup, commit))
	if comp_popup.xdg_popup.base.initial_commit {
		C.wlr_xdg_surface_schedule_configure(comp_popup.xdg_popup.base)
	}
}

fn xdg_popup_destroy(listener &C.wl_listener, mut data voidptr) {
	comp_popup := &Comp_popup(data)
	// popup := wlr.wl_container_of(comp_popup, listener, __offsetof(Comp_popup, destroy))
	C.wl_list_remove(&comp_popup.commit.link)
	C.wl_list_remove(&comp_popup.destroy.link)
	unsafe {
		free(comp_popup)
	}
}

// &C.xdg_popup(data)

fn server_new_xdg_popup(listener &C.wl_listener, mut data C.wlr_xdg_popup) {
	mut popup := &Comp_popup{
		xdg_popup: data
	}

	parent := C.wlr_xdg_surface_try_from_wlr_surface(data.parent)
	base_data := C.wlr_scene_xdg_surface_create(parent.data, data.base)
	data.base.data = &base_data // cannot ref directly

	popup.commit.notify = xdg_popup_commit
	C.wl_signal_add(&data.base.surface.events.commit, &popup.commit)

	popup.destroy.notify = xdg_popup_destroy
	C.wl_signal_add(&data.base.surface.events.destroy, &popup.destroy)
}

fn main() {
	mut server := Comp_server{}

	// Display
	server.wl_display = C.wl_display_create()

	// Backend
	server.backend = C.wlr_backend_autocreate(C.wl_display_get_event_loop(server.wl_display),
		unsafe { nil })
	server.renderer = C.wlr_renderer_autocreate(server.backend)
	C.wlr_renderer_init_wl_display(server.renderer, server.wl_display)

	// Allocator
	server.allocator = C.wlr_allocator_autocreate(server.backend, server.renderer)

	// Compositor
	C.wlr_compositor_create(server.wl_display, 5, server.renderer)
	C.wlr_subcompositor_create(server.wl_display)
	C.wlr_data_device_manager_create(server.wl_display)

	// Outputs
	server.output_layout = C.wlr_output_layout_create(server.wl_display)
	C.wl_list_init(&server.outputs)

	// Shell
	server.xdg_shell = C.wlr_xdg_shell_create(server.wl_display, 3)
	server.new_xdg_toplevel.notify = server_new_xdg_popup
	C.wl_signal_add(&server.xdg_shell.events.new_toplevel, &server.new_xdg_toplevel)
	server.new_xdg_popup.notify = server_new_xdg_popup
	C.wl_signal_add(&server.xdg_shell.events.new_popup, &server.new_xdg_popup)

	// Cursor
	server.cursor = C.wlr_cursor_create()
	C.wlr_cursor_attach_output_layout(server.cursor, server.output_layout)
	server.cursor_mgr = C.wlr_xcursor_manager_create(unsafe { nil }, 24)
	server.cursor_mode = .passthrough
	server.cursor_motion.notify = server.server_cursor_motion
	C.wl_signal_add(&server.cursor.events.motion, &server.cursor_motion)
	server.cursor_motion_absolute.notify = server.server_cursor_motion_absolute
	C.wl_signal_add(&server.cursor.events.motion_absolute, &server.cursor_motion_absolute)
	server.cursor_button.notify = server.server_cursor_button

	// FIXME: look at pixman Format_code_t for potential issues

	println('Run completed.')
}
