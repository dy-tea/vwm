module wlr

import pixman

#flag linux -I/usr/include
#flag linux -I/usr/include/pixman-1
#flag linux -I/usr/include/wayland-protocols
#flag -I @VMODROOT
#flag linux -I/usr/include/wlroots-0.19
#flag linux -Lwlroots
#flag linux -DWLR_USE_UNSTABLE

#include "wlr/types/wlr_compositor.h"

enum Wlr_surface_state_field {
	buffer              = 1 << 0
	surface_damage      = 1 << 1
	buffer_damage       = 1 << 2
	opaque_region       = 1 << 3
	input_region        = 1 << 4
	transform           = 1 << 5
	scale               = 1 << 6
	frame_callback_last = 1 << 7
	viewport            = 1 << 8
	offset              = 1 << 9
}

struct C.wlr_surface_state {
	committed u32
	seq       u32

	buffer              C.wlr_buffer
	dx                  int
	dy                  int
	surface_damage      pixman.Pixman_region32_t
	buffer_damage       pixman.Pixman_region32_t
	opaque_region       pixman.Pixman_region32_t
	input_region        pixman.Pixman_region32_t
	transform           Wl_output_transform
	scale               int
	frame_callback_last C.wl_list

	width         int
	height        int
	buffer_width  int
	buffer_height int

	subsurfaces_below C.wl_list
	subsufaces_above  C.wl_list

	viewport struct {
		has_src    bool
		has_dst    bool
		src        C.wlr_fbox
		dst_width  int
		dst_height int
	}

	chached_state_locks usize
	chached_state_link  C.wl_list

	synced C.wl_array
}

struct C.wlr_surface_role {
	const_name &char
	no_object  bool
	// je ne sais pas
}

struct C.wlr_surface_output {
	surface C.wlr_surface
	output  C.wlr_output

	link C.wl_list

	wlr_private struct {
		bind    C.wl_listener
		destroy C.wl_listener
	}
}

pub struct C.wlr_surface {
	resource        C.wl_resource
	compositor      C.wlr_compositor
	buffer          C.wlr_client_buffer
	buffer_damage   pixman.Pixman_region32_t
	opaque_region   pixman.Pixman_region32_t
	input_region    pixman.Pixman_region32_t
	current         C.wlr_surface_state
	pending         C.wlr_surface_state
	chached         C.wl_list
	mapped          bool
	role            C.wlr_surface_role
	role_resource   C.wl_resource
	events          struct {
		client_commit  C.wl_signal
		commit         C.wl_signal
		map            C.wl_signal
		unmap          C.wl_signal
		new_subsurface C.wl_signal
		destroy        C.wl_signal
	}
	current_outputs C.wl_list
	addons          C.wlr_addon_set
	data            voidptr
	wlr_private     struct {
		role_resource_destroy           C.wl_listener
		previous                        struct {
			scale         int
			transform     Wl_output_transform
			width         int
			height        int
			buffer_width  int
			buffer_height int
		}
		unmap_commit                    bool
		opaque                          bool
		handling_commit                 bool
		pending_rejected                bool
		preferred_buffer_scale          bool
		preferred_buffer_transform_set  bool
		preferred_buffer_transform      Wl_output_transform
		synced                          C.wl_list
		synced_len                      usize
		pending_buffer_resource         C.wl_resource
		pending_buffer_resource_destroy C.wl_listener
	}
}

pub struct C.wlr_renderer {}

pub struct C.wlr_compositor {
	global      C.wl_global
	renderer    C.wlr_renderer
	events      struct {
		new_surface C.wl_signal
		destroy     C.wl_signal
	}
	wlr_private struct {
		display_destroy  C.wl_listener
		renderer_destroy C.wl_listener
	}
}
