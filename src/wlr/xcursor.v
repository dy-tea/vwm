module wlr

#flag linux -I/usr/include
#flag linux -I/usr/include/pixman-1
#flag linux -I/usr/include/wayland-protocols
#flag -I @VMODROOT
#flag linux -I/usr/include/wlroots-0.19
#flag linux -lwayland-server
#flag linux -lwlroots-0.19
#flag linux -DWLR_USE_UNSTABLE

#include "wlr/xcursor.h"

pub struct C.wlr_xcursor_image {
	width     u32
	height    u32
	hotspot_x u32
	hotspot_y u32
	delay     u32
	buffer    []u8
}

pub struct C.wlr_xcursor {
	image_count u32
	images      &C.wlr_xcursor_image
	name        string
	total_delay u32
}

pub struct C.wlr_xcursor_theme {
	cursor_count u32
	cursors      &C.wlr_xcursor
	name         string
	size         int
}

pub fn C.wlr_xcursor_theme_load(name string, size int) &C.wlr_xcursor_theme
pub fn C.wlr_xcursor_theme_destroy(theme &C.wlr_xcursor_theme)

pub fn C.wlr_xcursor_theme_get_cursor(theme &C.wlr_xcusor_theme, name string) &C.wlr_xcursor
pub fn C.wlr_xcursor_frame(cursor &C.wlr_xcursor, time u32) int
pub fn C.wlr_xcursor_get_resize_name(edges Wlr_edges) string
