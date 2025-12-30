module types

import wl

#flag linux -DWLR_USE_UNSTABLE
#pkgconfig wlroots-0.20
#include <wlr/types/wlr_data_device.h>

pub struct C.wlr_data_device_manager {
pub:
	global       &C.wl_global
	data_sources C.wl_list

	events struct {
	pub:
		destroy C.wl_signal
	}
pub mut:
	data voidptr
}

pub enum Wlr_data_offer_type {
	selection
	drag
}

pub struct C.wlr_data_offer {
pub:
	resouce &C.wl_resource
	source  &C.wlr_data_source
	type    Wlr_data_offer_type
	link    C.wl_list

	actions          u32
	preferred_action wl.Wl_data_device_manager_dnd_action
	in_ask           bool
}

pub struct C.wlr_data_source_impl {
pub:
	send    fn (source &C.wlr_data_source, mime_type &char, fd i32)
	accept  fn (source &C.wlr_data_source, serial u32, mime_type &char)
	destroy fn (source &C.wlr_data_source)

	dnd_drop   fn (source &C.wlr_data_source)
	dnd_finish fn (source &C.wlr_data_source)
	dnd_action fn (source &C.wlr_data_source, action wl.Wl_data_device_manager_dnd_action)
}

pub struct C.wlr_data_source {
pub:
	impl &C.wlr_data_source_impl

	mime_types C.wl_array
	actions    i32

	accepted bool

	current_dnd_action wl.Wl_data_device_manager_dnd_action
	compositor_action  u32

	events struct {
	pub:
		destroy C.wl_signal
	}
}

pub struct C.wlr_drag_icon {
pub:
	drag    &C.wlr_drag
	surface &C.wlr_surface

	events struct {
	pub:
		destroy C.wl_signal
	}
pub mut:
	data voidptr
}

pub enum Wlr_drag_grab_type {
	keyboard
	keyboard_pointer
	keyboard_touch
}

pub struct C.wlr_drag {
pub:
	grab_type     Wlr_drag_grab_type
	keyboard_grab C.wlr_seat_keyboard_grab
	pointer_grab  C.wlr_seat_pointer_grab
	touch_grab    C.wlr_seat_touch_grab

	seat         &C.wlr_seat
	seat_client  &C.wlr_seat_client
	focus_client &C.wlr_seat_client

	icon   &C.wlr_drag_icon
	focus  &C.wlr_surface
	source &C.wlr_data_source

	started       bool
	dropped       bool
	cancelling    bool
	grab_touch_id i32
	touch_id      i32

	events struct {
	pub:
		focus   C.wl_signal
		motion  C.wl_signal
		drop    C.wl_signal
		destroy C.wl_signal
	}
pub mut:
	data voidptr
}

pub struct C.wlr_drag_motion_event {
pub:
	drag &C.wlr_drag
	time u32
	sx   f64
	sy   f64
}

pub struct C.wlr_drag_drop_event {
pub:
	drag &C.wlr_drag
	time u32
}

fn C.wlr_data_device_manager_create(display &C.wl_display) &C.wlr_data_device_manager

fn C.wlr_seat_request_set_selection(seat &C.wlr_seat, client &C.wlr_seat_client, source &C.wlr_data_source, serial u32)
fn C.wlr_seat_set_selection(seat &C.wlr_seat, source &C.wlr_data_source, serial u32)

fn C.wlr_drag_create(seat_client &C.wlr_seat_client, source &C.wlr_data_source, icon_surface &C.wlr_surface) &C.wlr_drag

fn C.wlr_seat_request_start_drag(seat &C.wlr_seat, drag &C.wlr_drag, origin &C.wlr_surface, serial u32)
fn C.wlr_seat_start_drag(seat &C.wlr_seat, drag &C.wlr_drag, serial u32)

fn C.wlr_seat_start_pointer_drag(seat &C.wlr_seat, drag &C.wlr_drag, serial u32)
fn C.wlr_seat_start_touch_drag(seat &C.wlr_seat, drag &C.wlr_drag, serial u32, point &C.wlr_touch_point)

fn C.wlr_data_source_init(source &C.wlr_data_source, impl &C.wlr_data_source_impl)
fn C.wlr_data_source_send(source &C.wlr_data_source, mime_type &char, fd i32)
fn C.wlr_data_source_accept(source &C.wlr_data_source, serial u32, mime_type &char)
fn C.wlr_data_source_destroy(source &C.wlr_data_source)

fn C.wlr_data_source_dnd_drop(source &C.wlr_data_source)
fn C.wlr_data_source_dnd_finish(source &C.wlr_data_source)
fn C.wlr_data_source_dnd_action(source &C.wlr_data_source, action wl.Wl_data_device_manager_dnd_action)
