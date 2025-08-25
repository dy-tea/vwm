module types

import wl

#flag linux -DWLR_USE_UNSTABLE
#flag linux -I/usr/include/
#flag linux -I/usr/include/wlroots-0.20
#flag linux -lwlroots-0.20
#include <wlr/types/wlr_primary_selection.h>

pub struct C.wlr_primary_selection_source_impl {
pub:
	send    fn (source &C.wlr_primary_selection_source, mime_type &char, fd int)
	destroy fn (source &C.wlr_primary_selection_source)
}

pub struct C.wlr_primary_selection_source {
pub:
	mime_types C.wl_array

	events struct {
	pub:
		destroy C.wl_signal
	}
pub mut:
	data voidptr
}

fn C.wlr_primary_selection_source_init(source &C.wlr_primary_selection_source, impl &C.wlr_primary_selection_source_impl)
fn C.wlr_primary_selection_source_destroy(source &C.wlr_primary_selection_source)
fn C.wlr_primary_selection_source_send(source &C.wlr_primary_selection_source, const_mime_type &char, fd int)

fn C.wlr_seat_request_set_primary_selection(client &C.wlr_seat_client, source &C.wlr_primary_selection_source, serial u32)
fn C.wlr_seat_set_primary_selection(seat &C.wlr_seat, source &C.wlr_primary_selection_source, serial u32)
