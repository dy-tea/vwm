module wl

import utils

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

pub fn wl_container_of[T](ptr voidptr, member_name string) &T {
	$if T is $struct && T !is $string {
		return unsafe { &T(&char(ptr) - utils.offsetof[T](member_name)) }
	} $else {
		$compile_error('T is not of type struct')
	}
}

pub fn wl_list_for_each[T](head &C.wl_list, member_name string, for_each fn (&T)) {
	$if T is $struct {
		offset := utils.offsetof[T](member_name)
		mut pos := wl_container_of[T](head.next, member_name)
		for {
			cur := pos
			if cur == wl_container_of[T](head, member_name) {
				break
			}
			for_each(cur)
			link := unsafe { &C.wl_list(&u8(cur) + offset) }
			pos = wl_container_of[T](link.next, member_name)
		}
	} $else {
		$compile_error('T is not of type struct')
	}
}

pub fn wl_list_for_each_reverse[T](head &C.wl_list, member_name string, for_each fn (&T)) {
	$if T is $struct {
		offset := utils.offsetof[T](member_name)
		mut pos := wl_container_of[T](head.prev, member_name)
		for {
			cur := pos
			if cur == wl_container_of[T](head, member_name) {
				break
			}
			for_each(cur)
			link := unsafe { &C.wl_list(&u8(cur) + offset) }
			pos = wl_container_of[T](link.prev, member_name)
		}
	} $else {
		$compile_error('T is not of type struct')
	}
}

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
