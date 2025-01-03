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

#include <time.h>

pub struct C.timespec {
	tv_sec  int
	tv_nsec int
}

#include "wlr/types/wlr_output.h"

pub enum Wlr_output_mode_aspect_ratio {
	none
	ratio_4_3
	ratio_16_9
	ratio_64_27
	ratio_256_135
}

pub struct C.wlr_output_mode {
	width                int
	height               int
	refresh              int // mHz
	preferred            bool
	picture_aspect_ratio Wlr_output_mode_aspect_ratio
	link                 C.wl_list
}

pub struct C.wlr_output_cursor {
	output        &C.wlr_output
	x             f64
	y             f64
	enabled       bool
	visible       bool
	width         u32
	height        u32
	src_box       C.wlr_fbox
	transform     Wl_output_transform
	hotspot_x     int
	hotspot_y     int
	texture       C.wlr_texture
	own_texture   bool
	wait_timeline C.wlr_drm_syncobj_timeline
	wait_point    u64
	link          C.wl_list

	wlr_private struct {
		renderer_destroy C.wl_listener
	}
}

pub enum Wlr_output_adaptive_sync_status {
	disabled
	enabled
}

pub enum Wlr_output_state_field {
	buffer                = 1 << 0
	damage                = 1 << 1
	mode                  = 1 << 2
	enabled               = 1 << 3
	scale                 = 1 << 4
	transform             = 1 << 5
	adaptive_sync_enabled = 1 << 6
	gamma_lut             = 1 << 7
	render_format         = 1 << 8
	subpixel              = 1 << 9
	layers                = 1 << 10
	wait_timeline         = 1 << 11
	signal_timeline       = 1 << 12
}

pub enum Wlr_output_state_mode_type {
	fixed
	custom
}

pub struct C.wlr_output_state {
	committed             u32
	allow_reconfiguration bool
	damage                pixman.Pixman_region32_t
	enabled               bool
	scale                 f32
	transform             Wl_output_transform
	adaptive_sync_enabled bool
	render_format         u32
	subpixel              Wl_output_subpixel

	buffer         C.wlr_buffer
	buffer_src_box C.wlr_fbox
	buffer_dst_box C.wlr_box

	tearing_page_flip bool

	mode_type   Wlr_output_state_mode_type
	mode        C.wlr_output_mode
	custom_mode struct {
		width   int
		height  int
		refresh int
	}

	gamma_lut      u16
	gamma_lut_size usize

	layers     C.wlr_output_layer_state
	layers_len usize

	wait_timeline   C.wlr_drm_syncobj_timeline
	wait_point      u64
	signal_timeline C.wlr_drm_syncobj_timeline
	signal_point    u64
}

pub struct C.wlr_output_impl {}

pub struct C.wlr_render_pass {}

pub struct C.wlr_output {
	impl       C.wlr_output_impl
	event_loop C.wl_event_loop

	global    C.wl_global
	resources C.wl_list

	name        string
	description string
	make        string
	model       string
	serial      string
	phys_width  int
	phys_height int

	modes        C.wl_list
	current_mode C.wlr_output_mode
	width        int
	height       int
	refresh      int

	enabled              bool
	scale                f32
	subpixel             Wl_output_subpixel
	transform            Wl_output_transform
	adaptive_sync_status Wlr_output_adaptive_sync_status
	render_format        u32

	adaptive_sync_supported bool
	needs_frame             bool
	frame_pending           bool
	non_desktop             bool
	commit_seq              u32

	events struct {
		frame         C.wl_signal
		damage        C.wl_signal
		needs_frame   C.wl_signal
		precommit     C.wl_signal
		commit        C.wl_signal
		present       C.wl_signal
		bind          C.wl_signal
		description   C.wl_signal
		request_state C.wl_signal
		destroy       C.wl_signal
	}

	idle_frame C.wl_event_source
	idle_done  C.wl_event_source

	attach_render_locks int

	cursors               C.wl_list
	hardware_cursor       C.wlr_output_cursor
	cursor_swapchain      C.wlr_swapchain
	cursor_front_buffer   C.wlr_buffer
	software_cursor_locks int

	layers C.wl_list

	allocator C.wlr_allocator
	renderer  C.wlr_renderer
	swapchain C.wlr_swapchain

	addons C.wlr_addon_set

	data voidptr

	wlr_private struct {
		display_destroy C.wl_listener
	}
}

pub struct C.wlr_output_event_damage {
	output C.wlr_output
	damage pixman.Pixman_region32_t
}

pub struct C.wlr_output_event_precommit {
	output C.wlr_output
	when   C.timespec
	state  C.wlr_output_state
}

pub struct C.wlr_output_event_commit {
	output C.wlr_output
	when   C.timespec
	state  C.wlr_output_state
}

pub enum Wlr_output_present_flag {
	vsync         = 0x1
	hw_clock      = 0x2
	hw_completion = 0x4
	zero_copy     = 0x8
}

pub struct C.wlr_output_event_present {
	output     C.wlr_output
	commit_seq u32
	presented  bool
	when       C.timespec
	refresh    int
	flags      u32
}

pub struct C.wlr_output_event_bind {
	output   C.wlr_output
	resource C.wl_resource
}

pub struct C.wlr_output_event_request_state {
	output C.wlr_output
	state  C.wlr_output_state
}

pub struct C.wlr_surface {}

pub fn C.wlr_output_create_global(output C.wlr_output, display C.wl_display)
pub fn C.wlr_output_destroy_global(output C.wlr_output)

pub fn C.wlr_output_init_reader(output C.wlr_output, allocator C.wlr_allocator, renderer C.wlr_renderer) bool

pub fn C.wlr_output_preferred_mode(output C.wlr_output) C.wlr_output_mode

pub fn C.wlr_output_set_name(output C.wlr_output, name string)
pub fn C.wlr_output_set_description(output C.wlr_output, description string)

pub fn C.wlr_output_schedule_done(output C.wlr_output)
pub fn C.wlr_output_destroy(output C.wlr_output)

pub fn C.wlr_output_transformed_resolution(output C.wlr_output, width int, height int)

pub fn C.wlr_output_effective_resolution(output C.wlr_output, width int, height int)

pub fn C.wlr_output_test_state(output C.wlr_output, state C.wlr_output_state) bool

pub fn C.wlr_output_commit_state(output C.wlr_output, state C.wlr_output_state) bool

pub fn C.wlr_output_schedule_frame(output C.wlr_output)

pub fn C.wlr_output_get_gamma_size(output C.wlr_output) usize

pub fn C.wlr_output_from_resource(resource C.wl_resource) C.wlr_output

pub fn C.wlr_output_lock_attach_render(output C.wlr_output, lock, bool)

pub fn C.wlr_output_lock_software_cursors(output C.wlr_output, lock, bool)

pub fn C.wlr_output_add_software_cursors_to_render_pass(output C.wlr_output, render_pass C.wlr_render_pass, damage pixman.Pixman_region32_t)

pub fn C.wlr_output_get_primary_formats(output C.wlr_output, buffer_caps u32) C.wlr_drm_format_set

pub fn C.wlr_output_is_direct_scanout_allowed(output C.wlr_output) bool

pub fn C.wlr_output_cursor_create(output C.wlr_output) C.wlr_output_cursor
pub fn C.wlr_output_cursor_set_buffer(cursor C.wlr_output_cursor, buffer C.wlr_buffer, hotspot_x int, hotspot_y int) bool
pub fn C.wlr_output_cursor_move(cursor C.wlr_output_cursor, x f64, y f64) bool
pub fn C.wlr_output_cursor_destroy(cursor C.wlr_output_cursor)

pub fn C.wlr_output_state_init(state C.wlr_output_state)

pub fn C.wlr_output_state_finish(state C.wlr_output_state)

pub fn C.wlr_output_state_set_enabled(state C.wlr_output_state, enabled bool)

pub fn C.wlr_output_state_set_mode(state C.wlr_output_state, mode C.wlr_output_mode)

pub fn C.wlr_output_state_set_custom_mode(state C.wlr_output_state, width int, height int, refresh int)

pub fn C.wlr_output_state_set_scale(state C.wlr_output_state, scale f32)

pub fn C.wlr_output_state_set_transform(state C.wlr_output_state, transform Wl_output_transform)

pub fn C.wlr_output_state_set_adaptive_sync_enabled(state C.wlr_output_state, enabled bool)

pub fn C.wlr_output_state_set_render_format(state C.wlr_output_state, format u32)

pub fn C.wlr_output_state_set_subpixel(state C.wlr_output_state, subpixel C.wl_output_subpixel)

pub fn C.wlr_output_state_set_buffer(state C.wlr_output_state, buffer C.wlr_buffer)

pub fn C.wlr_output_state_set_gamma_lut(state C.wlr_output_state, ramp_size usize, r u16, g u16, b u16) bool

pub fn C.wlr_output_state_set_damage(state C.wlr_output_state, damgage pixman.Pixman_region32_t)

pub fn C.wlr_output_state_set_layers(state C.wlr_output_state, layers C.wl_output_layer_state, len usize)

pub fn C.wlr_output_state_set_wait_timeline(state C.wlr_output_state, timeline C.wlr_drm_syncobj_timeline, point u64)

pub fn C.wlr_output_state_set_signal_timeline(state C.wlr_output_state, timeline C.wlr_drm_syncobj_timeline, point u64)

pub fn C.wlr_output_state_copy(dst C.wlr_output_state, src C.wlr_output_state) bool

pub fn C.wlr_output_configure_primary_swapchain(output C.wlr_output, state C.wlr_output_state, swapchain C.wlr_swapchain) bool

pub fn C.wlr_output_begin_render_pass(output C.wlr_output, state C.wlr_output_state, render_options C.wlr_buffer_pass_options) C.wlr_render_pass
