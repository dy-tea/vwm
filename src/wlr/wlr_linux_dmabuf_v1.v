module wlr

#flag linux -I/usr/include
#flag linux -I/usr/include/pixman-1
#flag linux -I/usr/include/wayland-protocols
#flag -I @VMODROOT
#flag linux -I/usr/include/wlroots-0.19
#flag linux -Lwlroots
#flag linux -DWLR_USE_UNSTABLE

#include <sys/stat.h>

type C.dev_t = u32

#include "wlr/types/wlr_linux_dmabuf_v1.h"

pub struct C.wlr_dmabuf_v1_buffer {
	base      C.wlr_buffer
	resource  &C.wl_resource
	atributes C.wlr_dmabuf_attributes

	wlr_private struct {
		release C.wl_listener
	}
}

pub fn C.wlr_dmabuf_v1_buffer_try_from_buffer_resource(resource &C.wl_resource) &C.wlr_dmabuf_v1_buffer

pub struct C.wlr_linux_dmabuf_feedback_v1 {
	main_device C.dev_t
	tranches    C.wl_array
}

pub struct C.wlr_linux_dmabuf_feedback_v1_tranche {
	target_device C.dev_t
	flags         u32
	formats       C.wlr_drm_format_set
}

pub struct C.wlr_linux_dmabuf_v1 {
	gloabl &C.wl_global

	events struct {
		destroy C.wl_signal
	}

	wlr_private struct {
		default_feedback voidptr // FIXME: C.wlr_linux_dmabuf_feedback_v1_compiled
		default_formats  C.wlr_drm_format_set
		surfaces         C.wl_list

		main_device_fd int

		display_destroy C.wl_listener

		check_dmabuf_callback      ?fn (attribs &C.wlr_dmabuf_attributes, data voidptr) bool
		check_dmabuf_callback_data voidptr
	}
}

pub fn C.wlr_linux_dmabuf_v1_create(display &C.wl_display, version u32, default_feedback &C.wlr_linux_dmabuf_feedback_v1) &C.wlr_linux_dmabuf_v1
pub fn C.wlr_linux_dmabuf_v1_create_with_renderer(display &C.wl_display, version u32, renderer &C.wlr_renderer) &C.wlr_linux_dmabuf_v1
pub fn C.wlr_linux_dmabuf_v1_set_check_dmabuf_callback(linux_dmabuf &C.wlr_linux_dmabuf_v1, callback ?fn (attribs &C.wlr_dmabuf_attributes, data voidptr) bool, data voidptr)
pub fn C.wlr_linux_dmabuf_v1_set_surface_feedback(linux_dmabuf &C.wlr_linux_dmabuf_v1, surface &C.wlr_surface, feedback &C.wlr_linux_dmabuf_feedback_v1) bool

pub fn C.wlr_linux_dmabuf_feedback_add_tranche(feedback &C.wlr_linux_dmabuf_feedback_v1) &C.wlr_linux_dmabuf_feedback_v1_tranche
pub fn C.wlr_linux_dmabuf_feedback_v1_finish(feedback &C.wlr_linux_dmabuf_feedback_v1)

pub struct C.wlr_linux_dmabuf_feedback_v1_init_options {
	main_renderer               &C.wlr_renderer
	scanout_primary_output      &C.wl_output
	output_layer_feedback_event C.wlr_output_layer_feedback_event
}

pub fn C.wlr_linux_dmabuf_feedback_v1_init_with_options(feedback &C.wlr_linux_dmabuf_feedback_v1, options &C.wlr_linux_dmabuf_feedback_v1_init_options) bool
