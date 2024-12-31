module main

import wlr

enum Comp_cursor_mode {
	passthrough
	move
	resize
}

struct Comp_server {
	wl_display &C.wl_display
	backend    &C.wlr_backend
	renderer   &C.wlr_renderer

	xdg_shell       &C.wlr_xdg_shell = unsafe { nil }
	new_xdg_surface C.wl_listener
	views           C.wl_list

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
	grabbed_view          &Comp_view = unsafe { nil }
	grab_x                f64
	grab_y                f64
	grab_geobox           C.wlr_box
	resize_edges          u32

	output_layout &C.wlr_output_layout = unsafe { nil }
	outputs       C.wl_list
	new_output    C.wl_listener
}

struct Comp_output {
	link       C.wl_list
	server     &Comp_server
	wlr_output &C.wlr_output
	frame      C.wl_listener
}

struct Comp_view {
	link           C.wl_list
	server         &Comp_server
	xdg_surface    &C.wlr_xdg_surface
	map            C.wl_listener
	unmap          C.wl_listener
	destroy        C.wl_listener
	request_move   C.wl_listener
	request_resize C.wl_listener
	mapped         bool
	x              int
	y              int
}

struct Comp_keyboard {
	link   C.wl_list
	server &Comp_server
	device &C.wlr_input_device

	modifiers C.wl_listener
	key       C.wl_listener
}

fn main() {
	display := C.wl_display_create()
	backend := C.wlr_backend_autocreate(C.wl_get_event_loop(display), unsafe { nil })
	renderer := C.wlr_renderer_autocreate(backend)

	mut server := Comp_server{
		wl_display: display
		backend:    &backend
		renderer:   &renderer
	}

	C.wlr_renderer_init_wl_display(server.renderer, server.wl_display)
}
