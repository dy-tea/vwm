module wlr

#flag linux -I/usr/include
#flag linux -I/usr/include/pixman-1
#flag linux -I/usr/include/wayland-protocols
#flag -I @VMODROOT
#flag linux -I/usr/include/wlroots-0.19
#flag linux -lwayland-server
#flag linux -lwlroots-0.19
#flag linux -DWLR_USE_UNSTABLE

#include "wlr/render/allocator.h"

pub struct C.wlr_allocator_interface {
	create_buffer fn (alloc &C.wlr_allocator, width int, height int, format &C.wlr_drm_format) &C.wlr_buffer
	destroy       fn (alloc &C.wlr_allocator)
}

pub fn C.wlr_allocator_init(alloc &C.wlr_allocator, impl &C.wlr_allocator_interface, buffer_caps u32)

pub struct C.wlr_allocator {
	impl           &C.wlr_allocator_interface
	buffer_caps    u32
	events_destroy C.wl_signal
}

pub fn C.wlr_allocator_autocreate(backend &C.wlr_backend, renderer &C.wlr_renderer) &C.wlr_allocator
pub fn C.wlr_allocator_destroy(alloc &C.wlr_allocator)

pub fn C.wlr_allocator_create_buffer(alloc &C.wlr_allocator, width int, height int, format &C.wlr_drm_format) &C.wlr_buffer
