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

pub struct C.wlr_xcursor_manager {}

pub struct C.wlr_cursor_state {}

pub struct C.wlr_cursor {
	state  &C.wlr_cursor_state
	x      f64
	y      f64
	events struct {
	pub:
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

pub fn C.wlr_cursor_create() &C.wlr_cursor

pub fn C.wlr_cursor_destroy(cur &C.wlr_cursor)

pub fn C.wlr_cursor_warp(cur &C.wlr_cursor, dev &C.wlr_input_device, lx f64, ly f64) bool

pub fn C.wlr_cursor_absolute_to_layout_coords(cur &C.wlr_cursor, dev &C.wlr_input_device, x f64, y f64, lx &f64, ly &f64)

pub fn C.wlr_cursor_warp_closest(cur &C.wlr_cursor, dev &C.wlr_input_device, x f64, y f64)

pub fn C.wlr_cursor_warp_absolute(cur &C.wlr_cursor, dev &C.wlr_input_device, x f64, y f64)

pub fn C.wlr_cursor_move(cur &C.wlr_cursor, dev &C.wlr_input_device, delta_x f64, delta_y f64)

pub fn C.wlr_cursor_set_buffer(cur &C.wlr_cursor, buffer &C.wlr_buffer, hotspot_x int, hotspot_y int, scale f32)

pub fn C.wlr_cursor_unset_image(cur &C.wlr_cursor)

pub fn C.wlr_cursor_set_xcursor(cur &C.wlr_cursor, manager &C.wlr_xcursor_manager, name &char)

pub fn C.wlr_cursor_set_surface(cur &C.wlr_cursor, surface &C.wlr_surface, hotspot_x int, hotspot_y int)

pub fn C.wlr_cursor_attach_input_device(cur &C.wlr_cursor, dev &C.wlr_input_device)

pub fn C.wlr_cursor_detach_input_device(cur &C.wlr_cursor, dev &C.wlr_input_device)

pub fn C.wlr_cursor_attach_output_layout(cur &C.wlr_cursor, l &C.wlr_output_layout)

pub fn C.wlr_cursor_map_to_output(cur &C.wlr_cursor, output &C.wlr_output)

pub fn C.wlr_cursor_map_input_to_output(cur &C.wlr_cursor, dev &C.wlr_input_device, output &C.wlr_output)

pub fn C.wlr_cursor_map_to_region(cur &C.wlr_cursor, box &C.wlr_box)

pub fn C.wlr_cursor_map_input_to_region(cur &C.wlr_cursor, dev &C.wlr_input_device, box &C.wlr_box)
