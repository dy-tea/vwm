module wl

#pkgconfig wayland-server
#include <wayland-server.h>

pub struct C.wl_object {
pub:
	interface      &C.wl_interface
	implementation voidptr
	id             u32
}

pub struct C.wl_resource {
pub:
	object         C.wl_object
	destroy        Wl_resource_destroy_func_t
	link           C.wl_list
	destroy_signal C.wl_signal
	client         &C.wl_client
pub mut:
	data voidptr
}
