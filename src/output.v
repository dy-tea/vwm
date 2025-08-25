module src

import wl
import wlr.types

@[heap]
struct Output {
pub mut:
	wlr_output    &C.wlr_output
	sr            &Server
	frame         wl.Listener
	request_state wl.Listener
	destroy       wl.Listener
}

fn (output Output) get_geometry() C.wlr_box {
	mut box := C.wlr_box{}
	C.wlr_output_layout_get_box(output.sr.output_layout, output.wlr_output, &box)
	return box
}
