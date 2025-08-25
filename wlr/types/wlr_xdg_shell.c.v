module types

import util
import wl

#flag linux -DWLR_USE_UNSTABLE
#flag linux -I/usr/include/
#flag linux -I/usr/include/wlroots-0.20
#flag linux -lwlroots-0.20
#include <wlr/types/wlr_xdg_shell.h>

// xdg-shell-enum

pub enum Xdg_wm_base_error {
	error_role
	defunct_surfaces
	not_the_topmost_popup
	invalid_popup_parent
	invalid_surface_state
	invalid_positioner
	unresponsive
}

pub enum Xdg_positioner_error {
	invalid_input
}

pub enum Xdg_positioner_anchor {
	none
	top
	bottom
	left
	right
	top_left
	bottom_left
	top_right
	bottom_right
}

pub enum Xdg_positioner_gravity {
	none
	top
	bottom
	left
	right
	top_left
	bottom_left
	top_right
	bottom_right
}

pub enum Xdg_positioner_constraint_adjustment {
	none     = 0
	slide_x  = 1
	slide_y  = 2
	flip_x   = 4
	flip_y   = 8
	resize_x = 16
	resize_y = 32
}

pub enum Xdg_surface_error {
	not_constructed
	already_constructed
	unconfigured_buffer
	invalid_serial
	invalid_size
	defunct_role_object
}

pub enum Xdg_toplevel_error {
	invalid_resize_edge
	invalid_parent
	invalid_size
}

pub enum Xdg_toplevel_resize_edge {
	none
	top
	bottom
	left
	top_left
	bottom_left
	right
	top_right
	bottom_right
}

pub enum Xdg_toplevel_state {
	maximized
	fullscreen
	resizing
	activated
	tiled_left
	tiled_right
	tiled_top
	tiled_bottom
	suspended
	constrained_left
	constrained_right
	constrained_top
	constrained_bottom
}

pub enum Xdg_toplevel_wm_capabilities {
	window_menu
	maximize
	fullscreen
	minimize
}

pub enum Xdg_popup_error {
	invalid_grab
}

// xdg-shell

pub struct C.wlr_xdg_shell {
pub:
	events struct {
	pub:
		new_surface  C.wl_signal
		new_toplevel C.wl_signal
		new_popup    C.wl_signal
		destroy      C.wl_signal
	}
}

pub struct C.wlr_xdg_client {
pub:
	shell &C.wlr_xdg_shell

	ping_serial u32
}

pub struct C.wlr_xdg_positioner_rules {
pub:
	anchor_rect           C.wlr_box
	anchor                Xdg_positioner_anchor
	gravity               Xdg_positioner_gravity
	constraint_adjustment Xdg_positioner_constraint_adjustment

	reactive bool

	has_parent_configure_serial bool
	parent_configure_serial     u32

	size struct {
		width  i32
		height i32
	}

	parent_size struct {
		width  i32
		height i32
	}

	offset struct {
		x i32
		y i32
	}
}

pub struct C.wlr_xdg_positioner {
pub:
	resource &C.wl_resource
	rules    C.wlr_xdg_positioner_rules
}

pub struct C.wlr_xdg_popup_state {
pub:
	geometry C.wlr_box
	reactive bool
}

pub enum Wlr_xdg_popup_configure_field {
	reposition_token = 1 << 0
}

pub struct C.wlr_xdg_popup_configure {
pub:
	fields           u32
	geometry         C.wlr_box
	rules            C.wlr_xdg_positioner_rules
	reposition_token u32
}

pub struct C.wlr_xdg_popup_configure {
pub:
	fields           u32
	geometry         C.wlr_box
	rules            C.wlr_xdg_positioner_rules
	reposition_token u32
}

pub struct C.wlr_xdg_popup {
pub:
	link C.wl_list

	resource &C.wl_resource
	parent   &C.wlr_surface
	seat     &C.wlr_seat

	scheduled C.wlr_xdg_popup_configure
	current   C.wlr_xdg_popup_state
	pending   C.wlr_xdg_popup_state

	events struct {
	pub:
		destroy    C.wl_signal
		reposition C.wl_signal
	}

	grab_link C.wl_list
pub mut:
	base &C.wlr_xdg_surface
}

pub struct C.wlr_xdg_popup_grab {
}

pub enum Wlr_xdg_surface_role {
	none
	toplevel
	popup
}

pub struct C.wlr_xdg_toplevel_state {
pub:
	maximized   bool
	fullscreen  bool
	resizing    bool
	activated   bool
	suspended   bool
	tiled       u32
	constrained u32
	width       i32
	height      i32
	max_width   i32
	max_height  i32
	min_width   i32
	min_height  i32
}

pub enum Wlr_xdg_toplevel_wm_capabilities {
	window_menu = 1 << 0
	maximize    = 1 << 1
	fullscreen  = 1 << 2
	minimize    = 1 << 3
}

pub enum Wlr_xdg_toplevel_configure_field {
	bounds          = 1 << 0
	wm_capabilities = 1 << 1
}

pub struct C.wlr_xdg_toplevel_configure {
pub:
	fields u32

	maximized   bool
	fullscreen  bool
	resizing    bool
	activated   bool
	suspended   bool
	tiled       u32
	constrained u32
	width       i32
	height      i32

	bounds struct {
		width  i32
		height i32
	}

	wm_capabilities u32
}

pub struct C.wlr_xdg_toplevel_requested {
pub:
	maximized         bool
	minimized         bool
	fullscreen        bool
	fullscreen_output &C.wlr_output
}

pub struct C.wlr_xdg_toplevel {
pub:
	resource &C.wl_resource

	parent &C.wlr_xdg_toplevel

	current C.wlr_xdg_toplevel_state
	pending C.wlr_xdg_toplevel_state

	scheduled C.wlr_xdg_toplevel_configure
	requested C.wlr_xdg_toplevel_requested

	title  &u8
	app_id &u8

	events struct {
	pub:
		destroy C.wl_signal

		request_maximize   C.wl_signal
		request_fullscreen C.wl_signal

		request_minimize         C.wl_signal
		request_move             C.wl_signal
		request_resize           C.wl_signal
		request_show_window_menu C.wl_signal
		set_parent               C.wl_signal
		set_title                C.wl_signal
		set_app_id               C.wl_signal
	}
pub mut:
	base &C.wlr_xdg_surface
}

pub struct C.wlr_xdg_surface_configure {
pub:
	surface &C.wlr_xdg_surface
	link    C.wl_list
	serial  u32

	toplevel_configure &C.wlr_xdg_toplevel_configure
	popup_configure    &C.wlr_xdg_popup_configure
}

pub enum Wlr_xdg_surface_state_field {
	window_geometry = 1 << 0
}

pub struct C.wlr_xdg_surface_state {
pub:
	committed        u32
	geometry         C.wlr_box
	configure_serial u32
}

pub struct C.wlr_xdg_surface {
pub:
	client   &C.wlr_xdg_client
	resource &C.wl_resource
	surface  &C.wlr_surface
	link     C.wl_list

	role          Wlr_xdg_surface_role
	role_resource &C.wl_resource

	toplevel &C.wlr_xdg_toplevel
	popup    &C.wlr_xdg_popup

	popups C.wl_list

	configured       bool
	configure_idle   &C.wl_event_source
	scheduled_serial u32
	configure_list   C.wl_list

	current C.wlr_xdg_surface_state
	pending C.wlr_xdg_surface_state

	initialized    bool
	initial_commit bool

	geometry C.wlr_box

	events struct {
	pub:
		destroy      C.wl_signal
		ping_timeout C.wl_signal
		new_popup    C.wl_signal

		configure     C.wl_signal
		ack_configure C.wl_signal
	}
pub mut:
	data voidptr
}

pub struct C.wlr_xdg_toplevel_move_event {
pub:
	toplevel &C.wlr_xdg_toplevel
	seat     &C.wlr_seat_client
	serial   u32
}

pub struct C.wlr_xdg_toplevel_resize_event {
pub:
	toplevel &C.wlr_xdg_toplevel
	seat     &C.wlr_seat_client
	serial   u32
	edges    u32
}

pub struct C.wlr_xdg_toplevel_show_window_menu_event {
pub:
	toplevel &C.wlr_xdg_toplevel
	seat     &C.wlr_seat_client
	serial   u32
	x        i32
	y        i32
}

fn C.wlr_xdg_shell_create(display &C.wl_display, version u32) &C.wlr_xdg_shell

fn C.wlr_xdg_surface_from_resource(resource &C.wl_resource) &C.wlr_xdg_surface
fn C.wlr_xdg_popup_from_resource(resource &C.wl_resource) &C.wlr_xdg_popup
fn C.wlr_xdg_toplevel_from_resource(resource &C.wl_resource) &C.wlr_xdg_toplevel
fn C.wlr_xdg_positioner_from_resource(resource &C.wl_resource) &C.wlr_xdg_positioner

fn C.wlr_xdg_surface_ping(surface &C.wlr_xdg_surface)

fn C.wlr_xdg_toplevel_configure(toplevel &C.wlr_xdg_toplevel, configure &C.wlr_xdg_toplevel_configure) u32
fn C.wlr_xdg_toplevel_set_size(toplevel &C.wlr_xdg_toplevel, width i32, height i32) u32
fn C.wlr_xdg_toplevel_set_activated(toplevel &C.wlr_xdg_toplevel, activated bool) u32
fn C.wlr_xdg_toplevel_set_maximized(toplevel &C.wlr_xdg_toplevel, maximized bool) u32
fn C.wlr_xdg_toplevel_set_fullscreen(toplevel &C.wlr_xdg_toplevel, fullscreen bool) u32
fn C.wlr_xdg_toplevel_set_resizing(toplevel &C.wlr_xdg_toplevel, resizing bool) u32
fn C.wlr_xdg_toplevel_set_tiled(toplevel &C.wlr_xdg_toplevel, tiled_edges u32) u32
fn C.wlr_xdg_toplevel_set_bounds(toplevel &C.wlr_xdg_toplevel, width i32, height i32) u32
fn C.wlr_xdg_toplevel_set_wm_capabilities(toplevel &C.wlr_xdg_toplevel, caps u32) u32
fn C.wlr_xdg_toplevel_set_suspended(toplevel &C.wlr_xdg_toplevel, suspended bool) u32
fn C.wlr_xdg_toplevel_set_constrained(toplevel &C.wlr_xdg_toplevel, constrained_edges u32) u32
fn C.wlr_xdg_toplevel_send_close(toplevel &C.wlr_xdg_toplevel)
fn C.wlr_xdg_toplevel_set_parent(toplevel &C.wlr_xdg_toplevel, parent &C.wlr_xdg_toplevel)

fn C.wlr_xdg_popup_destroy(popup &C.wlr_xdg_popup)
fn C.wlr_xdg_popup_get_position(popup &C.wlr_xdg_popup, popup_sx &f32, popup_sy &f32)

fn C.wlr_xdg_positioner_is_complete(positioner &C.wlr_xdg_positioner) bool

fn C.wlr_xdg_positioner_rules_get_geometry(rules &C.wlr_xdg_positioner_rules, box &C.wlr_box)
fn C.wlr_xdg_positioner_rules_unconstrain_box(rules &C.wlr_xdg_positioner_rules, constraint &C.wlr_box, box &C.wlr_box)

fn C.wlr_xdg_popup_get_toplevel_coords(popup &C.wlr_xdg_popup, popup_sx int, popup_sy int, toplevel_sx &int, toplevel_sy &int)
fn C.wlr_xdg_popup_unconstrain_from_box(popup &C.wlr_xdg_popup, toplevel_space_box &C.wlr_box)

fn C.wlr_xdg_surface_surface_at(surface &C.wlr_xdg_surface, x f32, y f32, sub_x &f32, sub_y &f32) &C.wlr_surface
fn C.wlr_xdg_surface_popup_surface_at(surface &C.wlr_xdg_surface, x f32, y f32, sub_x &f32, sub_y &f32) &C.wlr_surface

fn C.wlr_xdg_surface_try_from_wlr_surface(surface &C.wlr_surface) &C.wlr_xdg_surface
fn C.wlr_xdg_toplevel_try_from_wlr_surface(surface &C.wlr_surface) &C.wlr_xdg_toplevel
fn C.wlr_xdg_popup_try_from_wlr_surface(surface &C.wlr_surface) &C.wlr_xdg_popup

fn C.wlr_xdg_surface_schedule_configure(surface &C.wlr_xdg_surface) u32
