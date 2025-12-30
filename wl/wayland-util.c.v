module wl

#pkgconfig wayland-server
#include <wayland-util.h>

pub struct C.wl_message {
pub:
	name      &u8
	signature &u8
	types     &&C.wl_interface
}

pub struct C.wl_interface {
pub:
	name         &u8
	version      int
	method_count int
	// methods &C.wl_message
	event_count int
	// events  &C.wl_message
}

pub struct C.wl_list {
pub:
	prev &C.wl_list
	next &C.wl_list
}

fn C.wl_list_init(list &C.wl_list)
fn C.wl_list_insert(list &C.wl_list, element &C.wl_list)
fn C.wl_list_remove(element &C.wl_list)
fn C.wl_list_length(list &C.wl_list) int
fn C.wl_list_empty(list &C.wl_list) bool
fn C.wl_list_insert_list(list &C.wl_list, other &C.wl_list)

pub struct C.wl_array {
pub:
	size  usize
	alloc usize
	data  voidptr
}

fn C.wl_array_init(array &C.wl_array)
fn C.wl_array_release(array &C.wl_array)
fn C.wl_array_add(array &C.wl_array, size usize) voidptr
fn C.wl_array_copy(array &C.wl_array, source &C.wl_array) int

pub enum Wl_interator_result {
	stop
	continue
}
