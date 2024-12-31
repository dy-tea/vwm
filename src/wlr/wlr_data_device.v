module wlr

#flag linux -I/usr/include
#flag linux -I/usr/include/pixman-1
#flag linux -I/usr/include/wayland-protocols
#flag -I @VMODROOT
#flag linux -I/usr/include/wlroots-0.19
#flag linux -Lwlroots
#flag linux -DWLR_USE_UNSTABLE

#include "wlr/types/wlr_data_device.h"

pub struct C.wlr_data_device_manager {
	global       C.wl_global
	data_sources C.wl_list

	events struct {
		destroy C.wl_signal
	}

	data voidptr

	wlr_private struct {
		display_destroy C.wl_listener
	}
}

enum Wlr_data_offer_type {
	selection
	drag
}

pub struct C.wlr_data_offer {
	resource C.wl_resource
	source   C.wlr_data_source
	type     Wlr_data_offer_type

	actions          u32
	preferred_action C.wl_data_device_manager_dnd_action
	in_ask           bool

	wlr_private struct {
		source_destroy C.wl_listener
	}
}

pub struct C.wlr_data_source {
	impl C.wlr_data_source_impl

	mime_types C.wl_array
	actions    int

	accepted bool

	current_dnd_action C.wl_data_device_manager_dnd_action
	compositor_action  u32

	events struct {
		destroy C.wl_signal
	}
}

pub struct C.wlr_drag_icon {
	drag    &C.wlr_drag = unsafe { nil }
	surface C.wlr_surface

	events struct {
		destroy C.wl_signal
	}

	data voidptr

	wlr_private struct {
		surface_destroy C.wl_listener
	}
}

enum Wlr_drag_grab_type {
	keyboard
	keyboard_pointer
	keyboard_touch
}

pub struct C.wlr_drag {
	grab_type    Wlr_drag_grab_type
	pointer_grab C.wlr_seat_keyboard_grab
	touch_grab   C.wlr_seat_touch_grab

	seat         C.wlr_seat
	seat_client  C.wlr_seat_client
	focus_client C.wlr_seat_client

	icon   C.wlr_drag_icon
	focus  C.wlr_surface
	source C.wlr_data_source

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

	wlr_private struct {
		source_destroy      C.wl_listener
		seat_client_destroy C.wl_listener
		focus_destroy       C.wl_listener
		icon_destroy        C.wl_listener
	}
}

pub struct C.wlr_drag_motion_event {
	drag C.wlr_drag
	time u32
	sx   f64
	sy   f64
}

pub struct C.wlr_drag_drop_event {
	drag C.wlr_drag
	time u32
}
