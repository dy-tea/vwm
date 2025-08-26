module types

import wl

#flag linux -DWLR_USE_UNSTABLE
#flag linux -I/usr/include/
#flag linux -I/usr/include/wlroots-0.20
#flag linux -lwlroots-0.20
#include <wlr/types/wlr_single_pixel_buffer_v1.h>

pub struct C.wlr_single_pixel_buffer_manager_v1 {
pub:
	global &C.wl_global
}

fn C.wlr_single_pixel_buffer_manager_v1_create(display &C.wl_display) &C.wlr_single_pixel_buffer_manager_v1
