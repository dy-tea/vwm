module render

#flag linux -DWLR_USE_UNSTABLE
#flag linux -I/usr/include/
#flag linux -I/usr/include/pixman-1
#flag linux -I/usr/include/wlroots-0.20
#flag linux -lwlroots-0.20
#include <wlr/render/allocator.h>

pub struct C.wlr_allocator {
}

fn C.wlr_allocator_autocreate(backend &C.wlr_backend, renderer &C.wlr_renderer) &C.wlr_allocator
fn C.wlr_allocator_destroy(allocator &C.wlr_allocator)
