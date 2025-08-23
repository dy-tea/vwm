module types

#flag linux -DWLR_USE_UNSTABLE
#flag linux -I/usr/include/
#flag linux -I/usr/include/wlroots-0.20
#flag linux -lwlroots-0.20
#include <wlr/types/wlr_scene.h>

pub struct C.wlr_scene_output_layout {}

pub enum Wlr_scene_node_type {
	tree
	rect
	buffer
}

pub struct C.wlr_scene_node {
pub:
	type   Wlr_scene_node_type
	parent &C.wlr_scene_tree

	link C.wl_list

	enabled bool
	x       int
	y       int

	events struct {
	pub:
		destroy C.wl_signal
	}
pub mut:
	data voidptr
}

pub struct C.wlr_scene_tree {
pub:
	children C.wl_list
pub mut:
	node C.wlr_scene_node
}

pub struct C.wlr_scene {
pub:
	tree    C.wlr_scene_tree
	outputs C.wl_list
}

pub struct C.wlr_scene_surface {
pub:
	buffer  &C.wlr_scene_buffer
	surface &C.wlr_surface
}

pub struct C.wlr_scene_rect {
pub:
	node   C.wlr_scene_ndoe
	width  int
	height int
	color  [4]f32
}

pub struct C.wlr_scene_buffer {}

pub struct C.wlr_scene_output {}

fn C.wlr_scene_node_destroy(node &C.wlr_scene_node)
fn C.wlr_scene_node_set_enabled(node &C.wlr_scene_node, enabled bool)
fn C.wlr_scene_node_set_position(node &C.wlr_scene_node, x int, y int)
fn C.wlr_scene_node_place_above(node &C.wlr_scene_node, sibling &C.wlr_scene_node)
fn C.wlr_scene_node_place_below(node &C.wlr_scene_node, sibling &C.wlr_scene_node)
fn C.wlr_scene_node_raise_to_top(node &C.wlr_scene_node)
fn C.wlr_scene_node_lower_to_bottom(node &C.wlr_scene_node)
fn C.wlr_scene_node_reparent(node &C.wlr_scene_node, new_parent &C.wlr_scene_tree)
fn C.wlr_scene_node_coords(node &C.wlr_scene_node, x &int, y &int) bool
fn C.wlr_scene_node_at(node &C.wlr_scene_node, lx f64, ly f64, nx &f64, ny &f64) &C.wlr_scene_node

fn C.wlr_scene_create() &C.wlr_scene

fn C.wlr_scene_tree_create(parent &C.wlr_scene_tree) &C.wlr_scene_tree

fn C.wlr_scene_surface_create(parent &C.wlr_scene_tree, surface &C.wlr_surface) &C.wlr_scene_surface

fn C.wlr_scene_buffer_from_node(node &C.wlr_scene_node) &C.wlr_scene_buffer
fn C.wlr_scene_tree_from_node(node &C.wlr_scene_node) &C.wlr_scene_tree
fn C.wlr_scene_rect_from_node(node &C.wlr_scene_node) &C.wlr_scene_rect

fn C.wlr_scene_surface_try_from_buffer(scene_buffer &C.wlr_scene_buffer) &C.wlr_scene_surface

fn C.wlr_scene_output_create(scene &C.wlr_scene, output &C.wlr_output) &C.wlr_scene_output
fn C.wlr_scene_output_destroy(output &C.wlr_scene_output)

pub struct C.wlr_scene_output_state_options {
}

fn C.wlr_scene_output_needs_frame(scene_output &C.wlr_scene_output) bool
fn C.wlr_scene_output_commit(scene_output &C.wlr_scene_output, options &C.wlr_scene_output_state_options) bool

fn C.wlr_scene_output_send_frame_done(scene_output &C.wlr_scene_output, now &C.timespec)

fn C.wlr_scene_get_scene_output(scene &C.wlr_scene, output &C.wlr_output) &C.wlr_scene_output
fn C.wlr_scene_attach_output_layout(scene &C.wlr_scene, output_layout &C.wlr_output_layout) &C.wlr_scene_output_layout
fn C.wlr_scene_output_layout_add_output(sol &C.wlr_scene_output_layout, lo &C.wlr_output_layout_output, so &C.wlr_scene_output)

fn C.wlr_scene_subsurface_tree_create(parent &C.wlr_scene_tree, surface &C.wlr_surface) &C.wlr_scene_tree
fn C.wlr_scene_subsurface_tree_set_clip(parent &C.wlr_scene_tree, clip &C.wlr_box)

fn C.wlr_scene_xdg_surface_create(parent &C.wlr_scene_tree, xdg_surface &C.wlr_xdg_surface) &C.wlr_scene_tree
