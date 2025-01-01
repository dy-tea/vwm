module wlr

import pixman

#flag linux -I/usr/include
#flag linux -I/usr/include/pixman-1
#flag linux -I/usr/include/wayland-protocols
#flag -I @VMODROOT
#flag linux -I/usr/include/wlroots-0.19
#flag linux -Lwlroots
#flag linux -DWLR_USE_UNSTABLE

#include "wlr/types/wlr_output_layer.h"

pub struct C.wlr_output_layer {
	link   C.wl_list
	addons C.wlr_addon_set

	events struct {
		feedback C.wl_signal
	}

	data voidptr

	wlr_private struct {
		src_box C.wlr_fbox
		dst_box C.wlr_box
	}
}

pub struct C.wlr_output_layer_state {
	layer    &C.wlr_output_layer
	buffer   &C.wlr_buffer
	src_box  C.wlr_fbox
	dst_box  C.wlr_box
	damage   &pixman.Pixman_region32_t
	accepted bool
}

pub struct C.wlr_output_layer_feedback_event {
	target_device C.dev_t
	formats       &C.wlr_drm_format_set
}

pub fn C.wlr_output_layer_create(output &C.wlr_output) &C.wlr_output_layer
pub fn C.wlr_output_layer_destroy(layer &C.wlr_output_layer)
