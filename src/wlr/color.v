module wlr

#flag linux -I/usr/include
#flag linux -I/usr/include/pixman-1
#flag linux -I/usr/include/wayland-protocols
#flag -I @VMODROOT
#flag linux -I/usr/include/wlroots-0.19
#flag linux -lwayland-server
#flag linux -lwlroots-0.19
#flag linux -DWLR_USE_UNSTABLE

#include "wlr/render/color.h"

pub struct C.wlr_color_transform {}

pub fn C.wlr_color_transform_init_linear_to_icc(data voidptr, size usize) &C.wlr_color_transform
pub fn C.wlr_color_transform_init_srgb() &C.wlr_color_transform
pub fn C.wlr_color_transform_ref(tr &C.wlr_color_transform) &C.wlr_color_transform
pub fn C.wlr_color_transform_unref(tr &C.wlr_color_transform)
