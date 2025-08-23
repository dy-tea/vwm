module types

#flag linux -DWLR_USE_UNSTABLE
#flag linux -I/usr/include/
#flag linux -I/usr/include/wlroots-0.20
#flag linux -lwlroots-0.20
#include <wlr/types/wlr_subcompositor.h>

pub struct C.wlr_subcompositor {
}

fn C.wlr_subcompositor_create(display &C.wl_display) &C.wlr_subcompositor
