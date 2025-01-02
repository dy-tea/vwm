module wlr

#flag linux -I/usr/include
#flag linux -I/usr/include/pixman-1
#flag linux -I/usr/include/wayland-protocols
#flag -I @VMODROOT
#flag linux -I/usr/include/wlroots-0.19
#flag linux -Lwlroots
#flag linux -DWLR_USE_UNSTABLE

#include "wlr/backend/wayland.h"

pub fn C.wlr_wl_backend_create(loop &C.wl_event_loop, remote_display &C.wl_display) &C.wlr_backend
pub fn C.wlr_wl_backend_get_remote_display(backend &C.wlr_backend) &C.wl_display
pub fn C.wlr_wl_output_create(backend &C.wlr_backend) &C.wlr_output
pub fn C.wlr_wl_output_create_from_surface(backend &C.wlr_backend, surface &C.wl_resource) &C.wlr_output
pub fn C.wlr_backend_is_wl(backend &C.wlr_backend) bool
pub fn C.wlr_input_device_is_wl(input_device &C.wlr_input_device) bool
pub fn C.wlr_output_is_wl(output &C.wlr_output) bool
pub fn C.wlr_wl_output_set_title(output &C.wlr_output, title string)
pub fn C.wlr_wl_output_set_app_id(output &C.wlr_output, app_id string)
pub fn C.wlr_wl_output_get_surface(output &C.wlr_output) &C.wl_surface
