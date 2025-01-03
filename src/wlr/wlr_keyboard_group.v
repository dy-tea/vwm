module wlr

#flag linux -I/usr/include
#flag linux -I/usr/include/pixman-1
#flag linux -I/usr/include/wayland-protocols
#flag -I @VMODROOT
#flag linux -I/usr/include/wlroots-0.19
#flag linux -lwayland-server
#flag linux -lwlroots-0.19
#flag linux -DWLR_USE_UNSTABLE

#include "wlr/types/wlr_keyboard_group.h"

pub struct C.wlr_keyboard_group {
	keyboard C.wlr_keyboard
	devices  C.wl_list
	keys     C.wl_list

	events struct {
		enter C.wl_signal
		leave C.wl_signal
	}

	data voidptr
}

pub fn C.wlr_keyboard_group_create() &C.wlr_keyboard_group
pub fn C.wlr_keyboard_group_from_wlr_keyboard(keyboard &C.wlr_keyboard) &C.wlr_keyboard_group
pub fn C.wlr_keyboard_group_add_keyboard(group &C.wlr_keyboard_group, keyboard &C.wlr_keyboard) bool
pub fn C.wlr_keyboard_group_remove_keyboard(group &C.wlr_keyboard_group, keyboard &C.wlr_keyboard)
pub fn C.wlr_keyboard_group_destroy(group &C.wlr_keyboard_group)
