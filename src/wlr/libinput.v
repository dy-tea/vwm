module wlr

#flag linux -I/usr/include
#flag linux -I/usr/include/pixman-1
#flag linux -I/usr/include/wayland-protocols
#flag -I @VMODROOT
#flag linux -lwayland-server
#flag linux -I/usr/include/wlroots-0.19
#flag linux -lwlroots-0.19
#flag linux -DWLR_USE_UNSTABLE

#include "wlr/backend/libinput.h"

pub struct C.wlr_input_device {}

pub fn C.wlr_libinput_backend_create(session &C.wlr_session) &C.wlr_backend

pub fn C.wlr_libinput_get_device_handle(device &C.wlr_input_device) &C.libinput_device

pub fn C.wlr_backend_is_libinput(backend &C.wlr_backend) bool
pub fn C.wlr_input_device_is_libinput(device &C.wlr_input_device) bool
