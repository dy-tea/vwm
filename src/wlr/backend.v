module wlr

#flag linux -I/usr/include
#flag linux -I/usr/include/pixman-1
#flag linux -I/usr/include/wayland-protocols
#flag -I @VMODROOT
#flag linux -I/usr/include/wlroots-0.19
#flag linux -lwayland-server
#flag linux -lwlroots-0.19
#flag linux -DWLR_USE_UNSTABLE

#include "wlr/backend.h"

pub struct C.wlr_backend_output_state {
	output &C.wlr_output
	base   C.wlr_output_state
}

pub struct C.wlr_backend_impl {}

pub struct C.wlr_backend {
	impl              &C.wlr_backend_impl
	features_timeline bool
	events_destroy    C.wl_signal
	events_new_input  C.wl_signal
	events_new_output C.wl_signal
}

pub fn C.wlr_backend_autocreate(loop &C.wl_event_loop, session_ptr &&C.wlr_session) &C.wlr_backend

pub fn C.wlr_backend_start(backend &C.wlr_backend) bool

pub fn C.wlr_backend_destroy(backend &C.wlr_backend)

pub fn C.wlr_backend_get_drm_fd(backend &C.wlr_backend) int

pub fn C.wlr_backend_test(backend &C.wlr_backend, states &C.wlr_backend_output_state, states_len usize) bool

pub fn C.wlr_backend_commit(backend &C.wlr_backend, states &C.wlr_backend_output_state, states_len usize) bool
