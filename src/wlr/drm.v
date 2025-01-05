module wlr

#flag linux -I/usr/include
#flag linux -I/usr/include/pixman-1
#flag linux -I/usr/include/wayland-protocols
#flag -I @VMODROOT
#flag linux -I/usr/include/wlroots-0.19
#flag linux -lwayland-server
#flag linux -lwlroots-0.19
#flag linux -DWLR_USE_UNSTABLE

#include "wlr/backend/drm.h"

pub struct C.wlr_drm_backend {}

@[typedef]
pub struct C._drmModeModeInfo {}

pub struct C.drmModeModeInfo {}

pub struct C.wlr_drm_lease {
	fd        int
	lessee_id u32
	backend   &C.wlr_drm_backend

	events struct {
	pub:
		destroy C.wl_signal
	}

	data voidptr
}

pub fn C.wlr_drm_backend_create(session &C.wlr_session, dev &C.wlr_device, parent &C.wlr_backend) &C.wlr_backend

pub fn C.wlr_backend_is_drm(backend &C.wlr_backend) bool
pub fn C.wlr_output_is_drm(output &C.wlr_output) bool

pub fn C.wlr_drm_backend_get_parent(backend &C.wlr_drm_backend) &C.wlr_backend
pub fn C.wlr_drm_connector_get_id(output &C.wlr_output) u32
pub fn C.wlr_drm_backend_get_non_master_fd(backend &C.wlr_drm_backend) int
pub fn C.wlr_drm_create_lease(outputs &&C.wlr_output, n_outputs usize, lease_fd &int) &C.wlr_drm_lease
pub fn C.wlr_drm_lease_terminate(lease &C.wlr_drm_lease)
pub fn C.wlr_drm_connector_add_mode(output &C.wlr_output, mode &C.drmModeModeInfo) &C.wlr_output_mode
pub fn C.wlr_drm_mode_get_info(mode &C.wlr_output_mode) &C.drmModeModeInfo
pub fn C.wlr_drm_connector_get_panel_orientation(output &C.wlr_output) Wl_output_transform
