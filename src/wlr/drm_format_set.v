module wlr

#flag linux -I/usr/include
#flag linux -I/usr/include/pixman-1
#flag linux -I/usr/include/wayland-protocols
#flag -I @VMODROOT
#flag linux -I/usr/include/wlroots-0.19
#flag linux -lwayland-server
#flag linux -lwlroots-0.19
#flag linux -DWLR_USE_UNSTABLE

#include "wlr/render/drm_format_set.h"

pub struct C.wlr_drm_format {
	format    u32
	len       usize
	capacity  usize
	modifiers &u64
}

pub fn C.wlr_drm_format_finish(format &C.wlr_drm_format)

pub struct C.wlr_drm_format_set {
	len      usize
	capacity usize
	formats  []C.wlr_drm_format
}

pub fn C.wlr_drm_format_set_finish(set &C.wlr_drm_format_set)

pub fn C.wlr_drm_format_set_get(set &C.wlr_drm_format_set, format u32) &C.wlr_drm_format
pub fn C.wlr_drm_format_set_remove(set &C.wlr_drm_format_set, format u32, modifier u64) bool
pub fn C.wlr_drm_format_set_has(set &C.wlr_drm_format_set, format u32, modifier u64) bool
pub fn C.wlr_drm_format_set_add(set &C.wlr_drm_format_set, format u32, modifier u64) bool

pub fn C.wlr_format_set_intersect(dst &C.wlr_drm_format_set, a &C.wlr_drm_format_set, b &C.wlr_drm_format_set) bool
pub fn C.wlr_format_set_union(dst &C.wlr_drm_format_set, a &C.wlr_drm_format_set, b &C.wlr_drm_format_set) bool
