module util

#flag linux -DWLR_USE_UNSTABLE
#pkgconfig wlroots-0.20
#include <wlr/util/edges.h>

pub enum Wlr_edges as u32 {
	none   = 0
	top    = 1 << 0
	bottom = 1 << 1
	left   = 1 << 2
	right  = 1 << 3
}

pub fn (edges Wlr_edges) matches(mask u32) bool {
	edge_val := u32(edges)
	return edge_val & mask != 0
}
