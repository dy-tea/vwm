module wlr

#flag linux -I/usr/include
#flag linux -I/usr/include/pixman-1
#flag linux -I/usr/include/wayland-protocols
#flag -I @VMODROOT
#flag linux -I/usr/include/wlroots-0.19
#flag linux -Lwlroots
#flag linux -DWLR_USE_UNSTABLE

#include "wayland-server.h"

pub struct C.wl_object {
	interface &C.wl_interface
	implementation voidptr
	id u32
}

pub struct C.wl_resource {
	object C.wl_object
	destroy Wl_resource_destroy_func_t
	link C.wl_list
	destroy_signal C.wl_signal
	client &C.wl_client
	data voidptr
}
