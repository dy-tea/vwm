module src

import wl { Listener }
import wlr.types
import utils { is_nullptr }

@[heap]
struct Output {
	layers struct {
		background &C.wlr_scene_tree
		bottom     &C.wlr_scene_tree
		top        &C.wlr_scene_tree
		overlay    &C.wlr_scene_tree
	}
pub mut:
	wlr_output      &C.wlr_output
	sr              &Server
	frame           Listener
	request_state   Listener
	destroy         Listener
	layout_geometry C.wlr_box
	usable_area     C.wlr_box
}

fn Output.new(mut sr Server, wlr_output &C.wlr_output) &Output {
	C.wlr_output_init_render(wlr_output, sr.allocator, sr.renderer)

	mut state := C.wlr_output_state{}
	C.wlr_output_state_init(&state)
	C.wlr_output_state_set_enabled(&state, true)

	mode := C.wlr_output_preferred_mode(wlr_output)
	if !is_nullptr(mode) {
		C.wlr_output_state_set_mode(&state, mode)
	}

	C.wlr_output_commit_state(wlr_output, &state)
	C.wlr_output_state_finish(&state)

	mut outr := &Output{
		layers:     struct {
			background: C.wlr_scene_tree_create(sr.layers.background)
			bottom:     C.wlr_scene_tree_create(sr.layers.bottom)
			top:        C.wlr_scene_tree_create(sr.layers.top)
			overlay:    C.wlr_scene_tree_create(sr.layers.overlay)
		}
		wlr_output: wlr_output
		sr:         sr
	}
	outr.wlr_output.data = outr
	sr.outputs.push_back(outr)

	// xdg_output listeners
	outr.frame = Listener.new(fn [sr, wlr_output] (_ &C.wl_listener, _ voidptr) {
		scene_output := C.wlr_scene_get_scene_output(sr.scene, wlr_output)

		C.wlr_scene_output_commit(scene_output, unsafe { nil })

		now := C.timespec{}
		C.clock_gettime(.monotonic, &now)
		C.wlr_scene_output_send_frame_done(scene_output, &now)
	}, &wlr_output.events.frame)

	outr.request_state = Listener.new(fn [wlr_output] (_ &C.wl_listener, event &C.wlr_output_event_request_state) {
		C.wlr_output_commit_state(wlr_output, event.state)
	}, &wlr_output.events.request_state)

	outr.destroy = Listener.new(fn [outr, mut sr] (_ &C.wl_listener, _ voidptr) {
		outr.frame.destroy()
		outr.request_state.destroy()
		outr.destroy.destroy()

		if ix := sr.outputs.index(outr) {
			sr.outputs.delete(ix)
		}
	}, &wlr_output.events.destroy)

	l_output := C.wlr_output_layout_add_auto(sr.output_layout, wlr_output)
	scene_output := C.wlr_scene_output_create(sr.scene, wlr_output)
	C.wlr_scene_output_layout_add_output(sr.scene_layout, l_output, scene_output)

	C.wlr_output_layout_get_box(sr.output_layout, wlr_output, &outr.layout_geometry)
	unsafe {
		C.memcpy(&outr.usable_area, &outr.layout_geometry, sizeof(C.wlr_box))
	}
	return outr
}

fn (output Output) get_geometry() C.wlr_box {
	mut box := C.wlr_box{}
	C.wlr_output_layout_get_box(output.sr.output_layout, output.wlr_output, &box)
	return box
}

fn (mut output Output) arrange_layers() {
	mut usable := C.wlr_box{}
	C.wlr_output_effective_resolution(output.wlr_output, &usable.width, &usable.height)
	full_area := usable

	// exclusive
	output.arrange_layer_surface(full_area, mut usable, output.layers.overlay, true)
	output.arrange_layer_surface(full_area, mut usable, output.layers.top, true)
	output.arrange_layer_surface(full_area, mut usable, output.layers.bottom, true)
	output.arrange_layer_surface(full_area, mut usable, output.layers.background, true)

	// non-exclusive
	output.arrange_layer_surface(full_area, mut usable, output.layers.overlay, false)
	output.arrange_layer_surface(full_area, mut usable, output.layers.top, false)
	output.arrange_layer_surface(full_area, mut usable, output.layers.bottom, false)
	output.arrange_layer_surface(full_area, mut usable, output.layers.background, false)

	if usable.x != output.usable_area.x || usable.y != output.usable_area.y {
		output.usable_area = usable
	}

	mut topmost := unsafe { nil }
	for layer in [output.layers.overlay, output.layers.top] {
		wl.wl_list_for_each_reverse(&layer.children, 'link', fn [output, mut topmost] (node &C.wlr_scene_node) {
			surface := unsafe { &LayerSurface(node.data) }
			if is_nullptr(surface)
				|| surface.layer_surface.current.keyboard_interactive != .exclusive
				|| !surface.layer_surface.surface.mapped {
				return
			}

			topmost = surface
			_ = topmost
		})
		if !is_nullptr(topmost) {
			break
		}
	}
}

fn (output Output) arrange_layer_surface(full C.wlr_box, mut usable C.wlr_box, tree &C.wlr_scene_tree, exclusive bool) {
	wl.wl_list_for_each(&tree.children, 'link', fn [full, mut usable, exclusive] (node &C.wlr_scene_node) {
		ls := unsafe { &LayerSurface(node.data) }
		if is_nullptr(ls) || !ls.layer_surface.initialized {
			return
		}

		if (ls.layer_surface.current.exclusive_zone > 0) != exclusive {
			return
		}

		C.wlr_scene_layer_surface_v1_configure(ls.scene_layer_surface, &full, &usable)
	})
}

fn (output Output) shell_layer(layer types.Zwlr_layer_shell_v1_layer) &C.wlr_scene_tree {
	return match layer {
		.background {
			output.layers.background
		}
		.bottom {
			output.layers.bottom
		}
		.top {
			output.layers.top
		}
		.overlay {
			output.layers.overlay
		}
	}
}
