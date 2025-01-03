module wlr

#flag linux -I/usr/include
#flag linux -I/usr/include/pixman-1
#flag linux -I/usr/include/wayland-protocols
#flag -I @VMODROOT
#flag linux -I/usr/include/wlroots-0.19
#flag linux -lwayland-server
#flag linux -lwlroots-0.19
#flag linux -DWLR_USE_UNSTABLE

#include "wlr/render/wlr_renderer.h"

struct C.wlr_backend {}

struct C.wlr_renderer_impl {}

struct C.wlr_drm_format_set {}

struct C.wlr_buffer {}

struct C.wlr_box {}

struct C.wlr_fbox {}

pub struct C.wlr_renderer {
	render_buffer_caps u32
	events             struct {
		destroy C.wl_signal
		lost    C.wl_signal
	}
	features           struct {
		output_color_tranforms bool
		timeline               bool
	}
	wlr_private        struct {
		impl C.wlr_renderer_impl
	}
}

pub fn C.wlr_renderer_autocreate(backend &C.wlr_backend) &C.wlr_renderer

pub fn C.wlr_renderer_get_texture_formats(r &C.wlr_renderer, buffer_caps u32) C.wlr_drm_format_set

pub fn C.wlr_renderer_init_wl_display(r &C.wlr_renderer, wl_display &C.wl_display) bool

pub fn C.wlr_renderer_init_wl_shm(r &C.wlr_renderer, wl_display &C.wl_display) bool

pub fn C.wlr_renderer_get_drm_fd(r &C.wlr_renderer) int

pub fn C.wlr_renderer_destroy(renderer &C.wlr_renderer)

pub fn C.wlr_render_timer_create(renderer &C.wlr_renderer) C.wlr_render_timer

pub fn C.wlr_render_timer_get_duration_ns(timer &C.wlr_render_timer) int

pub fn C.wlr_render_timer_destroy(timer &C.wlr_render_timer)
