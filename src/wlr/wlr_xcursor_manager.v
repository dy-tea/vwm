module wlr

#flag linux -I/usr/include
#flag linux -I/usr/include/pixman-1
#flag linux -I/usr/include/wayland-protocols
#flag -I @VMODROOT
#flag linux -I/usr/include/wlroots-0.19
#flag linux -Lwlroots
#flag linux -DWLR_USE_UNSTABLE

#include "wlr/types/wlr_xcursor_manager.h"

pub struct C.wlr_xcursor_manager_theme {
	scale f32
	theme &C.wlr_xcursor_theme
	link  C.wl_list
}

pub struct C.wlr_xcursor_manager {
	name          string
	size          u32
	scaled_themes C.wl_list
}

pub fn C.wlr_xcursor_manager_create(name string, size u32) &C.wlr_xcursor_manager
pub fn C.wlr_xcursor_manager_destroy(manager &C.wlr_xcursor_manager)

pub fn C.wlr_xcursor_manager_load(manager &C.wlr_xcursor_manager, scale f32) &C.wlr_xcursor_manager_theme

pub fn C.wlr_xcursor_manager_get_xcursor(manager &C.wlr_xcursor_manager, name string, scale f32) &C.wlr_xcursor
