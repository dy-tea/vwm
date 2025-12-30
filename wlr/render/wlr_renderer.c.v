module render

#flag linux -DWLR_USE_UNSTABLE
#pkgconfig wlroots-0.20
#include <wlr/render/wlr_renderer.h>

pub struct C.wlr_renderer {
}

fn C.wlr_renderer_autocreate(backend &C.wlr_backend) &C.wlr_renderer
fn C.wlr_renderer_destroy(renderer &C.wlr_renderer)
fn C.wlr_renderer_init_wl_display(renderer &C.wlr_renderer, display &C.wl_display) bool
