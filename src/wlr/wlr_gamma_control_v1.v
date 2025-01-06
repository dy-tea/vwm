module wlr

#flag linux -I/usr/include
#flag linux -I/usr/include/pixman-1
#flag linux -I/usr/include/wayland-protocols
#flag -I @VMODROOT
#flag linux -I/usr/include/wlroots-0.19
#flag linux -lwayland-server
#flag linux -lwlroots-0.19
#flag linux -DWLR_USE_UNSTABLE

#include "wlr/types/wlr_gamma_control_v1.h"

pub struct C.wlr_gamma_control_manager_v1 {
	global   &C.wl_global
	controls C.wl_list

	events struct {
		destroy   C.wl_signal
		set_gamma C.wl_signal
	}

	data voidptr

	WLR_PRIVATE struct {
		display_destroy &C.wlr_backend
	}
}

pub struct C.wlr_gamma_control_manager_v1_set_gamma_event {
	output  &C.wlr_output
	control &C.wlr_gamma_control_v1
}

pub struct C.wlr_gamma_control_v1 {
	resource &C.wl_resource
	output   &C.wlr_output
	manager  &C.wlr_gamma_control_manager_v1
	link     C.wl_list

	table     []u16
	ramp_size usize

	data voidptr

	WLR_PRIVATE struct {
		output_destroy_listener C.wl_listener
	}
}

pub fn C.wlr_gamma_control_manager_v1_create(display &C.wl_display) &C.wlr_gamma_control_manager_v1
pub fn C.wlr_gamma_control_manager_v1_get_control(manager &C.wlr_gamma_control_manager_v1, output &C.wlr_output) &C.wlr_gamma_control_v1
pub fn C.wlr_gamma_control_v1_apply(control &C.wlr_gamma_control_v1i, output_state &C.wlr_output_state) bool
pub fn C.wlr_gamma_control_v1_send_failed_and_destroy(control &C.wlr_gamma_control_v1)
