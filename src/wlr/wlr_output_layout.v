module wlr

#flag linux -I/usr/include
#flag linux -I/usr/include/pixman-1
#flag linux -I/usr/include/wayland-protocols
#flag -I @VMODROOT
#flag linux -I/usr/include/wlroots-0.19
#flag linux -Lwlroots
#flag linux -DWLR_USE_UNSTABLE

#include "wlr/types/wlr_output_layout.h"

pub struct C.wlr_box {}

pub struct C.wlr_output_layout {
	outputs C.wl_list
	display C.wlr_display

	events struct {
		add     C.wl_signal
		change  C.wl_signal
		destroy C.wl_signal
	}

	data voidptr

	wlr_private struct {
		display_destroy C.wl_listener
	}
}

pub struct C.wlr_output_layout_output {
	layout C.wlr_output_layout
	output C.wlr_output

	x    int
	y    int
	link C.wl_list

	auto_configured bool

	events struct {
		destroy C.wl_signal
	}

	wlr_private struct {
		addon  C.wlr_addon
		commit C.wl_listener
	}
}

pub fn C.wlr_output_layout_create(display C.wl_display) C.wlr_output_layout

pub fn C.wlr_output_layout_destroy(layout C.wlr_output_layout)

pub fn C.wlr_output_layout_get(layout C.wlr_output_layout, reference C.wlr_output) C.wlr_output_layout_output

pub fn C.wlr_output_layout_output_at(layout C.wlr_output_layout, lx f64, ly f64) C.wlr_output

pub fn C.wlr_output_layout_add(layout C.wlr_output_layout, output C.wlr_output, lx int, ly int) C.wlr_output_layout_output

pub fn C.wlr_output_layout_add_auto(layout C.wlr_output_layout, output C.wlr_output) C.wlr_output_layout_output

pub fn C.wlr_output_layout_remove(layout C.wlr_output_layout, output C.wlr_output)

pub fn C.wlr_output_layout_output_coords(layout C.wlr_output_layout, reference C.wlr_output, lx f64, ly f64)
pub fn C.wlr_output_layout_contains_point(layout C.wlr_output_layout, reference C.wlr_output, lx int, ly int) bool
pub fn C.wlr_output_layout_intersects(layout C.wlr_output_layout, reference C.wlr_output, target_lbox C.wlr_box) bool

pub fn C.wlr_output_layout_closest_point(layout C.wlr_output_layout, reference C.wlr_output, lx f64, ly f64, dest_lx f64, dest_ly f64)

pub fn C.wlr_output_layout_get_box(layout C.wlr_output_layout, reference C_wlr_output, dest_box C.wlr_box)

pub fn C.wlr_output_layout_get_center_output(layout C.wlr_output_layout) C.wlr_output

pub enum Wlr_direction {
	up    = 1 << 0
	down  = 1 << 1
	left  = 1 << 2
	right = 1 << 3
}

pub fn C.wlr_output_layout_adjacent_output(layout C.wlr_output_layout, direction Wlr_direction, reference C.wlr_output, ref_lx f64, ref_ly f64) C.wlr_output
pub fn C.wlr_output_layout_farthest_output(layout C.wlr_output_layout, direction Wlr_direction, reference C.wlr_output, ref_lx f64, ref_ly f64) C.wlr_output
