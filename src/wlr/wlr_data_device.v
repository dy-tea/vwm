module wlr

#flag linux -I/usr/include
#flag linux -I/usr/include/pixman-1
#flag linux -I/usr/include/wayland-protocols
#flag -I @VMODROOT
#flag linux -I/usr/include/wlroots-0.19
#flag linux -lwayland-server
#flag linux -lwlroots-0.19
#flag linux -DWLR_USE_UNSTABLE

#include "wlr/types/wlr_data_device.h"

pub struct C.wlr_data_device_manager {
	global       &C.wl_global
	data_sources C.wl_list

	events struct {
		destroy C.wl_signal
	}

	data voidptr

	WLR_PRIVATE struct {
		display_destroy C.wl_listener
	}
}

pub enum Wlr_data_offer_type {
	selection
	drag
}

pub struct C.wlr_data_offer {
	resource &C.wl_resource
	source   &C.wlr_data_source
	type     Wlr_data_offer_type

	actions          u32
	preferred_action Wl_data_device_manager_dnd_action
	in_ask           bool

	WLR_PRIVATE struct {
		source_destroy C.wl_listener
	}
}

pub struct C.wlr_data_source_impl {
	send    fn (source &C.wlr_data_source, mime_type string, fd int)
	accept  fn (source &C.wlr_data_source, serial u32, mime_type string)
	destroy fn (source &C.wlr_data_source)

	dnd_drop   fn (source &C.wlr_data_source)
	dnd_finish fn (source &C.wlr_data_source)
	dnd_action fn (source &C.wlr_data_source, dnd_action Wl_data_device_manager_dnd_action)
}

pub struct C.wlr_data_source {
	impl C.wlr_data_source_impl

	mime_types C.wl_array
	actions    int

	accepted bool

	current_dnd_action Wl_data_device_manager_dnd_action
	compositor_action  u32

	events struct {
		destroy C.wl_signal
	}
}

pub struct C.wlr_drag_icon {
	drag    &C.wlr_drag = unsafe { nil }
	surface &C.wlr_surface

	events struct {
		destroy C.wl_signal
	}

	data voidptr

	WLR_PRIVATE struct {
		surface_destroy C.wl_listener
	}
}

pub enum Wlr_drag_grab_type {
	keyboard
	keyboard_pointer
	keyboard_touch
}

pub struct C.wlr_drag {
	grab_type    Wlr_drag_grab_type
	pointer_grab C.wlr_seat_keyboard_grab
	touch_grab   C.wlr_seat_touch_grab

	seat         &C.wlr_seat
	seat_client  &C.wlr_seat_client
	focus_client &C.wlr_seat_client

	icon   &C.wlr_drag_icon
	focus  &C.wlr_surface
	source &C.wlr_data_source

	started    bool
	dropped    bool
	cancelling bool

	grab_touch_id int
	touch_id      int

	events struct {
		focus   C.wl_signal
		motion  C.wl_signal
		drop    C.wl_signal
		destroy C.wl_signal
	}

	data voidptr

	WLR_PRIVATE struct {
		source_destroy      C.wl_listener
		seat_client_destroy C.wl_listener
		focus_destroy       C.wl_listener
		icon_destroy        C.wl_listener
	}
}

pub struct C.wlr_drag_motion_event {
	drag &C.wlr_drag
	time u32
	sx   f64
	sy   f64
}

pub struct C.wlr_drag_drop_event {
	drag &C.wlr_drag
	time u32
}

pub fn C.wlr_data_device_manager_create(display &C.wl_display) &C.wlr_data_device_manager

pub fn C.wlr_seat_request_set_selection(seat &C.wlr_seat, client &C.wlr_seat_client, source &C.wlr_data_source, serial u32)
pub fn C.wlr_seat_set_selection(seat &C.wlr_seat, source &C.wlr_data_source, serial u32)
pub fn C.wlr_drag_create(client &C.wlr_seat_client, source &C.wlr_data_source, icon_surface &C.wlr_surface, grab_type Wlr_drag_grab_type) &C.wlr_drag
pub fn C.wlr_seat_request_start_drag(seat &C.wlr_seat, drag &C.wlr_drag, origin &C.wlr_surface, serial u32)
pub fn C.wlr_seat_start_drag(seat &C.wlr_seat, drag &C.wlr_drag, serial u32)
pub fn C.wlr_seat_start_pointer_drag(seat &C.wlr_seat, drag &C.wlr_drag, serial u32)
pub fn C.wlr_seat_start_touch_drag(seat &C.wlr_seat, drag &C.wlr_drag, serial u32, point &C.wlr_touch_point)
pub fn C.wlr_data_source_init(source &C.wlr_data_source, impl &C.wlr_data_source_impl)
pub fn C.wlr_data_source_send(source &C.wlr_data_source, mime_type string, fd int)
pub fn C.wlr_data_source_accept(source &C.wlr_data_source, serial u32, mime_type string)
pub fn C.wlr_data_source_destroy(source &C.wlr_data_source)
pub fn C.wlr_data_source_dnd_drop(source &C.wlr_data_source)
pub fn C.wlr_data_source_dnd_finish(source &C.wlr_data_source)
pub fn C.wlr_data_source_dnd_action(source &C.wlr_data_source, dnd_action Wl_data_device_manager_dnd_action)
