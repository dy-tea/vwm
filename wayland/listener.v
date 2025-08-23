module wayland

@[heap]
pub struct Listener {
	wl_listener &C.wl_listener = unsafe { nil }
}

pub fn Listener.new(notify fn (listener &C.wl_listener, data voidptr), signal &C.wl_signal) Listener {
	mut listener := Listener{
		wl_listener: &C.wl_listener{
			link:   C.wl_list{
				prev: unsafe { nil }
				next: unsafe { nil }
			}
			notify: notify
		}
	}
	C.wl_signal_add(signal, listener.wl_listener)
	return listener
}

pub fn (listener Listener) destroy() {
	if listener.wl_listener == unsafe { nil } {
		panic('Listener not initialized')
	}
	C.wl_list_remove(&listener.wl_listener.link)
}
