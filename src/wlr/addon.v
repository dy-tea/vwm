module wlr

#flag linux -I/usr/include
#flag linux -I/usr/include/pixman-1
#flag linux -I/usr/include/wayland-protocols
#flag -I @VMODROOT
#flag linux -I/usr/include/wlroots-0.19
#flag linux -Lwlroots
#flag linux -DWLR_USE_UNSTABLE

#include "wlr/util/addon.h"

pub struct C.wlr_addon_set {
	wlr_private struct {
		addons C.wl_list
	}
}

pub struct C.wlr_addon_iterface {
	name    string
	destroy fn (addon &C.wlr_addon)
}

pub struct C.wlr_addon {
	impl &C.wlr_addon_interface

	wlr_private struct {
		owner voidptr
		link  C.wl_list
	}
}

pub fn C.wlr_addon_set_init(set &C.wlr_addon_set)
pub fn C.wlr_addon_set_finish(set &C.wlr_addon_set)

pub fn C.wlr_addon_init(addon &C.wlr_addon, set &C.wlr_addon_set, owner voidptr, impl &C.wlr_addon_interface)
pub fn C.wlr_addon_finish(addon &C.wlr_addon)

pub fn C.wlr_addon_find(set &C.wlr_addon_set, owner voidptr, impl C.wlr_addon_interface) &C.wlr_addon
