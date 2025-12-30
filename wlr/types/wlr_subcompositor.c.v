module types

#flag linux -DWLR_USE_UNSTABLE
#pkgconfig wlroots-0.20
#include <wlr/types/wlr_subcompositor.h>

pub struct C.wlr_subcompositor {
}

fn C.wlr_subcompositor_create(display &C.wl_display) &C.wlr_subcompositor
