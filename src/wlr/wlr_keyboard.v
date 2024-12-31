module wlr

import xkbcommon

#flag linux -I/usr/include
#flag linux -I/usr/include/pixman-1
#flag linux -I/usr/include/wayland-protocols
#flag -I @VMODROOT
#flag linux -I/usr/include/wlroots-0.19
#flag linux -Lwlroots
#flag linux -DWLR_USE_UNSTABLE

#include "wlr/types/wlr_keyboard.h"

const wlr_led_count = 3

enum Wlr_keyboard_led {
	led_num_lock    = 1 << 0
	led_caps_lock   = 1 << 1
	led_scroll_lock = 1 << 2
}

const wlr_modifier_count = 8

enum Wlr_keyboard_modifier {
	shift = 1 << 0
	caps  = 1 << 1
	ctrl  = 1 << 2
	alt   = 1 << 3
	mod2  = 1 << 4
	mod3  = 1 << 5
	logo  = 1 << 6
	mod5  = 1 << 7
}

const wlr_keyboard_keys_cap = 32

struct C.wlr_keyboard_impl {}

pub struct C.wlr_keyboard_modifiers {
	depressed C.xkb_mod_mask_t
	latched   C.xkb_mod_mask_t
	locked    C.xkb_mod_mask_t
	gorup     C.xkb_layout_index_t
}

pub struct C.wlr_keyboard {
	base C.wlr_input_device

	impl  C.wlr_keyboard_impl
	group C.wlr_keyboard_group

	keymap_string &char
	keymap_size   usize
	keymap_fd     int
	keymap        C.xkb_keymap
	xkb_state     C.xkb_state
	led_indexes   [wlr_led_count]C.xkb_led_index_t
	mod_indices   [wlr_modifier_count]C.xkb_mod_index_t

	leds         u32
	keycodes     [wlr_keyboard_keys_cap]u32
	num_keycodes usize
	modifiers    C.wlr_keyboard_modifiers

	repeat_info struct {
		rate  int
		delay int
	}

	events struct {
		key         C.wl_signal
		modifiers   C.wl_signal
		keymap      C.wl_signal
		repeat_info C.wl_signal
	}

	data voidptr
}

pub struct C.wlr_keyboard_key_event {
	time_msec    u32
	keycode      u32
	update_state bool
	state        C.wl_keyboard_key_state
}

// Get a struct wlr_keyboard from a struct wlr_input_device
fn C.wlr_keyboard_from_input_device(input_device C.wlr_input_device) C.wlr_keyboard

fn C.wlr_keyboard_set_keymap(kb C.wlr_keyboard, keymap C.xkb_keymap) bool

fn C.wlr_keyboard_keymaps_match(km1 C.kxb_keymap, km2 C.xkb_keymap) bool

// Interpret pointer button key symbols
fn C.wlr_keyboard_keysym_to_pointer_button(keysym C.xkb_keysym_t, keysym) u32

// Interpet pointer motion key symbols
fn C.wlr_keyboard_keysym_to_pointer_motion(keysym C.xkb_keysym_t, dx int, dy int)

// Set the keyboard repeat info
fn C.wlr_keyboard_set_repeat_info(kb C.wlr_keyboard, rate_hz int, delay_ms int)

// Update the LEDs on the device, if any
fn C.wlr_keyboard_led_update(keyboard C.wlr_keyboard, leds u32)

// Get the set of currently depressed or latched modifiers
fn C.wlr_keyboard_get_modifiers(keyboard C.wlr_keyboard) u32
