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

#include "wlr/render/pass.h"

pub struct C.wlr_renderer {}

pub struct C.wlr_buffer {}

pub struct C.wlr_render_pass {}

pub struct C.wlr_render_timer {}

pub struct C.wlr_buffer_pass_options {
	timer           &C.wlr_render_timer
	color_transform &C.wlr_color_transform
	signal_timeline &C.wlr_drm_syncobj_timeline
	signal_point    u64
}

pub fn C.wlr_renderer_begin_buffer_pass(renderer &C.wlr_renderer, buffer &C.wlr_buffer, options &C.wlr_buffer_pass_options) &C.wlr_render_pass

pub fn C.wlr_render_pass_submit(pass &C.wlr_render_pass) bool

pub enum Wlr_render_blend_mode {
	premultiplied
	none
}

pub enum Wlr_scale_filter_mode {
	bilinear
	nearest
}

pub struct C.wlr_render_texture_options {
	texture     &C.wlr_texture
	src_box     C.wlr_fbox
	dst_box     C.wlr_box
	alpha       &f32
	clip        &C.pixman_region32_t
	transform   Wl_output_transform
	filter_mode Wlr_scale_filter_mode
	blend_mode  Wlr_render_blend_mode

	wait_timeline &C.wlr_drm_syncobj_timeline
	wait_point    u64
}

pub fn C.wlr_render_pass_add_texture(pass &C.wlr_render_pass, options &C.wlr_render_texture_options)

pub struct C.wlr_render_color {
	r f32
	g f32
	b f32
	a f32
}

pub struct C.wlr_render_rect_options {
	box        C.wlr_box
	color      C.wlr_render_color
	clip       &C.pixman_region32_t
	blend_mode Wlr_render_blend_mode
}

pub fn C.wlr_render_pass_add_rect(pass &C.wlr_render_pass, options &C.wlr_render_rect_options)
