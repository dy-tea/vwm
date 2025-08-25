module types

import wl

#flag linux -DWLR_USE_UNSTABLE
#flag linux -I/usr/include/
#flag linux -I/usr/include/wlroots-0.20
#flag linux -lwlroots-0.20
#include <wlr/types/wlr_output.h>

pub struct C.wlr_output_mode {
pub:
	width     u32
	height    u32
	preferred bool
}

pub struct C.wlr_output_state {
	committed             u32
	allow_reconfiguration bool

	enabled               bool
	scale                 f32
	transform             wl.Wl_output_transform
	adaptive_sync_enabled bool
	render_format         u32
	subpixel              wl.Wl_output_subpixel

	tearing_page_flip bool
}

pub struct C.wlr_output {
pub:
	phys_width  int
	phys_height int

	width   int
	height  int
	refresh int

	supported_primaries          u32
	supported_transfer_functions u32

	enabled bool
	scale   f32
	//...
	render_format u32
	//...

	adaptive_sync_supported bool
	needs_frame             bool
	frame_pending           bool
	non_desktop             bool
	commit_seq              u32
	//...
	events struct {
	pub:
		frame         C.wl_signal
		damage        C.wl_signal
		needs_frame   C.wl_signal
		precommit     C.wl_signal
		commit        C.wl_signal
		present       C.wl_signal
		bind          C.wl_signal
		description   C.wl_signal
		request_state C.wl_signal
		destroy       C.wl_signal
	}
}

pub struct C.wlr_output_event_request_state {
pub:
	wlr_output &C.wlr_output
	state      &C.wlr_output_state
}

fn C.wlr_output_init_render(output &C.wlr_output, allocator &C.wlr_allocator, renderer &C.wlr_renderer) bool
fn C.wlr_output_preferred_mode(output &C.wlr_output) &C.wlr_output_mode

fn C.wlr_output_commit_state(output &C.wlr_output, state &C.wlr_output_state)

fn C.wlr_output_state_init(state &C.wlr_output_state)
fn C.wlr_output_state_finish(state &C.wlr_output_state)
fn C.wlr_output_state_set_enabled(state &C.wlr_output_state, enabled bool)
fn C.wlr_output_state_set_mode(state &C.wlr_output_state, mode &C.wlr_output_mode)
