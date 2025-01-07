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

#include "wlr/types/wlr_compositor.h"

pub enum Wlr_surface_state_field {
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

pub struct C.wlr_surface_state {
	committed u32
	seq       u32

	buffer              &C.wlr_buffer
	dx                  int
	dy                  int
	surface_damage      C.pixman_region32_t
	buffer_damage       C.pixman_region32_t
	opaque              C.pixman_region32_t
	input               C.pixman_region32_t
	transform           Wl_output_transform
	scale               int
	frame_callback_list C.wl_list

	width         int
	height        int
	buffer_width  int
	buffer_height int

	subsurfaces_below C.wl_list
	subsurfaces_above C.wl_list

	viewport struct {
	pub:
		has_src bool
		has_dst bool
		src     C.wlr_box
		dst     C.wlr_box
	}

	cached_state_locks usize
	cached_state_link  C.wl_list

	synced C.wl_array
}

pub struct C.wlr_surface_role {
	const_name &char
	no_object  bool

	client_commit fn (surface &C.wlr_surface)
	commit        fn (surface &C.wlr_surface)
	map           fn (surface &C.wlr_surface)
	unmap         fn (surface &C.wlr_surface)
	destroy       fn (surface &C.wlr_surface)
}

pub struct C.wlr_surface_output {
	surface &C.wlr_surface
	output  &C.wlr_output
	link    C.wl_list

	WLR_PRIVATE struct {
		bind    C.wl_listener
		destroy C.wl_listener
	}
}

pub struct C.wlr_surface {
	resource      &C.wl_resource
	compositor    &C.wlr_compositor
	buffer        &C.wlr_client_buffer
	buffer_damage C.pixman_region32_t
	opaque_region C.pixman_region32_t
	input_region  C.pixman_region32_t
	current       C.wlr_surface_state
	pending       C.wlr_surface_state
	cached        C.wl_list
	mapped        bool
	role          &C.wlr_surface_role
	role_resource &C.wl_resource

	events struct {
	pub:
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
	WLR_PRIVATE     struct {
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
	global      &C.wl_global
	renderer    &C.wlr_renderer = unsafe { nil }
	events      struct {
		new_surface C.wl_signal
		destroy     C.wl_signal
	}
	WLR_PRIVATE struct {
		display_destroy  C.wl_listener
		renderer_destroy C.wl_listener
	}
}

pub type Wlr_surface_iterator_func_t = fn (surface &C.wlr_surface, sx int, sy int, data voidptr)

pub fn C.wlr_surface_set_role(surface &C.wlr_surface, role &C.wlr_surface_role, error_resource &C.wl_resource, error_code u32) bool
pub fn C.wlr_surface_set_role_object(surface &C.wlr_surface, role_resource &C.wl_resource) bool
pub fn C.wlr_surace_map(surface &C.wlr_surface)
pub fn C.wlr_surface_unmap(surface &C.wlr_surface)
pub fn C.wlr_surface_reject_pending(surface &C.wlr_surface, resource &C.wl_resource, code u32, msg string, ...)
pub fn C.wlr_surface_has_buffer(surface &C.wlr_surface) bool
pub fn C.wlr_surface_get_texture(surface &C.wlr_surface) &C.wlr_texture
pub fn C.wlr_surface_get_root_surface(surface &C.wlr_surface) &C.wlr_surface
pub fn C.wlr_surface_point_accepts_input(surface &C.wlr_surface, sx f64, sy f64) bool
pub fn C.wlr_surface_at(surface &C.wlr_surface, sx int, sy int, sub_x &int, sub_y &int) &C.wlr_surface
pub fn C.wlr_surface_send_enter(surface &C.wlr_surface, output &C.wlr_output)
pub fn C.wlr_surface_send_leave(surface &C.wlr_surface, output &C.wlr_output)
pub fn C.wlr_surface_send_frame_done(surface &C.wlr_surface, when &C.timespec)
pub fn C.wlr_surface_get_extents(surface &C.wlr_surface, box &C.wlr_box)
pub fn C.wlr_surface_from_resource(resource &C.wl_resource) &C.wlr_surface
pub fn C.wlr_surface_for_each_surface(surface &C.wlr_surface, iterator Wlr_surface_iterator_func_t, data voidptr)
pub fn C.wlr_surface_get_effective_damage(surface &C.wlr_surface, damage &C.pixman_region32_t)
pub fn C.wlr_surface_get_buffer_source_box(surface &C.wlr_surface, box &C.wlr_fbox)
pub fn C.wlr_surface_lock_pending(surface &C.wlr_surface) u32
pub fn C.wlr_surface_unlock_cached(surface &C.wlr_surface, lock, u32)
pub fn C.wlr_surface_set_preferred_buffer_scale(surface &C.wlr_surface, scale int)
pub fn C.wlr_surface_set_preferred_buffer_transform(surface &C.wlr_surface, transform Wl_output_transform)

pub struct C.wlr_surface_synced_impl {
	state_size   usize
	init_state   fn (state voidptr)
	finish_state fn (state voidptr)
	move_state   fn (dst voidptr, src voidptr)
}

pub struct C.wlr_surface_synced {
	surface &C.wlr_surface
	impl    &C.wlr_surface_synced_impl
	link    C.wl_list
	index   usize
}

pub fn C.wlr_surface_synced_init(synced &C.wlr_surface_synced, surface &C.wlr_surface, impl &C.wlr_surface_synced_impl, pending voidptr, current voidptr) &C.wlr_surface_synced
pub fn C.wlr_surface_synced_finish(synced &C.wlr_surface_synced)
pub fn C.wlr_surface_synced_get_state(synced &C.wlr_surface_synced) voidptr

pub fn C.wlr_region_from_resource(resource &C.wl_resource) &C.pixman_region32_t

pub fn C.wlr_compositor_create(display &C.wl_display, version u32, renderer &C.wlr_renderer) &C.wlr_compositor
pub fn C.wlr_compositor_set_renderer(compositor &C.wlr_compositor, renderer &C.wlr_renderer)
