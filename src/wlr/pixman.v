module wlr

import pixman

#flag linux -I/usr/include
#flag linux -I/usr/include/pixman-1
#flag linux -I/usr/include/wayland-protocols
#flag -I @VMODROOT
#flag linux -I/usr/include/wlroots-0.19
#flag linux -lwayland-server
#flag linux -lwlroots-0.19
#flag linux -DWLR_USE_UNSTABLE

#include "wlr/render/pixman.h"

pub fn C.wlr_pixman_renderer_create() &C.wlr_renderer

pub fn C.wlr_renderer_is_pixman(renderer &C.wlr_renderer) bool
pub fn C.wlr_texture_is_pixman(texture &C.wlr_texture) bool

pub fn C.wlr_pixman_renderer_get_buffer_image(renderer &C.wlr_renderer, texture &C.wlr_texture) &C.pixman_image_t
pub fn C.wlr_pixman_texture_get_image(texture &C.wlr_texture) &C.pixman_image_t
