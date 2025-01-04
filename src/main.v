module main

import wlr

enum Comp_cursor_mode {
	passthrough
	move
	resize
}

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

	map                C.wl_listener
	unmap              C.wl_listener
	commit             C.wl_listener
	destroy            C.wl_listener
	request_move       C.wl_listener
	request_resize     C.wl_listener
	request_maximize   C.wl_listener
	request_fullscreen C.wl_listener
}

struct Comp_popup {
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

fn xdg_popup_commit(listener &C.wl_listener, mut data voidptr) {

}

fn xdg_popup_destroy(listener &C.wl_listener, mut data voidptr) {
}

// &C.xdg_popup(data)

fn server_new_xdg_popup(listener &C.wl_listener, mut data C.wlr_xdg_popup) {
	mut popup := &Comp_popup{
		xdg_popup: data
	}

	parent := C.wlr_xdg_surface_try_from_wlr_surface(data.parent)
	parent_tree := &parent.data
	base_data := C.wlr_scene_xdg_surface_create(parent_tree, data.base)
	data.base.data = &base_data // cannot ref directly

	popup.commit.notify = xdg_popup_commit
	C.wl_signal_add(&data.base.surface.events_commit, popup.commit)

	popup.destroy.notify = xdg_popup_destroy
	C.wl_signal_add(&data.base.surface.events_destroy, popup.destroy)
}

fn main() {
	mut server := Comp_server{}

	server.wl_display = C.wl_display_create()

	server.backend = C.wlr_backend_autocreate(C.wl_display_get_event_loop(server.wl_display),
		unsafe { nil })
	server.renderer = C.wlr_renderer_autocreate(server.backend)
	C.wlr_renderer_init_wl_display(server.renderer, server.wl_display)

	server.allocator = C.wlr_allocator_autocreate(server.backend, server.renderer)

	C.wlr_compositor_create(server.wl_display, 5, server.renderer)
	C.wlr_subcompositor_create(server.wl_display)

	C.wlr_data_device_manager_create(server.wl_display)

	server.output_layout = C.wlr_output_layout_create(server.wl_display)
	C.wl_list_init(&server.outputs)

	server.xdg_shell = C.wlr_xdg_shell_create(server.wl_display, 3)
	server.new_xdg_toplevel.notify = server_new_xdg_popup

	// C.wl_signal_add(&server.xdg_shell.events.new_toplevel, &server.new_xdg_toplevel)
}
