module wlr

#flag linux -I/usr/include
#flag linux -I/usr/include/pixman-1
#flag linux -I/usr/include/wayland-protocols
#flag -I @VMODROOT
#flag linux -I/usr/include/wlroots-0.19
#flag linux -lwayland-server
#flag linux -lwlroots-0.19
#flag linux -DWLR_USE_UNSTABLE

#include "wlr/types/wlr_pointer.h"

const wlr_pointer_buttons_cap = 16

pub struct C.wlr_pointer_impl {}

pub struct C.wlr_pointer {
	base C.wlr_input_device
	impl &C.wlr_pointer_impl

	output_name string

	buttons      [wlr_pointer_buttons_cap]u32
	button_count usize

	events struct {
		motion          C.wl_signal
		motion_absolute C.wl_signal
		button          C.wl_signal
		axis            C.wl_signal
		frame           C.wl_signal

		swipe_begin  C.wl_signal
		swipe_update C.wl_signal
		swipe_end    C.wl_signal

		pinch_begin  C.wl_signal
		pinch_update C.wl_signal
		pinch_end    C.wl_signal

		hold_begin C.wl_signal
		hold_end   C.wl_signal
	}

	data voidptr
}

pub struct C.wlr_pointer_motion_event {
	pointer    &C.wlr_pointer
	time_msec  u32
	delta_x    f64
	delta_y    f64
	unaccel_dx f64
	unaccel_dy f64
}

pub struct C.wlr_pointer_motion_absolute_event {
	pointer   &C.wlr_pointer
	time_msec u32
	x         f64
	y         f64
}

pub struct C.wlr_pointer_button_event {
	pointer   &C.wlr_pointer
	time_msec u32
	button    u32
	state     Wl_pointer_button_state
}

const wlr_pointer_axis_discrete_step = 120

pub struct C.wlr_pointer_axis_event {
	pointer            &C.wlr_pointer
	time_msec          u32
	source             Wl_pointer_axis_source
	orientation        Wl_pointer_axis
	relative_direction Wl_pointer_axis_relative_direction
	delta              f64
	delta_discrete     int
}

pub struct C.wlr_pointer_swipe_begin_event {
	pointer   &C.wlr_pointer
	time_msec u32
	fingers   u32
}

pub struct C.wlr_pointer_swipe_update_event {
	pointer   &C.wlr_pointer
	time_msec u32
	fingers   u32
	dx        f64
	dy        f64
}

pub struct C.wlr_pointer_swipe_end_event {
	pointer   &C.wlr_pointer
	time_msec u32
	cancelled bool
}

pub struct C.wlr_pointer_pinch_begin_event {
	pointer   &C.wlr_pointer
	time_msec u32
	fingers   u32
}

pub struct C.wlr_pointer_pinch_update_event {
	pointer   &C.wlr_pointer
	time_msec u32
	fingers   u32
	dx        f64
	dy        f64
	scale     f64
	rotation  f64
}

pub struct C.wlr_pointer_pinch_end_event {
	pointer   &C.wlr_pointer
	time_msec u32
	cancelled bool
}

pub struct C.wlr_pointer_hold_begin_event {
	pointer   &C.wlr_pointer
	time_msec u32
	fingers   u32
}

pub struct C.wlr_pointer_hold_end_event {
	pointer   &C.wlr_pointer
	time_msec u32
	cancelled bool
}

pub fn C.wlr_pointer_from_input_device(input_device C.wlr_input_device) C.wlr_pointer
