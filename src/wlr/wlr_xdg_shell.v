module wlr

#flag linux -I/usr/include
#flag linux -I/usr/include/pixman-1
#flag linux -I/usr/include/wayland-protocols
#flag -I @VMODROOT
#flag linux -I/usr/include/wlroots-0.19
#flag linux -lwayland-server
#flag linux -lwlroots-0.19
#flag linux -DWLR_USE_UNSTABLE

#include "wlr/types/wlr_xdg_shell.h"

pub struct C.wlr_xdg_shell {
	global       &C.wl_global
	version      u32
	clients      C.wl_list
	popup_grabs  C.wl_list
	ping_timeout u32

	events struct {
		new_surface  C.wl_signal
		new_toplevel C.wl_signal
		new_popup    C.wl_signal
		destroy      C.wl_signal
	}

	data voidptr

	wlr_private struct {
		display_destroy C.wl_listener
	}
}

pub struct C.wlr_xdg_client {
	shell    &C.wlr_xdg_shell
	resource &C.wl_resource
	client   &C.wl_client
	surfaces C.wl_list

	link C.wl_list

	ping_serial u32
	ping_timer  &C.wl_event_source
}

pub struct C.wlr_positioner_rules {
	anchor_rect           C.wlr_box
	anchor                C.xdg_positioner_anchor
	gravity               C.xdg_positioner_gravity
	constraint_adjustment C.xdg_positioner_constraint_adjustment

	reactive bool

	has_parent_configure_serial bool
	parent_configure_serial     u32

	size        struct {
		width  int
		height int
	}
	parent_size struct {
		width  int
		height int
	}

	offset struct {
		x int
		y int
	}
}

pub struct C.wlr_xdg_positioner {
	resource &C.wl_resource
	rules    C.wlr_positioner_rules
}

pub struct C.wlr_xdg_popup_state {
	geometry C.wlr_box
	reactive bool
}

pub enum Wlr_xdg_popup_configure_field {
	token = 1 << 0
}

pub struct C.wlr_xdg_popup_configure {
	fields           u32
	geometry         C.wlr_box
	rules            C.wlr_positioner_rules
	reposition_token u32
}

pub struct C.wlr_xdg_popup {
	base C.wlr_xdg_surface
	link C.wl_list

	resource &C.wl_resource
	parent   &C.wlr_surface
	seat     &C.wlr_seat

	scheduled C.wlr_xdg_popup_configure

	current C.wlr_xdg_popup_state
	pending C.wlr_xdg_popup_state

	events struct {
		destroy    C.wl_signal
		reposition C.wl_signal
	}

	grab_link C.wl_list

	wlr_private struct {
		synced C.wlr_surface_synced
	}
}

pub struct C.wlr_xdg_popup_grab {
	client        &C.wl_client
	pointer_grab  C.wlr_seat_pointer_grab
	keyboard_grab C.wlr_seat_keyboard_grab
	touch_grab    C.wlr_seat_touch_grab
	seat          &C.wlr_seat
	popups        C.wl_list
	link          C.wl_list

	wlr_private struct {
		seat_destroy C.wl_listener
	}
}

pub enum Wlr_xdg_surface_role {
	none
	toplevel
	popup
}

pub struct C.wlr_xdg_toplevel_state {
	maximized  bool
	fullscreen bool
	resizing   bool
	activated  bool
	suspended  bool

	tiled  u32
	width  u32
	height u32

	bounds struct {
		width  u32
		height u32
	}

	wm_capabilities u32
}

pub struct C.wlr_xdg_toplevel_requested {
	maximized  bool
	minimized  bool
	fullscreen bool

	wlr_private struct {
		fullscreen_output_destroy C.wl_listener
	}
}

pub struct C.wlr_xdg_toplevel {
	resource &C.wl_resource
	base     &C.wlr_xdg_surface

	parent  &C.wlr_xdg_toplevel
	current C.wlr_xdg_toplevel_state
	pending C.wlr_xdg_toplevel_state

	scheduled C.wlr_xdg_toplevel_configure
	requested C.wlr_xdg_toplevel_configure

	title  string
	app_id string

	events struct {
		request_maximize         C.wl_signal
		request_fullscreen       C.wl_signal
		request_minimize         C.wl_signal
		request_move             C.wl_signal
		request_resize           C.wl_signal
		request_show_window_menu C.wl_signal
		set_parent               C.wl_signal
		set_title                C.wl_signal
		set_app_id               C.wl_signal
	}

	wlr_private struct {
		synced       C.wlr_surface_synced
		parent_unmap C.wl_listener
	}
}

pub struct C.wlr_xdg_surface_configure {
	surface &C.wlr_xdg_surface
	link    C.wl_list
	serial  u32

	// union?
	toplevel_configure &C.wlr_xdg_toplevel_configure
	popup_configure    &C.wlr_xdg_popup_configure
}

pub enum Wlr_xdg_surface_state_field {
	window_geometry = 1 << 0
}

pub struct C.wlr_xdg_surface_state {
	committed u32

	geometry C.wlr_box

	configure_serial u32
}

pub struct C.wlr_xdg_surface {
	client   &C.wlr_xdg_client
	resource &C.wl_resource
	surface  &C.wlr_surface
	link     C.wl_list

	role          C.wlr_xdg_surface_role
	role_resource &C.wl_resource

	// union?
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
		destroy      C.wl_signal
		ping_timeout C.wl_signal
		new_popup    C.wl_signal

		configure     C.wl_signal
		ack_configure C.wl_signal
	}

	data voidptr

	wlr_private struct {
		synced                C.wlr_surface_synced
		role_resource_destroy C.wl_listener
	}
}

pub struct C.wlr_xdg_toplevel_move_event {
	toplevel &C.wlr_xdg_toplevel
	seat     &C.wlr_seat
	serial   u32
}

pub struct C.wlr_xdg_toplevel_resize_event {
	toplevel &C.wlr_xdg_toplevel
	seat     &C.wlr_seat
	serial   u32
	edges    u32
}

pub struct C.wlr_xdg_toplevel_show_window_menu_event {
	toplevel &C.wlr_xdg_toplevel
	seat     &C.wlr_seat
	serial   u32
	x        u32
	y        u32
}

pub fn C.wlr_xdg_shell_create(display &C.wl_display, version u32) &C.wlr_xdg_shell

pub fn C.wlr_xdg_surface_from_resource(resource &C.wl_resource) &C.wlr_xdg_surface
pub fn C.wlr_xdg_popup_from_resource(resource &C.wl_resource) &C.wlr_xdg_popup
pub fn C.wlr_xdg_toplevel_from_resource(resource &C.wl_resource) &C.wlr_xdg_toplevel
pub fn C.wlr_xdg_positioner_from_resource(resource &C.wl_resource) &C.wlr_xdg_positioner

pub fn C.wlr_xdg_surface_ping(surface &C.wlr_xdg_surface)

pub fn C.wlr_xdg_toplevel_configure(toplevel &C.wlr_xdg_toplevel, configure &C.wlr_xdg_toplevel_configure) u32
pub fn C.wlr_xdg_toplevel_set_size(toplevel &C.wlr_xdg_toplevel, width u32, height u32) u32
pub fn C.wlr_xdg_toplevel_set_activated(toplevel &C.wlr_xdg_toplevel, activated bool) u32
pub fn C.wlr_xdg_toplevel_set_maximized(toplevel &C.wlr_xdg_toplevel, maximized bool) u32
pub fn C.wlr_xdg_toplevel_set_fullscreen(toplevel &C.wlr_xdg_toplevel, fullscreen bool) u32
pub fn C.wlr_xdg_toplevel_set_resizing(toplevel &C.wlr_xdg_toplevel, resizing bool) u32
pub fn C.wlr_xdg_toplevel_set_tiled(toplevel &C.wlr_xdg_toplevel, tiled_edges u32) u32
pub fn C.wlr_xdg_toplevel_set_bounds(toplevel &C.wlr_xdg_toplevel, width u32, height u32) u32
pub fn C.wlr_xdg_toplevel_set_wm_capabilities(toplevel &C.wlr_xdg_toplevel, caps u32) u32
pub fn C.wlr_xdg_toplevel_set_suspended(toplevel &C.wlr_xdg_toplevel, suspended bool) u32
pub fn C.wlr_xdg_toplevel_send_close(toplevel &C.wlr_xdg_toplevel)
pub fn C.wlr_xdg_toplevel_set_parent(toplevel &C.wlr_xdg_toplevel, parent &C.wlr_xdg_toplevel) bool

pub fn C.wlr_xdg_popup_destroy(popup &C.wlr_xdg_popup)
pub fn C.wlr_xdg_popup_get_position(popup &C.wlr_xdg_popup, popup_sx &f64, popup_sy &f64)

pub fn C.wlr_xdg_positioner_is_complete(positioner &C.wlr_xdg_positioner) bool

pub fn C.wlr_xdg_positioner_rules_get_geometry(rules &C.wlr_xdg_positioner_rules, box &C.wlr_box)
pub fn C.wlr_xdg_positioner_rules_unconstrain_box(rules &C.wlr_xdg_positioner_rules, constraint &C.wlr_box, box &C.wlr_box)

pub fn C.wlr_xdg_popup_get_toplevel_coords(popup &C.wlr_xdg_popup, popup_sx int, popup_sy int, x &int, y &int)
pub fn C.wlr_xdg_popup_unconstrain_from_box(popup &C.wlr_xdg_popup, toplevel_space_box &C.wlr_box)

pub fn C.wlr_xdg_suface_surface_at(surface &C.wlr_xdg_surface, sx f64, sy f64, sub_x &f64, sub_y &f64) &C.wlr_surface

pub fn C.wlr_xdg_surface_try_from_wlr_surface(surface &C.wlr_surface) &C.wlr_xdg_surface
pub fn C.wlr_xdg_toplevel_try_from_wlr_surface(surface &C.wlr_surface) &C.wlr_xdg_toplevel
pub fn C.wlr_xdg_popup_try_from_wlr_surface(surface &C.wlr_surface) &C.wlr_xdg_popup

pub fn C.wlr_xdg_surface_for_each_surface(surface &C.wlr_xdg_surface, iterator Wlr_xdg_surface_iterator_func_t, user_data voidptr)
pub fn C.wlr_xdg_surface_for_each_popup_surface(surface &C.wlr_xdg_surface, iterator Wlr_xdg_surface_iterator_func_t, user_data voidptr)

pub fn C.wlr_xdg_surface_schedule_configure(surface &C.wlr_xdg_surface) u32
