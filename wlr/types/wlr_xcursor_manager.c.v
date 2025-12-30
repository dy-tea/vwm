module types

#flag linux -DWLR_USE_UNSTABLE
#pkgconfig wlroots-0.20
#include <wlr/types/wlr_xcursor_manager.h>

pub struct C.wlr_xcursor_manager_theme {
	scale f32
	theme &C.wlr_xcursor_theme
	link  C.wl_list
}

pub struct C.wlr_xcursor_manager {
pub:
	name          &u8
	size          u32
	scaled_themes C.wl_list
}

fn C.wlr_xcursor_manager_create(name &char, size u32) &C.wlr_xcursor_manager
fn C.wlr_xcursor_manager_destroy(manager &C.wlr_xcursor_manager)

fn C.wlr_xcursor_manager_load(manager &C.wlr_xcursor_manager, scale f32) bool
fn C.wlr_xcursor_manager_get_xcursor(manager &C.wlr_xcursor_manager, name &char, scale f32) &C.wlr_xcursor
