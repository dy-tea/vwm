module types

#flag linux -DWLR_USE_UNSTABLE
#flag linux -I/usr/include/
#flag linux -I/usr/include/wlroots-0.20
#flag linux -lwlroots-0.20
#include <wlr/types/wlr_input_device.h>

pub enum Wlr_button_state {
	released
	pressed
}

pub enum Wlr_input_device_type {
	keyboard
	pointer
	touch
	tablet
	tablet_pad
	switch
}

pub struct C.wlr_input_device {
pub:
	type Wlr_input_device_type
	name &u8

	events struct {
	pub:
		destroy C.wl_signal
	}
pub mut:
	data voidptr
}
