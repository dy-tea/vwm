module src

import wl
import wlr.types

@[heap]
struct Toplevel {
pub:
	xdg_toplevel &C.wlr_xdg_toplevel
pub mut:
	sr                 &Server
	scene_tree         &C.wlr_scene_tree
	map                wl.Listener
	unmap              wl.Listener
	commit             wl.Listener
	destroy            wl.Listener
	request_move       wl.Listener
	request_resize     wl.Listener
	request_maximize   wl.Listener
	request_fullscreen wl.Listener
}

fn (toplevel &Toplevel) focus() {
	mut sr := toplevel.sr

	prev_surface := sr.seat.keyboard_state.focused_surface
	surface := toplevel.xdg_toplevel.base.surface
	unsafe { // v does not have a pointer compare so I need to do this
		if i64(prev_surface) - i64(surface) == 0 {
			return
		}
	}
	// deactivate previous surface
	if prev_surface != unsafe { nil } {
		prev_toplevel := C.wlr_xdg_toplevel_try_from_wlr_surface(prev_surface)
		if prev_toplevel != unsafe { nil } {
			C.wlr_xdg_toplevel_set_activated(prev_toplevel, false)
		}
	}

	// move toplevel to top
	C.wlr_scene_node_raise_to_top(&toplevel.scene_tree.node)
	if ix := sr.toplevels.index(toplevel) {
		sr.toplevels.delete(ix)
		sr.toplevels.push_front(toplevel)
	}

	C.wlr_xdg_toplevel_set_activated(toplevel.xdg_toplevel, true)

	// give keyboard focus to surface
	keyboard := C.wlr_seat_get_keyboard(sr.seat)
	if keyboard != unsafe { nil } {
		C.wlr_seat_keyboard_notify_enter(sr.seat, surface, keyboard.keycodes, keyboard.num_keycodes,
			&keyboard.modifiers)
	}
}
