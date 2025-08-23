module wlr

import util

#flag linux -DWLR_USE_UNSTABLE
#flag linux -I/usr/include/
#flag linux -I/usr/include/wlroots-0.20
#flag linux -lwlroots-0.20
#include <wlr/xcursor.h>

pub struct C.wlr_xcursor_image {
pub:
	width     u32
	height    u32
	hotspot_x u32
	hotspot_y u32
	delay     u32
	buffer    &u8
}

pub struct C.wlr_xcursor {
pub:
	image_count u32
	images      &&C.wlr_xcursor_image
	name        &u8
	total_delay u32
}

pub struct C.wlr_xcursor_theme {
pub:
	cursor_count u32
	cursors      &&C.wlr_xcursor
	name         &u8
	size         int
}

fn C.wlr_xcursor_theme_load(name &char, size int) &C.wlr_xcursor_theme
fn C.wlr_xcursor_theme_destroy(theme &C.wlr_xcursor_theme)

fn C.wlr_xcursor_theme_get_cursor(theme &C.wlr_xcursor_theme, name &char) &C.wlr_xcursor
fn C.wlr_xcursor_frame(theme &C.wlr_xcursor_theme, time u32) &C.wlr_xcursor
fn C.wlr_xcursor_get_resize_name(edges Wlr_edges) &char
