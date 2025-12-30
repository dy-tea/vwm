module types

#flag linux -DWLR_USE_UNSTABLE
#pkgconfig wlroots-0.20
#include <wlr/types/wlr_cursor.h>

pub struct C.wlr_cursor_state {}

pub struct C.wlr_cursor {
pub:
	state &C.wlr_cursor_state
	x     f32
	y     f32

	events struct {
	pub:
		motion          C.wl_signal
		motion_absolute C.wl_signal
		button          C.wl_signal
		axis            C.wl_signal
		frame           C.wl_signal
		swipe_begin     C.wl_signal
		swipe_update    C.wl_signal
		swipe_end       C.wl_signal
		pinch_begin     C.wl_signal
		pinch_update    C.wl_signal
		pinch_end       C.wl_signal
		hold_begin      C.wl_signal
		hold_end        C.wl_signal

		touch_up     C.wl_signal
		touch_down   C.wl_signal
		touch_motion C.wl_signal
		touch_cancel C.wl_signal
		touch_frame  C.wl_signal

		tablet_tool_axis      C.wl_signal
		tablet_tool_proximity C.wl_signal
		tablet_tool_tip       C.wl_signal
		tablet_tool_button    C.wl_signal
	}
pub mut:
	data voidptr
}

fn C.wlr_cursor_create() &C.wlr_cursor
fn C.wlr_cursor_destroy(cursor &C.wlr_cursor)

fn C.wlr_cursor_warp(cur &C.wlr_cursor, dev &C.wlr_input_device, lx f32, ly f32) bool
fn C.wlr_cursor_absolute_to_layout_coords(cur &C.wlr_cursor, dev &C.wlr_input_device, x f32, y f32, lx &f32, ly &f32)
fn C.wlr_cursor_warp_closest(cur &C.wlr_cursor, dev &C.wlr_input_device, x f32, y f32)
fn C.wlr_cursor_warp_absolute(cur &C.wlr_cursor, dev &C.wlr_input_device, x f32, y f32)
fn C.wlr_cursor_move(cur &C.wlr_cursor, dev &C.wlr_input_device, delta_x f32, delta_y f32)

fn C.wlr_cursor_set_buffer(cur &C.wlr_cursor, buffer &C.wlr_buffer, hotspot_x i32, hotspot_y i32, scale f32)
fn C.wlr_cursor_unset_image(cur &C.wlr_cursor)

fn C.wlr_cursor_set_xcursor(cur &C.wlr_cursor, manager &C.wlr_xcursor_manager, name &char)
fn C.wlr_cursor_set_surface(cur &C.wlr_cursor, surface &C.wlr_surface, hotspot_x i32, hotspot_y i32)

fn C.wlr_cursor_attach_input_device(cur &C.wlr_cursor, dev &C.wlr_input_device)
fn C.wlr_cursor_detach_input_device(cur &C.wlr_cursor, dev &C.wlr_input_device)

fn C.wlr_cursor_attach_output_layout(cur &C.wlr_cursor, l &C.wlr_output_layout)
