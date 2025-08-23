module types

#flag linux -DWLR_USE_UNSTABLE
#flag linux -I/usr/include/
#flag linux -I/usr/include/wlroots-0.20
#flag linux -lwlroots-0.20
#include <wlr/types/wlr_output_layout.h>

pub struct C.wlr_output_layout {
}

pub struct C.wlr_output_layout_output {
}

fn C.wlr_output_layout_create(display &C.wl_display) &C.wlr_output_layout
fn C.wlr_output_layout_destroy(output_layout &C.wlr_output_layout)
fn C.wlr_output_layout_get(layout &C.wlr_output_layout, reference &C.wlr_output) &C.wlr_output_layout
fn C.wlr_output_layout_output_at(layout &C.wlr_output_layout, lx i64, ly i64) &C.wlr_output
fn C.wlr_output_layout_add(layout &C.wlr_output_layout, output &C.wlr_output, lx i64, ly i64) &C.wlr_output_layout_output
fn C.wlr_output_layout_add_auto(layout &C.wlr_output_layout, output &C.wlr_output) &C.wlr_output_layout_output
