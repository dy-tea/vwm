module types

import wayland

#flag linux -DWLR_USE_UNSTABLE
#flag linux -I/usr/include/
#flag linux -I/usr/include/wlroots-0.20
#flag linux -lwlroots-0.20
#include <wlr/types/wlr_pointer.h>

pub struct C.wlr_pointer_impl {}

pub struct C.wlr_pointer {
pub:
	base C.wlr_input_device

	impl &C.wlr_pointer_impl

	output_name &u8

	buttons      [16]u32
	button_count usize

	events struct {
	pub:
		motion          C.wl_signal // struct wlr_pointer_motion_event
		motion_absolute C.wl_signal // struct wlr_pointer_motion_absolute_event
		button          C.wl_signal // struct wlr_pointer_button_event
		axis            C.wl_signal // struct wlr_pointer_axis_event
		frame           C.wl_signal

		swipe_begin  C.wl_signal // struct wlr_pointer_swipe_begin_event
		swipe_update C.wl_signal // struct wlr_pointer_swipe_update_event
		swipe_end    C.wl_signal // struct wlr_pointer_swipe_end_event

		pinch_begin  C.wl_signal // struct wlr_pointer_pinch_begin_event
		pinch_update C.wl_signal // struct wlr_pointer_pinch_update_event
		pinch_end    C.wl_signal // struct wlr_pointer_pinch_end_event

		hold_begin C.wl_signal // struct wlr_pointer_hold_begin_event
		hold_end   C.wl_signal // struct wlr_pointer_hold_end_event
	}
pub mut:
	data voidptr
}

pub struct C.wlr_pointer_motion_event {
pub:
	pointer    &C.wlr_pointer
	time_msec  u32
	delta_x    f64
	delta_y    f64
	unaccel_dx f64
	unaccel_dy f64
}

pub struct C.wlr_pointer_motion_absolute_event {
pub:
	pointer   &C.wlr_pointer
	time_msec u32
	x         f64
	y         f64
}

pub struct C.wlr_pointer_button_event {
pub:
	pointer   &C.wlr_pointer
	time_msec u32
	button    u32
	state     wayland.Wl_pointer_button_state
}

pub struct C.wlr_pointer_axis_event {
pub:
	pointer            &C.wlr_pointer
	time_msec          u32
	source             wayland.Wl_pointer_axis_source
	orientation        wayland.Wl_pointer_axis
	relative_direction wayland.Wl_pointer_axis_relative_direction
	delta              f64
	delta_discrete     i32
}

pub struct C.wlr_pointer_swipe_begin_event {
pub:
	pointer   &C.wlr_pointer
	time_msec u32
	fingers   u32
}

pub struct C.wlr_pointer_swipe_update_event {
pub:
	pointer   &C.wlr_pointer
	time_msec u32
	fingers   u32
	dx        f64
	dy        f64
}

pub struct C.wlr_pointer_swipe_end_event {
pub:
	pointer   &C.wlr_pointer
	time_msec u32
	cancelled bool
}

pub struct C.wlr_pointer_pinch_begin_event {
pub:
	pointer   &C.wlr_pointer
	time_msec u32
	fingers   u32
}

pub struct C.wlr_pointer_pinch_update_event {
pub:
	pointer   &C.wlr_pointer
	time_msec u32
	fingers   u32
	dx        f64
	dy        f64
	scale     f64
	rotation  f64
}

pub struct C.wlr_pointer_pinch_end_event {
pub:
	pointer   &C.wlr_pointer
	time_msec u32
	cancelled u32
}

pub struct C.wlr_pointer_hold_begin_event {
pub:
	pointer   &C.wlr_pointer
	time_msec u32
	fingers   u32
}

pub struct C.wlr_pointer_hold_end_event {
pub:
	pointer   &C.wlr_pointer
	time_msec u32
	cancelled bool
}

fn C.wlr_pointer_from_input_device(input_device &C.wlr_input_device) &C.wlr_pointer
