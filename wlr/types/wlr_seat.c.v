module types

import wl

#flag linux -DWLR_USE_UNSTABLE
#flag linux -I/usr/include/
#flag linux -I/usr/include/wlroots-0.20
#flag linux -lwlroots-0.20
#include <wlr/types/wlr_seat.h>

pub struct C.wlr_serial_range {
pub:
	min_incl u32
	max_incl u32
}

pub struct C.wlr_serial_ringset {
pub:
	data  [128]C.wlr_serial_range
	end   int
	count int
}

pub struct C.wlr_seat_client {
pub:
	client &C.wl_client
	seat   &C.wlr_seat
	link   C.wl_list

	resources    C.wl_list
	pointers     C.wl_list
	keyboards    C.wl_list
	touches      C.wl_list
	data_devices C.wl_list

	events struct {
	pub:
		destroy C.wl_signal
	}

	serials           C.wlr_serial_ringset
	needs_touch_frame bool

	value120 struct {
	pub:
		acc_discrete  [2]i32
		last_discrete [2]i32
		acc_axis      [2]f64
	}
}

pub struct C.wlr_touch_point {
pub:
	touch_id i32
	surface  &C.wlr_surface
	client   &C.wlr_seat_client

	focus_surface &C.wlr_surface
	focus_client  &C.wlr_seat_client
	sx            f64
	sy            f64

	events struct {
	pub:
		destroy C.wl_signal
	}

	link C.wl_list
}

pub struct C.wlr_seat_touch_grab {
pub:
	seat &C.wlr_seat
pub mut:
	data voidptr
}

pub struct C.wlr_seat_keyboard_grab {
pub:
	seat &C.wlr_seat
pub mut:
	data voidptr
}

pub struct C.wlr_seat_pointer_grab {
pub:
	seat &C.wlr_seat
pub mut:
	data voidptr
}

pub struct C.wlr_seat_pointer_button {
pub:
	button    u32
	n_pressed usize
}

pub struct C.wlr_seat_pointer_state {
pub:
	seat            &C.wlr_seat
	focused_client  &C.wlr_seat_client
	focused_surface &C.wlr_surface
	sx              f64
	sy              f64

	grab         &C.wlr_seat_pointer_grab
	default_grab &C.wlr_seat_pointer_grab

	sent_axis_source   bool
	cached_axis_source wl.Wl_pointer_axis_source

	buttons      [16]C.wlr_seat_pointer_button
	button_count usize

	grab_button u32
	grab_serial u32
	grab_time   u32

	events struct {
	pub:
		focus_change C.wl_signal
	}
}

pub struct C.wlr_seat_keyboard_state {
pub:
	seat     &C.wlr_seat
	keyboard &C.wlr_keyboard

	focused_client  &C.wlr_seat_client
	focused_surface &C.wlr_surface

	grab         &C.wlr_seat_pointer_grab
	default_grab &C.wlr_seat_pointer_grab

	events struct {
	pub:
		focus_change C.wl_signal
	}
}

pub struct C.wlr_seat_touch_state {
pub:
	seat &C.wlr_seat

	grab_serial u32
	grab_id     u32

	grab         &C.wlr_seat_pointer_grab
	default_grab &C.wlr_seat_pointer_grab
}

pub struct C.wlr_seat {
pub:
	global  &C.wl_global
	display &C.wl_display
	clients C.wl_list

	name                     &u8
	capabilities             u32
	accumulated_capabilities u32

	selection_source &C.wlr_data_source
	selection_serial u32
	selection_offers C.wl_list

	// primary_selection_source &C.wlr_primary_selection_source
	// primary_selection_serial u32
	drag        &C.wlr_drag
	drag_source &C.wlr_data_source
	drag_serial u32
	drag_offers C.wl_list

	pointer_state  C.wlr_seat_pointer_state
	keyboard_state C.wlr_seat_keyboard_state
	touch_state    C.wlr_seat_touch_state

	events struct {
	pub:
		pointer_grab_begin C.wl_signal
		pointer_grab_end   C.wl_signal

		keyboard_grab_begin C.wl_signal
		keyboard_grab_end   C.wl_signal

		touch_grab_begin C.wl_signal
		touch_grab_end   C.wl_signal

		// struct wlr_seat_pointer_request_set_cursor_event
		request_set_cursor C.wl_signal

		// Called when an application _wants_ to set the selection (user copies some data).
		// Compositors should listen to this event and call wlr_seat_set_selection()
		// if they want to accept the client's request.
		request_set_selection C.wl_signal // struct wlr_seat_request_set_selection_event
		// Called after the data source is set for the selection.
		set_selection C.wl_signal

		// Called when an application _wants_ to set the primary selection (user selects some data).
		// Compositors should listen to this event and call wlr_seat_set_primary_selection()
		// if they want to accept the client's request.
		request_set_primary_selection C.wl_signal // struct wlr_seat_request_set_primary_selection_event
		// Called after the primary selection source object is set.
		set_primary_selection C.wl_signal

		// struct wlr_seat_request_start_drag_event
		request_start_drag C.wl_signal
		start_drag         C.wl_signal // struct wlr_drag

		destroy C.wl_signal
	}
pub mut:
	data voidptr
}

pub struct C.wlr_seat_pointer_request_set_cursor_event {
pub:
	seat_client &C.wlr_seat_client
	surface     &C.wlr_surface
	serial      u32
	hotspot_x   int
	hotspot_y   int
}

pub struct C.wlr_seat_request_set_selection_event {
pub:
	source &C.wlr_data_source
	serial u32
}

pub struct C.wlr_seat_request_set_primary_selection_event {
pub:
	source &C.wlr_primary_selection_source
	serial u32
}

pub struct C.wlr_seat_request_start_drag_event {
pub:
	drag   &C.wlr_drag
	origin &C.wlr_surface
	serial u32
}

pub struct C.wlr_seat_pointer_focus_change_event {
pub:
	seat        &C.wlr_seat
	old_surface &C.wlr_surface
	new_surface &C.wlr_surface
	sx          f64
	sy          f64
}

pub struct C.wlr_seat_keyboard_focus_change_event {
pub:
	seat        &C.wlr_seat
	old_surface &C.wlr_surface
	new_surface &C.wlr_surface
}

fn C.wlr_seat_create(display &C.wl_display, name &char) &C.wlr_seat
fn C.wlr_seat_destroy(wlr_seat &C.wlr_seat)

fn C.wlr_seat_client_for_wl_client(wlr_seat &C.wlr_seat, wl_client &C.wl_client) &C.wlr_seat_client

fn C.wlr_seat_set_capabilities(wlr_seat &C.wlr_seat, capabilities u32)
fn C.wlr_seat_set_name(wlr_seat &C.wlr_seat, name &char)

fn C.wlr_seat_pointer_surface_has_focus(wlr_seat &C.wlr_seat, surface &C.wlr_surface) bool
fn C.wlr_seat_pointer_enter(wlr_seat &C.wlr_seat, surface &C.wlr_surface, sx f64, sy f64)
fn C.wlr_seat_pointer_clear_focus(wlr_seat &C.wlr_seat)
fn C.wlr_seat_pointer_send_motion(wlr_seat &C.wlr_seat, time_msec u32, sx f64, sy f64)
fn C.wlr_seat_pointer_send_button(wlr_seat &C.wlr_seat, time_msec u32, button u32, state wl.Wl_pointer_button_state) u32
fn C.wlr_seat_pointer_send_axis(wlr_seat &C.wlr_seat, time_msec u32, orientation wl.Wl_pointer_axis, value f64, value_discrete i32, source wl.Wl_pointer_source, relative_direction wl.Wl_pointer_axis_relative_direction)
fn C.wlr_seat_pointer_send_frame(wlr_seat &C.wlr_seat)
fn C.wlr_seat_pointer_notify_enter(wlr_seat &C.wlr_seat, surface &C.wlr_surface, sx f64, sy f64)
fn C.wlr_seat_pointer_notify_clear_focus(wlr_seat &C.wlr_seat)
fn C.wlr_seat_pointer_warp(wlr_seat &C.wlr_seat, sx f64, sy f64)
fn C.wlr_seat_pointer_notify_motion(wlr_seat &C.wlr_seat, time_msec u32, sx f64, sy f64)
fn C.wlr_seat_pointer_notify_button(wlr_seat &C.wlr_seat, time_msec u32, button u32, state wl.Wl_pointer_button_state) u32
fn C.wlr_seat_pointer_notify_axis(wlr_seat &C.wlr_seat, time_msec u32, orientation wl.Wl_pointer_axis, value f64, value_discrete i32, source wl.Wl_pointer_axis_source, relative_direction wl.Wl_pointer_axis_relative_direction)
fn C.wlr_seat_pointer_notify_frame(wlr_seat &C.wlr_seat)
fn C.wlr_seat_pointer_start_grab(wlr_seat &C.wlr_seat, grab &C.wlr_pointer_grab)
fn C.wlr_seat_pointer_end_grab(wlr_seat &C.wlr_seat)
fn C.wlr_seat_pointer_has_grab(seat &C.wlr_seat) bool

fn C.wlr_seat_set_keyboard(seat &C.wlr_seat, keyboard &C.wlr_keyboard)
fn C.wlr_seat_get_keyboard(seat &C.wlr_seat) &C.wlr_keyboard
fn C.wlr_seat_keyboard_send_key(seat &C.wlr_seat, time_msec u32, key u32, state u32)
fn C.wlr_seat_keyboard_send_modifiers(seat &C.wlr_seat, modifiers &C.wlr_keyboard_modifiers)
fn C.wlr_seat_keyboard_enter(seat &C.wlr_seat, surface &C.wlr_surface, keycodes []u32, num_keycodes usize, modifiers &C.wlr_keyboard_modifiers)
fn C.wlr_seat_keyboard_clear_focus(wlr_seat &C.wlr_seat)
fn C.wlr_seat_keyboard_notify_key(seat &C.wlr_seat, time_msec u32, key u32, state u32)
fn C.wlr_seat_keyboard_notify_modifiers(seat &C.wlr_seat, modifiers &C.wlr_keyboard_modifiers)
fn C.wlr_seat_keyboard_notify_enter(seat &C.wlr_seat, surface &C.wlr_surface, const_keycodes &u32, num_keycodes usize, const_modifiers &C.wlr_keyboard_modifiers)
fn C.wlr_seat_keyboard_notify_clear_focus(wlr_seat &C.wlr_seat)
fn C.wlr_seat_keyboard_start_grab(wlr_seat &C.wlr_seat, grab &C.wlr_seat_keyboard_grab)
fn C.wlr_seat_keyboard_end_grab(wlr_seat &C.wlr_seat)
fn C.wlr_seat_keyboard_has_grab(seat &C.wlr_seat) bool

fn C.wlr_seat_touch_get_point(seat &C.wlr_seat, touch_id i32) &C.wlr_touch_point
fn C.wlr_seat_touch_point_focus(seat &C.wlr_seat, surface &C.wlr_surface, time_msec u32, touch_id i32, sx f64, sy f64)
fn C.wlr_seat_touch_point_clear_focus(seat &C.wlr_seat, time_msec u32, touch_id i32)

fn C.wlr_seat_touch_send_down(seat &C.wlr_seat, surface &C.wlr_surface, time_msec u32, touch_id i32, sx f64, sy f64) u32
fn C.wlr_seat_touch_send_up(seat &C.wlr_seat, time_msec u32, touch_id i32) u32
fn C.wlr_seat_touch_send_motion(seat &C.wlr_seat, time_msec u32, touch_id i32, sx f64, sy f64)
fn C.wlr_seat_touch_send_cancel(seat &C.wlr_seat, seat_client &C.wlr_seat_client)
fn C.wlr_seat_touch_send_frame(seat &C.wlr_seat)
fn C.wlr_seat_touch_notify_down(seat &C.wlr_seat, surface &C.wlr_surface, time_msec u32, touch_id i32, sx f64, sy f64) u32
fn C.wlr_seat_touch_notify_up(seat &C.wlr_seat, time_msec u32, touch_id i32) u32
fn C.wlr_seat_touch_notify_motion(seat &C.wlr_seat, time_msec u32, touch_id i32, sx f64, sy f64)
fn C.wlr_seat_touch_notify_cancel(seat &C.wlr_seat, seat_client &C.wlr_seat_client)
fn C.wlr_seat_touch_notify_frame(seat &C.wlr_seat)
fn C.wlr_seat_touch_num_points(seat &C.wlr_seat) int
fn C.wlr_seat_touch_start_grab(wlr_seat &C.wlr_seat, grab &C.wlr_seat_touch_grab)
fn C.wlr_seat_touch_end_grab(wlr_seat &C.wlr_seat)
fn C.wlr_seat_touch_has_grab(seat &C.wlr_seat) bool

fn C.wlr_seat_validate_pointer_grab_serial(seat &C.wlr_seat, origin &C.wlr_surface, serial u32) bool
fn C.wlr_seat_validate_touch_grab_serial(seat &C.wlr_seat, origin &C.wlr_surface, serial u32, point_ptr &&C.wlr_touch_point) bool

fn C.wlr_seat_client_next_serial(client &C.wlr_seat_client) u32
fn C.wlr_seat_client_validate_event_serial(client &C.wlr_seat_client, serial u32) bool
fn C.wlr_seat_client_from_resource(resource &C.wl_resource) &C.wlr_seat_client
fn C.wlr_seat_client_from_pointer_resource(resource &C.wl_resource) &C.wlr_seat_client

fn C.wlr_surface_accepts_touch(surface &C.wlr_surface, wlr_seat &C.wlr_seat) bool
