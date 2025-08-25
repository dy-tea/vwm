module src

import wl
import wlr.types

@[heap]
struct Popup {
pub:
	xdg_popup &C.wlr_xdg_popup
pub mut:
	commit  wl.Listener
	destroy wl.Listener
}
