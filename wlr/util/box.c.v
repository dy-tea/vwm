module util

#flag linux -DWLR_USE_UNSTABLE
#pkgconfig wlroots-0.20
#include <wlr/util/box.h>

pub struct C.wlr_box {
	x      int
	y      int
	width  int
	height int
}

pub struct C.wlr_fbox {
	x      f32
	y      f32
	width  f32
	height f32
}

fn C.wlr_box_empty(box &C.wlr_box) bool
