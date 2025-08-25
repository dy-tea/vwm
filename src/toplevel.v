module src

import wl
import wlr.types

@[heap]
struct Toplevel {
pub:
	xdg_toplevel &C.wlr_xdg_toplevel
pub mut:
	sr         &Server
	scene_tree &C.wlr_scene_tree

	map                wl.Listener
	unmap              wl.Listener
	commit             wl.Listener
	destroy            wl.Listener
	request_move       wl.Listener
	request_resize     wl.Listener
	request_maximize   wl.Listener
	request_fullscreen wl.Listener

	maximized      bool
	saved_geometry C.wlr_box = C.wlr_box{}
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

fn (mut toplevel Toplevel) save_geometry() {
	toplevel.saved_geometry = C.wlr_box{
		x:      toplevel.scene_tree.node.x
		y:      toplevel.scene_tree.node.y
		width:  toplevel.xdg_toplevel.base.geometry.width
		height: toplevel.xdg_toplevel.base.geometry.height
	}
}

fn (mut toplevel Toplevel) set_position_size(x f64, y f64, width int, height int) {
	C.wlr_scene_node_set_position(&toplevel.scene_tree.node, x, y)
	C.wlr_xdg_toplevel_set_size(toplevel.xdg_toplevel, width, height)
	C.wlr_xdg_surface_schedule_configure(toplevel.xdg_toplevel.base)
}

fn (mut toplevel Toplevel) maximize(maximized bool) {
	if toplevel.maximized == maximized {
		return
	}

	toplevel.maximized = maximized
	C.wlr_xdg_toplevel_set_maximized(toplevel.xdg_toplevel, maximized)

	if focused_output := toplevel.sr.focused_output() {
		geo := focused_output.get_geometry()

		if maximized {
			toplevel.save_geometry()
			toplevel.set_position_size(geo.x, geo.y, geo.width, geo.height)
		} else {
			if toplevel.saved_geometry.width > 0 && toplevel.saved_geometry.height > 0 {
				toplevel.set_position_size(toplevel.saved_geometry.x, toplevel.saved_geometry.y,
					toplevel.saved_geometry.width, toplevel.saved_geometry.height)
			} else {
				toplevel.set_position_size(toplevel.scene_tree.node.x, toplevel.scene_tree.node.y,
					toplevel.xdg_toplevel.base.geometry.width / 2, toplevel.xdg_toplevel.base.geometry.height / 2)
			}
		}
	} else {
		eprintln('no focused output')
	}
}
