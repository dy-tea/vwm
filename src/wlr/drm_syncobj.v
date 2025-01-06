module wlr

#flag linux -I/usr/include
#flag linux -I/usr/include/pixman-1
#flag linux -I/usr/include/wayland-protocols
#flag -I @VMODROOT
#flag linux -I/usr/include/wlroots-0.19
#flag linux -lwayland-server
#flag linux -lwlroots-0.19
#flag linux -DWLR_USE_UNSTABLE

#include "wlr/render/drm_syncobj.h"

pub struct C.wlr_drm_syncobj_timeline {
	drm_fd int
	handle u32

	addons C.wlr_addon_set

	WLR_PRIVATE struct {
		n_refs usize
	}
}

pub struct C.wlr_drm_syncobj_timeline_waiter {
	events struct {
	pub:
		ready C.wl_signal
	}

	WLR_PRIVATE struct {
		ev_fd        int
		event_source &C.wl_event_source
	}
}

pub fn C.wlr_drm_syncobj_timeline_create(drm_fd int) &C.wlr_drm_syncobj_timeline
pub fn C.wlr_drm_syncobj_timeline_import(drm_fd int, drm_syncobj_fd int) &C.wlr_drm_syncobj_timeline
pub fn C.wlr_drm_syncobj_timeline_ref(timeline &C.wlr_drm_syncobj_timeline) &C.wlr_drm_syncobj_timeline
pub fn C.wlr_drm_syncobj_timeline_unref(timeline &C.wlr_drm_syncobj_timeline)
pub fn C.wlr_drm_syncobj_timeline_export(timeline &C.wlr_drm_syncobj_timeline) int
pub fn C.wlr_drm_syncobj_timeline_transfer(dst &C.wlr_drm_syncobj_timeline, dst_point u64, src &C.wlr_drm_syncobj_timeline, src_point u64) bool
pub fn C.wlr_drm_syncobj_timeline_check(timeline &C.wlr_drm_syncobj_timeline, point u64, flags u32, result &bool) bool
pub fn C.wlr_drm_syncobj_timeline_waiter_init(waiter &C.wlr_drm_syncobj_timeline_waiter, timeline &C.wlr_drm_syncobj_timeline, point u64, flags u32, loop &C.wl_event_loop) bool
pub fn C.wlr_drm_syncobj_timeline_waiter_finish(waiter &C.wlr_drm_syncobj_timeline_waiter)
pub fn C.wlr_drm_syncobj_timeline_export_sync_file(timeline &C.wlr_drm_syncobj_timeline, src_point u64) int
pub fn C.wlr_drm_syncobj_timeline_import_sync_file(timeline &C.wlr_drm_syncobj_timeline, dst_point u64, sync_file_fd int) bool
