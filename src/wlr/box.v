module wlr

#flag linux -I/usr/include
#flag linux -I/usr/include/pixman-1
#flag linux -I/usr/include/wayland-protocols
#flag -I @VMODROOT
#flag linux -I/usr/include/wlroots-0.19
#flag linux -Lwlroots
#flag linux -DWLR_USE_UNSTABLE

#include "wlr/util/box.h"

pub struct C.wlr_box {
	x      int
	y      int
	width  int
	height int
}

pub struct C.wlr_fbox {
	x      f64
	y      f64
	width  f64
	height f64
}

pub fn C.wlr_box_closest_point(box &C.wlr_box, x f64, y f64, dest_x &f64, dest_y &f64)
pub fn C.wlr_box_intersection(dest &C.wlr_box, box_a &C.wlr_box, box_b &C.wlr_box) bool
pub fn C.wlr_box_contains_point(box &C.wlr_box, x f64, y f64) bool
pub fn C.wlr_box_contains_box(bigger &C.wlr_box, smaller &C.wlr_box) bool
pub fn C.wlr_box_empty(box &C.wlr_box) bool
pub fn C.wlr_box_transform(dest &C.wlr_box, box &C.wlr_box, transform Wl_output_transform, width int, height int)

pub fn C.wlr_fbox_empty(box &C.wlr_fbox) bool
pub fn C.wlr_fbox_transform(dest &C.wlr_fbox, box &C.wlr_fbox, transform Wl_output_transform, width f64, height f64)

pub fn C.wlr_box_equal(a &C.wlr_box, b &C.wlr_box) bool
pub fn C.wlr_fbox_equal(a &C.wlr_fbox, b &C.wlr_fbox) bool
