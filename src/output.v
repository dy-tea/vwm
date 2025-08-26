module src

import wl { Listener }
import wlr.types

@[heap]
struct Output {
pub mut:
	wlr_output    &C.wlr_output
	sr            &Server
	frame         Listener
	request_state Listener
	destroy       Listener
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

	return outr
}

fn (output Output) get_geometry() C.wlr_box {
	mut box := C.wlr_box{}
	C.wlr_output_layout_get_box(output.sr.output_layout, output.wlr_output, &box)
	return box
}
