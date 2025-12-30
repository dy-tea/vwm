module types

#flag linux -DWLR_USE_UNSTABLE
#pkgconfig wlroots-0.20
#include <wlr/types/wlr_output_layout.h>

pub struct C.wlr_output_layout {
pub:
	outputs C.wl_list
	display &C.wl_display

	events struct {
	pub:
		add     C.wl_signal
		change  C.wl_signal
		destroy C.wl_signal
	}
pub mut:
	data voidptr
}

pub struct C.wlr_output_layout_output {
pub:
	layout &C.wlr_output_layout

	output &C.wlr_output

	x    int
	y    int
	link C.wl_list

	auto_configured bool

	events struct {
	pub:
		destroy C.wl_signal
	}
}

fn C.wlr_output_layout_create(display &C.wl_display) &C.wlr_output_layout
fn C.wlr_output_layout_destroy(output_layout &C.wlr_output_layout)
fn C.wlr_output_layout_get(layout &C.wlr_output_layout, reference &C.wlr_output) &C.wlr_output_layout
fn C.wlr_output_layout_output_at(layout &C.wlr_output_layout, lx f64, ly f64) &C.wlr_output
fn C.wlr_output_layout_add(layout &C.wlr_output_layout, output &C.wlr_output, lx int, ly int) &C.wlr_output_layout_output
fn C.wlr_output_layout_add_auto(layout &C.wlr_output_layout, output &C.wlr_output) &C.wlr_output_layout_output
fn C.wlr_output_layout_remove(layout &C.wlr_output_layout, output &C.wlr_output)

fn C.wlr_output_layout_output_coords(layout &C.wlr_output_layout, reference &C.wlr_output, lx &f64, ly &f64)
fn C.wlr_output_layout_contains_point(layout &C.wlr_output_layout, reference &C.wlr_output, lx int, ly int) bool
fn C.wlr_output_layout_intersects(layout &C.wlr_output_layout, reference &C.wlr_output, const_target_lbox &C.wlr_box) bool

fn C.wlr_output_layout_closest_point(layout &C.wlr_output_layout, reference &C.wlr_output, lx f64, ly f64, dest_lx &f64, dest_ly &f64)
fn C.wlr_output_layout_get_box(layout &C.wlr_output_layout, reference &C.wlr_output, dest_box &C.wlr_box)

fn C.wlr_output_layout_get_center_output(layout &C.wlr_output_layout) &C.wlr_output

pub enum Wlr_direction {
	up    = 1 << 0
	down  = 1 << 1
	left  = 1 << 2
	right = 1 << 3
}

fn C.wlr_output_layout_adjacent_output(layout &C.wlr_output_layout, direction Wlr_direction, reference &C.wlr_output, ref_lx f64, ref_ly f64) &C.wlr_output
fn C.wlr_output_layout_farthest_output(layout &C.wlr_output_layout, direction Wlr_direction, reference &C.wlr_output, ref_lx f64, ref_ly f64) &C.wlr_output
