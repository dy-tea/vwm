module wlr

#flag linux -I/usr/include
#flag linux -I/usr/include/pixman-1
#flag linux -I/usr/include/wayland-protocols
#flag -I @VMODROOT
#flag linux -I/usr/include/wlroots-0.19
#flag linux -lwayland-server
#flag linux -lwlroots-0.19
#flag linux -DWLR_USE_UNSTABLE

#include <sys/types.h>

type C.off_t = i64

#include "wlr/interfaces/wlr_buffer.h"

pub struct C.wlr_buffer_impl {
	destroy             fn (buffer &C.wlr_buffer)
	get_dmabuf          fn (buffer &C.wlr_buffer, attribs &C.wlr_dmabuf_attributes) bool
	get_shm             fn (buffer &C.wlr_buffer, attribs &C.wlr_dmabuf_attributes) &C.wl_shm_buffer
	begin_ptr_access    fn (buffer &C.wlr_buffer, flags u32, data &voidptr, format u32, stride usize) voidptr
	end_data_ptr_access fn (buffer &C.wlr_buffer)
}

pub struct C.wlr_buffer_resource_interface {
	name          string
	is_instance   fn (resource &C.wl_resource) bool
	from_resource fn (resource &C.wl_resource) &C.wlr_buffer
}

pub fn C.wlr_buffer_init(buffer &C.wlr_buffer, impl &C.wlr_buffer_impl, width int, height int)
pub fn C.wlr_buffer_register_resource_interface(iface &C.wlr_buffer_resource_interface)

#include "wlr/types/wlr_buffer.h"

pub struct C.wlr_shm_attributes {
	fd     int
	format u32
	width  int
	height int
	stride int
	offset C.off_t
}

pub enum Wlr_buffer_cap {
	data_ptr = 1 << 0
	dmabuf   = 1 << 1
	shm      = 1 << 2
}

pub struct C.wlr_buffer {
	impl &C.wlr_buffer_impl

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

	addons C.wlr_addon_set
}

pub fn C.wlr_buffer_drop(buffer &C.wlr_buffer)
pub fn C.wlr_buffer_lock(buffer &C.wlr_buffer) &C.wlr_buffer
pub fn C.wlr_buffer_unlock(buffer &C.wlr_buffer)
pub fn C.wlr_buffer_get_dmabuf(buffer &C.wlr_buffer, &C.wlr_dmabuf_attributes) bool
pub fn C.wlr_buffer_get_shm(buffer &C.wlr_buffer, &C.wlr_shm_attributes) bool
pub fn C.wlr_buffer_try_from_resource(resource &C.wlr_resource) &C.wlr_buffer

pub enum Wlr_buffer_data_ptr_access_flag {
	read  = 1 << 0
	write = 1 << 1
}

pub fn C.wlr_buffer_begin_data_ptr_access(buffer &C.wlr_buffer, flags u32, data &voidptr, format &u32, stride &usize) bool
pub fn C.wlr_buffer_end_data_ptr_access(buffer &C.wlr_buffer)

pub struct C.wlr_client_buffer {
	base    C.wlr_buffer
	texture &C.wlr_texture

	wlr_private struct {
		source_destroy   C.wl_listener
		renderer_destroy C.wl_listener

		n_ignore_locks usize
	}
}

pub fn C.wlr_client_buffer_get(buffer &C.wlr_buffer) &C.wlr_client_buffer
