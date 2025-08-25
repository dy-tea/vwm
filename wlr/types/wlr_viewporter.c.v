module types

import wl

#flag linux -DWLR_USE_UNSTABLE
#flag linux -I/usr/include/
#flag linux -I/usr/include/wlroots-0.20
#flag linux -lwlroots-0.20
#include <wlr/types/wlr_viewporter.h>

pub struct C.wlr_viewporter {
pub:
	global &C.wl_global

	events struct {
	pub:
		destroy C.wl_signal
	}
}

fn C.wlr_viewporter_create(display &C.wl_display) &C.wlr_viewporter
