module types

import wl

#flag linux -DWLR_USE_UNSTABLE
#flag linux -I/usr/include/
#flag linux -I/usr/include/wlroots-0.20
#flag linux -lwlroots-0.20
#include <wlr/types/wlr_keyboard_group.h>

pub struct C.wlr_keyboard_group {
pub:
	keyboard C.wlr_keyboard
	devices  C.wl_list
	keys     C.wl_list

	events struct {
	pub:
		enter C.wl_signal
		leave C.wl_signal
	}
pub mut:
	data voidptr
}

fn C.wlr_keyboard_group_create() &C.wlr_keyboard_group
fn C.wlr_keyboard_group_from_wlr_keyboard(keyboard &C.wlr_keyboard) &C.wlr_keyboard_group

fn C.wlr_keyboard_group_add_keyboard(group &C.wlr_keyboard_group, keyboard &C.wlr_keyboard) bool
fn C.wlr_keyboard_group_remove_keyboard(group &C.wlr_keyboard_group, keyboard &C.wlr_keyboard)

fn C.wlr_keyboard_group_destroy(group &C.wlr_keyboard_group)
