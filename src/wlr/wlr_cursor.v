module wlr

#flag linux -I/usr/include
#flag linux -I/usr/include/pixman-1
#flag linux -I/usr/include/wayland-protocols
#flag -I @VMODROOT
#flag linux -I/usr/include/wlroots-0.19
#flag linux -lwayland-server
#flag linux -lwlroots-0.19
#flag linux -DWLR_USE_UNSTABLE

#include "wlr/types/wlr_cursor.h"

pub struct C.wlr_input_device {}

pub struct C.wlr_xcursor_manager {}

pub struct C.wlr_box {}

pub struct C.wlr_cursor_state {}

pub struct C.wlr_cursor {
	state  C.wlr_cursor_state
	x      f64
	y      f64
	events struct {
		motion                  C.wl_signal
		motion_absolute         C.wl_signal
		button                  C.wl_signal
		axis                    C.wl_signal
		axis_discrete           C.wl_signal
		axis_source             C.wl_signal
		axis_stop               C.wl_signal
		axis_discrete_stop      C.wl_signal
		frame                   C.wl_signal
		swipe_begin             C.wl_signal
		swipe_update            C.wl_signal
		swipe_end               C.wl_signal
		pinch_begin             C.wl_signal
		pinch_update            C.wl_signal
		pinch_end               C.wl_signal
		touch_down              C.wl_signal
		touch_up                C.wl_signal
		touch_motion            C.wl_signal
		touch_cancel            C.wl_signal
		tablet_tool_axis        C.wl_signal
		tablet_tool_proximity   C.wl_signal
		tablet_tool_tip         C.wl_signal
		tablet_tool_button      C.wl_signal
		tablet_tool_axis_source C.wl_signal
		tablet_tool_frame       C.wl_signal
		tablet_pad_button       C.wl_signal
		tablet_pad_ring         C.wl_signal
		tablet_pad_strip        C.wl_signal
		tablet_pad_group_mode   C.wl_signal
	}
	data   voidptr
}
