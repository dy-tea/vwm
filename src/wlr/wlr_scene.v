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

#include "wlr/types/wlr_scene.h"
#include <time.h>

pub struct C.wlr_output {}

pub struct C.wlr_output_layout {}

pub struct C.wlr_output_layout_output {}

pub struct C.wlr_layer_surface_v1 {}

pub struct C.wlr_drag_icon {}

pub struct C.wlr_surface {}

pub struct C.wlr_scene_buffer {}

pub struct C.wlr_scene_output_layout {}

pub struct C.wlr_presentation {}

pub struct C.wlr_linux_dmabuf_v1 {}

pub struct C.wlr_gamma_control_manager_v1 {}

pub struct C.wlr_output_state {}

type Wlr_scene_buffer_point_accepts_input_func_t = fn (buffer &C.wlr_scene_buffer, sx &f64, xy &f64)

type Wlr_scene_node_iterator_func_t = fn (buffer &C.wlr_scene_buffer, sx int, sy int, user_data voidptr)

pub enum Scene_node_type {
	tree
	rect
	buffer
}

pub struct C.wlr_scene_node {
	type   Scene_node_type
	parent &C.wlr_scene_tree

	link C.wl_list

	enabled bool
	x       int
	y       int

	events struct {
		destroy C.wl_signal
	}

	data voidptr

	addons C.wlr_addon_set

	WLR_PRIVATE struct {
		visible C.pixman_region32_t
	}
}

pub enum Wlr_scene_debug_damage_option {
	none
	rerender
	highlight
}

pub struct C.wlr_scene_tree {
	node     C.wlr_scene_node
	children C.wl_list
}

pub struct C.wlr_scene {
	tree    C.wlr_scene_tree
	outputs C.wl_list

	linux_dmabuf_v1          &C.wlr_linux_dmabuf_v1
	gamma_control_manager_v1 &C.wlr_gamma_control_manager_v1

	WLR_PRIVATE struct {
		linux_dmabuf_v1_destroy            C.wl_listener
		gamma_control_manager_v1_destroy   C.wl_listener
		gamma_control_manager_v1_set_gamma C.wl_listener

		debug_damage_option          Wlr_scene_debug_damage_option
		direct_scanout               bool
		calculate_visibility         bool
		highlight_transparent_region bool
	}
}

pub struct C.wlr_scene_surface {
	buffer  &C.wlr_scene_buffer
	surface &C.wlr_surface

	WLR_PRIVATE struct {
		clip C.wlr_box

		addon C.wlr_addon

		outputs_update  C.wl_listener
		output_enter    C.wl_listener
		output_leave    C.wl_listener
		output_sample   C.wl_listener
		frame_done      C.wl_listener
		surface_destroy C.wl_listener
		surface_commit  C.wl_listener
	}
}

pub struct C.wlr_scene_rect {
	node   &C.wlr_scene_node
	width  int
	height int
	color  [4]f32
}

pub struct C.wlr_scene_outputs_update_event {
	active &&C.wlr_scene_output
	size   usize
}

pub struct C.wlr_scene_output_sample_event {
	output         &C.wlr_scene_output
	direct_scanout bool
}

pub struct C.wlr_scene_buffer {
	node &C.wlr_scene_node

	buffer &C.wlr_buffer

	events struct {
		outputs_update C.wl_signal
		output_enter   C.wl_signal
		output_leave   C.wl_signal
		output_sample  C.wl_signal
		frame_done     C.wl_signal
	}

	point_accepts_input Wlr_scene_buffer_point_accepts_input_func_t

	primary_output &C.wlr_scene_output

	opacity       f32
	filter_mode   Wlr_scale_filter_mode
	src_box       C.wlr_fbox
	dst_width     int
	dst_height    int
	transform     Wl_output_transform
	opaque_region C.pixman_region32_t

	WLR_PRIVATE struct {
		active_outputs        u64
		texture               &C.wlr_texture
		prev_feedback_options C.wlr_linux_dmabuf_feedback_v1_init_options

		own_buffer       bool
		buffer_width     int
		buffer_height    int
		buffer_is_opaque bool

		wait_timeline &C.wlr_drm_syncobj_timeline
		wait_point    u64

		buffer_release   C.wl_listener
		renderer_destroy C.wl_listener
	}
}

pub struct C.wlr_scene_output {
	output &C.wlr_output
	link   C.wl_list
	scene  &C.wlr_scene
	addon  C.wlr_addon

	damage_ring C.wlr_damage_ring

	x int
	y int

	events struct {
		destroy C.wl_signal
	}

	WLR_PRIVATE struct {
		pending_commit_damage C.pixman_region32_t

		index        u8
		prev_scanout bool

		gamma_lut_changed bool
		gamma_lut         &C.wlr_gamma_control_v1

		output_commit      C.wl_listener
		output_damage      C.wl_listener
		output_needs_frame C.wl_listener

		damage_highlight_regions C.wl_list

		render_list C.wl_array

		in_timeline &C.wlr_drm_syncobj_timeline
		in_point    u64
	}
}

pub struct C.wlr_scene_timer {
	pre_render_duration f64
	render_timer        &C.wlr_render_timer
}

pub struct C.wlr_scene_layer_surface_v1 {
	tree          &C.wlr_scene_tree
	layer_surface &C.wlr_layer_surface_v1

	WLR_PRIVATE struct {
		tree_destroy          C.wl_listener
		layer_surface_destroy C.wl_listener
		layer_surface_map     C.wl_listener
		layer_surface_unmap   C.wl_listener
	}
}

pub fn C.wlr_scene_node_destroy(node &C.wlr_scene_node)

pub fn C.wlr_scene_node_set_enabled(node &C.wlr_scene_node, enabled bool)

pub fn C.wlr_scene_node_set_position(node &C.wlr_scene_node, x int, y int)

pub fn C.wlr_scene_node_place_above(node &C.wlr_scene_node, sibling &C.wlr_scene_node)

pub fn C.wlr_scene_node_place_below(node &C.wlr_scene_node, sibling &C.wlr_scene_node)

pub fn C.wlr_scene_node_raise_to_top(node &C.wlr_scene_node)

pub fn C.wlr_scene_node_lower_to_bottom(node &C.wlr_scene_node)

pub fn C.wlr_scene_node_reparent(node &C.wlr_scene_node, new_parent &C.wlr_scene_node)

pub fn C.wlr_scene_node_coords(node &C.wlr_scene_node, lx int, ly int) bool

pub fn C.wlr_scene_node_for_each_buffer(node &C.wlr_scene_node, iterator Wlr_scene_node_iterator_func_t, user_data voidptr)

pub fn C.wlr_scene_node_at(node &C.wlr_scene_node, lx f64, ly f64, nx &f64, ny &f64) &C.wlr_scene_node

pub fn C.wlr_scene_create() &C.wlr_scene

pub fn C.wlr_scene_set_linux_dmabuf_v1(scene &C.wlr_scene, linux_dmabuf_v1 &C.wlr_linux_dmabuf_v1)

pub fn C.wlr_scene_set_gamma_control_manager_v1(scene &C.wlr_scene, gamma_control &C.wlr_gamma_control_manager_v1)

pub fn C.wlr_scene_tree_create(parent &C.wlr_scene_tree) &C.wlr_scene_tree

pub fn C.wlr_scene_surface_create(scene &C.wlr_scene, surface &C.wlr_surface) &C.wlr_scene_surface

pub fn C.wlr_scene_buffer_from_node(node &C.wlr_scene_node) &C.wlr_scene_buffer

pub fn C.wlr_scene_tree_from_node(node &C.wlr_scene_node) &C.wlr_scene_tree

pub fn C.wlr_scene_rect_from_node(node &C.wlr_scene_node) &C.wlr_scene_rect

pub fn C.wlr_scene_surface_try_from_buffer(scene_buffer &C.wlr_scene_buffer) &C.wlr_scene_surface

pub fn C.wlr_scene_rect_create(parent &C.wlr_scene_tree, width int, height int, color [4]f32) &C.wlr_scene_rect

pub fn C.wlr_scene_rect_set_size(rect &C.wlr_scene_rect, width int, height int)

pub fn C.wlr_scene_rect_set_color(rect &C.wlr_scene_rect, color [5]f32)

pub fn C.wlr_scene_buffer_create(parent &C.wlr_scene_tree, buffer &C.wlr_buffer) &C.wlr_scene_buffer

pub fn C.wlr_scene_buffer_set_buffer(scene_buffer &C.wlr_scene_buffer, buffer &C.wlr_buffer)

pub fn C.wlr_scene_buffer_set_buffer_with_damage(scene_buffer &C.wlr_scene_buffer, buffer &C.wlr_buffer, region &C.pixman_region32_t)

struct C.wlr_scene_buffer_set_buffer_options {
	damage &C.pixman_region32_t

	wait_timeline &C.wlr_drm_syncobj_timeline
	wait_point    u64
}

pub fn C.wlr_scene_buffer_set_buffer_with_options(scene_buffer &C.wlr_scene_buffer, buffer &C.wlr_buffer, options &C.wlr_scene_buffer_set_buffer_options)

pub fn C.wlr_scene_buffer_set_opaque_region(scene_buffer &C.wlr_scene_buffer, region &C.pixman_region32_t)

pub fn C.wlr_scene_buffer_set_source_box(scene_buffer &C.wlr_scene_buffer, box &C.wlr_fbox)

pub fn C.wlr_scene_buffer_set_dest_size(scene_buffer &C.wlr_scene_buffer, width int, height int)

pub fn C.wlr_scene_buffer_set_transform(scene_buffer &C.wlr_scene_buffer, transform Wl_output_transform)

pub fn C.wlr_scene_buffer_set_opacity(scene_buffer &C.wlr_scene_buffer, opacity f32)

pub fn C.wlr_scene_buffer_set_filter_mode(scene_buffer &C.wlr_scene_buffer, filter_mode &C.wlr_scale_filter_mode)

pub fn C.wlr_scene_buffer_send_frame_done(scene_buffer &C.wlr_scene_buffer, now &C.timespec)

pub fn C.wlr_scene_output_create(scene &C.wlr_scene, output &C.wlr_output) &C.wlr_scene_output

pub fn C.wlr_scene_output_destroy(scene_output &C.wlr_scene_output)

pub fn C.wlr_scene_output_set_position(scene_output &C.wlr_scene_output, lx int, ly int)

struct C.wlr_scene_output_state_options {
	timer           &C.wlr_scene_timer
	color_transform &C.wlr_color_transform

	swapchain &C.wlr_swapchain
}

pub fn C.wlr_scene_output_needs_frame(scene_output &C.wlr_scene_output) bool

pub fn C.wlr_scene_output_commit(scene_output &C.wlr_scene_output, options &C.wlr_scene_output_state_options) bool

pub fn C.wlr_scene_output_build_state(scene_output &C.wlr_scene_output, state &C.wlr_output_state, options &C.wlr_scene_output_state_options) bool

pub fn C.wlr_scene_timer_get_duration_ns(timer &C.wlr_scene_timer) i64
pub fn C.wlr_scene_timer_finish(timer &C.wlr_scene_timer)

pub fn C.wlr_scene_output_send_frame_done(scene_output &C.wlr_scene_output, now &C.timespec)

pub fn C.wlr_scene_output_for_eacH_buffer(scene_output &C.wlr_scene_output, iterator Wlr_scene_node_iterator_func_t, user_data voidptr)

pub fn C.wlr_schene_get_scene_output(scene &C.wlr_scene, output &C.wlr_output) &C.wlr_scene_output

pub fn C.wlr_scene_attach_output_layout(scene &C.wlr_scene, output_layout &C.wlr_output_layout) &C.wlr_scene_output_layout

pub fn C.wlr_scene_output_layout_add_output(sol &C.wlr_scene_output_layout, lo &C.wlr_output_layout_output, so &C.wlr_scene_output)

pub fn C.wlr_scene_subsurface_tree_create(parent &C.wlr_scene_tree, srface &C.wlr_subsurface) &C.wlr_scene_tree

pub fn C.wlr_scene_subsurface_tree_set_clip(node &C.wlr_scene_node, clip &C.wlr_box)

pub fn C.wlr_scene_xdg_surface_create(parent &C.wlr_scene_tree, xdg_surface &C.wlr_xdg_surface) &C.wlr_scene_tree

pub fn C.wlr_scene_layer_surface_v1_create(parent &C.wlr_scene_tree, layer_surface &C.wlr_layer_surface_v1) &C.wlr_scene_layer_surface_v1

pub fn C.wlr_scene_layer_surface_v1_configure(scene_layer_surface &C.wlr_scene_layer_surface_v1, full_area &C.wlr_box, usable_area &C.wlr_box)

pub fn C.wlr_scene_drag_icon_create(parent &C.wlr_scene_tree, drag_icon &C.wlr_drag_icon) &C.wlr_scene_tree
