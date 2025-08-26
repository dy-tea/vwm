module src

import wl { Listener }
import wlr.types { Wlr_keyboard_modifier }
import xkb

@[heap]
struct Keyboard {
pub:
	wlr_keyboard &C.wlr_keyboard
pub mut:
	sr        &Server
	modifiers Listener
	key       Listener
	destroy   Listener
}

fn Keyboard.new(mut sr Server, wlr_keyboard &C.wlr_keyboard) &Keyboard {
	mut kr := &Keyboard{
		wlr_keyboard: wlr_keyboard
		sr:           sr
	}

	// setup keymap for keyboard
	mut context := C.xkb_context_new(.no_flags)
	keymap := C.xkb_keymap_new_from_names(context, unsafe { nil }, .no_flags)

	C.wlr_keyboard_set_keymap(wlr_keyboard, keymap)
	C.xkb_keymap_unref(keymap)
	C.xkb_context_unref(context)
	C.wlr_keyboard_set_repeat_info(wlr_keyboard, 25, 600)

	// keyboard listeners
	kr.modifiers = Listener.new(fn [sr, kr] (_ &C.wl_listener, _ voidptr) {
		C.wlr_seat_set_keyboard(sr.seat, kr.wlr_keyboard)
		C.wlr_seat_keyboard_notify_modifiers(sr.seat, &kr.wlr_keyboard.modifiers)
	}, &wlr_keyboard.events.modifiers)

	kr.key = Listener.new(fn [mut sr, kr] (_ &C.wl_listener, event &C.wlr_keyboard_key_event) {
		keycode := event.keycode + 8
		syms := &u32(unsafe { nil })
		nsyms := C.xkb_state_key_get_syms(kr.wlr_keyboard.xkb_state, keycode, &syms)

		mut handled := false

		modifiers := C.wlr_keyboard_get_modifiers(kr.wlr_keyboard)
		if Wlr_keyboard_modifier.alt.matches(modifiers) && event.state == .pressed {
			for i := 0; i < nsyms; i++ {
				handled = sr.handle_keybinding(unsafe { xkb.Keysym(syms[i]) })
			}
		}

		if !handled {
			C.wlr_seat_set_keyboard(sr.seat, kr.wlr_keyboard)
			C.wlr_seat_keyboard_notify_key(sr.seat, event.time_msec, event.keycode, u32(event.state))
		}
	}, &wlr_keyboard.events.key)

	kr.destroy = Listener.new(fn [mut sr, mut kr] (_ &C.wl_listener, _ voidptr) {
		kr.modifiers.destroy()
		kr.key.destroy()
		kr.destroy.destroy()

		if ix := sr.keyboards.index(kr) {
			sr.keyboards.delete(ix)
		}
	}, &wlr_keyboard.base.events.destroy)

	sr.keyboards.push_back(kr)
	return kr
}
