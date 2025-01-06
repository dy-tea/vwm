module wlr

import pixman

#flag linux -I/usr/include
#flag linux -I/usr/include/pixman-1
#flag linux -I/usr/include/wayland-protocols
#flag -I @VMODROOT
#flag linux -I/usr/include/wlroots-0.19
#flag linux -lwayland-server
#flag linux -lwlroots-0.19
#flag linux -DWLR_USE_UNSTABLE

#include "wlr/render/wlr_texture.h"

pub struct C.wlr_buffer {}

pub struct C.wlr_renderer {}

pub struct C.wlr_texture_impl {}

pub struct C.wlr_texture {
	impl     &C.wlr_texture_impl
	width    u32
	height   u32
	renderer &C.wlr_renderer
}

pub struct C.wlr_texture_read_pixels_options {
	data    voidptr
	format  u32
	stride  u32
	dst_x   u32
	dst_y   u32
	src_box C.wlr_box
}

pub fn C.wlr_texture_read_pixels(texture &C.wlr_texture, options &C.wlr_texture_read_pixels_options) bool
pub fn C.wlr_texture_preferred_read_format(texture &C.wlr_texture) u32

pub fn C.wlr_texture_from_pixels(renderer &C.wlr_renderer, wl_fmt u32, stride u32, width u32, height u32, data voidptr) &C.wlr_texture
pub fn C.wlr_texture_from_dmabuf(renderer &C.wlr_renderer, attribs &C.wlr_dmabuf_attributes) &C.wlr_texture

pub fn C.wlr_texture_update_from_buffer(texture &C.wlr_texture, buffer &C.wlr_buffer, damage &C.pixman_region32_t) bool

pub fn C.wlr_texture_destroy(texture &C.wlr_texture)

pub fn C.wlr_texture_from_buffer(renderer &C.wlr_renderer, buffer &C.wlr_buffer) &C.wlr_texture
