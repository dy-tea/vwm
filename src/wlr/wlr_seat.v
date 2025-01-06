module wlr

#flag linux -I/usr/include
#flag linux -I/usr/include/pixman-1
#flag linux -I/usr/include/wayland-protocols
#flag -I @VMODROOT
#flag linux -I/usr/include/wlroots-0.19
#flag linux -lwayland-server
#flag linux -lwlroots-0.19
#flag linux -DWLR_USE_UNSTABLE

#include "wlr/types/wlr_seat.h"
#include <time.h>

pub struct C.wlr_surface {}

const wlr_serial_ringset_size = 128

pub struct C.wlr_serial_range {
	min_incl u32
	max_incl u32
}

pub struct C.wlr_serial_ringset {
	data  [wlr_serial_ringset_size]C.wlr_serial_range
	end   int
	count int
}

pub struct C.wlr_seat_client {
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
		acc_discrete  [2]int
		last_discrete [2]int
		acc_axis      [2]f32
	}
}

pub struct C.wlr_touch_point {
	touch_id int
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

	wlr_private struct {
		surface_destroy       C.wl_listener
		focus_surface_destroy C.wl_listener
		client_destroy        C.wl_listener
	}
}

pub struct C.wlr_seat_pointer_grab {}

pub struct C.wlr_pointer_grab_interface {
	enter       fn (grab &C.wlr_seat_pointer_grab, surface &C.wlr_surface, sx f64, sy f64)
	clear_focus fn (grab &C.wlr_seat_pointer_grab)
	motion      fn (grab &C.wlr_seat_pointer_grab, time_msec u32, sx f64, sy f64)
	button      fn (grab &C.wlr_seat_pointer_grab, time_msec u32, button u32, state Wl_pointer_button_state) u32
	axis        fn (grab &C.wlr_seat_pointer_grab, time_msec u32, orientation Wl_pointer_axis, value f64, value_discrete int, source Wl_pointer_axis_source)
	frame       fn (grab &C.wlr_seat_pointer_grab)
	cancel      fn (grab &C.wlr_seat_pointer_grab)
}

pub struct C.wlr_seat_keyboard_grab {}

pub struct C.wlr_keyboard_grab_interface {
	enter       fn (grab &C.wlr_seat_keyboard_grab, surface &C.wlr_surface, keycodes []u32, num_keycodes usize, modifiers &C.wlr_keyboard_modifiers)
	clear_focus fn (grab &C.wlr_seat_keyboard_grab)
	key         fn (grab &C.wlr_seat_keyboard_grab, time_msec u32, key u32, state u32)
	modifiers   fn (grab &C.wlr_seat_keyboard_grab, modifiers &C.wlr_keyboard_modifiers)
	cancel      fn (grab &C.wlr_seat_keyboard_grab)
}

pub struct C.wlr_seat_touch_grab {}

pub struct C.wlr_touch_grab_interface {
	down      fn (grab &C.wlr_seat_touch_grab, time_msec u32, point &C.wlr_touch_point) u32
	up        fn (grab &C.wlr_seat_touch_grab, time_msec u32, point &C.wlr_touch_point) u32
	motion    fn (grab &C.wlr_seat_touch_grab, time_msec u32, point &C.wlr_touch_point)
	enter     fn (grab &C.wlr_seat_touch_grab, surface &C.wlr_surface, point &C.wlr_touch_point)
	frame     fn (grab &C.wlr_seat_touch_grab)
	cancel    fn (grab &C.wlr_seat_touch_grab)
	wl_cancel fn (grab &C.wlr_seat_touch_grab, seat_client &C.wlr_seat_client)
}

pub struct C.wlr_seat_touch_grab {
	interface &C.wlr_touch_grab_interface
	seat      &C.wlr_seat
	data      voidptr
}

pub struct C.wlr_seat_keyboard_grab {
	interface &C.wlr_keyboard_grab_interface
	seat      &C.wlr_seat
	data      voidptr
}

pub struct C.wlr_seat_pointer_grab {
	interface &C.wlr_pointer_grab_interface
	seat      &C.wlr_seat
	data      voidptr
}

pub struct C.wlr_seat_pointer_button {
	button    u32
	n_pressed usize
}

pub struct C.wlr_seat_pointer_state {
	seat            &C.wlr_seat
	focused_client  &C.wlr_seat_client
	focused_surface &C.wlr_surface
	sx              f64
	sy              f64

	grab         &C.wlr_seat_pointer_grab
	default_grab &C.wlr_seat_pointer_grab

	sent_axis_source   bool
	cached_axis_source Wl_pointer_axis_source

	buttons      [wlr_pointer_buttons_cap]C.wlr_seat_pointer_button
	button_count usize

	grab_button u32
	grab_serial u32
	grab_time   u32

	events struct {
	pub:
		focus_change C.wl_signal
	}

	wlr_private struct {
		surface_destroy C.wl_listener
	}
}

pub struct C.wlr_seat_keyboard_state {
	seat     &C.wlr_seat
	keyboard &C.wlr_keyboard

	focused_client  &C.wlr_seat_client
	focused_surface &C.wlr_surface

	grab         &C.wlr_seat_keyboard_grab
	default_grab &C.wlr_seat_keyboard_grab

	events struct {
	pub:
		focus_change C.wl_signal
	}

	wlr_private struct {
		keyboard_destroy     C.wl_listener
		keyboard_keymap      C.wl_listener
		keyboard_repeat_info C.wl_listener

		surface_destroy C.wl_listener
	}
}

pub struct C.wlr_seat_touch_state {
	seat         &C.wlr_seat
	touch_points C.wl_list

	grab_serial u32
	grab_id     u32

	grab         &C.wlr_seat_touch_grab
	default_grab &C.wlr_seat_touch_grab
}

pub struct C.wlr_primary_selection_source {}

pub struct C.wlr_seat {
	global  &C.wl_global
	display &C.wl_display
	clients C.wl_list

	name                     &char
	capabilities             u32
	accumulated_capabilities u32

	selection_source &C.wlr_data_source
	selection_serial u32
	selection_offers C.wl_list

	primary_selection_source &C.wlr_primary_selection_source
	primary_selection_serial u32

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

		request_set_cursor    C.wl_signal
		request_set_selection C.wl_signal

		set_selection C.wl_signal

		request_set_primary_selection C.wl_signal
		set_primary_selection         C.wl_signal

		request_start_drag C.wl_signal
		start_drag         C.wl_signal

		destroy C.wl_signal
	}

	data voidptr

	wlr_private struct {
		display_destroy                   C.wl_listener
		selection_source_destroya         C.wl_listener
		primary_selection_source_destroya C.wl_listener
		drag_source_destroy               C.wl_listener
	}
}

pub struct C.wlr_seat_pointer_request_set_cursor_event {
	seat_client &C.wlr_seat_client
	surface     &C.wlr_surface
	serial      u32
	hotspot_x   int
	hotspot_y   int
}

pub struct C.wlr_seat_request_set_selection_event {
	source &C.wlr_data_source
	serial u32
}

pub struct C.wlr_seat_request_set_primary_selection_event {
	source &C.wlr_primary_selection_source
	serial u32
}

pub struct C.wlr_seat_request_start_drag_event {
	drag   &C.wlr_drag
	origin &C.wlr_surface
	serial u32
}

pub struct C.wlr_seat_pointer_focus_change_event {
	seat        &C.wlr_seat
	old_surface &C.wlr_surface
	new_surface &C.wlr_surface
	sx          f64
	sy          f64
}

pub struct C.wlr_seat_keyboard_focus_change_event {
	seat        &C.wlr_seat
	old_surface &C.wlr_surface
	new_surface &C.wlr_surface
}

pub fn C.wlr_seat_create(display &C.wl_display, name string) &C.wlr_seat
pub fn C.wlr_seat_destroy(seat &C.wlr_seat)

pub fn C.wlr_seat_for_client_for_wl_client(wlr_seat &C.wlr_seat, wl_client &C.wl_client) &C.wlr_seat_client

pub fn C.wlr_seat_set_capabilities(wlr_seat &C.wlr_seat, capabilities u32)

pub fn C.wlr_seat_set_name(wlr_seat &C.wlr_seat, name string)

pub fn C.wlr_seat_pointer_surface_has_focus(wlr_seat &C.wlr_seat, surface &C.wlr_surface) bool

pub fn C.wlr_seat_pointer_enter(wlr_seat &C.wlr_seat, surface &C.wlr_surface, sx f64, sy f64)

pub fn C.wlr_seat_pointer_clear_focus(wlr_seat &C.wlr_seat)

pub fn C.wlr_seat_pointer_send_motion(wlr_seat &C.wlr_seat, time_msec u32, sx f64, sy f64)

pub fn C.wlr_seat_pointer_send_button(wlr_seat &C.wlr_seat, time_msec u32, button u32, state Wl_pointer_button_state) u32

pub fn C.wlr_seat_pointer_send_axis(wlr_seat &C.wlr_seat, time_msec u32, orientation Wl_pointer_axis, value f64, value_discrete int, source Wl_pointer_axis_source, relative_direction Wl_pointer_axis_relative_direction)

pub fn C.wlr_seat_pointer_send_frame(wlr_seat &C.wlr_seat)

pub fn C.wlr_seat_pointer_notify_enter(wlr_seat &C.wlr_seat, surface &C.wlr_surface, sx f64, sy f64)

pub fn C.wlr_seat_pointer_notify_clear_focus(wlr_seat &C.wlr_seat)

pub fn C.wlr_seat_pointer_warp(wlr_seat &C.wlr_seat, sx f64, sy f64)

pub fn C.wlr_seat_pointer_notify_motion(wlr_seat &C.wlr_seat, time_msec u32, sx f64, sy f64)

pub fn C.wlr_seat_pointer_notify_button(wlr_seat &C.wlr_seat, time_msec u32, button u32, state Wl_pointer_button_state) u32

pub fn C.wlr_seat_pointer_notify_axis(wlr_seat &C.wlr_seat, time_msec u32, orientation Wl_pointer_axis, value f64, value_discrete int, source Wl_pointer_axis_source, relative_direction Wl_pointer_axis_relative_direction)

pub fn C.wlr_seat_pointer_notify_frame(wlr_seat &C.wlr_seat)

pub fn C.wlr_seat_pointer_start_grab(wlr_seat &C.wlr_seat, grab &C.wlr_seat_pointer_grab)

pub fn C.wlr_seat_pointer_end_grab(wlr_seat &C.wlr_seat)

pub fn C.wlr_seat_pointer_has_grab(wlr_seat &C.wlr_seat) bool

pub fn C.wlr_seat_set_keyboard(wlr_seat &C.wlr_seat, keyboard &C.wlr_keyboard)

pub fn C.wlr_seat_get_keyboard(wlr_seat &C.wlr_seat) &C.wlr_keyboard

pub fn C.wlr_seat_keyboard_send_key(wlr_seat &C.wlr_seat, time_msec u32, key u32, state u32)

pub fn C.wlr_seat_keyboard_send_modifiers(wlr_seat &C.wlr_seat, modifiers &C.wlr_keyboard_modifiers)

pub fn C.wlr_seat_keyboard_enter(wlr_seat &C.wlr_seat, surface &C.wlr_surface, keycodes []u32, num_keycodes usize, modifiers &C.wlr_keyboard_modifiers)

pub fn C.wlr_seat_keyboard_clear_focus(wlr_seat &C.wlr_seat)

pub fn C.wlr_seat_keyboard_notify_key(wlr_seat &C.wlr_seat, time_msec u32, key u32, state u32)

pub fn C.wlr_seat_keyboard_notify_modifiers(wlr_seat &C.wlr_seat, modifiers &C.wlr_keyboard_modifiers)

pub fn C.wlr_seat_keyboard_notify_enter(wlr_seat &C.wlr_seat, surface &C.wlr_surface, keycodes []u32, num_keycodes usize, modifiers &C.wlr_keyboard_modifiers)

pub fn C.wlr_seat_keyboard_notify_clear_focus(wlr_seat &C.wlr_seat)

pub fn C.wlr_seat_keyboard_start_grab(wlr_seat &C.wlr_seat, grab &C.wlr_seat_keyboard_grab)

pub fn C.wlr_seat_keyboard_end_grab(wlr_seat &C.wlr_seat)

pub fn C.wlr_seat_keyboard_has_grab(wlr_seat &C.wlr_seat) bool

pub fn C.wlr_seat_touch_get_point(wlr_seat &C.wlr_seat, touch_id int) &C.wlr_touch_point

pub fn C.wlr_seat_touch_point_focus(wlr_seat &C.wlr_seat, point &C.wlr_touch_point, surface &C.wlr_surface, time_msec u32, touch_id int, sx f64, sy f64)

pub fn C.wlr_seat_touch_point_clear_focus(wlr_seat &C.wlr_seat, point &C.wlr_touch_point, time_msec u32, touch_id int)

pub fn C.wlr_seat_touch_send_down(wlr_seat &C.wlr_seat, surface &C.wlr_surface, time_msec u32, touch_id int, sx f64, sy f64) u32

pub fn C.wlr_seat_touch_send_up(wlr_seat &C.wlr_seat, time_msec u32, touch_id int) u32

pub fn C.wlr_seat_touch_send_motion(wlr_seat &C.wlr_seat, time_msec u32, touch_id int, sx f64, sy f64)

pub fn C.wlr_seat_touch_send_cancel(wlr_seat &C.wlr_seat, seat_client &C.wlr_seat_client)

pub fn C.wlr_seat_touch_send_frame(wlr_seat &C.wlr_seat)

pub fn C.wlr_seat_touch_notify_down(wlr_seat &C.wlr_seat, surface &C.wlr_surface, time_msec u32, touch_id int, sx f64, sy f64) u32

pub fn C.wlr_seat_touch_notify_up(wlr_seat &C.wlr_seat, time_msec u32, touch_id int) u32

pub fn C.wlr_seat_touch_notify_motion(wlr_seat &C.wlr_seat, time_msec u32, touch_id int, sx f64, sy f64)

pub fn C.wlr_seat_touch_notify_cancel(wlr_seat &C.wlr_seat, seat_client &C.wlr_seat_client)

pub fn C.wlr_seat_touch_notify_frame(wlr_seat &C.wlr_seat)

pub fn C.wlr_seat_touch_num_points(wlr_seat &C.wlr_seat) int

pub fn C.wlr_seat_touch_start_grab(wlr_seat &C.wlr_seat, grab &C.wlr_seat_touch_grab)

pub fn C.wlr_seat_touch_end_grab(wlr_seat &C.wlr_seat)

pub fn C.wlr_seat_touch_has_grab(wlr_seat &C.wlr_seat) bool

pub fn C.wlr_seat_validate_pointer_grab_serial(wlr_seat &C.wlr_seat, origin &C.wlr_surface, serial u32) bool

pub fn C.wlr_seat_validate_touch_grab_serial(wlr_seat &C.wlr_seat, origin &C.wlr_surface, serial u32, point_ptr &C.wlr_touch_point) bool

pub fn C.wlr_seat_client_next_serial(wlr_seat_client &C.wlr_seat_client) u32

pub fn C.wlr_seat_client_validate_event_serial(client &C.wlr_seat_client, serial u32) bool

pub fn C.wlr_seat_client_from_resource(resource &C.wl_resource) &C.wlr_seat_client

pub fn C.wlr_seat_client_from_pointer_resource(resource &C.wl_resource) &C.wlr_seat_client

pub fn C.wlr_surface_accepts_touch(surface &C.wlr_surface, wlr_seat &C.wlr_seat) bool
