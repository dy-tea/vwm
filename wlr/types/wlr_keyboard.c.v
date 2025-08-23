module types

import xkb
import wayland

#flag linux -DWLR_USE_UNSTABLE
#flag linux -I/usr/include/
#flag linux -I/usr/include/wlroots-0.20
#flag linux -lwlroots-0.20
#include <wlr/types/wlr_keyboard.h>

pub enum Wlr_keyboar_led {
	num_lock    = 1 << 0
	caps_lock   = 1 << 1
	scroll_lock = 1 << 2
	compose     = 1 << 3
	kana        = 1 << 4
}

pub enum Wlr_keyboard_modifier {
	shift = 1 << 0
	caps  = 1 << 1
	ctrl  = 1 << 2
	alt   = 1 << 3
	mod2  = 1 << 4
	mod3  = 1 << 5
	logo  = 1 << 6
	mod5  = 1 << 7
}

pub struct C.wlr_keyboard_modifiers {
pub:
	depressed u32
	latched   u32
	locked    u32
	group     u32
}

pub struct C.wlr_keyboard_impl {}

pub struct C.wlr_keyboard {
pub:
	base C.wlr_input_device

	impl  &C.wlr_keyboard_impl
	group &C.wlr_keyboard_group

	keymap_string &u8
	keymap_size   usize
	keymap_fd     int
	keymap        &C.xkb_keymap
	xkb_state     &C.xkb_state
	led_indexes   [5]u32
	mod_indexes   [8]u32

	leds         u32
	keycodes     &u32 // size 32
	num_keycodes usize
	modifiers    C.wlr_keyboard_modifiers

	repeat_info struct {
	pub:
		rate  i32
		delay i32
	}

	events struct {
	pub:
		key         C.wl_signal
		modifiers   C.wl_signal
		keymap      C.wl_signal
		repeat_info C.wl_signal
	}
pub mut:
	data voidptr
}

pub struct C.wlr_keyboard_key_event {
pub:
	time_msec    u32
	keycode      u32
	update_state bool
	state        wayland.Wl_keyboard_key_state
}

fn C.wlr_keyboard_from_input_device(input_device &C.wlr_input_device) &C.wlr_keyboard
fn C.wlr_keyboard_set_keymap(kb &C.wlr_keyboard, keymap &C.xkb_keymap) bool
fn C.wlr_keyboard_keymaps_match(kb1 &C.wlr_keyboard, kb2 &C.wlr_keyboard) bool

fn C.wlr_keyboard_keysym_to_pointer_button(keysym u32) u32
fn C.wlr_keyboard_keysym_to_pointer_motion(keysym u32, dx &i32, dy &i32)

fn C.wlr_keyboard_set_repeat_info(kb &C.wlr_keyboard, rate_hz i32, delay_ms i32)
fn C.wlr_keyboard_led_update(keyboard &C.wl_keyboard, leds u32)
fn C.wlr_keyboard_get_modifiers(keyboard &C.wl_keyboard) u32
