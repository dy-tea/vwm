module wlr

#flag linux -I/usr/include
#flag linux -I/usr/include/pixman-1
#flag linux -I/usr/include/wayland-protocols
#flag -I @VMODROOT
#flag linux -I/usr/include/wlroots-0.19
#flag linux -Lwlroots
#flag linux -DWLR_USE_UNSTABLE

#include "wlr/types/wlr_input_device.h"

enum Wlr_button_state {
	released
	pressed
}

enum Wlr_input_device_type {
	keyboard
	pointer
	touch
	tablet
	tablet_pad
	switch
}

pub struct C.wlr_input_device {
	type Wlr_input_device_type
	name &char

	events struct {
		destroy C.wl_signal
	}

	data voidptr
}
