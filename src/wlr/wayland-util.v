module wlr

#flag linux -I/usr/include
#flag linux -I/usr/include/pixman-1
#flag linux -I/usr/include/wayland-protocols
#flag -I @VMODROOT
#flag linux -I/usr/include/wlroots-0.19
#flag linux -Lwlroots
#flag linux -DWLR_USE_UNSTABLE

#include "wayland-util.h"

pub struct C.wl_object {}

pub struct C.wl_message {
	name string
	signature string
	types &C.wl_interface
}

pub struct C.wl_interface {
	name string
	version int
	method_count int
	methods &C.wl_message
	event_count int
	events &C.wl_message
}

pub struct C.wl_list {
	prev &C.wl_list = unsafe { nil }
	next &C.wl_list = unsafe { nil }
}

pub fn C.wl_list_init(list &C.wl_list)
pub fn C.wl_list_insert(list &C.wl_list, elm &C.wl_list)
pub fn C.wl_list_remove(elm &C.wl_list)
pub fn C.wl_list_length(list &C.wl_list) int
pub fn C.wl_list_empty(list &C.wl_list) bool
pub fn C.wl_list_insert_list(list &C.wl_list, other &C.wl_list)

pub struct C.wl_array {
	size usize
	alloc usize
	data voidptr
}

pub fn C.wl_array_init(array &C.wl_array)
pub fn C.wl_array_release(array &C.wl_array)
pub fn C.wl_array_add(array &C.wl_array, size usize) voidptr
pub fn C.wl_array_copy(array &C.wl_array, source &C.wl_array) int

pub type Wl_fixed_t = u32

@[inline]
pub fn wl_fixed_to_double(fixed Wl_fixed_t) f64 {
	return f64(fixed) / 256.0
}

pub fn C.wl_fixed_from_double(d f64) Wl_fixed_t

@[inline]
pub fn wl_fixed_to_int(f Wl_fixed_t) int {
	return int(f) / 256
}

pub fn C.wl_fixed_from_int(d int) Wl_fixed_t

pub union C.wl_argument {
	i int
	u u32
	f Wl_fixed_t
	s string
	o &C.wl_object
	n u32
	a &C.wl_array
	h int
}

pub type Wl_dispatcher_func_t = fn (data voidptr, target voidptr, opcode u32, msg &C.wl_message, args &C.wl_argument) int

pub type Wl_log_func_t = fn (fmt string, args ...)

pub enum Wl_iterator_result {
	stop
	contiue
}
