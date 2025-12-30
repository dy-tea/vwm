module xkb

#pkgconfig xkbcommon
#include <xkbcommon/xkbcommon.h>

pub struct C.xkb_context {
}

pub struct C.xkb_keymap {
}

pub struct C.xkb_state {
}

pub struct C.xkb_rule_names {
pub:
	rules   &u8
	model   &u8
	layout  &u8
	variant &u8
	options &u8
}

pub struct C.xkb_component_names {
pub:
	keycodes      &u8
	compatability &u8
	geometry      &u8
	symbols       &u8
	types         &u8
}

pub enum Xkb_keysym_flags {
	no_flags         = 0
	case_insensitive = 1 << 0
}

fn C.xkb_context_new(flags Xkb_context_flags) &C.xkb_context
fn C.xkb_context_ref(context &C.xkb_context) &C.xkb_context
fn C.xkb_context_unref(context &C.xkb_context)

pub enum Xkb_context_flags {
	no_flags                     = 0
	no_default_includes          = 1 << 0
	no_default_environment_names = 1 << 1
	no_secure_getenv             = 1 << 2
}

pub enum Xkb_log_level {
	critical = 10
	error    = 20
	warning  = 30
	info     = 40
	debug    = 50
}

pub enum Xkb_keymap_compile_flags {
	no_flags = 0
}

pub enum Xkb_keymap_format {
	text_v1 = 1
	text_v2 = 2
}

fn C.xkb_keymap_new_from_names(context &C.xkb_context, names &C.xkb_rule_names, flags Xkb_keymap_compile_flags) &C.xkb_keymap

fn C.xkb_keymap_ref(keymap &C.xkb_keymap) &C.xkb_keymap
fn C.xkb_keymap_unref(keymap &C.xkb_keymap)

pub enum Xkb_key_direction {
	up
	down
}

pub enum Xkb_state_component {
	mods_depressed   = 1 << 0
	mods_latched     = 1 << 1
	mods_locked      = 1 << 2
	mods_effective   = 1 << 3
	layout_depressed = 1 << 4
	layout_latched   = 1 << 5
	layout_locked    = 1 << 6
	layout_effective = 1 << 7
	leds             = 1 << 8
}

pub enum Xkb_state_match {
	any           = 1 << 0
	all           = 1 << 1
	non_exclusive = 1 << 16
}

pub enum Xkb_consumed_mode {
	xkb
	gtk
}

fn C.xkb_state_key_get_syms(state &C.xkb_state, key u32, syms_out &&u32) int
