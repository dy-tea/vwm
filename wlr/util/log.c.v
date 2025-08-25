module util

#flag linux -DWLR_USE_UNSTABLE
#flag linux -I/usr/include/
#flag linux -I/usr/include/wlroots-0.20
#flag linux -lwlroots-0.20
#include <wlr/util/log.h>

pub enum Wlr_log_importance {
	silent
	error
	info
	debug
	last
}

type Wlr_log_func_t = fn (importance Wlr_log_importance, fmt ...&char)

fn C.wlr_log_init(verbosity Wlr_log_importance, callback Wlr_log_func_t)
fn C.wlr_log_get_verbosity() Wlr_log_importance
