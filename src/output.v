module src

import wl
import wlr.types

@[heap]
pub struct Output {
pub:
	wlr_output &C.wlr_output
pub mut:
	sr            &Server
	frame         wl.Listener
	request_state wl.Listener
	destroy       wl.Listener
}
