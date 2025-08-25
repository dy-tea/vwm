module src

import wl

@[heap]
pub struct Keyboard {
pub:
	wlr_keyboard &C.wlr_keyboard
pub mut:
	sr        &Server
	modifiers wl.Listener
	key       wl.Listener
	destroy   wl.Listener
}
