module wlr

#flag linux -I/usr/include
#flag linux -I/usr/include/pixman-1
#flag linux -I/usr/include/wayland-protocols
#flag -I @VMODROOT
#flag linux -I/usr/include/wlroots-0.19
#flag linux -Lwlroots
#flag linux -DWLR_USE_UNSTABLE

#include "wlr/render/allocator.h"

pub struct C.wlr_buffer {}

pub struct C.wlr_allocator_interface {
	create_buffer C.wlr_buffer
	destroy       voidptr
}

pub struct C.wlr_allocator {
	impl        C.wlr_allocator_interface
	buffer_caps u32
	events      struct {
		destroy C.wl_signal
	}
}
