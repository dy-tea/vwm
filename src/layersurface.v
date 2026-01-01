module src

import wl { Listener }
import wlr.types
import utils { is_nullptr }

@[heap]
struct LayerSurface {
mut:
	sr                  &Server
	output              &Output
	layer_surface       &C.wlr_layer_surface_v1
	scene_tree          &C.wlr_scene_tree
	scene_layer_surface &C.wlr_scene_layer_surface_v1
	mapped              bool
	map                 Listener
	unmap               Listener
	commit              Listener
	new_popup           Listener
	destroy             Listener
}

fn LayerSurface.new(mut sr Server, mut output Output, mut layer_surface C.wlr_layer_surface_v1) &LayerSurface {
	scene_layer := output.shell_layer(layer_surface.pending.layer)
	mut scene_layer_surface := C.wlr_scene_layer_surface_v1_create(scene_layer, layer_surface)
	mut lsr := &LayerSurface{
		sr:                  sr
		output:              output
		layer_surface:       layer_surface
		scene_tree:          scene_layer_surface.tree
		scene_layer_surface: scene_layer_surface
	}
	layer_surface.data = voidptr(lsr)
	scene_layer_surface.tree.node.data = voidptr(lsr)
	sr.layer_surfaces.push_back(lsr)

	output.arrange_layers()
	C.wlr_surface_send_enter(layer_surface.surface, output.wlr_output)

	lsr.map = Listener.new(fn [mut lsr] (_ &C.wl_listener, _ voidptr) {
		lsr.output.arrange_layers()

		if lsr.layer_surface.current.keyboard_interactive != .none
			&& int(lsr.layer_surface.current.layer) >= int(types.Zwlr_layer_shell_v1_layer.top) {
			lsr.focus()
		}
	}, &layer_surface.surface.events.map)

	lsr.unmap = Listener.new(fn [mut lsr] (_ &C.wl_listener, _ voidptr) {
		C.wlr_scene_node_set_enabled(&lsr.scene_tree.node, false)
		lsr.output.arrange_layers()
	}, &layer_surface.surface.events.unmap)

	lsr.commit = Listener.new(fn [mut lsr] (_ &C.wl_listener, _ voidptr) {
		if !lsr.layer_surface.initialized {
			return
		}

		mut needs_arrange := false
		if lsr.layer_surface.current.committed & u32(types.Wlr_layer_surface_v1_state_field.layer) != 0 {
			new_tree := lsr.output.shell_layer(lsr.layer_surface.current.layer)
			C.wlr_scene_node_reparent(&lsr.scene_layer_surface.tree.node, new_tree)
			needs_arrange = true
		}
		if needs_arrange || lsr.layer_surface.initial_commit {
			lsr.mapped = lsr.layer_surface.surface.mapped
			lsr.output.arrange_layers()
		}
	}, &layer_surface.surface.events.commit)

	lsr.new_popup = Listener.new(fn (_ &C.wl_listener, mut popup C.wlr_xdg_popup) {
		Popup.new(mut popup)
	}, &layer_surface.events.new_popup)

	lsr.destroy = Listener.new(fn [mut lsr] (_ &C.wl_listener, _ voidptr) {
		lsr.map.destroy()
		lsr.unmap.destroy()
		lsr.commit.destroy()
		lsr.new_popup.destroy()
		lsr.destroy.destroy()
		lsr.output.arrange_layers()
	}, &layer_surface.events.destroy)

	return lsr
}

fn (ls LayerSurface) focus() {
	if !ls.should_focus() || is_nullptr(ls.scene_layer_surface) {
		return
	}

	surface := ls.layer_surface.surface
	seat := ls.sr.seat
	keyboard := C.wlr_seat_get_keyboard(seat)

	if !is_nullptr(keyboard) {
		C.wlr_seat_keyboard_notify_enter(seat, surface, keyboard.keycodes, keyboard.num_keycodes,
			&keyboard.modifiers)
	}
}

fn (ls LayerSurface) should_focus() bool {
	if is_nullptr(ls.layer_surface) || is_nullptr(ls.layer_surface.surface)
		|| !ls.layer_surface.surface.mapped {
		return false
	}

	return ls.layer_surface.current.keyboard_interactive != .none
}
