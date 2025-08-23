module types

#flag linux -DWLR_USE_UNSTABLE
#flag linux -I/usr/include/
#flag linux -I/usr/include/wlroots-0.20
#flag linux -lwlroots-0.20
#include <wlr/types/wlr_compositor.h>

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
pub:
	committed u32
	seq       u32

	buffer &C.wlr_buffer
	dx     i32
	dy     i32

	scale               i32
	frame_callback_list C.wl_list

	width         int
	height        int
	buffer_width  int
	buffer_height int

	subsurfaces_below C.wl_list
	subsurfaces_above C.wl_list

	viewport struct {
		has_src    bool
		has_dst    bool
		src        C.wlr_fbox
		dst_width  int
		dst_height int
	}

	cached_state_locks usize
	cached_state_link  C.wl_list
	//...
}

pub struct C.wlr_surface_role {
pub:
	name &u8

	no_object bool

	client_commit fn (surface &C.wlr_surface)
	commit        fn (surface &C.wlr_surface)
	map           fn (surface &C.wlr_surface)
	unmap         fn (surface &C.wlr_surface)
	destroy       fn (surface &C.wlr_surface)
}

pub struct C.wlr_surface_output {
pub:
	surface &C.wlr_surface
	output  &C.wlr_output

	link C.wl_list
}

pub struct C.wlr_surface {
pub:
	resource   &C.wl_resource
	compositor &C.wlr_compositor

	buffer &C.wlr_client_buffer
	//...

	current C.wlr_surface_state
	pending C.wlr_surface_state

	cached C.wl_list

	mapped bool

	role    &C.wlr_surface_role
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

	// ...
pub mut:
	data voidptr
}

pub struct C.wlr_compositor {
pub:
	events struct {
	pub:
		display_destroy C.wl_signal
		renderer_destroy C.wl_signal
	}
}

fn C.wlr_compositor_create(display &C.wl_display, version u32, renderer &C.wlr_renderer) &C.wlr_compositor
