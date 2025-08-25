module wlr

import wl

#flag linux -DWLR_USE_UNSTABLE
#flag linux -I/usr/include/
#flag linux -I/usr/include/wlroots-0.20
#flag linux -lwlroots-0.20
#include <wlr/backend.h>

pub struct C.wlr_backend {
pub:
	buffer_caps u32

	features struct {
		timeline bool
	}

	events struct {
	pub:
		new_output C.wl_signal
		new_input  C.wl_signal
	}
}

fn C.wlr_backend_autocreate(event_loop &C.wl_event_loop, session_ptr &&C.wlr_session) &C.wlr_backend
fn C.wlr_backend_start(backend &C.wlr_backend) bool
fn C.wlr_backend_destroy(backend &C.wlr_backend)
