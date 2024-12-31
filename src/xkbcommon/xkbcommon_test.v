module xkbcommon

fn test_xkbcommon() {
	ctx := context_new(.xkb_context_no_flags)

	names := Xkb_rule_names{
		rules:   ''.str
		model:   'pc105'.str
		layout:  'us'.str
		variant: ''.str
		options: ''.str
	}

	keymap := keymap_new_from_names(ctx, names, .xkb_keymap_compile_no_flags)

	state := state_new(keymap)

	keycode := keymap_key_by_name(keymap, 'a'.str)

	keysym := state_key_get_one_sym(state, keycode)

	keyname := keymap_key_get_name(keymap, keycode)
}
