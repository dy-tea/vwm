module render

#flag linux -DWLR_USE_UNSTABLE
#pkgconfig wlroots-0.20
#include <wlr/render/allocator.h>

pub struct C.wlr_allocator {
}

fn C.wlr_allocator_autocreate(backend &C.wlr_backend, renderer &C.wlr_renderer) &C.wlr_allocator
fn C.wlr_allocator_destroy(allocator &C.wlr_allocator)
