module wlr

#flag linux -I/usr/include
#flag linux -I/usr/include/pixman-1
#flag linux -I/usr/include/wayland-protocols
#flag -I @VMODROOT
#flag linux -I/usr/include/wlroots-0.19
#flag linux -Lwlroots
#flag linux -DWLR_USE_UNSTABLE

#include "wlr/util/log.h"

pub enum Wlr_log_importance {
	silent
	error
	info
	debug
	last
}

type Wlr_log_func_t = fn (importance Wlr_log_importance, fmt string, args ...)

pub fn C.wlr_log_init(verbosity Wlr_log_importance, callback Wlr_log_func_t)

pub fn C.wlr_log_get_verbosity() Wlr_log_importance

pub fn C._wlr_log(verbosity Wlr_log_importance, fmt string, args ...)
pub fn C._wlr_vlog(verbosity Wlr_log_importance, fmt string, args ...)
