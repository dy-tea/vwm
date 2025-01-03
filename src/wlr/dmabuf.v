module wlr

#flag linux -I/usr/include
#flag linux -I/usr/include/pixman-1
#flag linux -I/usr/include/wayland-protocols
#flag -I @VMODROOT
#flag linux -I/usr/include/wlroots-0.19
#flag linux -lwayland-server
#flag linux -lwlroots-0.19
#flag linux -DWLR_USE_UNSTABLE

#include "wlr/render/dmabuf.h"

const wlr_dma_max_planes = 4

pub struct C.wlr_dmabuf_attributes {
	width    int
	height   int
	format   u32
	modifier u64

	n_planes int
	offset   [wlr_dma_max_planes]u32
	stride   [wlr_dma_max_planes]u32
	fd       [wlr_dma_max_planes]int
}

pub fn C.wlr_dmabuf_attributes_finish(attribs &C.wlr_dmabuf_attributes)
pub fn C.wlr_dmabuf_attributes_copy(dst &C.wlr_dmabuf_attributes, src &C.wlr_dmabuf_attributes) bool
