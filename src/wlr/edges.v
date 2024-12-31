module wlr

#flag linux -I/usr/include
#flag linux -I/usr/include/pixman-1
#flag linux -I/usr/include/wayland-protocols
#flag -I @VMODROOT
#flag linux -I/usr/include/wlroots-0.19
#flag linux -Lwlroots
#flag linux -DWLR_USE_UNSTABLE

#include "wlr/util/edges.h"

pub enum Wlr_edges {
	none   = 0
	top    = 1 << 0
	bottom = 1 << 1
	left   = 1 << 2
	right  = 1 << 3
}
