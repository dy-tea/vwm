module types

#flag linux -DWLR_USE_UNSTABLE
#flag linux -I/usr/include/
#flag linux -I/usr/include/wlroots-0.20
#flag linux -lwlroots-0.20
#include <wlr/types/wlr_buffer.h>

pub struct C.wlr_shm_attributes {
	fd     int
	format u32
	width  int
	height int
	stride int
	offset i64
}

pub enum Wlr_buffer_cap {
	data_ptr = 1 << 0
	dmabuf   = 1 << 1
	shm      = 1 << 2
}

pub struct C.wlr_buffer {
pub:
	width  int
	height int

	dropped            bool
	n_locks            usize
	accessing_data_ptr bool

	events struct {
	pub:
		destroy C.wl_signal
		release C.wl_signal
	}
	//...
}

pub struct C.wlr_client_buffer {
pub:
	base C.wlr_buffer
	//..
}
