module types

import wlr.util

#flag linux -DWLR_USE_UNSTABLE
#flag linux -I@VMODROOT/protocols
#pkgconfig wlroots-0.20
#include <wlr/types/wlr_layer_shell_v1.h>

pub struct C.wlr_layer_shell_v1 {
pub:
	global &C.wl_global

	events struct {
	pub:
		new_surface C.wl_signal
		destroy C.wl_signal
	}

pub mut:
	data voidptr
}

pub enum Wlr_layer_surface_v1_state_field {
	desired_size = 1 << 0
	anchor = 1 << 1
	exclusive_zone = 1 << 2
	margin = 1 << 3
	keyboard_interactivity = 1 << 4
	layer = 1 << 5
	exclusive_edge = 1 << 6
}

pub struct C.wlr_layer_surface_v1_state {
pub:
	committed u32

	anchor u32
	exlusive_zone i32
	margin struct {
	pub:
		top i32
		right i32
		bottom i32
		left i32
	}
	keyboard_interactive Zwlr_layer_surface_v1_keyboard_interactivity
	desired_width u32
	desired_height u32
	layer Zwlr_layer_shell_v1_layer
	exlucsive_edge u32

	configure_serial u32
	actual_width u32
	actual_height u32
}

pub struct C.wlr_layer_surface_v1_configure {
pub:
	link C.wl_list
	serial u32

	width u32
	height u32
}

pub struct C.wlr_layer_surface_v1 {
pub:
	surface &C.wlr_surface
	output &C.wlr_output
	resource &C.wl_resource
	shell &C.wlr_layer_shell_v1
	popups C.wl_list

	namespace &char

	configured bool
	configure_list C.wl_list

	current C.wlr_layer_surface_v1_state
	pending C.wlr_layer_surface_v1_state

	initialized bool
	initial_commit bool

	events struct {
	pub:
		destroy C.wl_signal
		new_popup C.wl_signal
	}
pub mut:
	data voidptr
}

pub fn C.wlr_layer_shell_v1_create(display &C.wl_display, version u32) &C.wlr_layer_shell_v1

pub fn C.wlr_layer_surface_v1_configure(surface &C.wlr_layer_surface_v1, width u32, height u32) u32
pub fn C.wlr_layer_surface_v1_destroy(surface &C.wlr_layer_surface)
pub fn C.wlr_layer_surface_v1_try_from_wlr_surface(surface &C.wlr_surface) &C.wlr_layer_surface_v1
// pub fn C.wlr_layer_surface_v1_for_each_surface(surface &C.wlr_layer_surface_v1, iterator Wlr_surface_iterator_func_t, user_data voidptr)
// pub fn C.wlr_layer_surface_v1_for_each_popup_surface(surface &C.wlr_layer_surface_v1, iterator Wlr_surface_iterator_func_t, user_data voidptr)
pub fn C.wlr_layer_surface_v1_surface_at(surface &C.wlr_layer_surface_v1, sx f64, sy f64, sub_x &f64, sub_y &f64) &C.wlr_surface
pub fn C.wlr_layer_surface_v1_popup_surface_at(surface &C.wlr_layer_surface_v1, sx f64, sy f64, sub_x &f64, sub_y &f64) &C.wlr_surface
pub fn C.wlr_layer_surface_from_resource(resource &C.wl_resource) &C.wlr_layer_surface_v1
pub fn C.wlr_layer_surface_v1_get_exclusive_edge(surface &C.wlr_layer_surface_v1) util.Wlr_edges

pub enum Zwlr_layer_shell_v1_error {
	role = 0
	invalid_layer = 1
	already_constructed = 2
}

pub enum Zwlr_layer_shell_v1_layer {
	background = 0
	bottom = 1
	top = 2
	overlay = 3
}

pub enum Zwlr_layer_surface_v1_keyboard_interactivity {
	none = 0
	exclusive = 1
	on_demand = 2
}

pub enum Zwlr_layer_surface_v1_error {
	invalid_surface_state = 0
	invalid_size = 1
	invalid_anchor = 2
	invalid_keyboard_interactivity = 3
	invalid_exclusive_edge = 4
}

pub enum Zwlr_layer_surface_v1_anchor {
	top = 1
	bottom = 2
	left = 4
	right = 8
}
