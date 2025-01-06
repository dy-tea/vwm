module wlr

#flag linux -I/usr/include
#flag linux -I/usr/include/pixman-1
#flag linux -I/usr/include/wayland-protocols
#flag -I @VMODROOT
#flag linux -I/usr/include/wlroots-0.19
#flag linux -lwayland-server
#flag linux -lwlroots-0.19
#flag linux -DWLR_USE_UNSTABLE

#include "wlr/render/swapchain.h"

const wlr_swapchain_cap = 4

pub struct C.wlr_swapchain_slot {
	buffer   &C.wlr_buffer
	acquired bool

	WLR_PRIVATE struct {
		release C.wl_listener
	}
}

pub struct C.wlr_swapchain {
	allocator &C.wlr_allocator

	width  int
	height int
	format &C.wlr_drm_format

	slots [wlr_swapchain_cap]C.wlr_swapchain_slot

	WLR_PRIVATE struct {
		allocator_destroy C.wl_listener
	}
}

pub fn C.wlr_swapchain_create(allocator &C.wlr_allocator, width int, height int, format &C.wlr_drm_format) &C.wlr_swapchain
pub fn C.wlr_swapchain_destroy(swapchain &C.wlr_swapchain)

pub fn C.wlr_swapchain_acquire(swapchain &C.wlr_swapchain) &C.wlr_buffer
pub fn C.wlr_swapchain_has_buffer(swapchain &C.wlr_swapchain, buffer &C.wlr_buffer) bool
