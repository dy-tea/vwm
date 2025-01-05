module wlr

#flag linux -I/usr/include
#flag linux -I/usr/include/pixman-1
#flag linux -I/usr/include/wayland-protocols
#flag -I @VMODROOT
#flag linux -I/usr/include/wlroots-0.19
#flag linux -lwayland-server
#flag linux -lwlroots-0.19
#flag linux -DWLR_USE_UNSTABLE

#include <libudev.h>

struct C.udev {}

struct C.udev_device {}

struct C.udev_monitor {}

struct C.udev_enumerate {}

struct C.udev_queue {}

struct C.udev_hwdb {}

#include "wlr/backend/session.h"

pub struct C.libseat {}

pub struct C.wlr_device {
	fd        int
	device_id int
	dev       C.dev_t
	link      C.wl_list

	events struct {
	pub:
		change C.wl_signal
		remove C.wl_signal
	}
}

pub struct C.wlr_session {
	active bool

	vtnr u32
	seat [256]char

	udev       &C.udev
	mon        &C.udev_monitor
	udev_event &C.wl_event_source

	seat_handle   &C.libseat
	libseat_event &C.wl_event_source

	devices C.wl_list

	event_loop &C.wl_event_loop

	events struct {
	pub:
		active       C.wl_signal
		add_drm_card C.wl_signal
		destroy      C.wl_signal
	}

	wlr_private struct {
		event_loop_destroy C.wl_listener
	}
}

pub struct C.wlr_session_add_event {
	path string
}

pub enum Wlr_device_change_type {
	hotplug = 1
	lease
}

pub struct C.wlr_device_hotplug_event {
	connector_id u32
	prop_id      u32
}

pub struct C.wlr_device_change_event {
	type Wlr_device_change_type

	// union
	hotplug C.wlr_device_hotplug_event
}

pub fn C.wlr_session_create(loop &C.wl_event_loop) &C.wlr_session
pub fn C.wlr_session_destroy(session &C.wlr_session)

pub fn C.wlr_session_open_file(session &C.wlr_session, path string) &C.wlr_device
pub fn C.wlr_session_close_file(session &C.wlr_session, device &C.wlr_device)

pub fn C.wlr_session_change_vt(session &C.wlr_session, vt u32) bool
pub fn C.wlr_session_find_gpus(session &C.wlr_session, ret_len usize, ret &&C.wlr_device) isize
