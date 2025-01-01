module wlr

import pixman

#flag linux -I/usr/include
#flag linux -I/usr/include/pixman-1
#flag linux -I/usr/include/wayland-protocols
#flag -I @VMODROOT
#flag linux -I/usr/include/wlroots-0.19
#flag linux -Lwlroots
#flag linux -DWLR_USE_UNSTABLE

#include "wlr/types/wlr_damange_ring.h"

pub struct C.wlr_damage_ring_buffer {
	buffer &C.wlr_buffer
	damage pixman.Pixman_region32_t

	ring &C.wlr_damage_ring
	link C.wl_list

	wlr_private struct {
		destroy C.wl_listener
	}
}

pub struct C.wlr_damage_ring {
	current pixman.Pixman_region32_t

	wlr_private struct {
		buffers C.wl_list
	}
}

pub fn C.wlr_damage_ring_init(ring &C.wlr_damage_ring)
pub fn C.wlr_damage_ring_finish(ring &C.wlr_damage_ring)

pub fn C.wlr_damage_ring_add(ring &C.wlr_damage_ring, damage &pixman.Pixman_region32_t)
pub fn C.wlr_damage_ring_add_box(ring &C.wlr_damage_ring, box &C.wlr_box)
pub fn C.wlr_damage_ring_add_whole(ring &C.wlr_damage_ring)

pub fn C.wlr_damage_ring_rotate_buffers(ring &C.wlr_damage_ring, buffer &C.wlr_buffer, damage &pixman.Pixman_region32_t)
