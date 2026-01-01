module src

import wl { Listener }
import wlr.types
import utils { is_nullptr }

@[heap]
struct Popup {
pub:
	xdg_popup &C.wlr_xdg_popup
pub mut:
	commit  Listener
	destroy Listener
}

fn Popup.new(mut xdg_popup C.wlr_xdg_popup) &Popup {
	parent := C.wlr_xdg_surface_try_from_wlr_surface(xdg_popup.parent)
	if is_nullptr(parent) {
		panic('popup parent is nil')
	}

	parent_tree := unsafe { &C.wlr_scene_tree(parent.data) }
	xdg_popup.base.data = C.wlr_scene_xdg_surface_create(parent_tree, xdg_popup.base)

	mut pr := &Popup{
		xdg_popup: xdg_popup
	}

	pr.commit = Listener.new(fn [mut pr] (_ &C.wl_listener, _ voidptr) {
		if pr.xdg_popup.base.initial_commit {
			C.wlr_xdg_surface_schedule_configure(pr.xdg_popup.base)
		}
	}, &xdg_popup.base.surface.events.commit)

	pr.destroy = Listener.new(fn [mut pr] (_ &C.wl_listener, _ voidptr) {
		pr.commit.destroy()
		pr.destroy.destroy()
	}, &xdg_popup.events.destroy)

	return pr
}
