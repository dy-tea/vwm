module src

import wl { Listener }
import wlr.types
import wlr.util

@[heap]
struct Toplevel {
pub:
	xdg_toplevel &C.wlr_xdg_toplevel
pub mut:
	sr         &Server
	scene_tree &C.wlr_scene_tree

	map                Listener
	unmap              Listener
	commit             Listener
	destroy            Listener
	request_move       Listener
	request_resize     Listener
	request_maximize   Listener
	request_fullscreen Listener

	maximized      bool
	saved_geometry C.wlr_box = C.wlr_box{}
}

fn Toplevel.new(mut sr Server, mut xdg_toplevel C.wlr_xdg_toplevel) &Toplevel {
	mut tlr := &Toplevel{
		sr:           sr
		xdg_toplevel: xdg_toplevel
		scene_tree:   C.wlr_scene_xdg_surface_create(&sr.scene.tree, xdg_toplevel.base)
	}
	tlr.scene_tree.node.data = tlr
	xdg_toplevel.base.data = tlr.scene_tree

	// toplevel listeners
	tlr.map = Listener.new(fn [mut sr, mut tlr] (_ &C.wl_listener, _ voidptr) {
		sr.toplevels.push_back(tlr)

		tlr.focus()
	}, &xdg_toplevel.base.surface.events.map)

	tlr.unmap = Listener.new(fn [mut sr, mut tlr] (_ &C.wl_listener, _ voidptr) {
		if grabbed := sr.grabbed_toplevel {
			if tlr == grabbed {
				sr.reset_cursor_mode()
			}
		}

		if ix := sr.toplevels.index(tlr) {
			sr.toplevels.delete(ix)
		}
	}, &xdg_toplevel.base.surface.events.unmap)

	tlr.commit = Listener.new(fn [mut tlr] (_ &C.wl_listener, _ voidptr) {
		if tlr.xdg_toplevel.base.initial_commit {
			C.wlr_xdg_toplevel_set_size(tlr.xdg_toplevel, 0, 0)
		}
	}, &xdg_toplevel.base.surface.events.commit)

	tlr.destroy = Listener.new(fn [mut tlr] (_ &C.wl_listener, _ voidptr) {
		tlr.map.destroy()
		tlr.unmap.destroy()
		tlr.commit.destroy()
		tlr.destroy.destroy()
		tlr.request_move.destroy()
		tlr.request_resize.destroy()
		tlr.request_maximize.destroy()
		tlr.request_fullscreen.destroy()
	}, &xdg_toplevel.events.destroy)

	tlr.request_move = Listener.new(fn [mut sr, mut tlr] (_ &C.wl_listener, _ voidptr) {
		sr.begin_interactive(mut tlr, .move, 0)
	}, &xdg_toplevel.events.request_move)

	tlr.request_resize = Listener.new(fn [mut sr, mut tlr] (_ &C.wl_listener, event &C.wlr_xdg_toplevel_resize_event) {
		sr.begin_interactive(mut tlr, .resize, event.edges)
	}, &xdg_toplevel.events.request_resize)

	tlr.request_maximize = Listener.new(fn [mut tlr] (_ &C.wl_listener, _ voidptr) {
		tlr.maximize(tlr.xdg_toplevel.requested.maximized)
	}, &xdg_toplevel.events.request_maximize)

	tlr.request_fullscreen = Listener.new(fn [mut tlr] (_ &C.wl_listener, _ voidptr) {
		if tlr.xdg_toplevel.base.initialized {
			C.wlr_xdg_surface_schedule_configure(tlr.xdg_toplevel.base)
		}
	}, &xdg_toplevel.events.request_fullscreen)

	return tlr
}

fn (toplevel &Toplevel) focus() {
	mut sr := toplevel.sr

	prev_surface := sr.seat.keyboard_state.focused_surface
	surface := toplevel.xdg_toplevel.base.surface
	if ptr_eq(prev_surface, surface) {
		return
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
		util.log(.error, 'no focused output')
	}
}
