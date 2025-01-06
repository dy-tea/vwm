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

#include "wlr/render/interface.h"

pub struct C.wlr_renderer_impl {
	get_texture_formats fn (renderer &C.wlr_renderer, buffer_caps u32) &C.wlr_drm_format_set
	get_render_formats  fn (renderer &C.wlr_renderer) &C.wlr_drm_format_set
	destroy             fn (renderer &C.wlr_renderer)
	get_drm_fd          fn (renderer &C.wlr_renderer) int
	texture_from_buffer fn (renderer &C.wlr_renderer, buffer &C.wlr_buffer) &C.wlr_texture
	begin_buffer_pass   fn (renderer &C.wlr_renderer, buffer &C.wlr_buffer, options &C.wlr_buffer_pass_options) &C.wlr_render_pass
	render_timer_create fn (renderer &C.wlr_renderer) &C.wlr_render_timer
}

pub fn C.wlr_renderer_init(renderer &C.wlr_renderer, impl &C.wlr_renderer_impl, render_buffer_caps u32)

pub struct C.wlr_texture_impl {
	update_from_buffer    fn (texture &C.wlr_texture, buffer &C.wlr_buffer, damage &C.pixman_region32_t) bool
	read_pixels           fn (texture &C.wlr_texture, options &C.wlr_texture_read_pixels_options) bool
	preferred_read_format fn (texture &C.wlr_texture) u32
	destroy               fn (texture &C.wlr_texture)
}

pub fn C.wlr_texture_init(texture &C.wlr_texture, renderer &C.wlr_renderer, impl &C.wlr_texture_impl, width u32, height u32)

pub struct C.wlr_render_pass {
	impl &C.wlr_render_pass_impl
}

pub fn C.wlr_pass_init(pass &C.wlr_render_pass, impl &C.wlr_render_pass_impl)

pub struct C.wlr_render_pass_impl {
	submit      fn (pass &C.wlr_render_pass) bool
	add_texture fn (pass &C.wlr_render_pass, options &C.wlr_render_texture_options)
	add_rect    fn (pass &C.wlr_render_pass, options &C.wlr_render_rect_options)
}

pub struct C.wlr_render_timer {
	impl &C.wlr_render_timer_impl
}

pub struct C.wlr_render_timer_impl {
	get_duration_ns fn (timer &C.wlr_render_timer) int
	destroy         fn (timer &C.wlr_render_timer)
}

pub fn C.wlr_render_texture_options_get_src_box(options &C.wlr_render_texture_options, box &C.wlr_fbox)
pub fn C.wlr_render_texture_options_get_dst_box(options &C.wlr_render_texture_options, box &C.wlr_box)
pub fn C.wlr_render_texture_options_get_alpha(options &C.wlr_render_texture_options) f32
pub fn C.wlr_render_texture_options_get_box(options &C.wlr_render_texture_options, buffer &C.wlr_buffer, box &C.wlr_box)

pub fn C.wlr_texture_read_pixels_options_get_src_box(options &C.wlr_texture_read_pixels_options, texture &C.wlr_texture, box &C.wlr_box)
pub fn C.wlr_texture_read_pixels_options_get_data(options &C.wlr_texture_read_pixels_options) voidptr
