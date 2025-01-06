module wlr

#flag linux -I/usr/include
#flag linux -I/usr/include/pixman-1
#flag linux -I/usr/include/wayland-protocols
#flag -I @VMODROOT
#flag linux -I/usr/include/wlroots-0.19
#flag linux -Lwayland-server
#flag linux -lwlroots-0.19
#flag linux -DWLR_USE_UNSTABLE

#include "wlr/types/wlr_subcompositor.h"

pub struct C.wlr_subsurface_parent_state {
	x    u32
	y    u32
	link C.wl_list

	WLR_PRIVATE struct {
		synced &C.wlr_surface_synced
	}
}

pub struct C.wlr_subsurface {
	resource &C.wl_resource
	surface  &C.wlr_surface
	parent   &C.wlr_surface

	current &C.wlr_subsurface_parent_state
	pending &C.wlr_subsurface_parent_state

	cached_seq u32
	has_cache  bool

	synchronized bool
	added        bool

	events struct {
		destroy &C.wl_signal
	}

	data voidptr

	WLR_PRIVATE struct {
		parent_synced C.wl_listener

		surface_client_commit C.wl_listener
		parent_destroy        C.wl_listener
	}
}

pub struct C.wlr_subcompositor {
	global &C.wl_global

	events struct {
		destroy &C.wl_signal
	}

	WLR_PRIVATE struct {
		display_destroy C.wl_listener
	}
}

pub fn C.wlr_subsurface_try_from_wlr_surface(surface &C.wlr_surface) &C.wlr_subsurface

pub fn C.wlr_subcompositor_create(display &C.wl_display) &C.wlr_subcompositor
