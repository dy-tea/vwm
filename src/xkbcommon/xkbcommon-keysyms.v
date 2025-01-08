module xkbcommon

pub const key_nosymbol = 0x000000 // Special KeySym

//
//* The "X11 Window System Protocol" standard defines in Appendix A the
//* keysym codes. These 29-bit integer values identify characters or
//* functions associated with each key (e.g., via the visible
//* engraving) of a keyboard layout. This file assigns mnemonic macro
//* names for these keysyms.
//*
//* This file is also compiled (by src/util/makekeys.c in libX11) into
//* hash tables that can be accessed with X11 library functions such as
//* XStringToKeysym() and XKeysymToString().
//*
//* Where a keysym corresponds one-to-one to an ISO 10646 / Unicode
//* character, this is noted in a comment that provides both the U+xxxx
//* Unicode position, as well as the official Unicode name of the
//* character.
//*
//* Some keysyms map to a character already mapped by another keysym,
//* with compatible but more precise semantics, such as the keypad-
//* related keysyms. In this case, none of the keysym are deprecated.
//* The most generic keysym is annotated as previously and more specific
//* keysyms have the same annotation between angle brackets:
//*
//*     pub const key_space                 := 0x0020  // U+0020 SPACE
//*     pub const key_kp_space              := 0xff80  //<U+0020 SPACE>
//*
//* Where the correspondence is either not one-to-one or semantically
//* unclear, the Unicode position and name are enclosed in
//* parentheses. Such legacy keysyms should be considered deprecated
//* and are not recommended for use in future keyboard mappings.
//*
//* For any future extension of the keysyms with characters already
//* found in ISO 10646 / Unicode, the following algorithm shall be
//* used. The new keysym code position will simply be the character's
//* Unicode number plus := 0x01000000. The keysym values in the range
//* := 0x01000100 to := 0x0110ffff are reserved to represent Unicode
//* characters in the range U+0100 to U+10FFFF.
//*
//* While most newer Unicode-based X11 clients do already accept
//* Unicode-mapped keysyms in the range := 0x01000100 to := 0x0110ffff, it
//* will remain necessary for clients -- in the interest of
//* compatibility with existing servers -- to also understand the
//* existing legacy keysym values in the range := 0x0100 to := 0x20ff.
//*
//* Where several mnemonic names are defined for the same keysym in this
//* file, the first one listed is considered the "canonical" name. This
//* is the name that should be used when retrieving a keysym name from
//* its code. The next names are considered "aliases" to the canonical
//* name.
//*
//* Aliases are made explicit by writing in their comment "alias for",
//* followed by the corresponding canonical name. Example:
//*
//*     pub const key_dead_tilde            := 0xfe53
//*     pub const key_dead_perispomeni      := 0xfe53 // alias for dead_tilde
//*
//* The rules to consider a keysym mnemonic name deprecated are:
//*
//*   1. A legacy keysym with its Unicode mapping in parentheses is
//*      deprecated (see above).
//*
//*   2. A keysym name is//*explicitly* deprecated by starting its comment
//*      with "deprecated". Examples:
//*
//*        pub const key_l1           := 0xffc8  // deprecated alias for F11
//*        pub const key_quoteleft    := 0x0060  // deprecated
//*
//*   3. A keysym name is//*explicitly*//*not* deprecated by starting its
//*      comment with "non-deprecated alias". Examples:
//*
//*       pub const key_dead_tilde       := 0xfe53
//*       pub const key_dead_perispomeni := 0xfe53 // non-deprecated alias for dead_tilde
//*
//*   4. If none of the previous rules apply, an alias is//*implicitly*
//*      deprecated if there is at least one previous name for the
//*      corresponding keysym that is//*not* explicitly deprecated.
//*
//*      Examples:
//*
//*        // SingleCandidate is the canonical name
//*        pub const key_singlecandidate        := 0xff3c
//*        // Hangul_SingleCandidate is deprecated because it is an alias
//*        // and it does not start with "non-deprecated alias"
//*        pub const key_hangul_singlecandidate := 0xff3c // Single candidate
//*
//*        // guillemotleft is the canonical name, but it is deprecated
//*        pub const key_guillemotleft  := 0x00ab // deprecated alias for guillemetleft (misspelling)
//*        // guillemetleft is not deprecated, because the keysym has no endorsed name before it.
//*        pub const key_guillemetleft  := 0x00ab // U+00AB LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
//*        // The following hypothetical name is deprecated because guillemetleft come before.
//*        pub const key_guillemetleft2 := 0x00ab
//*
//* Mnemonic names for keysyms are defined in this file with lines
//* that match one of these Perl regular expressions:
//*
//*    /^\pub const key_([a-za-z_0-9]+)\s+:= 0x([0-9a-f]+)\s*\/\* U\+([0-9A-F]{4,6}) (.*) \*\/\s*$/
//*    /^\pub const key_([a-za-z_0-9]+)\s+:= 0x([0-9a-f]+)\s*\/\*<U\+([0-9A-F]{4,6}) (.*)>\*\/\s*$/
//*    /^\pub const key_([a-za-z_0-9]+)\s+:= 0x([0-9a-f]+)\s*\/\*\(U\+([0-9A-F]{4,6}) (.*)\)\*\/\s*$/
//*    /^\pub const key_([a-za-z_0-9]+)\s+:= 0x([0-9a-f]+)\s*(\/\*\s*(.*)\s*\*\/)?\s*$/
//*
//* Before adding new keysyms, please do consider the following: In
//* addition to the keysym names defined in this file, the
//* XStringToKeysym() and XKeysymToString() functions will also handle
//* any keysym string of the form "U0020" to "U007E" and "U00A0" to
//* "U10FFFF" for all possible Unicode characters. In other words,
//* every possible Unicode character has already a keysym string
//* defined algorithmically, even if it is not listed here. Therefore,
//* defining an additional keysym macro is only necessary where a
//* non-hexadecimal mnemonic name is needed, or where the new keysym
//* does not represent any existing Unicode character.
//*
//* When adding new keysyms to this file, do not forget to also update the
//* following as needed:
//*
//*   - the mappings in src/KeyBind.c in the libX11 repo
//*     https://gitlab.freedesktop.org/xorg/lib/libx11
//*
//*   - the protocol specification in specs/keysyms.xml in this repo
//*     https://gitlab.freedesktop.org/xorg/proto/xorgproto
//*
//* Before removing or changing the order of the keysyms, please consider
//* the following: it is very difficult to know what keysyms are used and
//* how.
//*
//*   - A sandboxed application may have incompatibilities with the host
//*     system. For example, if new keysym name is introduced and is made
//*     the canonical name, then an application with an older keysym parser
//*     will not be able to parse the new name.
//*   - Customization of keyboard layout and Compose files are two popular
//*     use cases. Checking the standard keyboard layout database xkeyboard-config
//*     https://gitlab.freedesktop.org/xkeyboard-config/xkeyboard-config
//*     and the standard Compose files in libx11
//*     https://gitlab.freedesktop.org/xorg/lib/libx11 is a mandatory
//*     step, but may//*not* be enough for a proper impact assessment for
//*     e.g. keysyms removals.
//*
//* Therefore, it is advised to proceed to no removal and to make a new
//* name canonical only 10 years after its introduction. This means that
//* some keysyms may have their first listed name deprecated during the
//* period of transition. Once this period is over, the deprecated name
//* should be moved after the new canonical name.
//

pub const key_voidsymbol = 0xffffff // Void symbol

//
//* TTY function keys, cleverly chosen to map to ASCII, for convenience of
//* programming, but could have been arbitrary (at the cost of lookup
//* tables in client code).
//

pub const key_backspace = 0xff08 // U+0008 BACKSPACE
pub const key_tab = 0xff09 // U+0009 CHARACTER TABULATION
pub const key_linefeed = 0xff0a // U+000A LINE FEED
pub const key_clear = 0xff0b // U+000B LINE TABULATION
pub const key_return = 0xff0d // U+000D CARRIAGE RETURN
pub const key_pause = 0xff13 // Pause, hold
pub const key_scroll_lock = 0xff14
pub const key_sys_req = 0xff15
pub const key_escape = 0xff1b // U+001B ESCAPE
pub const key_delete = 0xffff // U+007F DELETE

// International & multi-key character composition

pub const key_multi_key = 0xff20 // Multi-key character compose
pub const key_codeinput = 0xff37
pub const key_singlecandidate = 0xff3c
pub const key_multiplecandidate = 0xff3d
pub const key_previouscandidate = 0xff3e

// Japanese keyboard support

pub const key_kanji = 0xff21 // Kanji, Kanji convert
pub const key_muhenkan = 0xff22 // Cancel Conversion
pub const key_henkan_mode = 0xff23 // Start/Stop Conversion
pub const key_henkan = 0xff23 // non-deprecated alias for Henkan_Mode
pub const key_romaji = 0xff24 // to Romaji
pub const key_hiragana = 0xff25 // to Hiragana
pub const key_katakana = 0xff26 // to Katakana
pub const key_hiragana_katakana = 0xff27 // Hiragana/Katakana toggle
pub const key_zenkaku = 0xff28 // to Zenkaku
pub const key_hankaku = 0xff29 // to Hankaku
pub const key_zenkaku_hankaku = 0xff2a // Zenkaku/Hankaku toggle
pub const key_touroku = 0xff2b // Add to Dictionary
pub const key_massyo = 0xff2c // Delete from Dictionary
pub const key_kana_lock = 0xff2d // Kana Lock
pub const key_kana_shift = 0xff2e // Kana Shift
pub const key_eisu_shift = 0xff2f // Alphanumeric Shift
pub const key_eisu_toggle = 0xff30 // Alphanumeric toggle
pub const key_kanji_bangou = 0xff37 // Codeinput
pub const key_zen_koho = 0xff3d // Multiple/All Candidate(s)
pub const key_mae_koho = 0xff3e // Previous Candidate

// := 0xff31 thru := 0xff3f are under XK_KOREAN

// Cursor control & motion

pub const key_home = 0xff50
pub const key_left = 0xff51 // Move left, left arrow
pub const key_up = 0xff52 // Move up, up arrow
pub const key_right = 0xff53 // Move right, right arrow
pub const key_down = 0xff54 // Move down, down arrow
pub const key_prior = 0xff55 // Prior, previous
pub const key_page_up = 0xff55 // deprecated alias for Prior
pub const key_next = 0xff56 // Next
pub const key_page_down = 0xff56 // deprecated alias for Next
pub const key_end = 0xff57 // EOL
pub const key_begin = 0xff58 // BOL

// Misc functions

pub const key_select = 0xff60 // Select, mark
pub const key_print = 0xff61
pub const key_execute = 0xff62 // Execute, run, do
pub const key_insert = 0xff63 // Insert, insert here
pub const key_undo = 0xff65
pub const key_redo = 0xff66 // Redo, again
pub const key_menu = 0xff67
pub const key_find = 0xff68 // Find, search
pub const key_cancel = 0xff69 // Cancel, stop, abort, exit
pub const key_help = 0xff6a // Help
pub const key_break = 0xff6b
pub const key_mode_switch = 0xff7e // Character set switch
pub const key_script_switch = 0xff7e // non-deprecated alias for Mode_switch
pub const key_num_lock = 0xff7f

// Keypad functions, keypad numbers cleverly chosen to map to ASCII

pub const key_kp_space = 0xff80 //<U+0020 SPACE>
pub const key_kp_tab = 0xff89 //<U+0009 CHARACTER TABULATION>
pub const key_kp_enter = 0xff8d //<U+000D CARRIAGE RETURN>
pub const key_kp_f1 = 0xff91 // PF1, KP_A, ...
pub const key_kp_f2 = 0xff92
pub const key_kp_f3 = 0xff93
pub const key_kp_f4 = 0xff94
pub const key_kp_home = 0xff95
pub const key_kp_left = 0xff96
pub const key_kp_up = 0xff97
pub const key_kp_right = 0xff98
pub const key_kp_down = 0xff99
pub const key_kp_prior = 0xff9a
pub const key_kp_page_up = 0xff9a // deprecated alias for KP_Prior
pub const key_kp_next = 0xff9b
pub const key_kp_page_down = 0xff9b // deprecated alias for KP_Next
pub const key_kp_end = 0xff9c
pub const key_kp_begin = 0xff9d
pub const key_kp_insert = 0xff9e
pub const key_kp_delete = 0xff9f
pub const key_kp_equal = 0xffbd //<U+003D EQUALS SIGN>
pub const key_kp_multiply = 0xffaa //<U+002A ASTERISK>
pub const key_kp_add = 0xffab //<U+002B PLUS SIGN>
pub const key_kp_separator = 0xffac //<U+002C COMMA>
pub const key_kp_subtract = 0xffad //<U+002D HYPHEN-MINUS>
pub const key_kp_decimal = 0xffae //<U+002E FULL STOP>
pub const key_kp_divide = 0xffaf //<U+002F SOLIDUS>

pub const key_kp_0 = 0xffb0 //<U+0030 DIGIT ZERO>
pub const key_kp_1 = 0xffb1 //<U+0031 DIGIT ONE>
pub const key_kp_2 = 0xffb2 //<U+0032 DIGIT TWO>
pub const key_kp_3 = 0xffb3 //<U+0033 DIGIT THREE>
pub const key_kp_4 = 0xffb4 //<U+0034 DIGIT FOUR>
pub const key_kp_5 = 0xffb5 //<U+0035 DIGIT FIVE>
pub const key_kp_6 = 0xffb6 //<U+0036 DIGIT SIX>
pub const key_kp_7 = 0xffb7 //<U+0037 DIGIT SEVEN>
pub const key_kp_8 = 0xffb8 //<U+0038 DIGIT EIGHT>
pub const key_kp_9 = 0xffb9 //<U+0039 DIGIT NINE>

//
////* Auxiliary functions; note the duplicate definitions for left and right
////* function keys;  Sun keyboards and a few other manufacturers have such
////* function key groups on the left and/or right sides of the keyboard.
////* We've not found a keyboard with more than 35 function keys total.
//

pub const key_f1 = 0xffbe
pub const key_f2 = 0xffbf
pub const key_f3 = 0xffc0
pub const key_f4 = 0xffc1
pub const key_f5 = 0xffc2
pub const key_f6 = 0xffc3
pub const key_f7 = 0xffc4
pub const key_f8 = 0xffc5
pub const key_f9 = 0xffc6
pub const key_f10 = 0xffc7
pub const key_f11 = 0xffc8
pub const key_l1 = 0xffc8 // deprecated alias for F11
pub const key_f12 = 0xffc9
pub const key_l2 = 0xffc9 // deprecated alias for F12
pub const key_f13 = 0xffca
pub const key_l3 = 0xffca // deprecated alias for F13
pub const key_f14 = 0xffcb
pub const key_l4 = 0xffcb // deprecated alias for F14
pub const key_f15 = 0xffcc
pub const key_l5 = 0xffcc // deprecated alias for F15
pub const key_f16 = 0xffcd
pub const key_l6 = 0xffcd // deprecated alias for F16
pub const key_f17 = 0xffce
pub const key_l7 = 0xffce // deprecated alias for F17
pub const key_f18 = 0xffcf
pub const key_l8 = 0xffcf // deprecated alias for F18
pub const key_f19 = 0xffd0
pub const key_l9 = 0xffd0 // deprecated alias for F19
pub const key_f20 = 0xffd1
pub const key_l10 = 0xffd1 // deprecated alias for F20
pub const key_f21 = 0xffd2
pub const key_r1 = 0xffd2 // deprecated alias for F21
pub const key_f22 = 0xffd3
pub const key_r2 = 0xffd3 // deprecated alias for F22
pub const key_f23 = 0xffd4
pub const key_r3 = 0xffd4 // deprecated alias for F23
pub const key_f24 = 0xffd5
pub const key_r4 = 0xffd5 // deprecated alias for F24
pub const key_f25 = 0xffd6
pub const key_r5 = 0xffd6 // deprecated alias for F25
pub const key_f26 = 0xffd7
pub const key_r6 = 0xffd7 // deprecated alias for F26
pub const key_f27 = 0xffd8
pub const key_r7 = 0xffd8 // deprecated alias for F27
pub const key_f28 = 0xffd9
pub const key_r8 = 0xffd9 // deprecated alias for F28
pub const key_f29 = 0xffda
pub const key_r9 = 0xffda // deprecated alias for F29
pub const key_f30 = 0xffdb
pub const key_r10 = 0xffdb // deprecated alias for F30
pub const key_f31 = 0xffdc
pub const key_r11 = 0xffdc // deprecated alias for F31
pub const key_f32 = 0xffdd
pub const key_r12 = 0xffdd // deprecated alias for F32
pub const key_f33 = 0xffde
pub const key_r13 = 0xffde // deprecated alias for F33
pub const key_f34 = 0xffdf
pub const key_r14 = 0xffdf // deprecated alias for F34
pub const key_f35 = 0xffe0
pub const key_r15 = 0xffe0 // deprecated alias for F35

// Modifiers

pub const key_shift_l = 0xffe1 // Left shift
pub const key_shift_r = 0xffe2 // Right shift
pub const key_control_l = 0xffe3 // Left control
pub const key_control_r = 0xffe4 // Right control
pub const key_caps_lock = 0xffe5 // Caps lock
pub const key_shift_lock = 0xffe6 // Shift lock

pub const key_meta_l = 0xffe7 // Left meta
pub const key_meta_r = 0xffe8 // Right meta
pub const key_alt_l = 0xffe9 // Left alt
pub const key_alt_r = 0xffea // Right alt
pub const key_super_l = 0xffeb // Left super
pub const key_super_r = 0xffec // Right super
pub const key_hyper_l = 0xffed // Left hyper
pub const key_hyper_r = 0xffee // Right hyper

//
////* Keyboard (XKB) Extension function and modifier keys
////* (from Appendix C of "The X Keyboard Extension: Protocol Specification")
////* Byte 3 = := 0xfe
//

pub const key_iso_lock = 0xfe01
pub const key_iso_level2_latch = 0xfe02
pub const key_iso_level3_shift = 0xfe03
pub const key_iso_level3_latch = 0xfe04
pub const key_iso_level3_lock = 0xfe05
pub const key_iso_level5_shift = 0xfe11
pub const key_iso_level5_latch = 0xfe12
pub const key_iso_level5_lock = 0xfe13
pub const key_iso_group_shift = 0xff7e // non-deprecated alias for Mode_switch
pub const key_iso_group_latch = 0xfe06
pub const key_iso_group_lock = 0xfe07
pub const key_iso_next_group = 0xfe08
pub const key_iso_next_group_lock = 0xfe09
pub const key_iso_prev_group = 0xfe0a
pub const key_iso_prev_group_lock = 0xfe0b
pub const key_iso_first_group = 0xfe0c
pub const key_iso_first_group_lock = 0xfe0d
pub const key_iso_last_group = 0xfe0e
pub const key_iso_last_group_lock = 0xfe0f

pub const key_iso_left_tab = 0xfe20
pub const key_iso_move_line_up = 0xfe21
pub const key_iso_move_line_down = 0xfe22
pub const key_iso_partial_line_up = 0xfe23
pub const key_iso_partial_line_down = 0xfe24
pub const key_iso_partial_space_left = 0xfe25
pub const key_iso_partial_space_right = 0xfe26
pub const key_iso_set_margin_left = 0xfe27
pub const key_iso_set_margin_right = 0xfe28
pub const key_iso_release_margin_left = 0xfe29
pub const key_iso_release_margin_right = 0xfe2a
pub const key_iso_release_both_margins = 0xfe2b
pub const key_iso_fast_cursor_left = 0xfe2c
pub const key_iso_fast_cursor_right = 0xfe2d
pub const key_iso_fast_cursor_up = 0xfe2e
pub const key_iso_fast_cursor_down = 0xfe2f
pub const key_iso_continuous_underline = 0xfe30
pub const key_iso_discontinuous_underline = 0xfe31
pub const key_iso_emphasize = 0xfe32
pub const key_iso_center_object = 0xfe33
pub const key_iso_enter = 0xfe34

pub const key_dead_grave = 0xfe50
pub const key_dead_acute = 0xfe51
pub const key_dead_circumflex = 0xfe52
pub const key_dead_tilde = 0xfe53
pub const key_dead_perispomeni = 0xfe53 // non-deprecated alias for dead_tilde
pub const key_dead_macron = 0xfe54
pub const key_dead_breve = 0xfe55
pub const key_dead_abovedot = 0xfe56
pub const key_dead_diaeresis = 0xfe57
pub const key_dead_abovering = 0xfe58
pub const key_dead_doubleacute = 0xfe59
pub const key_dead_caron = 0xfe5a
pub const key_dead_cedilla = 0xfe5b
pub const key_dead_ogonek = 0xfe5c
pub const key_dead_iota = 0xfe5d
pub const key_dead_voiced_sound = 0xfe5e
pub const key_dead_semivoiced_sound = 0xfe5f
pub const key_dead_belowdot = 0xfe60
pub const key_dead_hook = 0xfe61
pub const key_dead_horn = 0xfe62
pub const key_dead_stroke = 0xfe63
pub const key_dead_abovecomma = 0xfe64
pub const key_dead_psili = 0xfe64 // non-deprecated alias for dead_abovecomma
pub const key_dead_abovereversedcomma = 0xfe65
pub const key_dead_dasia = 0xfe65 // non-deprecated alias for dead_abovereversedcomma
pub const key_dead_doublegrave = 0xfe66
pub const key_dead_belowring = 0xfe67
pub const key_dead_belowmacron = 0xfe68
pub const key_dead_belowcircumflex = 0xfe69
pub const key_dead_belowtilde = 0xfe6a
pub const key_dead_belowbreve = 0xfe6b
pub const key_dead_belowdiaeresis = 0xfe6c
pub const key_dead_invertedbreve = 0xfe6d
pub const key_dead_belowcomma = 0xfe6e
pub const key_dead_currency = 0xfe6f

// extra dead elements for German T3 layout
pub const key_dead_lowline = 0xfe90
pub const key_dead_aboveverticalline = 0xfe91
pub const key_dead_belowverticalline = 0xfe92
pub const key_dead_longsolidusoverlay = 0xfe93

// dead vowels for universal syllable entry
pub const key_dead_a = 0xfe80
pub const key_dead_small_a = 0xfe81
pub const key_dead_e = 0xfe82
pub const key_dead_small_e = 0xfe83
pub const key_dead_i = 0xfe84
pub const key_dead_small_i = 0xfe85
pub const key_dead_o = 0xfe86
pub const key_dead_small_o = 0xfe87
pub const key_dead_u = 0xfe88
pub const key_dead_small_u = 0xfe89
pub const key_dead_small_schwa = 0xfe8a
pub const key_dead_schwa = 0xfe8b

pub const key_dead_greek = 0xfe8c
pub const key_dead_hamza = 0xfe8d

pub const key_first_virtual_screen = 0xfed0
pub const key_prev_virtual_screen = 0xfed1
pub const key_next_virtual_screen = 0xfed2
pub const key_last_virtual_screen = 0xfed4
pub const key_terminate_server = 0xfed5

pub const key_accessx_enable = 0xfe70
pub const key_accessx_feedback_enable = 0xfe71
pub const key_repeatkeys_enable = 0xfe72
pub const key_slowkeys_enable = 0xfe73
pub const key_bouncekeys_enable = 0xfe74
pub const key_stickykeys_enable = 0xfe75
pub const key_mousekeys_enable = 0xfe76
pub const key_mousekeys_accel_enable = 0xfe77
pub const key_overlay1_enable = 0xfe78
pub const key_overlay2_enable = 0xfe79
pub const key_audiblebell_enable = 0xfe7a

pub const key_pointer_left = 0xfee0
pub const key_pointer_right = 0xfee1
pub const key_pointer_up = 0xfee2
pub const key_pointer_down = 0xfee3
pub const key_pointer_upleft = 0xfee4
pub const key_pointer_upright = 0xfee5
pub const key_pointer_downleft = 0xfee6
pub const key_pointer_downright = 0xfee7
pub const key_pointer_button_dflt = 0xfee8
pub const key_pointer_button1 = 0xfee9
pub const key_pointer_button2 = 0xfeea
pub const key_pointer_button3 = 0xfeeb
pub const key_pointer_button4 = 0xfeec
pub const key_pointer_button5 = 0xfeed
pub const key_pointer_dblclick_dflt = 0xfeee
pub const key_pointer_dblclick1 = 0xfeef
pub const key_pointer_dblclick2 = 0xfef0
pub const key_pointer_dblclick3 = 0xfef1
pub const key_pointer_dblclick4 = 0xfef2
pub const key_pointer_dblclick5 = 0xfef3
pub const key_pointer_drag_dflt = 0xfef4
pub const key_pointer_drag1 = 0xfef5
pub const key_pointer_drag2 = 0xfef6
pub const key_pointer_drag3 = 0xfef7
pub const key_pointer_drag4 = 0xfef8
pub const key_pointer_drag5 = 0xfefd

pub const key_pointer_enablekeys = 0xfef9
pub const key_pointer_accelerate = 0xfefa
pub const key_pointer_dfltbtnnext = 0xfefb
pub const key_pointer_dfltbtnprev = 0xfefc

// Single-Stroke Multiple-Character N-Graph Keysyms For The X Input Method

pub const key_ch1 = 0xfea0
pub const key_ch2 = 0xfea1
pub const key_ch3 = 0xfea2
pub const key_c_h1 = 0xfea3
pub const key_c_h2 = 0xfea4
pub const key_c_h3 = 0xfea5

//
////* 3270 Terminal Keys
////* Byte 3 = := 0xfd
//

pub const key_3270_duplicate = 0xfd01
pub const key_3270_fieldmark = 0xfd02
pub const key_3270_right2 = 0xfd03
pub const key_3270_left2 = 0xfd04
pub const key_3270_backtab = 0xfd05
pub const key_3270_eraseeof = 0xfd06
pub const key_3270_eraseinput = 0xfd07
pub const key_3270_reset = 0xfd08
pub const key_3270_quit = 0xfd09
pub const key_3270_pa1 = 0xfd0a
pub const key_3270_pa2 = 0xfd0b
pub const key_3270_pa3 = 0xfd0c
pub const key_3270_test = 0xfd0d
pub const key_3270_attn = 0xfd0e
pub const key_3270_cursorblink = 0xfd0f
pub const key_3270_altcursor = 0xfd10
pub const key_3270_keyclick = 0xfd11
pub const key_3270_jump = 0xfd12
pub const key_3270_ident = 0xfd13
pub const key_3270_rule = 0xfd14
pub const key_3270_copy = 0xfd15
pub const key_3270_play = 0xfd16
pub const key_3270_setup = 0xfd17
pub const key_3270_record = 0xfd18
pub const key_3270_changescreen = 0xfd19
pub const key_3270_deleteword = 0xfd1a
pub const key_3270_exselect = 0xfd1b
pub const key_3270_cursorselect = 0xfd1c
pub const key_3270_printscreen = 0xfd1d
pub const key_3270_enter = 0xfd1e

//
////* Latin 1
////* (ISO/IEC 8859-1 = Unicode U+0020..U+00FF)
////* Byte 3 = 0
//

pub const key_space = 0x0020 // U+0020 SPACE
pub const key_exclam = 0x0021 // U+0021 EXCLAMATION MARK
pub const key_quotedbl = 0x0022 // U+0022 QUOTATION MARK
pub const key_numbersign = 0x0023 // U+0023 NUMBER SIGN
pub const key_dollar = 0x0024 // U+0024 DOLLAR SIGN
pub const key_percent = 0x0025 // U+0025 PERCENT SIGN
pub const key_ampersand = 0x0026 // U+0026 AMPERSAND
pub const key_apostrophe = 0x0027 // U+0027 APOSTROPHE
pub const key_quoteright = 0x0027 // deprecated
pub const key_parenleft = 0x0028 // U+0028 LEFT PARENTHESIS
pub const key_parenright = 0x0029 // U+0029 RIGHT PARENTHESIS
pub const key_asterisk = 0x002a // U+002A ASTERISK
pub const key_plus = 0x002b // U+002B PLUS SIGN
pub const key_comma = 0x002c // U+002C COMMA
pub const key_minus = 0x002d // U+002D HYPHEN-MINUS
pub const key_period = 0x002e // U+002E FULL STOP
pub const key_slash = 0x002f // U+002F SOLIDUS
pub const key_0 = 0x0030 // U+0030 DIGIT ZERO
pub const key_1 = 0x0031 // U+0031 DIGIT ONE
pub const key_2 = 0x0032 // U+0032 DIGIT TWO
pub const key_3 = 0x0033 // U+0033 DIGIT THREE
pub const key_4 = 0x0034 // U+0034 DIGIT FOUR
pub const key_5 = 0x0035 // U+0035 DIGIT FIVE
pub const key_6 = 0x0036 // U+0036 DIGIT SIX
pub const key_7 = 0x0037 // U+0037 DIGIT SEVEN
pub const key_8 = 0x0038 // U+0038 DIGIT EIGHT
pub const key_9 = 0x0039 // U+0039 DIGIT NINE
pub const key_colon = 0x003a // U+003A COLON
pub const key_semicolon = 0x003b // U+003B SEMICOLON
pub const key_less = 0x003c // U+003C LESS-THAN SIGN
pub const key_equal = 0x003d // U+003D EQUALS SIGN
pub const key_greater = 0x003e // U+003E GREATER-THAN SIGN
pub const key_question = 0x003f // U+003F QUESTION MARK
pub const key_at = 0x0040 // U+0040 COMMERCIAL AT
pub const key_a = 0x0041 // U+0041 LATIN CAPITAL LETTER A
pub const key_b = 0x0042 // U+0042 LATIN CAPITAL LETTER B
pub const key_c = 0x0043 // U+0043 LATIN CAPITAL LETTER C
pub const key_d = 0x0044 // U+0044 LATIN CAPITAL LETTER D
pub const key_e = 0x0045 // U+0045 LATIN CAPITAL LETTER E
pub const key_f = 0x0046 // U+0046 LATIN CAPITAL LETTER F
pub const key_g = 0x0047 // U+0047 LATIN CAPITAL LETTER G
pub const key_h = 0x0048 // U+0048 LATIN CAPITAL LETTER H
pub const key_i = 0x0049 // U+0049 LATIN CAPITAL LETTER I
pub const key_j = 0x004a // U+004A LATIN CAPITAL LETTER J
pub const key_k = 0x004b // U+004B LATIN CAPITAL LETTER K
pub const key_l = 0x004c // U+004C LATIN CAPITAL LETTER L
pub const key_m = 0x004d // U+004D LATIN CAPITAL LETTER M
pub const key_n = 0x004e // U+004E LATIN CAPITAL LETTER N
pub const key_o = 0x004f // U+004F LATIN CAPITAL LETTER O
pub const key_p = 0x0050 // U+0050 LATIN CAPITAL LETTER P
pub const key_q = 0x0051 // U+0051 LATIN CAPITAL LETTER Q
pub const key_r = 0x0052 // U+0052 LATIN CAPITAL LETTER R
pub const key_s = 0x0053 // U+0053 LATIN CAPITAL LETTER S
pub const key_t = 0x0054 // U+0054 LATIN CAPITAL LETTER T
pub const key_u = 0x0055 // U+0055 LATIN CAPITAL LETTER U
pub const key_v = 0x0056 // U+0056 LATIN CAPITAL LETTER V
pub const key_w = 0x0057 // U+0057 LATIN CAPITAL LETTER W
pub const key_x = 0x0058 // U+0058 LATIN CAPITAL LETTER X
pub const key_y = 0x0059 // U+0059 LATIN CAPITAL LETTER Y
pub const key_z = 0x005a // U+005A LATIN CAPITAL LETTER Z
pub const key_bracketleft = 0x005b // U+005B LEFT SQUARE BRACKET
pub const key_backslash = 0x005c // U+005C REVERSE SOLIDUS
pub const key_bracketright = 0x005d // U+005D RIGHT SQUARE BRACKET
pub const key_asciicircum = 0x005e // U+005E CIRCUMFLEX ACCENT
pub const key_underscore = 0x005f // U+005F LOW LINE
pub const key_grave = 0x0060 // U+0060 GRAVE ACCENT
pub const key_quoteleft = 0x0060 // deprecated
pub const key_small_a = 0x0061 // U+0061 LATIN SMALL LETTER A
pub const key_small_b = 0x0062 // U+0062 LATIN SMALL LETTER B
pub const key_small_c = 0x0063 // U+0063 LATIN SMALL LETTER C
pub const key_small_d = 0x0064 // U+0064 LATIN SMALL LETTER D
pub const key_small_e = 0x0065 // U+0065 LATIN SMALL LETTER E
pub const key_small_f = 0x0066 // U+0066 LATIN SMALL LETTER F
pub const key_small_g = 0x0067 // U+0067 LATIN SMALL LETTER G
pub const key_small_h = 0x0068 // U+0068 LATIN SMALL LETTER H
pub const key_small_i = 0x0069 // U+0069 LATIN SMALL LETTER I
pub const key_small_j = 0x006a // U+006A LATIN SMALL LETTER J
pub const key_small_k = 0x006b // U+006B LATIN SMALL LETTER K
pub const key_small_l = 0x006c // U+006C LATIN SMALL LETTER L
pub const key_small_m = 0x006d // U+006D LATIN SMALL LETTER M
pub const key_small_n = 0x006e // U+006E LATIN SMALL LETTER N
pub const key_small_o = 0x006f // U+006F LATIN SMALL LETTER O
pub const key_small_p = 0x0070 // U+0070 LATIN SMALL LETTER P
pub const key_small_q = 0x0071 // U+0071 LATIN SMALL LETTER Q
pub const key_small_r = 0x0072 // U+0072 LATIN SMALL LETTER R
pub const key_small_s = 0x0073 // U+0073 LATIN SMALL LETTER S
pub const key_small_t = 0x0074 // U+0074 LATIN SMALL LETTER T
pub const key_small_u = 0x0075 // U+0075 LATIN SMALL LETTER U
pub const key_small_v = 0x0076 // U+0076 LATIN SMALL LETTER V
pub const key_small_w = 0x0077 // U+0077 LATIN SMALL LETTER W
pub const key_small_x = 0x0078 // U+0078 LATIN SMALL LETTER X
pub const key_small_y = 0x0079 // U+0079 LATIN SMALL LETTER Y
pub const key_small_z = 0x007a // U+007A LATIN SMALL LETTER Z
pub const key_braceleft = 0x007b // U+007B LEFT CURLY BRACKET
pub const key_bar = 0x007c // U+007C VERTICAL LINE
pub const key_braceright = 0x007d // U+007D RIGHT CURLY BRACKET
pub const key_asciitilde = 0x007e // U+007E TILDE

pub const key_nobreakspace = 0x00a0 // U+00A0 NO-BREAK SPACE
pub const key_exclamdown = 0x00a1 // U+00A1 INVERTED EXCLAMATION MARK
pub const key_cent = 0x00a2 // U+00A2 CENT SIGN
pub const key_sterling = 0x00a3 // U+00A3 POUND SIGN
pub const key_currency = 0x00a4 // U+00A4 CURRENCY SIGN
pub const key_yen = 0x00a5 // U+00A5 YEN SIGN
pub const key_brokenbar = 0x00a6 // U+00A6 BROKEN BAR
pub const key_section = 0x00a7 // U+00A7 SECTION SIGN
pub const key_diaeresis = 0x00a8 // U+00A8 DIAERESIS
pub const key_copyright = 0x00a9 // U+00A9 COPYRIGHT SIGN
pub const key_ordfeminine = 0x00aa // U+00AA FEMININE ORDINAL INDICATOR
pub const key_guillemotleft = 0x00ab // deprecated alias for guillemetleft (misspelling)
pub const key_guillemetleft = 0x00ab // U+00AB LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
pub const key_notsign = 0x00ac // U+00AC NOT SIGN
pub const key_hyphen = 0x00ad // U+00AD SOFT HYPHEN
pub const key_registered = 0x00ae // U+00AE REGISTERED SIGN
pub const key_macron = 0x00af // U+00AF MACRON
pub const key_degree = 0x00b0 // U+00B0 DEGREE SIGN
pub const key_plusminus = 0x00b1 // U+00B1 PLUS-MINUS SIGN
pub const key_twosuperior = 0x00b2 // U+00B2 SUPERSCRIPT TWO
pub const key_threesuperior = 0x00b3 // U+00B3 SUPERSCRIPT THREE
pub const key_acute = 0x00b4 // U+00B4 ACUTE ACCENT
pub const key_mu = 0x00b5 // U+00B5 MICRO SIGN
pub const key_paragraph = 0x00b6 // U+00B6 PILCROW SIGN
pub const key_periodcentered = 0x00b7 // U+00B7 MIDDLE DOT
pub const key_cedilla = 0x00b8 // U+00B8 CEDILLA
pub const key_onesuperior = 0x00b9 // U+00B9 SUPERSCRIPT ONE
pub const key_masculine = 0x00ba // deprecated alias for ordmasculine (inconsistent name)
pub const key_ordmasculine = 0x00ba // U+00BA MASCULINE ORDINAL INDICATOR
pub const key_guillemotright = 0x00bb // deprecated alias for guillemetright (misspelling)
pub const key_guillemetright = 0x00bb // U+00BB RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
pub const key_onequarter = 0x00bc // U+00BC VULGAR FRACTION ONE QUARTER
pub const key_onehalf = 0x00bd // U+00BD VULGAR FRACTION ONE HALF
pub const key_threequarters = 0x00be // U+00BE VULGAR FRACTION THREE QUARTERS
pub const key_questiondown = 0x00bf // U+00BF INVERTED QUESTION MARK
pub const key_agrave = 0x00c0 // U+00C0 LATIN CAPITAL LETTER A WITH GRAVE
pub const key_aacute = 0x00c1 // U+00C1 LATIN CAPITAL LETTER A WITH ACUTE
pub const key_acircumflex = 0x00c2 // U+00C2 LATIN CAPITAL LETTER A WITH CIRCUMFLEX
pub const key_atilde = 0x00c3 // U+00C3 LATIN CAPITAL LETTER A WITH TILDE
pub const key_adiaeresis = 0x00c4 // U+00C4 LATIN CAPITAL LETTER A WITH DIAERESIS
pub const key_aring = 0x00c5 // U+00C5 LATIN CAPITAL LETTER A WITH RING ABOVE
pub const key_ae = 0x00c6 // U+00C6 LATIN CAPITAL LETTER AE
pub const key_ccedilla = 0x00c7 // U+00C7 LATIN CAPITAL LETTER C WITH CEDILLA
pub const key_egrave = 0x00c8 // U+00C8 LATIN CAPITAL LETTER E WITH GRAVE
pub const key_eacute = 0x00c9 // U+00C9 LATIN CAPITAL LETTER E WITH ACUTE
pub const key_ecircumflex = 0x00ca // U+00CA LATIN CAPITAL LETTER E WITH CIRCUMFLEX
pub const key_ediaeresis = 0x00cb // U+00CB LATIN CAPITAL LETTER E WITH DIAERESIS
pub const key_igrave = 0x00cc // U+00CC LATIN CAPITAL LETTER I WITH GRAVE
pub const key_iacute = 0x00cd // U+00CD LATIN CAPITAL LETTER I WITH ACUTE
pub const key_icircumflex = 0x00ce // U+00CE LATIN CAPITAL LETTER I WITH CIRCUMFLEX
pub const key_idiaeresis = 0x00cf // U+00CF LATIN CAPITAL LETTER I WITH DIAERESIS

@[deprecated: 'alias for eth']
pub const key_eth = 0x00d0 // deprecated
pub const key_ntilde = 0x00d1 // U+00D1 LATIN CAPITAL LETTER N WITH TILDE
pub const key_ograve = 0x00d2 // U+00D2 LATIN CAPITAL LETTER O WITH GRAVE
pub const key_oacute = 0x00d3 // U+00D3 LATIN CAPITAL LETTER O WITH ACUTE
pub const key_ocircumflex = 0x00d4 // U+00D4 LATIN CAPITAL LETTER O WITH CIRCUMFLEX
pub const key_otilde = 0x00d5 // U+00D5 LATIN CAPITAL LETTER O WITH TILDE
pub const key_odiaeresis = 0x00d6 // U+00D6 LATIN CAPITAL LETTER O WITH DIAERESIS
pub const key_multiply = 0x00d7 // U+00D7 MULTIPLICATION SIGN
pub const key_oslash = 0x00d8 // U+00D8 LATIN CAPITAL LETTER O WITH STROKE

@[deprecated: 'alias for oslash']
pub const key_ooblique = 0x00d8 // deprecated alias for Oslash
pub const key_ugrave = 0x00d9 // U+00D9 LATIN CAPITAL LETTER U WITH GRAVE
pub const key_uacute = 0x00da // U+00DA LATIN CAPITAL LETTER U WITH ACUTE
pub const key_ucircumflex = 0x00db // U+00DB LATIN CAPITAL LETTER U WITH CIRCUMFLEX
pub const key_udiaeresis = 0x00dc // U+00DC LATIN CAPITAL LETTER U WITH DIAERESIS
pub const key_yacute = 0x00dd // U+00DD LATIN CAPITAL LETTER Y WITH ACUTE

@[deprecated: 'alias for thorn']
pub const key_thorn = 0x00de // deprecated
pub const key_small_ssharp = 0x00df // U+00DF LATIN SMALL LETTER SHARP S
pub const key_small_agrave = 0x00e0 // U+00E0 LATIN SMALL LETTER A WITH GRAVE
pub const key_small_aacute = 0x00e1 // U+00E1 LATIN SMALL LETTER A WITH ACUTE
pub const key_small_acircumflex = 0x00e2 // U+00E2 LATIN SMALL LETTER A WITH CIRCUMFLEX
pub const key_small_atilde = 0x00e3 // U+00E3 LATIN SMALL LETTER A WITH TILDE
pub const key_small_adiaeresis = 0x00e4 // U+00E4 LATIN SMALL LETTER A WITH DIAERESIS
pub const key_small_aring = 0x00e5 // U+00E5 LATIN SMALL LETTER A WITH RING ABOVE
pub const key_small_ae = 0x00e6 // U+00E6 LATIN SMALL LETTER AE
pub const key_small_ccedilla = 0x00e7 // U+00E7 LATIN SMALL LETTER C WITH CEDILLA
pub const key_small_egrave = 0x00e8 // U+00E8 LATIN SMALL LETTER E WITH GRAVE
pub const key_small_eacute = 0x00e9 // U+00E9 LATIN SMALL LETTER E WITH ACUTE
pub const key_small_ecircumflex = 0x00ea // U+00EA LATIN SMALL LETTER E WITH CIRCUMFLEX
pub const key_small_ediaeresis = 0x00eb // U+00EB LATIN SMALL LETTER E WITH DIAERESIS
pub const key_small_igrave = 0x00ec // U+00EC LATIN SMALL LETTER I WITH GRAVE
pub const key_small_iacute = 0x00ed // U+00ED LATIN SMALL LETTER I WITH ACUTE
pub const key_small_icircumflex = 0x00ee // U+00EE LATIN SMALL LETTER I WITH CIRCUMFLEX
pub const key_small_idiaeresis = 0x00ef // U+00EF LATIN SMALL LETTER I WITH DIAERESIS
pub const key_small_eth = 0x00f0 // U+00F0 LATIN SMALL LETTER ETH
pub const key_small_ntilde = 0x00f1 // U+00F1 LATIN SMALL LETTER N WITH TILDE
pub const key_small_ograve = 0x00f2 // U+00F2 LATIN SMALL LETTER O WITH GRAVE
pub const key_small_oacute = 0x00f3 // U+00F3 LATIN SMALL LETTER O WITH ACUTE
pub const key_small_ocircumflex = 0x00f4 // U+00F4 LATIN SMALL LETTER O WITH CIRCUMFLEX
pub const key_small_otilde = 0x00f5 // U+00F5 LATIN SMALL LETTER O WITH TILDE
pub const key_small_odiaeresis = 0x00f6 // U+00F6 LATIN SMALL LETTER O WITH DIAERESIS
pub const key_division = 0x00f7 // U+00F7 DIVISION SIGN
pub const key_small_oslash = 0x00f8 // U+00F8 LATIN SMALL LETTER O WITH STROKE

@[deprecated: 'alias for small_oslash']
pub const key_small_ooblique = 0x00f8 // deprecated alias for oslash
pub const key_small_ugrave = 0x00f9 // U+00F9 LATIN SMALL LETTER U WITH GRAVE
pub const key_small_uacute = 0x00fa // U+00FA LATIN SMALL LETTER U WITH ACUTE
pub const key_small_ucircumflex = 0x00fb // U+00FB LATIN SMALL LETTER U WITH CIRCUMFLEX
pub const key_small_udiaeresis = 0x00fc // U+00FC LATIN SMALL LETTER U WITH DIAERESIS
pub const key_small_yacute = 0x00fd // U+00FD LATIN SMALL LETTER Y WITH ACUTE
pub const key_small_thorn = 0x00fe // U+00FE LATIN SMALL LETTER THORN
pub const key_small_ydiaeresis = 0x00ff // U+00FF LATIN SMALL LETTER Y WITH DIAERESIS

//
////* Latin 2
////* Byte 3 = 1
//

pub const key_aogonek = 0x01a1 // U+0104 LATIN CAPITAL LETTER A WITH OGONEK
pub const key_breve = 0x01a2 // U+02D8 BREVE
pub const key_lstroke = 0x01a3 // U+0141 LATIN CAPITAL LETTER L WITH STROKE
pub const key_lcaron = 0x01a5 // U+013D LATIN CAPITAL LETTER L WITH CARON
pub const key_sacute = 0x01a6 // U+015A LATIN CAPITAL LETTER S WITH ACUTE
pub const key_scaron = 0x01a9 // U+0160 LATIN CAPITAL LETTER S WITH CARON
pub const key_scedilla = 0x01aa // U+015E LATIN CAPITAL LETTER S WITH CEDILLA
pub const key_tcaron = 0x01ab // U+0164 LATIN CAPITAL LETTER T WITH CARON
pub const key_zacute = 0x01ac // U+0179 LATIN CAPITAL LETTER Z WITH ACUTE
pub const key_zcaron = 0x01ae // U+017D LATIN CAPITAL LETTER Z WITH CARON
pub const key_zabovedot = 0x01af // U+017B LATIN CAPITAL LETTER Z WITH DOT ABOVE
pub const key_small_aogonek = 0x01b1 // U+0105 LATIN SMALL LETTER A WITH OGONEK
pub const key_ogonek = 0x01b2 // U+02DB OGONEK
pub const key_small_lstroke = 0x01b3 // U+0142 LATIN SMALL LETTER L WITH STROKE
pub const key_small_lcaron = 0x01b5 // U+013E LATIN SMALL LETTER L WITH CARON
pub const key_small_sacute = 0x01b6 // U+015B LATIN SMALL LETTER S WITH ACUTE
pub const key_caron = 0x01b7 // U+02C7 CARON
pub const key_small_scaron = 0x01b9 // U+0161 LATIN SMALL LETTER S WITH CARON
pub const key_small_scedilla = 0x01ba // U+015F LATIN SMALL LETTER S WITH CEDILLA
pub const key_small_tcaron = 0x01bb // U+0165 LATIN SMALL LETTER T WITH CARON
pub const key_small_zacute = 0x01bc // U+017A LATIN SMALL LETTER Z WITH ACUTE
pub const key_doubleacute = 0x01bd // U+02DD DOUBLE ACUTE ACCENT
pub const key_small_zcaron = 0x01be // U+017E LATIN SMALL LETTER Z WITH CARON
pub const key_small_zabovedot = 0x01bf // U+017C LATIN SMALL LETTER Z WITH DOT ABOVE
pub const key_racute = 0x01c0 // U+0154 LATIN CAPITAL LETTER R WITH ACUTE
pub const key_abreve = 0x01c3 // U+0102 LATIN CAPITAL LETTER A WITH BREVE
pub const key_lacute = 0x01c5 // U+0139 LATIN CAPITAL LETTER L WITH ACUTE
pub const key_cacute = 0x01c6 // U+0106 LATIN CAPITAL LETTER C WITH ACUTE
pub const key_ccaron = 0x01c8 // U+010C LATIN CAPITAL LETTER C WITH CARON
pub const key_eogonek = 0x01ca // U+0118 LATIN CAPITAL LETTER E WITH OGONEK
pub const key_ecaron = 0x01cc // U+011A LATIN CAPITAL LETTER E WITH CARON
pub const key_dcaron = 0x01cf // U+010E LATIN CAPITAL LETTER D WITH CARON
pub const key_dstroke = 0x01d0 // U+0110 LATIN CAPITAL LETTER D WITH STROKE
pub const key_nacute = 0x01d1 // U+0143 LATIN CAPITAL LETTER N WITH ACUTE
pub const key_ncaron = 0x01d2 // U+0147 LATIN CAPITAL LETTER N WITH CARON
pub const key_odoubleacute = 0x01d5 // U+0150 LATIN CAPITAL LETTER O WITH DOUBLE ACUTE
pub const key_rcaron = 0x01d8 // U+0158 LATIN CAPITAL LETTER R WITH CARON
pub const key_uring = 0x01d9 // U+016E LATIN CAPITAL LETTER U WITH RING ABOVE
pub const key_udoubleacute = 0x01db // U+0170 LATIN CAPITAL LETTER U WITH DOUBLE ACUTE
pub const key_tcedilla = 0x01de // U+0162 LATIN CAPITAL LETTER T WITH CEDILLA
pub const key_small_racute = 0x01e0 // U+0155 LATIN SMALL LETTER R WITH ACUTE
pub const key_small_abreve = 0x01e3 // U+0103 LATIN SMALL LETTER A WITH BREVE
pub const key_small_lacute = 0x01e5 // U+013A LATIN SMALL LETTER L WITH ACUTE
pub const key_small_cacute = 0x01e6 // U+0107 LATIN SMALL LETTER C WITH ACUTE
pub const key_small_ccaron = 0x01e8 // U+010D LATIN SMALL LETTER C WITH CARON
pub const key_small_eogonek = 0x01ea // U+0119 LATIN SMALL LETTER E WITH OGONEK
pub const key_small_ecaron = 0x01ec // U+011B LATIN SMALL LETTER E WITH CARON
pub const key_small_dcaron = 0x01ef // U+010F LATIN SMALL LETTER D WITH CARON
pub const key_small_dstroke = 0x01f0 // U+0111 LATIN SMALL LETTER D WITH STROKE
pub const key_small_nacute = 0x01f1 // U+0144 LATIN SMALL LETTER N WITH ACUTE
pub const key_small_ncaron = 0x01f2 // U+0148 LATIN SMALL LETTER N WITH CARON
pub const key_small_odoubleacute = 0x01f5 // U+0151 LATIN SMALL LETTER O WITH DOUBLE ACUTE
pub const key_small_rcaron = 0x01f8 // U+0159 LATIN SMALL LETTER R WITH CARON
pub const key_small_uring = 0x01f9 // U+016F LATIN SMALL LETTER U WITH RING ABOVE
pub const key_small_udoubleacute = 0x01fb // U+0171 LATIN SMALL LETTER U WITH DOUBLE ACUTE
pub const key_small_tcedilla = 0x01fe // U+0163 LATIN SMALL LETTER T WITH CEDILLA
pub const key_abovedot = 0x01ff // U+02D9 DOT ABOVE

//
////* Latin 3
////* Byte 3 = 2
//

pub const key_hstroke = 0x02a1 // U+0126 LATIN CAPITAL LETTER H WITH STROKE
pub const key_hcircumflex = 0x02a6 // U+0124 LATIN CAPITAL LETTER H WITH CIRCUMFLEX
pub const key_iabovedot = 0x02a9 // U+0130 LATIN CAPITAL LETTER I WITH DOT ABOVE
pub const key_gbreve = 0x02ab // U+011E LATIN CAPITAL LETTER G WITH BREVE
pub const key_jcircumflex = 0x02ac // U+0134 LATIN CAPITAL LETTER J WITH CIRCUMFLEX
pub const key_small_hstroke = 0x02b1 // U+0127 LATIN SMALL LETTER H WITH STROKE
pub const key_small_hcircumflex = 0x02b6 // U+0125 LATIN SMALL LETTER H WITH CIRCUMFLEX
pub const key_small_idotless = 0x02b9 // U+0131 LATIN SMALL LETTER DOTLESS I
pub const key_small_gbreve = 0x02bb // U+011F LATIN SMALL LETTER G WITH BREVE
pub const key_small_jcircumflex = 0x02bc // U+0135 LATIN SMALL LETTER J WITH CIRCUMFLEX
pub const key_cabovedot = 0x02c5 // U+010A LATIN CAPITAL LETTER C WITH DOT ABOVE
pub const key_ccircumflex = 0x02c6 // U+0108 LATIN CAPITAL LETTER C WITH CIRCUMFLEX
pub const key_gabovedot = 0x02d5 // U+0120 LATIN CAPITAL LETTER G WITH DOT ABOVE
pub const key_gcircumflex = 0x02d8 // U+011C LATIN CAPITAL LETTER G WITH CIRCUMFLEX
pub const key_ubreve = 0x02dd // U+016C LATIN CAPITAL LETTER U WITH BREVE
pub const key_scircumflex = 0x02de // U+015C LATIN CAPITAL LETTER S WITH CIRCUMFLEX
pub const key_small_cabovedot = 0x02e5 // U+010B LATIN SMALL LETTER C WITH DOT ABOVE
pub const key_small_ccircumflex = 0x02e6 // U+0109 LATIN SMALL LETTER C WITH CIRCUMFLEX
pub const key_small_gabovedot = 0x02f5 // U+0121 LATIN SMALL LETTER G WITH DOT ABOVE
pub const key_small_gcircumflex = 0x02f8 // U+011D LATIN SMALL LETTER G WITH CIRCUMFLEX
pub const key_small_ubreve = 0x02fd // U+016D LATIN SMALL LETTER U WITH BREVE
pub const key_small_scircumflex = 0x02fe // U+015D LATIN SMALL LETTER S WITH CIRCUMFLEX

//
////* Latin 4
////* Byte 3 = 3
//

pub const key_kra = 0x03a2 // U+0138 LATIN SMALL LETTER KRA

@[deprecated]
pub const key_kappa = 0x03a2 // deprecated
pub const key_rcedilla = 0x03a3 // U+0156 LATIN CAPITAL LETTER R WITH CEDILLA
pub const key_itilde = 0x03a5 // U+0128 LATIN CAPITAL LETTER I WITH TILDE
pub const key_lcedilla = 0x03a6 // U+013B LATIN CAPITAL LETTER L WITH CEDILLA
pub const key_emacron = 0x03aa // U+0112 LATIN CAPITAL LETTER E WITH MACRON
pub const key_gcedilla = 0x03ab // U+0122 LATIN CAPITAL LETTER G WITH CEDILLA
pub const key_tslash = 0x03ac // U+0166 LATIN CAPITAL LETTER T WITH STROKE
pub const key_small_rcedilla = 0x03b3 // U+0157 LATIN SMALL LETTER R WITH CEDILLA
pub const key_small_itilde = 0x03b5 // U+0129 LATIN SMALL LETTER I WITH TILDE
pub const key_small_lcedilla = 0x03b6 // U+013C LATIN SMALL LETTER L WITH CEDILLA
pub const key_small_emacron = 0x03ba // U+0113 LATIN SMALL LETTER E WITH MACRON
pub const key_small_gcedilla = 0x03bb // U+0123 LATIN SMALL LETTER G WITH CEDILLA
pub const key_small_tslash = 0x03bc // U+0167 LATIN SMALL LETTER T WITH STROKE
pub const key_eng = 0x03bd // U+014A LATIN CAPITAL LETTER ENG
pub const key_small_eng = 0x03bf // U+014B LATIN SMALL LETTER ENG
pub const key_amacron = 0x03c0 // U+0100 LATIN CAPITAL LETTER A WITH MACRON
pub const key_iogonek = 0x03c7 // U+012E LATIN CAPITAL LETTER I WITH OGONEK
pub const key_eabovedot = 0x03cc // U+0116 LATIN CAPITAL LETTER E WITH DOT ABOVE
pub const key_imacron = 0x03cf // U+012A LATIN CAPITAL LETTER I WITH MACRON
pub const key_ncedilla = 0x03d1 // U+0145 LATIN CAPITAL LETTER N WITH CEDILLA
pub const key_omacron = 0x03d2 // U+014C LATIN CAPITAL LETTER O WITH MACRON
pub const key_kcedilla = 0x03d3 // U+0136 LATIN CAPITAL LETTER K WITH CEDILLA
pub const key_uogonek = 0x03d9 // U+0172 LATIN CAPITAL LETTER U WITH OGONEK
pub const key_utilde = 0x03dd // U+0168 LATIN CAPITAL LETTER U WITH TILDE
pub const key_umacron = 0x03de // U+016A LATIN CAPITAL LETTER U WITH MACRON
pub const key_small_amacron = 0x03e0 // U+0101 LATIN SMALL LETTER A WITH MACRON
pub const key_small_iogonek = 0x03e7 // U+012F LATIN SMALL LETTER I WITH OGONEK
pub const key_small_eabovedot = 0x03ec // U+0117 LATIN SMALL LETTER E WITH DOT ABOVE
pub const key_small_imacron = 0x03ef // U+012B LATIN SMALL LETTER I WITH MACRON
pub const key_small_ncedilla = 0x03f1 // U+0146 LATIN SMALL LETTER N WITH CEDILLA
pub const key_small_omacron = 0x03f2 // U+014D LATIN SMALL LETTER O WITH MACRON
pub const key_small_kcedilla = 0x03f3 // U+0137 LATIN SMALL LETTER K WITH CEDILLA
pub const key_small_uogonek = 0x03f9 // U+0173 LATIN SMALL LETTER U WITH OGONEK
pub const key_small_utilde = 0x03fd // U+0169 LATIN SMALL LETTER U WITH TILDE
pub const key_small_umacron = 0x03fe // U+016B LATIN SMALL LETTER U WITH MACRON

//
////* Latin 8
//
pub const key_wcircumflex = 0x1000174 // U+0174 LATIN CAPITAL LETTER W WITH CIRCUMFLEX
pub const key_small_wcircumflex = 0x1000175 // U+0175 LATIN SMALL LETTER W WITH CIRCUMFLEX
pub const key_ycircumflex = 0x1000176 // U+0176 LATIN CAPITAL LETTER Y WITH CIRCUMFLEX
pub const key_small_ycircumflex = 0x1000177 // U+0177 LATIN SMALL LETTER Y WITH CIRCUMFLEX
pub const key_babovedot = 0x1001e02 // U+1E02 LATIN CAPITAL LETTER B WITH DOT ABOVE
pub const key_small_babovedot = 0x1001e03 // U+1E03 LATIN SMALL LETTER B WITH DOT ABOVE
pub const key_dabovedot = 0x1001e0a // U+1E0A LATIN CAPITAL LETTER D WITH DOT ABOVE
pub const key_small_dabovedot = 0x1001e0b // U+1E0B LATIN SMALL LETTER D WITH DOT ABOVE
pub const key_fabovedot = 0x1001e1e // U+1E1E LATIN CAPITAL LETTER F WITH DOT ABOVE
pub const key_small_fabovedot = 0x1001e1f // U+1E1F LATIN SMALL LETTER F WITH DOT ABOVE
pub const key_mabovedot = 0x1001e40 // U+1E40 LATIN CAPITAL LETTER M WITH DOT ABOVE
pub const key_small_mabovedot = 0x1001e41 // U+1E41 LATIN SMALL LETTER M WITH DOT ABOVE
pub const key_pabovedot = 0x1001e56 // U+1E56 LATIN CAPITAL LETTER P WITH DOT ABOVE
pub const key_small_pabovedot = 0x1001e57 // U+1E57 LATIN SMALL LETTER P WITH DOT ABOVE
pub const key_sabovedot = 0x1001e60 // U+1E60 LATIN CAPITAL LETTER S WITH DOT ABOVE
pub const key_small_sabovedot = 0x1001e61 // U+1E61 LATIN SMALL LETTER S WITH DOT ABOVE
pub const key_tabovedot = 0x1001e6a // U+1E6A LATIN CAPITAL LETTER T WITH DOT ABOVE
pub const key_small_tabovedot = 0x1001e6b // U+1E6B LATIN SMALL LETTER T WITH DOT ABOVE
pub const key_wgrave = 0x1001e80 // U+1E80 LATIN CAPITAL LETTER W WITH GRAVE
pub const key_small_wgrave = 0x1001e81 // U+1E81 LATIN SMALL LETTER W WITH GRAVE
pub const key_wacute = 0x1001e82 // U+1E82 LATIN CAPITAL LETTER W WITH ACUTE
pub const key_small_wacute = 0x1001e83 // U+1E83 LATIN SMALL LETTER W WITH ACUTE
pub const key_wdiaeresis = 0x1001e84 // U+1E84 LATIN CAPITAL LETTER W WITH DIAERESIS
pub const key_small_wdiaeresis = 0x1001e85 // U+1E85 LATIN SMALL LETTER W WITH DIAERESIS
pub const key_ygrave = 0x1001ef2 // U+1EF2 LATIN CAPITAL LETTER Y WITH GRAVE
pub const key_small_ygrave = 0x1001ef3 // U+1EF3 LATIN SMALL LETTER Y WITH GRAVE

//
////* Latin 9
////* Byte 3 = := 0x13
//

pub const key_oe = 0x13bc // U+0152 LATIN CAPITAL LIGATURE OE
pub const key_small_oe = 0x13bd // U+0153 LATIN SMALL LIGATURE OE
pub const key_ydiaeresis = 0x13be // U+0178 LATIN CAPITAL LETTER Y WITH DIAERESIS

//
////* Katakana
////* Byte 3 = 4
//

pub const key_overline = 0x047e // U+203E OVERLINE
pub const key_kana_fullstop = 0x04a1 // U+3002 IDEOGRAPHIC FULL STOP
pub const key_kana_openingbracket = 0x04a2 // U+300C LEFT CORNER BRACKET
pub const key_kana_closingbracket = 0x04a3 // U+300D RIGHT CORNER BRACKET
pub const key_kana_comma = 0x04a4 // U+3001 IDEOGRAPHIC COMMA
pub const key_kana_conjunctive = 0x04a5 // U+30FB KATAKANA MIDDLE DOT

@[deprecated]
pub const key_kana_middledot = 0x04a5 // deprecated
pub const key_kana_wo = 0x04a6 // U+30F2 KATAKANA LETTER WO
pub const key_kana_small_a = 0x04a7 // U+30A1 KATAKANA LETTER SMALL A
pub const key_kana_small_i = 0x04a8 // U+30A3 KATAKANA LETTER SMALL I
pub const key_kana_small_u = 0x04a9 // U+30A5 KATAKANA LETTER SMALL U
pub const key_kana_small_e = 0x04aa // U+30A7 KATAKANA LETTER SMALL E
pub const key_kana_small_o = 0x04ab // U+30A9 KATAKANA LETTER SMALL O
pub const key_kana_small_ya = 0x04ac // U+30E3 KATAKANA LETTER SMALL YA
pub const key_kana_small_yu = 0x04ad // U+30E5 KATAKANA LETTER SMALL YU
pub const key_kana_small_yo = 0x04ae // U+30E7 KATAKANA LETTER SMALL YO
pub const key_kana_small_tsu = 0x04af // U+30C3 KATAKANA LETTER SMALL TU

@[deprecated]
pub const key_kana_tu = 0x04af // deprecated
pub const key_prolongedsound = 0x04b0 // U+30FC KATAKANA-HIRAGANA PROLONGED SOUND MARK
pub const key_kana_a = 0x04b1 // U+30A2 KATAKANA LETTER A
pub const key_kana_i = 0x04b2 // U+30A4 KATAKANA LETTER I
pub const key_kana_u = 0x04b3 // U+30A6 KATAKANA LETTER U
pub const key_kana_e = 0x04b4 // U+30A8 KATAKANA LETTER E
pub const key_kana_o = 0x04b5 // U+30AA KATAKANA LETTER O
pub const key_kana_ka = 0x04b6 // U+30AB KATAKANA LETTER KA
pub const key_kana_ki = 0x04b7 // U+30AD KATAKANA LETTER KI
pub const key_kana_ku = 0x04b8 // U+30AF KATAKANA LETTER KU
pub const key_kana_ke = 0x04b9 // U+30B1 KATAKANA LETTER KE
pub const key_kana_ko = 0x04ba // U+30B3 KATAKANA LETTER KO
pub const key_kana_sa = 0x04bb // U+30B5 KATAKANA LETTER SA
pub const key_kana_shi = 0x04bc // U+30B7 KATAKANA LETTER SI
pub const key_kana_su = 0x04bd // U+30B9 KATAKANA LETTER SU
pub const key_kana_se = 0x04be // U+30BB KATAKANA LETTER SE
pub const key_kana_so = 0x04bf // U+30BD KATAKANA LETTER SO
pub const key_kana_ta = 0x04c0 // U+30BF KATAKANA LETTER TA
pub const key_kana_chi = 0x04c1 // U+30C1 KATAKANA LETTER TI

@[deprecated]
pub const key_kana_ti = 0x04c1 // deprecated
pub const key_kana_tsu = 0x04c2 // U+30C4 KATAKANA LETTER TU

@[deprecated]
pub const key_kana__small_tu = 0x04c2 // deprecated
pub const key_kana_te = 0x04c3 // U+30C6 KATAKANA LETTER TE
pub const key_kana_to = 0x04c4 // U+30C8 KATAKANA LETTER TO
pub const key_kana_na = 0x04c5 // U+30CA KATAKANA LETTER NA
pub const key_kana_ni = 0x04c6 // U+30CB KATAKANA LETTER NI
pub const key_kana_nu = 0x04c7 // U+30CC KATAKANA LETTER NU
pub const key_kana_ne = 0x04c8 // U+30CD KATAKANA LETTER NE
pub const key_kana_no = 0x04c9 // U+30CE KATAKANA LETTER NO
pub const key_kana_ha = 0x04ca // U+30CF KATAKANA LETTER HA
pub const key_kana_hi = 0x04cb // U+30D2 KATAKANA LETTER HI
pub const key_kana_fu = 0x04cc // U+30D5 KATAKANA LETTER HU
pub const key_kana_hu = 0x04cc // deprecated
pub const key_kana_he = 0x04cd // U+30D8 KATAKANA LETTER HE
pub const key_kana_ho = 0x04ce // U+30DB KATAKANA LETTER HO
pub const key_kana_ma = 0x04cf // U+30DE KATAKANA LETTER MA
pub const key_kana_mi = 0x04d0 // U+30DF KATAKANA LETTER MI
pub const key_kana_mu = 0x04d1 // U+30E0 KATAKANA LETTER MU
pub const key_kana_me = 0x04d2 // U+30E1 KATAKANA LETTER ME
pub const key_kana_mo = 0x04d3 // U+30E2 KATAKANA LETTER MO
pub const key_kana_ya = 0x04d4 // U+30E4 KATAKANA LETTER YA
pub const key_kana_yu = 0x04d5 // U+30E6 KATAKANA LETTER YU
pub const key_kana_yo = 0x04d6 // U+30E8 KATAKANA LETTER YO
pub const key_kana_ra = 0x04d7 // U+30E9 KATAKANA LETTER RA
pub const key_kana_ri = 0x04d8 // U+30EA KATAKANA LETTER RI
pub const key_kana_ru = 0x04d9 // U+30EB KATAKANA LETTER RU
pub const key_kana_re = 0x04da // U+30EC KATAKANA LETTER RE
pub const key_kana_ro = 0x04db // U+30ED KATAKANA LETTER RO
pub const key_kana_wa = 0x04dc // U+30EF KATAKANA LETTER WA
pub const key_kana_n = 0x04dd // U+30F3 KATAKANA LETTER N
pub const key_voicedsound = 0x04de // U+309B KATAKANA-HIRAGANA VOICED SOUND MARK
pub const key_semivoicedsound = 0x04df // U+309C KATAKANA-HIRAGANA SEMI-VOICED SOUND MARK
pub const key_kana_switch = 0xff7e // non-deprecated alias for Mode_switch

//
////* Arabic
////* Byte 3 = 5
//

pub const key_farsi_0 = 0x10006f0 // U+06F0 EXTENDED ARABIC-INDIC DIGIT ZERO
pub const key_farsi_1 = 0x10006f1 // U+06F1 EXTENDED ARABIC-INDIC DIGIT ONE
pub const key_farsi_2 = 0x10006f2 // U+06F2 EXTENDED ARABIC-INDIC DIGIT TWO
pub const key_farsi_3 = 0x10006f3 // U+06F3 EXTENDED ARABIC-INDIC DIGIT THREE
pub const key_farsi_4 = 0x10006f4 // U+06F4 EXTENDED ARABIC-INDIC DIGIT FOUR
pub const key_farsi_5 = 0x10006f5 // U+06F5 EXTENDED ARABIC-INDIC DIGIT FIVE
pub const key_farsi_6 = 0x10006f6 // U+06F6 EXTENDED ARABIC-INDIC DIGIT SIX
pub const key_farsi_7 = 0x10006f7 // U+06F7 EXTENDED ARABIC-INDIC DIGIT SEVEN
pub const key_farsi_8 = 0x10006f8 // U+06F8 EXTENDED ARABIC-INDIC DIGIT EIGHT
pub const key_farsi_9 = 0x10006f9 // U+06F9 EXTENDED ARABIC-INDIC DIGIT NINE
pub const key_arabic_percent = 0x100066a // U+066A ARABIC PERCENT SIGN
pub const key_arabic_superscript_alef = 0x1000670 // U+0670 ARABIC LETTER SUPERSCRIPT ALEF
pub const key_arabic_tteh = 0x1000679 // U+0679 ARABIC LETTER TTEH
pub const key_arabic_peh = 0x100067e // U+067E ARABIC LETTER PEH
pub const key_arabic_tcheh = 0x1000686 // U+0686 ARABIC LETTER TCHEH
pub const key_arabic_ddal = 0x1000688 // U+0688 ARABIC LETTER DDAL
pub const key_arabic_rreh = 0x1000691 // U+0691 ARABIC LETTER RREH
pub const key_arabic_comma = 0x05ac // U+060C ARABIC COMMA
pub const key_arabic_fullstop = 0x10006d4 // U+06D4 ARABIC FULL STOP
pub const key_arabic_0 = 0x1000660 // U+0660 ARABIC-INDIC DIGIT ZERO
pub const key_arabic_1 = 0x1000661 // U+0661 ARABIC-INDIC DIGIT ONE
pub const key_arabic_2 = 0x1000662 // U+0662 ARABIC-INDIC DIGIT TWO
pub const key_arabic_3 = 0x1000663 // U+0663 ARABIC-INDIC DIGIT THREE
pub const key_arabic_4 = 0x1000664 // U+0664 ARABIC-INDIC DIGIT FOUR
pub const key_arabic_5 = 0x1000665 // U+0665 ARABIC-INDIC DIGIT FIVE
pub const key_arabic_6 = 0x1000666 // U+0666 ARABIC-INDIC DIGIT SIX
pub const key_arabic_7 = 0x1000667 // U+0667 ARABIC-INDIC DIGIT SEVEN
pub const key_arabic_8 = 0x1000668 // U+0668 ARABIC-INDIC DIGIT EIGHT
pub const key_arabic_9 = 0x1000669 // U+0669 ARABIC-INDIC DIGIT NINE
pub const key_arabic_semicolon = 0x05bb // U+061B ARABIC SEMICOLON
pub const key_arabic_question_mark = 0x05bf // U+061F ARABIC QUESTION MARK
pub const key_arabic_hamza = 0x05c1 // U+0621 ARABIC LETTER HAMZA
pub const key_arabic_maddaonalef = 0x05c2 // U+0622 ARABIC LETTER ALEF WITH MADDA ABOVE
pub const key_arabic_hamzaonalef = 0x05c3 // U+0623 ARABIC LETTER ALEF WITH HAMZA ABOVE
pub const key_arabic_hamzaonwaw = 0x05c4 // U+0624 ARABIC LETTER WAW WITH HAMZA ABOVE
pub const key_arabic_hamzaunderalef = 0x05c5 // U+0625 ARABIC LETTER ALEF WITH HAMZA BELOW
pub const key_arabic_hamzaonyeh = 0x05c6 // U+0626 ARABIC LETTER YEH WITH HAMZA ABOVE
pub const key_arabic_alef = 0x05c7 // U+0627 ARABIC LETTER ALEF
pub const key_arabic_beh = 0x05c8 // U+0628 ARABIC LETTER BEH
pub const key_arabic_tehmarbuta = 0x05c9 // U+0629 ARABIC LETTER TEH MARBUTA
pub const key_arabic_teh = 0x05ca // U+062A ARABIC LETTER TEH
pub const key_arabic_theh = 0x05cb // U+062B ARABIC LETTER THEH
pub const key_arabic_jeem = 0x05cc // U+062C ARABIC LETTER JEEM
pub const key_arabic_hah = 0x05cd // U+062D ARABIC LETTER HAH
pub const key_arabic_khah = 0x05ce // U+062E ARABIC LETTER KHAH
pub const key_arabic_dal = 0x05cf // U+062F ARABIC LETTER DAL
pub const key_arabic_thal = 0x05d0 // U+0630 ARABIC LETTER THAL
pub const key_arabic_ra = 0x05d1 // U+0631 ARABIC LETTER REH
pub const key_arabic_zain = 0x05d2 // U+0632 ARABIC LETTER ZAIN
pub const key_arabic_seen = 0x05d3 // U+0633 ARABIC LETTER SEEN
pub const key_arabic_sheen = 0x05d4 // U+0634 ARABIC LETTER SHEEN
pub const key_arabic_sad = 0x05d5 // U+0635 ARABIC LETTER SAD
pub const key_arabic_dad = 0x05d6 // U+0636 ARABIC LETTER DAD
pub const key_arabic_tah = 0x05d7 // U+0637 ARABIC LETTER TAH
pub const key_arabic_zah = 0x05d8 // U+0638 ARABIC LETTER ZAH
pub const key_arabic_ain = 0x05d9 // U+0639 ARABIC LETTER AIN
pub const key_arabic_ghain = 0x05da // U+063A ARABIC LETTER GHAIN
pub const key_arabic_tatweel = 0x05e0 // U+0640 ARABIC TATWEEL
pub const key_arabic_feh = 0x05e1 // U+0641 ARABIC LETTER FEH
pub const key_arabic_qaf = 0x05e2 // U+0642 ARABIC LETTER QAF
pub const key_arabic_kaf = 0x05e3 // U+0643 ARABIC LETTER KAF
pub const key_arabic_lam = 0x05e4 // U+0644 ARABIC LETTER LAM
pub const key_arabic_meem = 0x05e5 // U+0645 ARABIC LETTER MEEM
pub const key_arabic_noon = 0x05e6 // U+0646 ARABIC LETTER NOON
pub const key_arabic_ha = 0x05e7 // U+0647 ARABIC LETTER HEH
pub const key_arabic_heh = 0x05e7 // deprecated
pub const key_arabic_waw = 0x05e8 // U+0648 ARABIC LETTER WAW
pub const key_arabic_alefmaksura = 0x05e9 // U+0649 ARABIC LETTER ALEF MAKSURA
pub const key_arabic_yeh = 0x05ea // U+064A ARABIC LETTER YEH
pub const key_arabic_fathatan = 0x05eb // U+064B ARABIC FATHATAN
pub const key_arabic_dammatan = 0x05ec // U+064C ARABIC DAMMATAN
pub const key_arabic_kasratan = 0x05ed // U+064D ARABIC KASRATAN
pub const key_arabic_fatha = 0x05ee // U+064E ARABIC FATHA
pub const key_arabic_damma = 0x05ef // U+064F ARABIC DAMMA
pub const key_arabic_kasra = 0x05f0 // U+0650 ARABIC KASRA
pub const key_arabic_shadda = 0x05f1 // U+0651 ARABIC SHADDA
pub const key_arabic_sukun = 0x05f2 // U+0652 ARABIC SUKUN
pub const key_arabic_madda_above = 0x1000653 // U+0653 ARABIC MADDAH ABOVE
pub const key_arabic_hamza_above = 0x1000654 // U+0654 ARABIC HAMZA ABOVE
pub const key_arabic_hamza_below = 0x1000655 // U+0655 ARABIC HAMZA BELOW
pub const key_arabic_jeh = 0x1000698 // U+0698 ARABIC LETTER JEH
pub const key_arabic_veh = 0x10006a4 // U+06A4 ARABIC LETTER VEH
pub const key_arabic_keheh = 0x10006a9 // U+06A9 ARABIC LETTER KEHEH
pub const key_arabic_gaf = 0x10006af // U+06AF ARABIC LETTER GAF
pub const key_arabic_noon_ghunna = 0x10006ba // U+06BA ARABIC LETTER NOON GHUNNA
pub const key_arabic_heh_doachashmee = 0x10006be // U+06BE ARABIC LETTER HEH DOACHASHMEE
pub const key_farsi_yeh = 0x10006cc // U+06CC ARABIC LETTER FARSI YEH
pub const key_arabic_farsi_yeh = 0x10006cc // deprecated alias for Farsi_yeh
pub const key_arabic_yeh_baree = 0x10006d2 // U+06D2 ARABIC LETTER YEH BARREE
pub const key_arabic_heh_goal = 0x10006c1 // U+06C1 ARABIC LETTER HEH GOAL
pub const key_arabic_switch = 0xff7e // non-deprecated alias for Mode_switch

//
////* Cyrillic
////* Byte 3 = 6
//

pub const key_cyrillic_ghe_bar = 0x1000492 // U+0492 CYRILLIC CAPITAL LETTER GHE WITH STROKE
pub const key_cyrillic_small_ghe_bar = 0x1000493 // U+0493 CYRILLIC SMALL LETTER GHE WITH STROKE
pub const key_cyrillic_zhe_descender = 0x1000496 // U+0496 CYRILLIC CAPITAL LETTER ZHE WITH DESCENDER
pub const key_cyrillic_small_zhe_descender = 0x1000497 // U+0497 CYRILLIC SMALL LETTER ZHE WITH DESCENDER
pub const key_cyrillic_ka_descender = 0x100049a // U+049A CYRILLIC CAPITAL LETTER KA WITH DESCENDER
pub const key_cyrillic_small_ka_descender = 0x100049b // U+049B CYRILLIC SMALL LETTER KA WITH DESCENDER
pub const key_cyrillic_ka_vertstroke = 0x100049c // U+049C CYRILLIC CAPITAL LETTER KA WITH VERTICAL STROKE
pub const key_cyrillic_small_ka_vertstroke = 0x100049d // U+049D CYRILLIC SMALL LETTER KA WITH VERTICAL STROKE
pub const key_cyrillic_en_descender = 0x10004a2 // U+04A2 CYRILLIC CAPITAL LETTER EN WITH DESCENDER
pub const key_cyrillic_small_en_descender = 0x10004a3 // U+04A3 CYRILLIC SMALL LETTER EN WITH DESCENDER
pub const key_cyrillic_u_straight = 0x10004ae // U+04AE CYRILLIC CAPITAL LETTER STRAIGHT U
pub const key_cyrillic_small_u_straight = 0x10004af // U+04AF CYRILLIC SMALL LETTER STRAIGHT U
pub const key_cyrillic_u_straight_bar = 0x10004b0 // U+04B0 CYRILLIC CAPITAL LETTER STRAIGHT U WITH STROKE
pub const key_cyrillic_small_u_straight_bar = 0x10004b1 // U+04B1 CYRILLIC SMALL LETTER STRAIGHT U WITH STROKE
pub const key_cyrillic_ha_descender = 0x10004b2 // U+04B2 CYRILLIC CAPITAL LETTER HA WITH DESCENDER
pub const key_cyrillic_small_ha_descender = 0x10004b3 // U+04B3 CYRILLIC SMALL LETTER HA WITH DESCENDER
pub const key_cyrillic_che_descender = 0x10004b6 // U+04B6 CYRILLIC CAPITAL LETTER CHE WITH DESCENDER
pub const key_cyrillic_small_che_descender = 0x10004b7 // U+04B7 CYRILLIC SMALL LETTER CHE WITH DESCENDER
pub const key_cyrillic_che_vertstroke = 0x10004b8 // U+04B8 CYRILLIC CAPITAL LETTER CHE WITH VERTICAL STROKE
pub const key_cyrillic_small_che_vertstroke = 0x10004b9 // U+04B9 CYRILLIC SMALL LETTER CHE WITH VERTICAL STROKE
pub const key_cyrillic_shha = 0x10004ba // U+04BA CYRILLIC CAPITAL LETTER SHHA
pub const key_cyrillic_small_shha = 0x10004bb // U+04BB CYRILLIC SMALL LETTER SHHA

pub const key_cyrillic_schwa = 0x10004d8 // U+04D8 CYRILLIC CAPITAL LETTER SCHWA
pub const key_cyrillic_small_schwa = 0x10004d9 // U+04D9 CYRILLIC SMALL LETTER SCHWA
pub const key_cyrillic_i_macron = 0x10004e2 // U+04E2 CYRILLIC CAPITAL LETTER I WITH MACRON
pub const key_cyrillic_small_i_macron = 0x10004e3 // U+04E3 CYRILLIC SMALL LETTER I WITH MACRON
pub const key_cyrillic_o_bar = 0x10004e8 // U+04E8 CYRILLIC CAPITAL LETTER BARRED O
pub const key_cyrillic_small_o_bar = 0x10004e9 // U+04E9 CYRILLIC SMALL LETTER BARRED O
pub const key_cyrillic_u_macron = 0x10004ee // U+04EE CYRILLIC CAPITAL LETTER U WITH MACRON
pub const key_cyrillic_small_u_macron = 0x10004ef // U+04EF CYRILLIC SMALL LETTER U WITH MACRON

pub const key_serbian_small_dje = 0x06a1 // U+0452 CYRILLIC SMALL LETTER DJE
pub const key_macedonia_small_gje = 0x06a2 // U+0453 CYRILLIC SMALL LETTER GJE
pub const key_cyrillic_small_io = 0x06a3 // U+0451 CYRILLIC SMALL LETTER IO
pub const key_ukrainian_small_ie = 0x06a4 // U+0454 CYRILLIC SMALL LETTER UKRAINIAN IE
pub const key_ukranian_small_je = 0x06a4 // deprecated
pub const key_macedonia_small_dse = 0x06a5 // U+0455 CYRILLIC SMALL LETTER DZE
pub const key_ukrainian_small_i = 0x06a6 // U+0456 CYRILLIC SMALL LETTER BYELORUSSIAN-UKRAINIAN I
pub const key_ukranian_small_i = 0x06a6 // deprecated
pub const key_ukrainian_small_yi = 0x06a7 // U+0457 CYRILLIC SMALL LETTER YI
pub const key_ukranian_small_yi = 0x06a7 // deprecated
pub const key_cyrillic_small_je = 0x06a8 // U+0458 CYRILLIC SMALL LETTER JE
pub const key_serbian_small_je = 0x06a8 // deprecated
pub const key_cyrillic_small_lje = 0x06a9 // U+0459 CYRILLIC SMALL LETTER LJE
pub const key_serbian_small_lje = 0x06a9 // deprecated
pub const key_cyrillic_small_nje = 0x06aa // U+045A CYRILLIC SMALL LETTER NJE
pub const key_serbian_small_nje = 0x06aa // deprecated
pub const key_serbian_small_tshe = 0x06ab // U+045B CYRILLIC SMALL LETTER TSHE
pub const key_macedonia_small_kje = 0x06ac // U+045C CYRILLIC SMALL LETTER KJE
pub const key_ukrainian_small_ghe_with_upturn = 0x06ad // U+0491 CYRILLIC SMALL LETTER GHE WITH UPTURN
pub const key_byelorussian_small_shortu = 0x06ae // U+045E CYRILLIC SMALL LETTER SHORT U
pub const key_cyrillic_small_dzhe = 0x06af // U+045F CYRILLIC SMALL LETTER DZHE

@[deprecated]
pub const key_serbian_dze = 0x06af // deprecated
pub const key_numerosign = 0x06b0 // U+2116 NUMERO SIGN
pub const key_serbian_dje = 0x06b1 // U+0402 CYRILLIC CAPITAL LETTER DJE
pub const key_macedonia_gje = 0x06b2 // U+0403 CYRILLIC CAPITAL LETTER GJE
pub const key_cyrillic_io = 0x06b3 // U+0401 CYRILLIC CAPITAL LETTER IO
pub const key_ukrainian_ie = 0x06b4 // U+0404 CYRILLIC CAPITAL LETTER UKRAINIAN IE

@[deprecated]
pub const key_ukranian_je = 0x06b4 // deprecated
pub const key_macedonia_dse = 0x06b5 // U+0405 CYRILLIC CAPITAL LETTER DZE
pub const key_ukrainian_i = 0x06b6 // U+0406 CYRILLIC CAPITAL LETTER BYELORUSSIAN-UKRAINIAN I

@[deprecated]
pub const key_ukranian_i = 0x06b6 // deprecated
pub const key_ukrainian_yi = 0x06b7 // U+0407 CYRILLIC CAPITAL LETTER YI

@[deprecated]
pub const key_ukranian_yi = 0x06b7 // deprecated
pub const key_cyrillic_je = 0x06b8 // U+0408 CYRILLIC CAPITAL LETTER JE

@[deprecated]
pub const key_serbian_je = 0x06b8 // deprecated
pub const key_cyrillic_lje = 0x06b9 // U+0409 CYRILLIC CAPITAL LETTER LJE

@[deprecated]
pub const key_serbian_lje = 0x06b9 // deprecated
pub const key_cyrillic_nje = 0x06ba // U+040A CYRILLIC CAPITAL LETTER NJE

@[deprecated]
pub const key_serbian_nje = 0x06ba // deprecated
pub const key_serbian_tshe = 0x06bb // U+040B CYRILLIC CAPITAL LETTER TSHE
pub const key_macedonia_kje = 0x06bc // U+040C CYRILLIC CAPITAL LETTER KJE
pub const key_ukrainian_ghe_with_upturn = 0x06bd // U+0490 CYRILLIC CAPITAL LETTER GHE WITH UPTURN
pub const key_byelorussian_shortu = 0x06be // U+040E CYRILLIC CAPITAL LETTER SHORT U
pub const key_cyrillic_dzhe = 0x06bf // U+040F CYRILLIC CAPITAL LETTER DZHE

@[deprecated]
pub const key_serbian_small_dze = 0x06bf // deprecated
pub const key_cyrillic_small_yu = 0x06c0 // U+044E CYRILLIC SMALL LETTER YU
pub const key_cyrillic_small_a = 0x06c1 // U+0430 CYRILLIC SMALL LETTER A
pub const key_cyrillic_small_be = 0x06c2 // U+0431 CYRILLIC SMALL LETTER BE
pub const key_cyrillic_small_tse = 0x06c3 // U+0446 CYRILLIC SMALL LETTER TSE
pub const key_cyrillic_small_de = 0x06c4 // U+0434 CYRILLIC SMALL LETTER DE
pub const key_cyrillic_small_ie = 0x06c5 // U+0435 CYRILLIC SMALL LETTER IE
pub const key_cyrillic_small_ef = 0x06c6 // U+0444 CYRILLIC SMALL LETTER EF
pub const key_cyrillic_small_ghe = 0x06c7 // U+0433 CYRILLIC SMALL LETTER GHE
pub const key_cyrillic_small_ha = 0x06c8 // U+0445 CYRILLIC SMALL LETTER HA
pub const key_cyrillic_small_i = 0x06c9 // U+0438 CYRILLIC SMALL LETTER I
pub const key_cyrillic_small_shorti = 0x06ca // U+0439 CYRILLIC SMALL LETTER SHORT I
pub const key_cyrillic_small_ka = 0x06cb // U+043A CYRILLIC SMALL LETTER KA
pub const key_cyrillic_small_el = 0x06cc // U+043B CYRILLIC SMALL LETTER EL
pub const key_cyrillic_small_em = 0x06cd // U+043C CYRILLIC SMALL LETTER EM
pub const key_cyrillic_small_en = 0x06ce // U+043D CYRILLIC SMALL LETTER EN
pub const key_cyrillic_small_o = 0x06cf // U+043E CYRILLIC SMALL LETTER O
pub const key_cyrillic_small_pe = 0x06d0 // U+043F CYRILLIC SMALL LETTER PE
pub const key_cyrillic_small_ya = 0x06d1 // U+044F CYRILLIC SMALL LETTER YA
pub const key_cyrillic_small_er = 0x06d2 // U+0440 CYRILLIC SMALL LETTER ER
pub const key_cyrillic_small_es = 0x06d3 // U+0441 CYRILLIC SMALL LETTER ES
pub const key_cyrillic_small_te = 0x06d4 // U+0442 CYRILLIC SMALL LETTER TE
pub const key_cyrillic_small_u = 0x06d5 // U+0443 CYRILLIC SMALL LETTER U
pub const key_cyrillic_small_zhe = 0x06d6 // U+0436 CYRILLIC SMALL LETTER ZHE
pub const key_cyrillic_small_ve = 0x06d7 // U+0432 CYRILLIC SMALL LETTER VE
pub const key_cyrillic_small_softsign = 0x06d8 // U+044C CYRILLIC SMALL LETTER SOFT SIGN
pub const key_cyrillic_small_yeru = 0x06d9 // U+044B CYRILLIC SMALL LETTER YERU
pub const key_cyrillic_small_ze = 0x06da // U+0437 CYRILLIC SMALL LETTER ZE
pub const key_cyrillic_small_sha = 0x06db // U+0448 CYRILLIC SMALL LETTER SHA
pub const key_cyrillic_small_e = 0x06dc // U+044D CYRILLIC SMALL LETTER E
pub const key_cyrillic_small_shcha = 0x06dd // U+0449 CYRILLIC SMALL LETTER SHCHA
pub const key_cyrillic_small_che = 0x06de // U+0447 CYRILLIC SMALL LETTER CHE
pub const key_cyrillic_small_hardsign = 0x06df // U+044A CYRILLIC SMALL LETTER HARD SIGN
pub const key_cyrillic_yu = 0x06e0 // U+042E CYRILLIC CAPITAL LETTER YU
pub const key_cyrillic_a = 0x06e1 // U+0410 CYRILLIC CAPITAL LETTER A
pub const key_cyrillic_be = 0x06e2 // U+0411 CYRILLIC CAPITAL LETTER BE
pub const key_cyrillic_tse = 0x06e3 // U+0426 CYRILLIC CAPITAL LETTER TSE
pub const key_cyrillic_de = 0x06e4 // U+0414 CYRILLIC CAPITAL LETTER DE
pub const key_cyrillic_ie = 0x06e5 // U+0415 CYRILLIC CAPITAL LETTER IE
pub const key_cyrillic_ef = 0x06e6 // U+0424 CYRILLIC CAPITAL LETTER EF
pub const key_cyrillic_ghe = 0x06e7 // U+0413 CYRILLIC CAPITAL LETTER GHE
pub const key_cyrillic_ha = 0x06e8 // U+0425 CYRILLIC CAPITAL LETTER HA
pub const key_cyrillic_i = 0x06e9 // U+0418 CYRILLIC CAPITAL LETTER I
pub const key_cyrillic_shorti = 0x06ea // U+0419 CYRILLIC CAPITAL LETTER SHORT I
pub const key_cyrillic_ka = 0x06eb // U+041A CYRILLIC CAPITAL LETTER KA
pub const key_cyrillic_el = 0x06ec // U+041B CYRILLIC CAPITAL LETTER EL
pub const key_cyrillic_em = 0x06ed // U+041C CYRILLIC CAPITAL LETTER EM
pub const key_cyrillic_en = 0x06ee // U+041D CYRILLIC CAPITAL LETTER EN
pub const key_cyrillic_o = 0x06ef // U+041E CYRILLIC CAPITAL LETTER O
pub const key_cyrillic_pe = 0x06f0 // U+041F CYRILLIC CAPITAL LETTER PE
pub const key_cyrillic_ya = 0x06f1 // U+042F CYRILLIC CAPITAL LETTER YA
pub const key_cyrillic_er = 0x06f2 // U+0420 CYRILLIC CAPITAL LETTER ER
pub const key_cyrillic_es = 0x06f3 // U+0421 CYRILLIC CAPITAL LETTER ES
pub const key_cyrillic_te = 0x06f4 // U+0422 CYRILLIC CAPITAL LETTER TE
pub const key_cyrillic_u = 0x06f5 // U+0423 CYRILLIC CAPITAL LETTER U
pub const key_cyrillic_zhe = 0x06f6 // U+0416 CYRILLIC CAPITAL LETTER ZHE
pub const key_cyrillic_ve = 0x06f7 // U+0412 CYRILLIC CAPITAL LETTER VE
pub const key_cyrillic_softsign = 0x06f8 // U+042C CYRILLIC CAPITAL LETTER SOFT SIGN
pub const key_cyrillic_yeru = 0x06f9 // U+042B CYRILLIC CAPITAL LETTER YERU
pub const key_cyrillic_ze = 0x06fa // U+0417 CYRILLIC CAPITAL LETTER ZE
pub const key_cyrillic_sha = 0x06fb // U+0428 CYRILLIC CAPITAL LETTER SHA
pub const key_cyrillic_e = 0x06fc // U+042D CYRILLIC CAPITAL LETTER E
pub const key_cyrillic_shcha = 0x06fd // U+0429 CYRILLIC CAPITAL LETTER SHCHA
pub const key_cyrillic_che = 0x06fe // U+0427 CYRILLIC CAPITAL LETTER CHE
pub const key_cyrillic_hardsign = 0x06ff // U+042A CYRILLIC CAPITAL LETTER HARD SIGN

//
////* Greek
////* (based on an early draft of, and not quite identical to, ISO/IEC 8859-7)
////* Byte 3 = 7
//

pub const key_greek_alphaaccent = 0x07a1 // U+0386 GREEK CAPITAL LETTER ALPHA WITH TONOS
pub const key_greek_epsilonaccent = 0x07a2 // U+0388 GREEK CAPITAL LETTER EPSILON WITH TONOS
pub const key_greek_etaaccent = 0x07a3 // U+0389 GREEK CAPITAL LETTER ETA WITH TONOS
pub const key_greek_iotaaccent = 0x07a4 // U+038A GREEK CAPITAL LETTER IOTA WITH TONOS
pub const key_greek_iotadieresis = 0x07a5 // U+03AA GREEK CAPITAL LETTER IOTA WITH DIALYTIKA
pub const key_greek_iotadiaeresis = 0x07a5 // deprecated (old typo)
pub const key_greek_omicronaccent = 0x07a7 // U+038C GREEK CAPITAL LETTER OMICRON WITH TONOS
pub const key_greek_upsilonaccent = 0x07a8 // U+038E GREEK CAPITAL LETTER UPSILON WITH TONOS
pub const key_greek_upsilondieresis = 0x07a9 // U+03AB GREEK CAPITAL LETTER UPSILON WITH DIALYTIKA
pub const key_greek_omegaaccent = 0x07ab // U+038F GREEK CAPITAL LETTER OMEGA WITH TONOS
pub const key_greek_accentdieresis = 0x07ae // U+0385 GREEK DIALYTIKA TONOS
pub const key_greek_horizbar = 0x07af // U+2015 HORIZONTAL BAR
pub const key_greek_small_alphaaccent = 0x07b1 // U+03AC GREEK SMALL LETTER ALPHA WITH TONOS
pub const key_greek_small_epsilonaccent = 0x07b2 // U+03AD GREEK SMALL LETTER EPSILON WITH TONOS
pub const key_greek_small_etaaccent = 0x07b3 // U+03AE GREEK SMALL LETTER ETA WITH TONOS
pub const key_greek_small_iotaaccent = 0x07b4 // U+03AF GREEK SMALL LETTER IOTA WITH TONOS
pub const key_greek_small_iotadieresis = 0x07b5 // U+03CA GREEK SMALL LETTER IOTA WITH DIALYTIKA
pub const key_greek_small_iotaaccentdieresis = 0x07b6 // U+0390 GREEK SMALL LETTER IOTA WITH DIALYTIKA AND TONOS
pub const key_greek_small_omicronaccent = 0x07b7 // U+03CC GREEK SMALL LETTER OMICRON WITH TONOS
pub const key_greek_small_upsilonaccent = 0x07b8 // U+03CD GREEK SMALL LETTER UPSILON WITH TONOS
pub const key_greek_small_upsilondieresis = 0x07b9 // U+03CB GREEK SMALL LETTER UPSILON WITH DIALYTIKA
pub const key_greek_small_upsilonaccentdieresis = 0x07ba // U+03B0 GREEK SMALL LETTER UPSILON WITH DIALYTIKA AND TONOS
pub const key_greek_small_omegaaccent = 0x07bb // U+03CE GREEK SMALL LETTER OMEGA WITH TONOS
pub const key_greek_alpha = 0x07c1 // U+0391 GREEK CAPITAL LETTER ALPHA
pub const key_greek_beta = 0x07c2 // U+0392 GREEK CAPITAL LETTER BETA
pub const key_greek_gamma = 0x07c3 // U+0393 GREEK CAPITAL LETTER GAMMA
pub const key_greek_delta = 0x07c4 // U+0394 GREEK CAPITAL LETTER DELTA
pub const key_greek_epsilon = 0x07c5 // U+0395 GREEK CAPITAL LETTER EPSILON
pub const key_greek_zeta = 0x07c6 // U+0396 GREEK CAPITAL LETTER ZETA
pub const key_greek_eta = 0x07c7 // U+0397 GREEK CAPITAL LETTER ETA
pub const key_greek_theta = 0x07c8 // U+0398 GREEK CAPITAL LETTER THETA
pub const key_greek_iota = 0x07c9 // U+0399 GREEK CAPITAL LETTER IOTA
pub const key_greek_kappa = 0x07ca // U+039A GREEK CAPITAL LETTER KAPPA
pub const key_greek_lamda = 0x07cb // U+039B GREEK CAPITAL LETTER LAMDA
pub const key_greek_lambda = 0x07cb // non-deprecated alias for Greek_LAMDA
pub const key_greek_mu = 0x07cc // U+039C GREEK CAPITAL LETTER MU
pub const key_greek_nu = 0x07cd // U+039D GREEK CAPITAL LETTER NU
pub const key_greek_xi = 0x07ce // U+039E GREEK CAPITAL LETTER XI
pub const key_greek_omicron = 0x07cf // U+039F GREEK CAPITAL LETTER OMICRON
pub const key_greek_pi = 0x07d0 // U+03A0 GREEK CAPITAL LETTER PI
pub const key_greek_rho = 0x07d1 // U+03A1 GREEK CAPITAL LETTER RHO
pub const key_greek_sigma = 0x07d2 // U+03A3 GREEK CAPITAL LETTER SIGMA
pub const key_greek_tau = 0x07d4 // U+03A4 GREEK CAPITAL LETTER TAU
pub const key_greek_upsilon = 0x07d5 // U+03A5 GREEK CAPITAL LETTER UPSILON
pub const key_greek_phi = 0x07d6 // U+03A6 GREEK CAPITAL LETTER PHI
pub const key_greek_chi = 0x07d7 // U+03A7 GREEK CAPITAL LETTER CHI
pub const key_greek_psi = 0x07d8 // U+03A8 GREEK CAPITAL LETTER PSI
pub const key_greek_omega = 0x07d9 // U+03A9 GREEK CAPITAL LETTER OMEGA
pub const key_greek_small_alpha = 0x07e1 // U+03B1 GREEK SMALL LETTER ALPHA
pub const key_greek_small_beta = 0x07e2 // U+03B2 GREEK SMALL LETTER BETA
pub const key_greek_small_gamma = 0x07e3 // U+03B3 GREEK SMALL LETTER GAMMA
pub const key_greek_small_delta = 0x07e4 // U+03B4 GREEK SMALL LETTER DELTA
pub const key_greek_small_epsilon = 0x07e5 // U+03B5 GREEK SMALL LETTER EPSILON
pub const key_greek_small_zeta = 0x07e6 // U+03B6 GREEK SMALL LETTER ZETA
pub const key_greek_small_eta = 0x07e7 // U+03B7 GREEK SMALL LETTER ETA
pub const key_greek_small_theta = 0x07e8 // U+03B8 GREEK SMALL LETTER THETA
pub const key_greek_small_iota = 0x07e9 // U+03B9 GREEK SMALL LETTER IOTA
pub const key_greek_small_kappa = 0x07ea // U+03BA GREEK SMALL LETTER KAPPA
pub const key_greek_small_lamda = 0x07eb // U+03BB GREEK SMALL LETTER LAMDA
pub const key_greek_small_lambda = 0x07eb // non-deprecated alias for Greek_lamda
pub const key_greek_small_mu = 0x07ec // U+03BC GREEK SMALL LETTER MU
pub const key_greek_small_nu = 0x07ed // U+03BD GREEK SMALL LETTER NU
pub const key_greek_small_xi = 0x07ee // U+03BE GREEK SMALL LETTER XI
pub const key_greek_small_omicron = 0x07ef // U+03BF GREEK SMALL LETTER OMICRON
pub const key_greek_small_pi = 0x07f0 // U+03C0 GREEK SMALL LETTER PI
pub const key_greek_small_rho = 0x07f1 // U+03C1 GREEK SMALL LETTER RHO
pub const key_greek_small_sigma = 0x07f2 // U+03C3 GREEK SMALL LETTER SIGMA
pub const key_greek_small_finalsmallsigma = 0x07f3 // U+03C2 GREEK SMALL LETTER FINAL SIGMA
pub const key_greek_small_tau = 0x07f4 // U+03C4 GREEK SMALL LETTER TAU
pub const key_greek_small_upsilon = 0x07f5 // U+03C5 GREEK SMALL LETTER UPSILON
pub const key_greek_small_phi = 0x07f6 // U+03C6 GREEK SMALL LETTER PHI
pub const key_greek_small_chi = 0x07f7 // U+03C7 GREEK SMALL LETTER CHI
pub const key_greek_small_psi = 0x07f8 // U+03C8 GREEK SMALL LETTER PSI
pub const key_greek_small_omega = 0x07f9 // U+03C9 GREEK SMALL LETTER OMEGA
pub const key_greek_small_switch = 0xff7e // non-deprecated alias for Mode_switch

//
////* Technical
////* (from the DEC VT330/VT420 Technical Character Set, http://vt100.net/charsets/technical.html)
////* Byte 3 = 8
//

pub const key_leftradical = 0x08a1 // U+23B7 RADICAL SYMBOL BOTTOM
pub const key_topleftradical = 0x08a2 //(U+250C BOX DRAWINGS LIGHT DOWN AND RIGHT)
pub const key_horizconnector = 0x08a3 //(U+2500 BOX DRAWINGS LIGHT HORIZONTAL)
pub const key_topintegral = 0x08a4 // U+2320 TOP HALF INTEGRAL
pub const key_botintegral = 0x08a5 // U+2321 BOTTOM HALF INTEGRAL
pub const key_vertconnector = 0x08a6 //(U+2502 BOX DRAWINGS LIGHT VERTICAL)
pub const key_topleftsqbracket = 0x08a7 // U+23A1 LEFT SQUARE BRACKET UPPER CORNER
pub const key_botleftsqbracket = 0x08a8 // U+23A3 LEFT SQUARE BRACKET LOWER CORNER
pub const key_toprightsqbracket = 0x08a9 // U+23A4 RIGHT SQUARE BRACKET UPPER CORNER
pub const key_botrightsqbracket = 0x08aa // U+23A6 RIGHT SQUARE BRACKET LOWER CORNER
pub const key_topleftparens = 0x08ab // U+239B LEFT PARENTHESIS UPPER HOOK
pub const key_botleftparens = 0x08ac // U+239D LEFT PARENTHESIS LOWER HOOK
pub const key_toprightparens = 0x08ad // U+239E RIGHT PARENTHESIS UPPER HOOK
pub const key_botrightparens = 0x08ae // U+23A0 RIGHT PARENTHESIS LOWER HOOK
pub const key_leftmiddlecurlybrace = 0x08af // U+23A8 LEFT CURLY BRACKET MIDDLE PIECE
pub const key_rightmiddlecurlybrace = 0x08b0 // U+23AC RIGHT CURLY BRACKET MIDDLE PIECE
pub const key_topleftsummation = 0x08b1
pub const key_botleftsummation = 0x08b2
pub const key_topvertsummationconnector = 0x08b3
pub const key_botvertsummationconnector = 0x08b4
pub const key_toprightsummation = 0x08b5
pub const key_botrightsummation = 0x08b6
pub const key_rightmiddlesummation = 0x08b7
pub const key_lessthanequal = 0x08bc // U+2264 LESS-THAN OR EQUAL TO
pub const key_notequal = 0x08bd // U+2260 NOT EQUAL TO
pub const key_greaterthanequal = 0x08be // U+2265 GREATER-THAN OR EQUAL TO
pub const key_integral = 0x08bf // U+222B INTEGRAL
pub const key_therefore = 0x08c0 // U+2234 THEREFORE
pub const key_variation = 0x08c1 // U+221D PROPORTIONAL TO
pub const key_infinity = 0x08c2 // U+221E INFINITY
pub const key_nabla = 0x08c5 // U+2207 NABLA
pub const key_approximate = 0x08c8 // U+223C TILDE OPERATOR
pub const key_similarequal = 0x08c9 // U+2243 ASYMPTOTICALLY EQUAL TO
pub const key_ifonlyif = 0x08cd // U+21D4 LEFT RIGHT DOUBLE ARROW
pub const key_implies = 0x08ce // U+21D2 RIGHTWARDS DOUBLE ARROW
pub const key_identical = 0x08cf // U+2261 IDENTICAL TO
pub const key_radical = 0x08d6 // U+221A SQUARE ROOT
pub const key_includedin = 0x08da // U+2282 SUBSET OF
pub const key_includes = 0x08db // U+2283 SUPERSET OF
pub const key_intersection = 0x08dc // U+2229 INTERSECTION
pub const key_union = 0x08dd // U+222A UNION
pub const key_logicaland = 0x08de // U+2227 LOGICAL AND
pub const key_logicalor = 0x08df // U+2228 LOGICAL OR
pub const key_partialderivative = 0x08ef // U+2202 PARTIAL DIFFERENTIAL
pub const key_function = 0x08f6 // U+0192 LATIN SMALL LETTER F WITH HOOK
pub const key_leftarrow = 0x08fb // U+2190 LEFTWARDS ARROW
pub const key_uparrow = 0x08fc // U+2191 UPWARDS ARROW
pub const key_rightarrow = 0x08fd // U+2192 RIGHTWARDS ARROW
pub const key_downarrow = 0x08fe // U+2193 DOWNWARDS ARROW

//
////* Special
////* (from the DEC VT100 Special Graphics Character Set)
////* Byte 3 = 9
//

pub const key_blank = 0x09df
pub const key_soliddiamond = 0x09e0 // U+25C6 BLACK DIAMOND
pub const key_checkerboard = 0x09e1 // U+2592 MEDIUM SHADE
pub const key_ht = 0x09e2 // U+2409 SYMBOL FOR HORIZONTAL TABULATION
pub const key_ff = 0x09e3 // U+240C SYMBOL FOR FORM FEED
pub const key_cr = 0x09e4 // U+240D SYMBOL FOR CARRIAGE RETURN
pub const key_lf = 0x09e5 // U+240A SYMBOL FOR LINE FEED
pub const key_nl = 0x09e8 // U+2424 SYMBOL FOR NEWLINE
pub const key_vt = 0x09e9 // U+240B SYMBOL FOR VERTICAL TABULATION
pub const key_lowrightcorner = 0x09ea // U+2518 BOX DRAWINGS LIGHT UP AND LEFT
pub const key_uprightcorner = 0x09eb // U+2510 BOX DRAWINGS LIGHT DOWN AND LEFT
pub const key_upleftcorner = 0x09ec // U+250C BOX DRAWINGS LIGHT DOWN AND RIGHT
pub const key_lowleftcorner = 0x09ed // U+2514 BOX DRAWINGS LIGHT UP AND RIGHT
pub const key_crossinglines = 0x09ee // U+253C BOX DRAWINGS LIGHT VERTICAL AND HORIZONTAL
pub const key_horizlinescan1 = 0x09ef // U+23BA HORIZONTAL SCAN LINE-1
pub const key_horizlinescan3 = 0x09f0 // U+23BB HORIZONTAL SCAN LINE-3
pub const key_horizlinescan5 = 0x09f1 // U+2500 BOX DRAWINGS LIGHT HORIZONTAL
pub const key_horizlinescan7 = 0x09f2 // U+23BC HORIZONTAL SCAN LINE-7
pub const key_horizlinescan9 = 0x09f3 // U+23BD HORIZONTAL SCAN LINE-9
pub const key_leftt = 0x09f4 // U+251C BOX DRAWINGS LIGHT VERTICAL AND RIGHT
pub const key_rightt = 0x09f5 // U+2524 BOX DRAWINGS LIGHT VERTICAL AND LEFT
pub const key_bott = 0x09f6 // U+2534 BOX DRAWINGS LIGHT UP AND HORIZONTAL
pub const key_topt = 0x09f7 // U+252C BOX DRAWINGS LIGHT DOWN AND HORIZONTAL
pub const key_vertbar = 0x09f8 // U+2502 BOX DRAWINGS LIGHT VERTICAL

//
////* Publishing
////* (these are probably from a long forgotten DEC Publishing
////* font that once shipped with DECwrite)
////* Byte 3 = := 0x0a
//

pub const key_emspace = 0x0aa1 // U+2003 EM SPACE
pub const key_enspace = 0x0aa2 // U+2002 EN SPACE
pub const key_em3space = 0x0aa3 // U+2004 THREE-PER-EM SPACE
pub const key_em4space = 0x0aa4 // U+2005 FOUR-PER-EM SPACE
pub const key_digitspace = 0x0aa5 // U+2007 FIGURE SPACE
pub const key_punctspace = 0x0aa6 // U+2008 PUNCTUATION SPACE
pub const key_thinspace = 0x0aa7 // U+2009 THIN SPACE
pub const key_hairspace = 0x0aa8 // U+200A HAIR SPACE
pub const key_emdash = 0x0aa9 // U+2014 EM DASH
pub const key_endash = 0x0aaa // U+2013 EN DASH
pub const key_signifblank = 0x0aac //(U+2423 OPEN BOX)
pub const key_ellipsis = 0x0aae // U+2026 HORIZONTAL ELLIPSIS
pub const key_doubbaselinedot = 0x0aaf // U+2025 TWO DOT LEADER
pub const key_onethird = 0x0ab0 // U+2153 VULGAR FRACTION ONE THIRD
pub const key_twothirds = 0x0ab1 // U+2154 VULGAR FRACTION TWO THIRDS
pub const key_onefifth = 0x0ab2 // U+2155 VULGAR FRACTION ONE FIFTH
pub const key_twofifths = 0x0ab3 // U+2156 VULGAR FRACTION TWO FIFTHS
pub const key_threefifths = 0x0ab4 // U+2157 VULGAR FRACTION THREE FIFTHS
pub const key_fourfifths = 0x0ab5 // U+2158 VULGAR FRACTION FOUR FIFTHS
pub const key_onesixth = 0x0ab6 // U+2159 VULGAR FRACTION ONE SIXTH
pub const key_fivesixths = 0x0ab7 // U+215A VULGAR FRACTION FIVE SIXTHS
pub const key_careof = 0x0ab8 // U+2105 CARE OF
pub const key_figdash = 0x0abb // U+2012 FIGURE DASH
pub const key_leftanglebracket = 0x0abc //(U+2329 LEFT-POINTING ANGLE BRACKET)
pub const key_decimalpoint = 0x0abd //(U+002E FULL STOP)
pub const key_rightanglebracket = 0x0abe //(U+232A RIGHT-POINTING ANGLE BRACKET)
pub const key_marker = 0x0abf
pub const key_oneeighth = 0x0ac3 // U+215B VULGAR FRACTION ONE EIGHTH
pub const key_threeeighths = 0x0ac4 // U+215C VULGAR FRACTION THREE EIGHTHS
pub const key_fiveeighths = 0x0ac5 // U+215D VULGAR FRACTION FIVE EIGHTHS
pub const key_seveneighths = 0x0ac6 // U+215E VULGAR FRACTION SEVEN EIGHTHS
pub const key_trademark = 0x0ac9 // U+2122 TRADE MARK SIGN
pub const key_signaturemark = 0x0aca //(U+2613 SALTIRE)
pub const key_trademarkincircle = 0x0acb
pub const key_leftopentriangle = 0x0acc //(U+25C1 WHITE LEFT-POINTING TRIANGLE)
pub const key_rightopentriangle = 0x0acd //(U+25B7 WHITE RIGHT-POINTING TRIANGLE)
pub const key_emopencircle = 0x0ace //(U+25CB WHITE CIRCLE)
pub const key_emopenrectangle = 0x0acf //(U+25AF WHITE VERTICAL RECTANGLE)
pub const key_leftsinglequotemark = 0x0ad0 // U+2018 LEFT SINGLE QUOTATION MARK
pub const key_rightsinglequotemark = 0x0ad1 // U+2019 RIGHT SINGLE QUOTATION MARK
pub const key_leftdoublequotemark = 0x0ad2 // U+201C LEFT DOUBLE QUOTATION MARK
pub const key_rightdoublequotemark = 0x0ad3 // U+201D RIGHT DOUBLE QUOTATION MARK
pub const key_prescription = 0x0ad4 // U+211E PRESCRIPTION TAKE
pub const key_permille = 0x0ad5 // U+2030 PER MILLE SIGN
pub const key_minutes = 0x0ad6 // U+2032 PRIME
pub const key_seconds = 0x0ad7 // U+2033 DOUBLE PRIME
pub const key_latincross = 0x0ad9 // U+271D LATIN CROSS
pub const key_hexagram = 0x0ada
pub const key_filledrectbullet = 0x0adb //(U+25AC BLACK RECTANGLE)
pub const key_filledlefttribullet = 0x0adc //(U+25C0 BLACK LEFT-POINTING TRIANGLE)
pub const key_filledrighttribullet = 0x0add //(U+25B6 BLACK RIGHT-POINTING TRIANGLE)
pub const key_emfilledcircle = 0x0ade //(U+25CF BLACK CIRCLE)
pub const key_emfilledrect = 0x0adf //(U+25AE BLACK VERTICAL RECTANGLE)
pub const key_enopencircbullet = 0x0ae0 //(U+25E6 WHITE BULLET)
pub const key_enopensquarebullet = 0x0ae1 //(U+25AB WHITE SMALL SQUARE)
pub const key_openrectbullet = 0x0ae2 //(U+25AD WHITE RECTANGLE)
pub const key_opentribulletup = 0x0ae3 //(U+25B3 WHITE UP-POINTING TRIANGLE)
pub const key_opentribulletdown = 0x0ae4 //(U+25BD WHITE DOWN-POINTING TRIANGLE)
pub const key_openstar = 0x0ae5 //(U+2606 WHITE STAR)
pub const key_enfilledcircbullet = 0x0ae6 //(U+2022 BULLET)
pub const key_enfilledsqbullet = 0x0ae7 //(U+25AA BLACK SMALL SQUARE)
pub const key_filledtribulletup = 0x0ae8 //(U+25B2 BLACK UP-POINTING TRIANGLE)
pub const key_filledtribulletdown = 0x0ae9 //(U+25BC BLACK DOWN-POINTING TRIANGLE)
pub const key_leftpointer = 0x0aea //(U+261C WHITE LEFT POINTING INDEX)
pub const key_rightpointer = 0x0aeb //(U+261E WHITE RIGHT POINTING INDEX)
pub const key_club = 0x0aec // U+2663 BLACK CLUB SUIT
pub const key_diamond = 0x0aed // U+2666 BLACK DIAMOND SUIT
pub const key_heart = 0x0aee // U+2665 BLACK HEART SUIT
pub const key_maltesecross = 0x0af0 // U+2720 MALTESE CROSS
pub const key_dagger = 0x0af1 // U+2020 DAGGER
pub const key_doubledagger = 0x0af2 // U+2021 DOUBLE DAGGER
pub const key_checkmark = 0x0af3 // U+2713 CHECK MARK
pub const key_ballotcross = 0x0af4 // U+2717 BALLOT X
pub const key_musicalsharp = 0x0af5 // U+266F MUSIC SHARP SIGN
pub const key_musicalflat = 0x0af6 // U+266D MUSIC FLAT SIGN
pub const key_malesymbol = 0x0af7 // U+2642 MALE SIGN
pub const key_femalesymbol = 0x0af8 // U+2640 FEMALE SIGN
pub const key_telephone = 0x0af9 // U+260E BLACK TELEPHONE
pub const key_telephonerecorder = 0x0afa // U+2315 TELEPHONE RECORDER
pub const key_phonographcopyright = 0x0afb // U+2117 SOUND RECORDING COPYRIGHT
pub const key_caret = 0x0afc // U+2038 CARET
pub const key_singlelowquotemark = 0x0afd // U+201A SINGLE LOW-9 QUOTATION MARK
pub const key_doublelowquotemark = 0x0afe // U+201E DOUBLE LOW-9 QUOTATION MARK
pub const key_cursor = 0x0aff

//
////* APL
////* Byte 3 = := 0x0b
//

pub const key_leftcaret = 0x0ba3 //(U+003C LESS-THAN SIGN)
pub const key_rightcaret = 0x0ba6 //(U+003E GREATER-THAN SIGN)
pub const key_downcaret = 0x0ba8 //(U+2228 LOGICAL OR)
pub const key_upcaret = 0x0ba9 //(U+2227 LOGICAL AND)
pub const key_overbar = 0x0bc0 //(U+00AF MACRON)
pub const key_downtack = 0x0bc2 // U+22A4 DOWN TACK
pub const key_upshoe = 0x0bc3 //(U+2229 INTERSECTION)
pub const key_downstile = 0x0bc4 // U+230A LEFT FLOOR
pub const key_underbar = 0x0bc6 //(U+005F LOW LINE)
pub const key_jot = 0x0bca // U+2218 RING OPERATOR
pub const key_quad = 0x0bcc // U+2395 APL FUNCTIONAL SYMBOL QUAD
pub const key_uptack = 0x0bce // U+22A5 UP TACK
pub const key_circle = 0x0bcf // U+25CB WHITE CIRCLE
pub const key_upstile = 0x0bd3 // U+2308 LEFT CEILING
pub const key_downshoe = 0x0bd6 //(U+222A UNION)
pub const key_rightshoe = 0x0bd8 //(U+2283 SUPERSET OF)
pub const key_leftshoe = 0x0bda //(U+2282 SUBSET OF)
pub const key_lefttack = 0x0bdc // U+22A3 LEFT TACK
pub const key_righttack = 0x0bfc // U+22A2 RIGHT TACK

//
////* Hebrew
////* Byte 3 = := 0x0c
//

pub const key_hebrew_doublelowline = 0x0cdf // U+2017 DOUBLE LOW LINE
pub const key_hebrew_aleph = 0x0ce0 // U+05D0 HEBREW LETTER ALEF
pub const key_hebrew_bet = 0x0ce1 // U+05D1 HEBREW LETTER BET
pub const key_hebrew_beth = 0x0ce1 // deprecated
pub const key_hebrew_gimel = 0x0ce2 // U+05D2 HEBREW LETTER GIMEL
pub const key_hebrew_gimmel = 0x0ce2 // deprecated
pub const key_hebrew_dalet = 0x0ce3 // U+05D3 HEBREW LETTER DALET
pub const key_hebrew_daleth = 0x0ce3 // deprecated
pub const key_hebrew_he = 0x0ce4 // U+05D4 HEBREW LETTER HE
pub const key_hebrew_waw = 0x0ce5 // U+05D5 HEBREW LETTER VAV
pub const key_hebrew_zain = 0x0ce6 // U+05D6 HEBREW LETTER ZAYIN
pub const key_hebrew_zayin = 0x0ce6 // deprecated
pub const key_hebrew_chet = 0x0ce7 // U+05D7 HEBREW LETTER HET
pub const key_hebrew_het = 0x0ce7 // deprecated
pub const key_hebrew_tet = 0x0ce8 // U+05D8 HEBREW LETTER TET
pub const key_hebrew_teth = 0x0ce8 // deprecated
pub const key_hebrew_yod = 0x0ce9 // U+05D9 HEBREW LETTER YOD
pub const key_hebrew_finalkaph = 0x0cea // U+05DA HEBREW LETTER FINAL KAF
pub const key_hebrew_kaph = 0x0ceb // U+05DB HEBREW LETTER KAF
pub const key_hebrew_lamed = 0x0cec // U+05DC HEBREW LETTER LAMED
pub const key_hebrew_finalmem = 0x0ced // U+05DD HEBREW LETTER FINAL MEM
pub const key_hebrew_mem = 0x0cee // U+05DE HEBREW LETTER MEM
pub const key_hebrew_finalnun = 0x0cef // U+05DF HEBREW LETTER FINAL NUN
pub const key_hebrew_nun = 0x0cf0 // U+05E0 HEBREW LETTER NUN
pub const key_hebrew_samech = 0x0cf1 // U+05E1 HEBREW LETTER SAMEKH
pub const key_hebrew_samekh = 0x0cf1 // deprecated
pub const key_hebrew_ayin = 0x0cf2 // U+05E2 HEBREW LETTER AYIN
pub const key_hebrew_finalpe = 0x0cf3 // U+05E3 HEBREW LETTER FINAL PE
pub const key_hebrew_pe = 0x0cf4 // U+05E4 HEBREW LETTER PE
pub const key_hebrew_finalzade = 0x0cf5 // U+05E5 HEBREW LETTER FINAL TSADI
pub const key_hebrew_finalzadi = 0x0cf5 // deprecated
pub const key_hebrew_zade = 0x0cf6 // U+05E6 HEBREW LETTER TSADI
pub const key_hebrew_zadi = 0x0cf6 // deprecated
pub const key_hebrew_qoph = 0x0cf7 // U+05E7 HEBREW LETTER QOF
pub const key_hebrew_kuf = 0x0cf7 // deprecated
pub const key_hebrew_resh = 0x0cf8 // U+05E8 HEBREW LETTER RESH
pub const key_hebrew_shin = 0x0cf9 // U+05E9 HEBREW LETTER SHIN
pub const key_hebrew_taw = 0x0cfa // U+05EA HEBREW LETTER TAV
pub const key_hebrew_taf = 0x0cfa // deprecated
pub const key_hebrew_switch = 0xff7e // non-deprecated alias for Mode_switch

//
////* Thai
////* Byte 3 = := 0x0d
//

pub const key_thai_kokai = 0x0da1 // U+0E01 THAI CHARACTER KO KAI
pub const key_thai_khokhai = 0x0da2 // U+0E02 THAI CHARACTER KHO KHAI
pub const key_thai_khokhuat = 0x0da3 // U+0E03 THAI CHARACTER KHO KHUAT
pub const key_thai_khokhwai = 0x0da4 // U+0E04 THAI CHARACTER KHO KHWAI
pub const key_thai_khokhon = 0x0da5 // U+0E05 THAI CHARACTER KHO KHON
pub const key_thai_khorakhang = 0x0da6 // U+0E06 THAI CHARACTER KHO RAKHANG
pub const key_thai_ngongu = 0x0da7 // U+0E07 THAI CHARACTER NGO NGU
pub const key_thai_chochan = 0x0da8 // U+0E08 THAI CHARACTER CHO CHAN
pub const key_thai_choching = 0x0da9 // U+0E09 THAI CHARACTER CHO CHING
pub const key_thai_chochang = 0x0daa // U+0E0A THAI CHARACTER CHO CHANG
pub const key_thai_soso = 0x0dab // U+0E0B THAI CHARACTER SO SO
pub const key_thai_chochoe = 0x0dac // U+0E0C THAI CHARACTER CHO CHOE
pub const key_thai_yoying = 0x0dad // U+0E0D THAI CHARACTER YO YING
pub const key_thai_dochada = 0x0dae // U+0E0E THAI CHARACTER DO CHADA
pub const key_thai_topatak = 0x0daf // U+0E0F THAI CHARACTER TO PATAK
pub const key_thai_thothan = 0x0db0 // U+0E10 THAI CHARACTER THO THAN
pub const key_thai_thonangmontho = 0x0db1 // U+0E11 THAI CHARACTER THO NANGMONTHO
pub const key_thai_thophuthao = 0x0db2 // U+0E12 THAI CHARACTER THO PHUTHAO
pub const key_thai_nonen = 0x0db3 // U+0E13 THAI CHARACTER NO NEN
pub const key_thai_dodek = 0x0db4 // U+0E14 THAI CHARACTER DO DEK
pub const key_thai_totao = 0x0db5 // U+0E15 THAI CHARACTER TO TAO
pub const key_thai_thothung = 0x0db6 // U+0E16 THAI CHARACTER THO THUNG
pub const key_thai_thothahan = 0x0db7 // U+0E17 THAI CHARACTER THO THAHAN
pub const key_thai_thothong = 0x0db8 // U+0E18 THAI CHARACTER THO THONG
pub const key_thai_nonu = 0x0db9 // U+0E19 THAI CHARACTER NO NU
pub const key_thai_bobaimai = 0x0dba // U+0E1A THAI CHARACTER BO BAIMAI
pub const key_thai_popla = 0x0dbb // U+0E1B THAI CHARACTER PO PLA
pub const key_thai_phophung = 0x0dbc // U+0E1C THAI CHARACTER PHO PHUNG
pub const key_thai_fofa = 0x0dbd // U+0E1D THAI CHARACTER FO FA
pub const key_thai_phophan = 0x0dbe // U+0E1E THAI CHARACTER PHO PHAN
pub const key_thai_fofan = 0x0dbf // U+0E1F THAI CHARACTER FO FAN
pub const key_thai_phosamphao = 0x0dc0 // U+0E20 THAI CHARACTER PHO SAMPHAO
pub const key_thai_moma = 0x0dc1 // U+0E21 THAI CHARACTER MO MA
pub const key_thai_yoyak = 0x0dc2 // U+0E22 THAI CHARACTER YO YAK
pub const key_thai_rorua = 0x0dc3 // U+0E23 THAI CHARACTER RO RUA
pub const key_thai_ru = 0x0dc4 // U+0E24 THAI CHARACTER RU
pub const key_thai_loling = 0x0dc5 // U+0E25 THAI CHARACTER LO LING
pub const key_thai_lu = 0x0dc6 // U+0E26 THAI CHARACTER LU
pub const key_thai_wowaen = 0x0dc7 // U+0E27 THAI CHARACTER WO WAEN
pub const key_thai_sosala = 0x0dc8 // U+0E28 THAI CHARACTER SO SALA
pub const key_thai_sorusi = 0x0dc9 // U+0E29 THAI CHARACTER SO RUSI
pub const key_thai_sosua = 0x0dca // U+0E2A THAI CHARACTER SO SUA
pub const key_thai_hohip = 0x0dcb // U+0E2B THAI CHARACTER HO HIP
pub const key_thai_lochula = 0x0dcc // U+0E2C THAI CHARACTER LO CHULA
pub const key_thai_oang = 0x0dcd // U+0E2D THAI CHARACTER O ANG
pub const key_thai_honokhuk = 0x0dce // U+0E2E THAI CHARACTER HO NOKHUK
pub const key_thai_paiyannoi = 0x0dcf // U+0E2F THAI CHARACTER PAIYANNOI
pub const key_thai_saraa = 0x0dd0 // U+0E30 THAI CHARACTER SARA A
pub const key_thai_maihanakat = 0x0dd1 // U+0E31 THAI CHARACTER MAI HAN-AKAT
pub const key_thai_saraaa = 0x0dd2 // U+0E32 THAI CHARACTER SARA AA
pub const key_thai_saraam = 0x0dd3 // U+0E33 THAI CHARACTER SARA AM
pub const key_thai_sarai = 0x0dd4 // U+0E34 THAI CHARACTER SARA I
pub const key_thai_saraii = 0x0dd5 // U+0E35 THAI CHARACTER SARA II
pub const key_thai_saraue = 0x0dd6 // U+0E36 THAI CHARACTER SARA UE
pub const key_thai_sarauee = 0x0dd7 // U+0E37 THAI CHARACTER SARA UEE
pub const key_thai_sarau = 0x0dd8 // U+0E38 THAI CHARACTER SARA U
pub const key_thai_sarauu = 0x0dd9 // U+0E39 THAI CHARACTER SARA UU
pub const key_thai_phinthu = 0x0dda // U+0E3A THAI CHARACTER PHINTHU
pub const key_thai_maihanakat_maitho = 0x0dde //(U+0E3E Unassigned code point)
pub const key_thai_baht = 0x0ddf // U+0E3F THAI CURRENCY SYMBOL BAHT
pub const key_thai_sarae = 0x0de0 // U+0E40 THAI CHARACTER SARA E
pub const key_thai_saraae = 0x0de1 // U+0E41 THAI CHARACTER SARA AE
pub const key_thai_sarao = 0x0de2 // U+0E42 THAI CHARACTER SARA O
pub const key_thai_saraaimaimuan = 0x0de3 // U+0E43 THAI CHARACTER SARA AI MAIMUAN
pub const key_thai_saraaimaimalai = 0x0de4 // U+0E44 THAI CHARACTER SARA AI MAIMALAI
pub const key_thai_lakkhangyao = 0x0de5 // U+0E45 THAI CHARACTER LAKKHANGYAO
pub const key_thai_maiyamok = 0x0de6 // U+0E46 THAI CHARACTER MAIYAMOK
pub const key_thai_maitaikhu = 0x0de7 // U+0E47 THAI CHARACTER MAITAIKHU
pub const key_thai_maiek = 0x0de8 // U+0E48 THAI CHARACTER MAI EK
pub const key_thai_maitho = 0x0de9 // U+0E49 THAI CHARACTER MAI THO
pub const key_thai_maitri = 0x0dea // U+0E4A THAI CHARACTER MAI TRI
pub const key_thai_maichattawa = 0x0deb // U+0E4B THAI CHARACTER MAI CHATTAWA
pub const key_thai_thanthakhat = 0x0dec // U+0E4C THAI CHARACTER THANTHAKHAT
pub const key_thai_nikhahit = 0x0ded // U+0E4D THAI CHARACTER NIKHAHIT
pub const key_thai_leksun = 0x0df0 // U+0E50 THAI DIGIT ZERO
pub const key_thai_leknung = 0x0df1 // U+0E51 THAI DIGIT ONE
pub const key_thai_leksong = 0x0df2 // U+0E52 THAI DIGIT TWO
pub const key_thai_leksam = 0x0df3 // U+0E53 THAI DIGIT THREE
pub const key_thai_leksi = 0x0df4 // U+0E54 THAI DIGIT FOUR
pub const key_thai_lekha = 0x0df5 // U+0E55 THAI DIGIT FIVE
pub const key_thai_lekhok = 0x0df6 // U+0E56 THAI DIGIT SIX
pub const key_thai_lekchet = 0x0df7 // U+0E57 THAI DIGIT SEVEN
pub const key_thai_lekpaet = 0x0df8 // U+0E58 THAI DIGIT EIGHT
pub const key_thai_lekkao = 0x0df9 // U+0E59 THAI DIGIT NINE

//
////* Korean
////* Byte 3 = := 0x0e
//

pub const key_hangul = 0xff31 // Hangul start/stop(toggle)
pub const key_hangul_start = 0xff32 // Hangul start
pub const key_hangul_end = 0xff33 // Hangul end, English start
pub const key_hangul_hanja = 0xff34 // Start Hangul->Hanja Conversion
pub const key_hangul_jamo = 0xff35 // Hangul Jamo mode
pub const key_hangul_romaja = 0xff36 // Hangul Romaja mode
pub const key_hangul_codeinput = 0xff37 // Hangul code input mode
pub const key_hangul_jeonja = 0xff38 // Jeonja mode
pub const key_hangul_banja = 0xff39 // Banja mode
pub const key_hangul_prehanja = 0xff3a // Pre Hanja conversion
pub const key_hangul_posthanja = 0xff3b // Post Hanja conversion
pub const key_hangul_singlecandidate = 0xff3c // Single candidate
pub const key_hangul_multiplecandidate = 0xff3d // Multiple candidate
pub const key_hangul_previouscandidate = 0xff3e // Previous candidate
pub const key_hangul_special = 0xff3f // Special symbols
pub const key_hangul_switch = 0xff7e // non-deprecated alias for Mode_switch

// Hangul Consonant Characters
pub const key_hangul_kiyeog = 0x0ea1 // U+3131 HANGUL LETTER KIYEOK
pub const key_hangul_ssangkiyeog = 0x0ea2 // U+3132 HANGUL LETTER SSANGKIYEOK
pub const key_hangul_kiyeogsios = 0x0ea3 // U+3133 HANGUL LETTER KIYEOK-SIOS
pub const key_hangul_nieun = 0x0ea4 // U+3134 HANGUL LETTER NIEUN
pub const key_hangul_nieunjieuj = 0x0ea5 // U+3135 HANGUL LETTER NIEUN-CIEUC
pub const key_hangul_nieunhieuh = 0x0ea6 // U+3136 HANGUL LETTER NIEUN-HIEUH
pub const key_hangul_dikeud = 0x0ea7 // U+3137 HANGUL LETTER TIKEUT
pub const key_hangul_ssangdikeud = 0x0ea8 // U+3138 HANGUL LETTER SSANGTIKEUT
pub const key_hangul_rieul = 0x0ea9 // U+3139 HANGUL LETTER RIEUL
pub const key_hangul_rieulkiyeog = 0x0eaa // U+313A HANGUL LETTER RIEUL-KIYEOK
pub const key_hangul_rieulmieum = 0x0eab // U+313B HANGUL LETTER RIEUL-MIEUM
pub const key_hangul_rieulpieub = 0x0eac // U+313C HANGUL LETTER RIEUL-PIEUP
pub const key_hangul_rieulsios = 0x0ead // U+313D HANGUL LETTER RIEUL-SIOS
pub const key_hangul_rieultieut = 0x0eae // U+313E HANGUL LETTER RIEUL-THIEUTH
pub const key_hangul_rieulphieuf = 0x0eaf // U+313F HANGUL LETTER RIEUL-PHIEUPH
pub const key_hangul_rieulhieuh = 0x0eb0 // U+3140 HANGUL LETTER RIEUL-HIEUH
pub const key_hangul_mieum = 0x0eb1 // U+3141 HANGUL LETTER MIEUM
pub const key_hangul_pieub = 0x0eb2 // U+3142 HANGUL LETTER PIEUP
pub const key_hangul_ssangpieub = 0x0eb3 // U+3143 HANGUL LETTER SSANGPIEUP
pub const key_hangul_pieubsios = 0x0eb4 // U+3144 HANGUL LETTER PIEUP-SIOS
pub const key_hangul_sios = 0x0eb5 // U+3145 HANGUL LETTER SIOS
pub const key_hangul_ssangsios = 0x0eb6 // U+3146 HANGUL LETTER SSANGSIOS
pub const key_hangul_ieung = 0x0eb7 // U+3147 HANGUL LETTER IEUNG
pub const key_hangul_jieuj = 0x0eb8 // U+3148 HANGUL LETTER CIEUC
pub const key_hangul_ssangjieuj = 0x0eb9 // U+3149 HANGUL LETTER SSANGCIEUC
pub const key_hangul_cieuc = 0x0eba // U+314A HANGUL LETTER CHIEUCH
pub const key_hangul_khieuq = 0x0ebb // U+314B HANGUL LETTER KHIEUKH
pub const key_hangul_tieut = 0x0ebc // U+314C HANGUL LETTER THIEUTH
pub const key_hangul_phieuf = 0x0ebd // U+314D HANGUL LETTER PHIEUPH
pub const key_hangul_hieuh = 0x0ebe // U+314E HANGUL LETTER HIEUH

// Hangul Vowel Characters
pub const key_hangul_a = 0x0ebf // U+314F HANGUL LETTER A
pub const key_hangul_ae = 0x0ec0 // U+3150 HANGUL LETTER AE
pub const key_hangul_ya = 0x0ec1 // U+3151 HANGUL LETTER YA
pub const key_hangul_yae = 0x0ec2 // U+3152 HANGUL LETTER YAE
pub const key_hangul_eo = 0x0ec3 // U+3153 HANGUL LETTER EO
pub const key_hangul_e = 0x0ec4 // U+3154 HANGUL LETTER E
pub const key_hangul_yeo = 0x0ec5 // U+3155 HANGUL LETTER YEO
pub const key_hangul_ye = 0x0ec6 // U+3156 HANGUL LETTER YE
pub const key_hangul_o = 0x0ec7 // U+3157 HANGUL LETTER O
pub const key_hangul_wa = 0x0ec8 // U+3158 HANGUL LETTER WA
pub const key_hangul_wae = 0x0ec9 // U+3159 HANGUL LETTER WAE
pub const key_hangul_oe = 0x0eca // U+315A HANGUL LETTER OE
pub const key_hangul_yo = 0x0ecb // U+315B HANGUL LETTER YO
pub const key_hangul_u = 0x0ecc // U+315C HANGUL LETTER U
pub const key_hangul_weo = 0x0ecd // U+315D HANGUL LETTER WEO
pub const key_hangul_we = 0x0ece // U+315E HANGUL LETTER WE
pub const key_hangul_wi = 0x0ecf // U+315F HANGUL LETTER WI
pub const key_hangul_yu = 0x0ed0 // U+3160 HANGUL LETTER YU
pub const key_hangul_eu = 0x0ed1 // U+3161 HANGUL LETTER EU
pub const key_hangul_yi = 0x0ed2 // U+3162 HANGUL LETTER YI
pub const key_hangul_i = 0x0ed3 // U+3163 HANGUL LETTER I

// Hangul syllable-final (JongSeong) Characters
pub const key_hangul_j_kiyeog = 0x0ed4 // U+11A8 HANGUL JONGSEONG KIYEOK
pub const key_hangul_j_ssangkiyeog = 0x0ed5 // U+11A9 HANGUL JONGSEONG SSANGKIYEOK
pub const key_hangul_j_kiyeogsios = 0x0ed6 // U+11AA HANGUL JONGSEONG KIYEOK-SIOS
pub const key_hangul_j_nieun = 0x0ed7 // U+11AB HANGUL JONGSEONG NIEUN
pub const key_hangul_j_nieunjieuj = 0x0ed8 // U+11AC HANGUL JONGSEONG NIEUN-CIEUC
pub const key_hangul_j_nieunhieuh = 0x0ed9 // U+11AD HANGUL JONGSEONG NIEUN-HIEUH
pub const key_hangul_j_dikeud = 0x0eda // U+11AE HANGUL JONGSEONG TIKEUT
pub const key_hangul_j_rieul = 0x0edb // U+11AF HANGUL JONGSEONG RIEUL
pub const key_hangul_j_rieulkiyeog = 0x0edc // U+11B0 HANGUL JONGSEONG RIEUL-KIYEOK
pub const key_hangul_j_rieulmieum = 0x0edd // U+11B1 HANGUL JONGSEONG RIEUL-MIEUM
pub const key_hangul_j_rieulpieub = 0x0ede // U+11B2 HANGUL JONGSEONG RIEUL-PIEUP
pub const key_hangul_j_rieulsios = 0x0edf // U+11B3 HANGUL JONGSEONG RIEUL-SIOS
pub const key_hangul_j_rieultieut = 0x0ee0 // U+11B4 HANGUL JONGSEONG RIEUL-THIEUTH
pub const key_hangul_j_rieulphieuf = 0x0ee1 // U+11B5 HANGUL JONGSEONG RIEUL-PHIEUPH
pub const key_hangul_j_rieulhieuh = 0x0ee2 // U+11B6 HANGUL JONGSEONG RIEUL-HIEUH
pub const key_hangul_j_mieum = 0x0ee3 // U+11B7 HANGUL JONGSEONG MIEUM
pub const key_hangul_j_pieub = 0x0ee4 // U+11B8 HANGUL JONGSEONG PIEUP
pub const key_hangul_j_pieubsios = 0x0ee5 // U+11B9 HANGUL JONGSEONG PIEUP-SIOS
pub const key_hangul_j_sios = 0x0ee6 // U+11BA HANGUL JONGSEONG SIOS
pub const key_hangul_j_ssangsios = 0x0ee7 // U+11BB HANGUL JONGSEONG SSANGSIOS
pub const key_hangul_j_ieung = 0x0ee8 // U+11BC HANGUL JONGSEONG IEUNG
pub const key_hangul_j_jieuj = 0x0ee9 // U+11BD HANGUL JONGSEONG CIEUC
pub const key_hangul_j_cieuc = 0x0eea // U+11BE HANGUL JONGSEONG CHIEUCH
pub const key_hangul_j_khieuq = 0x0eeb // U+11BF HANGUL JONGSEONG KHIEUKH
pub const key_hangul_j_tieut = 0x0eec // U+11C0 HANGUL JONGSEONG THIEUTH
pub const key_hangul_j_phieuf = 0x0eed // U+11C1 HANGUL JONGSEONG PHIEUPH
pub const key_hangul_j_hieuh = 0x0eee // U+11C2 HANGUL JONGSEONG HIEUH

// Ancient Hangul Consonant Characters
pub const key_hangul_rieulyeorinhieuh = 0x0eef // U+316D HANGUL LETTER RIEUL-YEORINHIEUH
pub const key_hangul_sunkyeongeummieum = 0x0ef0 // U+3171 HANGUL LETTER KAPYEOUNMIEUM
pub const key_hangul_sunkyeongeumpieub = 0x0ef1 // U+3178 HANGUL LETTER KAPYEOUNPIEUP
pub const key_hangul_pansios = 0x0ef2 // U+317F HANGUL LETTER PANSIOS
pub const key_hangul_kkogjidalrinieung = 0x0ef3 // U+3181 HANGUL LETTER YESIEUNG
pub const key_hangul_sunkyeongeumphieuf = 0x0ef4 // U+3184 HANGUL LETTER KAPYEOUNPHIEUPH
pub const key_hangul_yeorinhieuh = 0x0ef5 // U+3186 HANGUL LETTER YEORINHIEUH

// Ancient Hangul Vowel Characters
pub const key_hangul_araea = 0x0ef6 // U+318D HANGUL LETTER ARAEA
pub const key_hangul_araeae = 0x0ef7 // U+318E HANGUL LETTER ARAEAE

// Ancient Hangul syllable-final (JongSeong) Characters
pub const key_hangul_j_pansios = 0x0ef8 // U+11EB HANGUL JONGSEONG PANSIOS
pub const key_hangul_j_kkogjidalrinieung = 0x0ef9 // U+11F0 HANGUL JONGSEONG YESIEUNG
pub const key_hangul_j_yeorinhieuh = 0x0efa // U+11F9 HANGUL JONGSEONG YEORINHIEUH

// Korean currency symbol
pub const key_korean_won = 0x0eff //(U+20A9 WON SIGN)

//
////* Armenian
//

pub const key_armenian_ligature_ew = 0x1000587 // U+0587 ARMENIAN SMALL LIGATURE ECH YIWN
pub const key_armenian_full_stop = 0x1000589 // U+0589 ARMENIAN FULL STOP
pub const key_armenian_verjaket = 0x1000589 // deprecated alias for Armenian_full_stop
pub const key_armenian_separation_mark = 0x100055d // U+055D ARMENIAN COMMA
pub const key_armenian_but = 0x100055d // deprecated alias for Armenian_separation_mark
pub const key_armenian_hyphen = 0x100058a // U+058A ARMENIAN HYPHEN
pub const key_armenian_yentamna = 0x100058a // deprecated alias for Armenian_hyphen
pub const key_armenian_exclam = 0x100055c // U+055C ARMENIAN EXCLAMATION MARK
pub const key_armenian_amanak = 0x100055c // deprecated alias for Armenian_exclam
pub const key_armenian_accent = 0x100055b // U+055B ARMENIAN EMPHASIS MARK
pub const key_armenian_shesht = 0x100055b // deprecated alias for Armenian_accent
pub const key_armenian_question = 0x100055e // U+055E ARMENIAN QUESTION MARK
pub const key_armenian_paruyk = 0x100055e // deprecated alias for Armenian_question
pub const key_armenian_ayb = 0x1000531 // U+0531 ARMENIAN CAPITAL LETTER AYB
pub const key_armenian_small_ayb = 0x1000561 // U+0561 ARMENIAN SMALL LETTER AYB
pub const key_armenian_ben = 0x1000532 // U+0532 ARMENIAN CAPITAL LETTER BEN
pub const key_armenian_small_ben = 0x1000562 // U+0562 ARMENIAN SMALL LETTER BEN
pub const key_armenian_gim = 0x1000533 // U+0533 ARMENIAN CAPITAL LETTER GIM
pub const key_armenian_small_gim = 0x1000563 // U+0563 ARMENIAN SMALL LETTER GIM
pub const key_armenian_da = 0x1000534 // U+0534 ARMENIAN CAPITAL LETTER DA
pub const key_armenian_small_da = 0x1000564 // U+0564 ARMENIAN SMALL LETTER DA
pub const key_armenian_yech = 0x1000535 // U+0535 ARMENIAN CAPITAL LETTER ECH
pub const key_armenian_small_yech = 0x1000565 // U+0565 ARMENIAN SMALL LETTER ECH
pub const key_armenian_za = 0x1000536 // U+0536 ARMENIAN CAPITAL LETTER ZA
pub const key_armenian_small_za = 0x1000566 // U+0566 ARMENIAN SMALL LETTER ZA
pub const key_armenian_e = 0x1000537 // U+0537 ARMENIAN CAPITAL LETTER EH
pub const key_armenian_small_e = 0x1000567 // U+0567 ARMENIAN SMALL LETTER EH
pub const key_armenian_at = 0x1000538 // U+0538 ARMENIAN CAPITAL LETTER ET
pub const key_armenian_small_at = 0x1000568 // U+0568 ARMENIAN SMALL LETTER ET
pub const key_armenian_to = 0x1000539 // U+0539 ARMENIAN CAPITAL LETTER TO
pub const key_armenian_small_to = 0x1000569 // U+0569 ARMENIAN SMALL LETTER TO
pub const key_armenian_zhe = 0x100053a // U+053A ARMENIAN CAPITAL LETTER ZHE
pub const key_armenian_small_zhe = 0x100056a // U+056A ARMENIAN SMALL LETTER ZHE
pub const key_armenian_ini = 0x100053b // U+053B ARMENIAN CAPITAL LETTER INI
pub const key_armenian_small_ini = 0x100056b // U+056B ARMENIAN SMALL LETTER INI
pub const key_armenian_lyun = 0x100053c // U+053C ARMENIAN CAPITAL LETTER LIWN
pub const key_armenian_small_lyun = 0x100056c // U+056C ARMENIAN SMALL LETTER LIWN
pub const key_armenian_khe = 0x100053d // U+053D ARMENIAN CAPITAL LETTER XEH
pub const key_armenian_small_khe = 0x100056d // U+056D ARMENIAN SMALL LETTER XEH
pub const key_armenian_tsa = 0x100053e // U+053E ARMENIAN CAPITAL LETTER CA
pub const key_armenian_small_tsa = 0x100056e // U+056E ARMENIAN SMALL LETTER CA
pub const key_armenian_ken = 0x100053f // U+053F ARMENIAN CAPITAL LETTER KEN
pub const key_armenian_small_ken = 0x100056f // U+056F ARMENIAN SMALL LETTER KEN
pub const key_armenian_ho = 0x1000540 // U+0540 ARMENIAN CAPITAL LETTER HO
pub const key_armenian_small_ho = 0x1000570 // U+0570 ARMENIAN SMALL LETTER HO
pub const key_armenian_dza = 0x1000541 // U+0541 ARMENIAN CAPITAL LETTER JA
pub const key_armenian_small_dza = 0x1000571 // U+0571 ARMENIAN SMALL LETTER JA
pub const key_armenian_ghat = 0x1000542 // U+0542 ARMENIAN CAPITAL LETTER GHAD
pub const key_armenian_small_ghat = 0x1000572 // U+0572 ARMENIAN SMALL LETTER GHAD
pub const key_armenian_tche = 0x1000543 // U+0543 ARMENIAN CAPITAL LETTER CHEH
pub const key_armenian_small_tche = 0x1000573 // U+0573 ARMENIAN SMALL LETTER CHEH
pub const key_armenian_men = 0x1000544 // U+0544 ARMENIAN CAPITAL LETTER MEN
pub const key_armenian_small_men = 0x1000574 // U+0574 ARMENIAN SMALL LETTER MEN
pub const key_armenian_hi = 0x1000545 // U+0545 ARMENIAN CAPITAL LETTER YI
pub const key_armenian_small_hi = 0x1000575 // U+0575 ARMENIAN SMALL LETTER YI
pub const key_armenian_nu = 0x1000546 // U+0546 ARMENIAN CAPITAL LETTER NOW
pub const key_armenian_small_nu = 0x1000576 // U+0576 ARMENIAN SMALL LETTER NOW
pub const key_armenian_sha = 0x1000547 // U+0547 ARMENIAN CAPITAL LETTER SHA
pub const key_armenian_small_sha = 0x1000577 // U+0577 ARMENIAN SMALL LETTER SHA
pub const key_armenian_vo = 0x1000548 // U+0548 ARMENIAN CAPITAL LETTER VO
pub const key_armenian_small_vo = 0x1000578 // U+0578 ARMENIAN SMALL LETTER VO
pub const key_armenian_cha = 0x1000549 // U+0549 ARMENIAN CAPITAL LETTER CHA
pub const key_armenian_small_cha = 0x1000579 // U+0579 ARMENIAN SMALL LETTER CHA
pub const key_armenian_pe = 0x100054a // U+054A ARMENIAN CAPITAL LETTER PEH
pub const key_armenian_small_pe = 0x100057a // U+057A ARMENIAN SMALL LETTER PEH
pub const key_armenian_je = 0x100054b // U+054B ARMENIAN CAPITAL LETTER JHEH
pub const key_armenian_small_je = 0x100057b // U+057B ARMENIAN SMALL LETTER JHEH
pub const key_armenian_ra = 0x100054c // U+054C ARMENIAN CAPITAL LETTER RA
pub const key_armenian_small_ra = 0x100057c // U+057C ARMENIAN SMALL LETTER RA
pub const key_armenian_se = 0x100054d // U+054D ARMENIAN CAPITAL LETTER SEH
pub const key_armenian_small_se = 0x100057d // U+057D ARMENIAN SMALL LETTER SEH
pub const key_armenian_vev = 0x100054e // U+054E ARMENIAN CAPITAL LETTER VEW
pub const key_armenian_small_vev = 0x100057e // U+057E ARMENIAN SMALL LETTER VEW
pub const key_armenian_tyun = 0x100054f // U+054F ARMENIAN CAPITAL LETTER TIWN
pub const key_armenian_small_tyun = 0x100057f // U+057F ARMENIAN SMALL LETTER TIWN
pub const key_armenian_re = 0x1000550 // U+0550 ARMENIAN CAPITAL LETTER REH
pub const key_armenian_small_re = 0x1000580 // U+0580 ARMENIAN SMALL LETTER REH
pub const key_armenian_tso = 0x1000551 // U+0551 ARMENIAN CAPITAL LETTER CO
pub const key_armenian_small_tso = 0x1000581 // U+0581 ARMENIAN SMALL LETTER CO
pub const key_armenian_vyun = 0x1000552 // U+0552 ARMENIAN CAPITAL LETTER YIWN
pub const key_armenian_small_vyun = 0x1000582 // U+0582 ARMENIAN SMALL LETTER YIWN
pub const key_armenian_pyur = 0x1000553 // U+0553 ARMENIAN CAPITAL LETTER PIWR
pub const key_armenian_small_pyur = 0x1000583 // U+0583 ARMENIAN SMALL LETTER PIWR
pub const key_armenian_ke = 0x1000554 // U+0554 ARMENIAN CAPITAL LETTER KEH
pub const key_armenian_small_ke = 0x1000584 // U+0584 ARMENIAN SMALL LETTER KEH
pub const key_armenian_o = 0x1000555 // U+0555 ARMENIAN CAPITAL LETTER OH
pub const key_armenian_small_o = 0x1000585 // U+0585 ARMENIAN SMALL LETTER OH
pub const key_armenian_fe = 0x1000556 // U+0556 ARMENIAN CAPITAL LETTER FEH
pub const key_armenian_small_fe = 0x1000586 // U+0586 ARMENIAN SMALL LETTER FEH
pub const key_armenian_apostrophe = 0x100055a // U+055A ARMENIAN APOSTROPHE

//
////* Georgian
//

pub const key_georgian_an = 0x10010d0 // U+10D0 GEORGIAN LETTER AN
pub const key_georgian_ban = 0x10010d1 // U+10D1 GEORGIAN LETTER BAN
pub const key_georgian_gan = 0x10010d2 // U+10D2 GEORGIAN LETTER GAN
pub const key_georgian_don = 0x10010d3 // U+10D3 GEORGIAN LETTER DON
pub const key_georgian_en = 0x10010d4 // U+10D4 GEORGIAN LETTER EN
pub const key_georgian_vin = 0x10010d5 // U+10D5 GEORGIAN LETTER VIN
pub const key_georgian_zen = 0x10010d6 // U+10D6 GEORGIAN LETTER ZEN
pub const key_georgian_tan = 0x10010d7 // U+10D7 GEORGIAN LETTER TAN
pub const key_georgian_in = 0x10010d8 // U+10D8 GEORGIAN LETTER IN
pub const key_georgian_kan = 0x10010d9 // U+10D9 GEORGIAN LETTER KAN
pub const key_georgian_las = 0x10010da // U+10DA GEORGIAN LETTER LAS
pub const key_georgian_man = 0x10010db // U+10DB GEORGIAN LETTER MAN
pub const key_georgian_nar = 0x10010dc // U+10DC GEORGIAN LETTER NAR
pub const key_georgian_on = 0x10010dd // U+10DD GEORGIAN LETTER ON
pub const key_georgian_par = 0x10010de // U+10DE GEORGIAN LETTER PAR
pub const key_georgian_zhar = 0x10010df // U+10DF GEORGIAN LETTER ZHAR
pub const key_georgian_rae = 0x10010e0 // U+10E0 GEORGIAN LETTER RAE
pub const key_georgian_san = 0x10010e1 // U+10E1 GEORGIAN LETTER SAN
pub const key_georgian_tar = 0x10010e2 // U+10E2 GEORGIAN LETTER TAR
pub const key_georgian_un = 0x10010e3 // U+10E3 GEORGIAN LETTER UN
pub const key_georgian_phar = 0x10010e4 // U+10E4 GEORGIAN LETTER PHAR
pub const key_georgian_khar = 0x10010e5 // U+10E5 GEORGIAN LETTER KHAR
pub const key_georgian_ghan = 0x10010e6 // U+10E6 GEORGIAN LETTER GHAN
pub const key_georgian_qar = 0x10010e7 // U+10E7 GEORGIAN LETTER QAR
pub const key_georgian_shin = 0x10010e8 // U+10E8 GEORGIAN LETTER SHIN
pub const key_georgian_chin = 0x10010e9 // U+10E9 GEORGIAN LETTER CHIN
pub const key_georgian_can = 0x10010ea // U+10EA GEORGIAN LETTER CAN
pub const key_georgian_jil = 0x10010eb // U+10EB GEORGIAN LETTER JIL
pub const key_georgian_cil = 0x10010ec // U+10EC GEORGIAN LETTER CIL
pub const key_georgian_char = 0x10010ed // U+10ED GEORGIAN LETTER CHAR
pub const key_georgian_xan = 0x10010ee // U+10EE GEORGIAN LETTER XAN
pub const key_georgian_jhan = 0x10010ef // U+10EF GEORGIAN LETTER JHAN
pub const key_georgian_hae = 0x10010f0 // U+10F0 GEORGIAN LETTER HAE
pub const key_georgian_he = 0x10010f1 // U+10F1 GEORGIAN LETTER HE
pub const key_georgian_hie = 0x10010f2 // U+10F2 GEORGIAN LETTER HIE
pub const key_georgian_we = 0x10010f3 // U+10F3 GEORGIAN LETTER WE
pub const key_georgian_har = 0x10010f4 // U+10F4 GEORGIAN LETTER HAR
pub const key_georgian_hoe = 0x10010f5 // U+10F5 GEORGIAN LETTER HOE
pub const key_georgian_fi = 0x10010f6 // U+10F6 GEORGIAN LETTER FI

//
////* Azeri (and other Turkic or Caucasian languages)
//

// latin
pub const key_xabovedot = 0x1001e8a // U+1E8A LATIN CAPITAL LETTER X WITH DOT ABOVE
pub const key_ibreve = 0x100012c // U+012C LATIN CAPITAL LETTER I WITH BREVE
pub const key_zstroke = 0x10001b5 // U+01B5 LATIN CAPITAL LETTER Z WITH STROKE
pub const key_gcaron = 0x10001e6 // U+01E6 LATIN CAPITAL LETTER G WITH CARON
pub const key_ocaron = 0x10001d1 // U+01D1 LATIN CAPITAL LETTER O WITH CARON
pub const key_obarred = 0x100019f // U+019F LATIN CAPITAL LETTER O WITH MIDDLE TILDE
pub const key_small_xabovedot = 0x1001e8b // U+1E8B LATIN SMALL LETTER X WITH DOT ABOVE
pub const key_small_ibreve = 0x100012d // U+012D LATIN SMALL LETTER I WITH BREVE
pub const key_small_zstroke = 0x10001b6 // U+01B6 LATIN SMALL LETTER Z WITH STROKE
pub const key_small_gcaron = 0x10001e7 // U+01E7 LATIN SMALL LETTER G WITH CARON
pub const key_small_ocaron = 0x10001d2 // U+01D2 LATIN SMALL LETTER O WITH CARON
pub const key_small_obarred = 0x1000275 // U+0275 LATIN SMALL LETTER BARRED O
pub const key_schwa = 0x100018f // U+018F LATIN CAPITAL LETTER SCHWA
pub const key_small_schwa = 0x1000259 // U+0259 LATIN SMALL LETTER SCHWA
pub const key_ezh = 0x10001b7 // U+01B7 LATIN CAPITAL LETTER EZH
pub const key_small_ezh = 0x1000292 // U+0292 LATIN SMALL LETTER EZH
// those are not really Caucasus
// For Inupiak
pub const key_lbelowdot = 0x1001e36 // U+1E36 LATIN CAPITAL LETTER L WITH DOT BELOW
pub const key_small_lbelowdot = 0x1001e37 // U+1E37 LATIN SMALL LETTER L WITH DOT BELOW

//
////* Vietnamese
//

pub const key_abelowdot = 0x1001ea0 // U+1EA0 LATIN CAPITAL LETTER A WITH DOT BELOW
pub const key_small_abelowdot = 0x1001ea1 // U+1EA1 LATIN SMALL LETTER A WITH DOT BELOW
pub const key_ahook = 0x1001ea2 // U+1EA2 LATIN CAPITAL LETTER A WITH HOOK ABOVE
pub const key_small_ahook = 0x1001ea3 // U+1EA3 LATIN SMALL LETTER A WITH HOOK ABOVE
pub const key_acircumflexacute = 0x1001ea4 // U+1EA4 LATIN CAPITAL LETTER A WITH CIRCUMFLEX AND ACUTE
pub const key_small_acircumflexacute = 0x1001ea5 // U+1EA5 LATIN SMALL LETTER A WITH CIRCUMFLEX AND ACUTE
pub const key_acircumflexgrave = 0x1001ea6 // U+1EA6 LATIN CAPITAL LETTER A WITH CIRCUMFLEX AND GRAVE
pub const key_small_acircumflexgrave = 0x1001ea7 // U+1EA7 LATIN SMALL LETTER A WITH CIRCUMFLEX AND GRAVE
pub const key_acircumflexhook = 0x1001ea8 // U+1EA8 LATIN CAPITAL LETTER A WITH CIRCUMFLEX AND HOOK ABOVE
pub const key_small_acircumflexhook = 0x1001ea9 // U+1EA9 LATIN SMALL LETTER A WITH CIRCUMFLEX AND HOOK ABOVE
pub const key_acircumflextilde = 0x1001eaa // U+1EAA LATIN CAPITAL LETTER A WITH CIRCUMFLEX AND TILDE
pub const key_small_acircumflextilde = 0x1001eab // U+1EAB LATIN SMALL LETTER A WITH CIRCUMFLEX AND TILDE
pub const key_acircumflexbelowdot = 0x1001eac // U+1EAC LATIN CAPITAL LETTER A WITH CIRCUMFLEX AND DOT BELOW
pub const key_small_acircumflexbelowdot = 0x1001ead // U+1EAD LATIN SMALL LETTER A WITH CIRCUMFLEX AND DOT BELOW
pub const key_abreveacute = 0x1001eae // U+1EAE LATIN CAPITAL LETTER A WITH BREVE AND ACUTE
pub const key_small_abreveacute = 0x1001eaf // U+1EAF LATIN SMALL LETTER A WITH BREVE AND ACUTE
pub const key_abrevegrave = 0x1001eb0 // U+1EB0 LATIN CAPITAL LETTER A WITH BREVE AND GRAVE
pub const key_small_abrevegrave = 0x1001eb1 // U+1EB1 LATIN SMALL LETTER A WITH BREVE AND GRAVE
pub const key_abrevehook = 0x1001eb2 // U+1EB2 LATIN CAPITAL LETTER A WITH BREVE AND HOOK ABOVE
pub const key_small_abrevehook = 0x1001eb3 // U+1EB3 LATIN SMALL LETTER A WITH BREVE AND HOOK ABOVE
pub const key_abrevetilde = 0x1001eb4 // U+1EB4 LATIN CAPITAL LETTER A WITH BREVE AND TILDE
pub const key_small_abrevetilde = 0x1001eb5 // U+1EB5 LATIN SMALL LETTER A WITH BREVE AND TILDE
pub const key_abrevebelowdot = 0x1001eb6 // U+1EB6 LATIN CAPITAL LETTER A WITH BREVE AND DOT BELOW
pub const key_small_abrevebelowdot = 0x1001eb7 // U+1EB7 LATIN SMALL LETTER A WITH BREVE AND DOT BELOW
pub const key_ebelowdot = 0x1001eb8 // U+1EB8 LATIN CAPITAL LETTER E WITH DOT BELOW
pub const key_small_ebelowdot = 0x1001eb9 // U+1EB9 LATIN SMALL LETTER E WITH DOT BELOW
pub const key_ehook = 0x1001eba // U+1EBA LATIN CAPITAL LETTER E WITH HOOK ABOVE
pub const key_small_ehook = 0x1001ebb // U+1EBB LATIN SMALL LETTER E WITH HOOK ABOVE
pub const key_etilde = 0x1001ebc // U+1EBC LATIN CAPITAL LETTER E WITH TILDE
pub const key_small_etilde = 0x1001ebd // U+1EBD LATIN SMALL LETTER E WITH TILDE
pub const key_ecircumflexacute = 0x1001ebe // U+1EBE LATIN CAPITAL LETTER E WITH CIRCUMFLEX AND ACUTE
pub const key_small_ecircumflexacute = 0x1001ebf // U+1EBF LATIN SMALL LETTER E WITH CIRCUMFLEX AND ACUTE
pub const key_ecircumflexgrave = 0x1001ec0 // U+1EC0 LATIN CAPITAL LETTER E WITH CIRCUMFLEX AND GRAVE
pub const key_small_ecircumflexgrave = 0x1001ec1 // U+1EC1 LATIN SMALL LETTER E WITH CIRCUMFLEX AND GRAVE
pub const key_ecircumflexhook = 0x1001ec2 // U+1EC2 LATIN CAPITAL LETTER E WITH CIRCUMFLEX AND HOOK ABOVE
pub const key_small_ecircumflexhook = 0x1001ec3 // U+1EC3 LATIN SMALL LETTER E WITH CIRCUMFLEX AND HOOK ABOVE
pub const key_ecircumflextilde = 0x1001ec4 // U+1EC4 LATIN CAPITAL LETTER E WITH CIRCUMFLEX AND TILDE
pub const key_small_ecircumflextilde = 0x1001ec5 // U+1EC5 LATIN SMALL LETTER E WITH CIRCUMFLEX AND TILDE
pub const key_ecircumflexbelowdot = 0x1001ec6 // U+1EC6 LATIN CAPITAL LETTER E WITH CIRCUMFLEX AND DOT BELOW
pub const key_small_ecircumflexbelowdot = 0x1001ec7 // U+1EC7 LATIN SMALL LETTER E WITH CIRCUMFLEX AND DOT BELOW
pub const key_ihook = 0x1001ec8 // U+1EC8 LATIN CAPITAL LETTER I WITH HOOK ABOVE
pub const key_small_ihook = 0x1001ec9 // U+1EC9 LATIN SMALL LETTER I WITH HOOK ABOVE
pub const key_ibelowdot = 0x1001eca // U+1ECA LATIN CAPITAL LETTER I WITH DOT BELOW
pub const key_small_ibelowdot = 0x1001ecb // U+1ECB LATIN SMALL LETTER I WITH DOT BELOW
pub const key_obelowdot = 0x1001ecc // U+1ECC LATIN CAPITAL LETTER O WITH DOT BELOW
pub const key_small_obelowdot = 0x1001ecd // U+1ECD LATIN SMALL LETTER O WITH DOT BELOW
pub const key_ohook = 0x1001ece // U+1ECE LATIN CAPITAL LETTER O WITH HOOK ABOVE
pub const key_small_ohook = 0x1001ecf // U+1ECF LATIN SMALL LETTER O WITH HOOK ABOVE
pub const key_ocircumflexacute = 0x1001ed0 // U+1ED0 LATIN CAPITAL LETTER O WITH CIRCUMFLEX AND ACUTE
pub const key_small_ocircumflexacute = 0x1001ed1 // U+1ED1 LATIN SMALL LETTER O WITH CIRCUMFLEX AND ACUTE
pub const key_ocircumflexgrave = 0x1001ed2 // U+1ED2 LATIN CAPITAL LETTER O WITH CIRCUMFLEX AND GRAVE
pub const key_small_ocircumflexgrave = 0x1001ed3 // U+1ED3 LATIN SMALL LETTER O WITH CIRCUMFLEX AND GRAVE
pub const key_ocircumflexhook = 0x1001ed4 // U+1ED4 LATIN CAPITAL LETTER O WITH CIRCUMFLEX AND HOOK ABOVE
pub const key_small_ocircumflexhook = 0x1001ed5 // U+1ED5 LATIN SMALL LETTER O WITH CIRCUMFLEX AND HOOK ABOVE
pub const key_ocircumflextilde = 0x1001ed6 // U+1ED6 LATIN CAPITAL LETTER O WITH CIRCUMFLEX AND TILDE
pub const key_small_ocircumflextilde = 0x1001ed7 // U+1ED7 LATIN SMALL LETTER O WITH CIRCUMFLEX AND TILDE
pub const key_ocircumflexbelowdot = 0x1001ed8 // U+1ED8 LATIN CAPITAL LETTER O WITH CIRCUMFLEX AND DOT BELOW
pub const key_small_ocircumflexbelowdot = 0x1001ed9 // U+1ED9 LATIN SMALL LETTER O WITH CIRCUMFLEX AND DOT BELOW
pub const key_ohornacute = 0x1001eda // U+1EDA LATIN CAPITAL LETTER O WITH HORN AND ACUTE
pub const key_small_ohornacute = 0x1001edb // U+1EDB LATIN SMALL LETTER O WITH HORN AND ACUTE
pub const key_ohorngrave = 0x1001edc // U+1EDC LATIN CAPITAL LETTER O WITH HORN AND GRAVE
pub const key_small_ohorngrave = 0x1001edd // U+1EDD LATIN SMALL LETTER O WITH HORN AND GRAVE
pub const key_ohornhook = 0x1001ede // U+1EDE LATIN CAPITAL LETTER O WITH HORN AND HOOK ABOVE
pub const key_small_ohornhook = 0x1001edf // U+1EDF LATIN SMALL LETTER O WITH HORN AND HOOK ABOVE
pub const key_ohorntilde = 0x1001ee0 // U+1EE0 LATIN CAPITAL LETTER O WITH HORN AND TILDE
pub const key_small_ohorntilde = 0x1001ee1 // U+1EE1 LATIN SMALL LETTER O WITH HORN AND TILDE
pub const key_ohornbelowdot = 0x1001ee2 // U+1EE2 LATIN CAPITAL LETTER O WITH HORN AND DOT BELOW
pub const key_small_ohornbelowdot = 0x1001ee3 // U+1EE3 LATIN SMALL LETTER O WITH HORN AND DOT BELOW
pub const key_ubelowdot = 0x1001ee4 // U+1EE4 LATIN CAPITAL LETTER U WITH DOT BELOW
pub const key_small_ubelowdot = 0x1001ee5 // U+1EE5 LATIN SMALL LETTER U WITH DOT BELOW
pub const key_uhook = 0x1001ee6 // U+1EE6 LATIN CAPITAL LETTER U WITH HOOK ABOVE
pub const key_small_uhook = 0x1001ee7 // U+1EE7 LATIN SMALL LETTER U WITH HOOK ABOVE
pub const key_uhornacute = 0x1001ee8 // U+1EE8 LATIN CAPITAL LETTER U WITH HORN AND ACUTE
pub const key_small_uhornacute = 0x1001ee9 // U+1EE9 LATIN SMALL LETTER U WITH HORN AND ACUTE
pub const key_uhorngrave = 0x1001eea // U+1EEA LATIN CAPITAL LETTER U WITH HORN AND GRAVE
pub const key_small_uhorngrave = 0x1001eeb // U+1EEB LATIN SMALL LETTER U WITH HORN AND GRAVE
pub const key_uhornhook = 0x1001eec // U+1EEC LATIN CAPITAL LETTER U WITH HORN AND HOOK ABOVE
pub const key_small_uhornhook = 0x1001eed // U+1EED LATIN SMALL LETTER U WITH HORN AND HOOK ABOVE
pub const key_uhorntilde = 0x1001eee // U+1EEE LATIN CAPITAL LETTER U WITH HORN AND TILDE
pub const key_small_uhorntilde = 0x1001eef // U+1EEF LATIN SMALL LETTER U WITH HORN AND TILDE
pub const key_uhornbelowdot = 0x1001ef0 // U+1EF0 LATIN CAPITAL LETTER U WITH HORN AND DOT BELOW
pub const key_small_uhornbelowdot = 0x1001ef1 // U+1EF1 LATIN SMALL LETTER U WITH HORN AND DOT BELOW
pub const key_ybelowdot = 0x1001ef4 // U+1EF4 LATIN CAPITAL LETTER Y WITH DOT BELOW
pub const key_small_ybelowdot = 0x1001ef5 // U+1EF5 LATIN SMALL LETTER Y WITH DOT BELOW
pub const key_yhook = 0x1001ef6 // U+1EF6 LATIN CAPITAL LETTER Y WITH HOOK ABOVE
pub const key_small_yhook = 0x1001ef7 // U+1EF7 LATIN SMALL LETTER Y WITH HOOK ABOVE
pub const key_ytilde = 0x1001ef8 // U+1EF8 LATIN CAPITAL LETTER Y WITH TILDE
pub const key_small_ytilde = 0x1001ef9 // U+1EF9 LATIN SMALL LETTER Y WITH TILDE
pub const key_ohorn = 0x10001a0 // U+01A0 LATIN CAPITAL LETTER O WITH HORN
pub const key_small_ohorn = 0x10001a1 // U+01A1 LATIN SMALL LETTER O WITH HORN
pub const key_uhorn = 0x10001af // U+01AF LATIN CAPITAL LETTER U WITH HORN
pub const key_small_uhorn = 0x10001b0 // U+01B0 LATIN SMALL LETTER U WITH HORN
pub const key_combining_tilde = 0x1000303 // U+0303 COMBINING TILDE
pub const key_combining_grave = 0x1000300 // U+0300 COMBINING GRAVE ACCENT
pub const key_combining_acute = 0x1000301 // U+0301 COMBINING ACUTE ACCENT
pub const key_combining_hook = 0x1000309 // U+0309 COMBINING HOOK ABOVE
pub const key_combining_belowdot = 0x1000323 // U+0323 COMBINING DOT BELOW

pub const key_ecusign = 0x10020a0 // U+20A0 EURO-CURRENCY SIGN
pub const key_colonsign = 0x10020a1 // U+20A1 COLON SIGN
pub const key_cruzeirosign = 0x10020a2 // U+20A2 CRUZEIRO SIGN
pub const key_ffrancsign = 0x10020a3 // U+20A3 FRENCH FRANC SIGN
pub const key_lirasign = 0x10020a4 // U+20A4 LIRA SIGN
pub const key_millsign = 0x10020a5 // U+20A5 MILL SIGN
pub const key_nairasign = 0x10020a6 // U+20A6 NAIRA SIGN
pub const key_pesetasign = 0x10020a7 // U+20A7 PESETA SIGN
pub const key_rupeesign = 0x10020a8 // U+20A8 RUPEE SIGN
pub const key_wonsign = 0x10020a9 // U+20A9 WON SIGN
pub const key_newsheqelsign = 0x10020aa // U+20AA NEW SHEQEL SIGN
pub const key_dongsign = 0x10020ab // U+20AB DONG SIGN
pub const key_eurosign = 0x20ac // U+20AC EURO SIGN

// one, two and three are defined above.
pub const key_zerosuperior = 0x1002070 // U+2070 SUPERSCRIPT ZERO
pub const key_foursuperior = 0x1002074 // U+2074 SUPERSCRIPT FOUR
pub const key_fivesuperior = 0x1002075 // U+2075 SUPERSCRIPT FIVE
pub const key_sixsuperior = 0x1002076 // U+2076 SUPERSCRIPT SIX
pub const key_sevensuperior = 0x1002077 // U+2077 SUPERSCRIPT SEVEN
pub const key_eightsuperior = 0x1002078 // U+2078 SUPERSCRIPT EIGHT
pub const key_ninesuperior = 0x1002079 // U+2079 SUPERSCRIPT NINE
pub const key_zerosubscript = 0x1002080 // U+2080 SUBSCRIPT ZERO
pub const key_onesubscript = 0x1002081 // U+2081 SUBSCRIPT ONE
pub const key_twosubscript = 0x1002082 // U+2082 SUBSCRIPT TWO
pub const key_threesubscript = 0x1002083 // U+2083 SUBSCRIPT THREE
pub const key_foursubscript = 0x1002084 // U+2084 SUBSCRIPT FOUR
pub const key_fivesubscript = 0x1002085 // U+2085 SUBSCRIPT FIVE
pub const key_sixsubscript = 0x1002086 // U+2086 SUBSCRIPT SIX
pub const key_sevensubscript = 0x1002087 // U+2087 SUBSCRIPT SEVEN
pub const key_eightsubscript = 0x1002088 // U+2088 SUBSCRIPT EIGHT
pub const key_ninesubscript = 0x1002089 // U+2089 SUBSCRIPT NINE
pub const key_partdifferential = 0x1002202 // U+2202 PARTIAL DIFFERENTIAL
pub const key_emptyset = 0x1002205 // U+2205 EMPTY SET
pub const key_elementof = 0x1002208 // U+2208 ELEMENT OF
pub const key_notelementof = 0x1002209 // U+2209 NOT AN ELEMENT OF
pub const key_containsas = 0x100220b // U+220B CONTAINS AS MEMBER
pub const key_squareroot = 0x100221a // U+221A SQUARE ROOT
pub const key_cuberoot = 0x100221b // U+221B CUBE ROOT
pub const key_fourthroot = 0x100221c // U+221C FOURTH ROOT
pub const key_dintegral = 0x100222c // U+222C DOUBLE INTEGRAL
pub const key_tintegral = 0x100222d // U+222D TRIPLE INTEGRAL
pub const key_because = 0x1002235 // U+2235 BECAUSE
pub const key_approxeq = 0x1002248 //(U+2248 ALMOST EQUAL TO)
pub const key_notapproxeq = 0x1002247 //(U+2247 NEITHER APPROXIMATELY NOR ACTUALLY EQUAL TO)
pub const key_notidentical = 0x1002262 // U+2262 NOT IDENTICAL TO
pub const key_stricteq = 0x1002263 // U+2263 STRICTLY EQUIVALENT TO

pub const key_braille_dot_1 = 0xfff1
pub const key_braille_dot_2 = 0xfff2
pub const key_braille_dot_3 = 0xfff3
pub const key_braille_dot_4 = 0xfff4
pub const key_braille_dot_5 = 0xfff5
pub const key_braille_dot_6 = 0xfff6
pub const key_braille_dot_7 = 0xfff7
pub const key_braille_dot_8 = 0xfff8
pub const key_braille_dot_9 = 0xfff9
pub const key_braille_dot_10 = 0xfffa
pub const key_braille_blank = 0x1002800 // U+2800 BRAILLE PATTERN BLANK
pub const key_braille_dots_1 = 0x1002801 // U+2801 BRAILLE PATTERN DOTS-1
pub const key_braille_dots_2 = 0x1002802 // U+2802 BRAILLE PATTERN DOTS-2
pub const key_braille_dots_12 = 0x1002803 // U+2803 BRAILLE PATTERN DOTS-12
pub const key_braille_dots_3 = 0x1002804 // U+2804 BRAILLE PATTERN DOTS-3
pub const key_braille_dots_13 = 0x1002805 // U+2805 BRAILLE PATTERN DOTS-13
pub const key_braille_dots_23 = 0x1002806 // U+2806 BRAILLE PATTERN DOTS-23
pub const key_braille_dots_123 = 0x1002807 // U+2807 BRAILLE PATTERN DOTS-123
pub const key_braille_dots_4 = 0x1002808 // U+2808 BRAILLE PATTERN DOTS-4
pub const key_braille_dots_14 = 0x1002809 // U+2809 BRAILLE PATTERN DOTS-14
pub const key_braille_dots_24 = 0x100280a // U+280A BRAILLE PATTERN DOTS-24
pub const key_braille_dots_124 = 0x100280b // U+280B BRAILLE PATTERN DOTS-124
pub const key_braille_dots_34 = 0x100280c // U+280C BRAILLE PATTERN DOTS-34
pub const key_braille_dots_134 = 0x100280d // U+280D BRAILLE PATTERN DOTS-134
pub const key_braille_dots_234 = 0x100280e // U+280E BRAILLE PATTERN DOTS-234
pub const key_braille_dots_1234 = 0x100280f // U+280F BRAILLE PATTERN DOTS-1234
pub const key_braille_dots_5 = 0x1002810 // U+2810 BRAILLE PATTERN DOTS-5
pub const key_braille_dots_15 = 0x1002811 // U+2811 BRAILLE PATTERN DOTS-15
pub const key_braille_dots_25 = 0x1002812 // U+2812 BRAILLE PATTERN DOTS-25
pub const key_braille_dots_125 = 0x1002813 // U+2813 BRAILLE PATTERN DOTS-125
pub const key_braille_dots_35 = 0x1002814 // U+2814 BRAILLE PATTERN DOTS-35
pub const key_braille_dots_135 = 0x1002815 // U+2815 BRAILLE PATTERN DOTS-135
pub const key_braille_dots_235 = 0x1002816 // U+2816 BRAILLE PATTERN DOTS-235
pub const key_braille_dots_1235 = 0x1002817 // U+2817 BRAILLE PATTERN DOTS-1235
pub const key_braille_dots_45 = 0x1002818 // U+2818 BRAILLE PATTERN DOTS-45
pub const key_braille_dots_145 = 0x1002819 // U+2819 BRAILLE PATTERN DOTS-145
pub const key_braille_dots_245 = 0x100281a // U+281A BRAILLE PATTERN DOTS-245
pub const key_braille_dots_1245 = 0x100281b // U+281B BRAILLE PATTERN DOTS-1245
pub const key_braille_dots_345 = 0x100281c // U+281C BRAILLE PATTERN DOTS-345
pub const key_braille_dots_1345 = 0x100281d // U+281D BRAILLE PATTERN DOTS-1345
pub const key_braille_dots_2345 = 0x100281e // U+281E BRAILLE PATTERN DOTS-2345
pub const key_braille_dots_12345 = 0x100281f // U+281F BRAILLE PATTERN DOTS-12345
pub const key_braille_dots_6 = 0x1002820 // U+2820 BRAILLE PATTERN DOTS-6
pub const key_braille_dots_16 = 0x1002821 // U+2821 BRAILLE PATTERN DOTS-16
pub const key_braille_dots_26 = 0x1002822 // U+2822 BRAILLE PATTERN DOTS-26
pub const key_braille_dots_126 = 0x1002823 // U+2823 BRAILLE PATTERN DOTS-126
pub const key_braille_dots_36 = 0x1002824 // U+2824 BRAILLE PATTERN DOTS-36
pub const key_braille_dots_136 = 0x1002825 // U+2825 BRAILLE PATTERN DOTS-136
pub const key_braille_dots_236 = 0x1002826 // U+2826 BRAILLE PATTERN DOTS-236
pub const key_braille_dots_1236 = 0x1002827 // U+2827 BRAILLE PATTERN DOTS-1236
pub const key_braille_dots_46 = 0x1002828 // U+2828 BRAILLE PATTERN DOTS-46
pub const key_braille_dots_146 = 0x1002829 // U+2829 BRAILLE PATTERN DOTS-146
pub const key_braille_dots_246 = 0x100282a // U+282A BRAILLE PATTERN DOTS-246
pub const key_braille_dots_1246 = 0x100282b // U+282B BRAILLE PATTERN DOTS-1246
pub const key_braille_dots_346 = 0x100282c // U+282C BRAILLE PATTERN DOTS-346
pub const key_braille_dots_1346 = 0x100282d // U+282D BRAILLE PATTERN DOTS-1346
pub const key_braille_dots_2346 = 0x100282e // U+282E BRAILLE PATTERN DOTS-2346
pub const key_braille_dots_12346 = 0x100282f // U+282F BRAILLE PATTERN DOTS-12346
pub const key_braille_dots_56 = 0x1002830 // U+2830 BRAILLE PATTERN DOTS-56
pub const key_braille_dots_156 = 0x1002831 // U+2831 BRAILLE PATTERN DOTS-156
pub const key_braille_dots_256 = 0x1002832 // U+2832 BRAILLE PATTERN DOTS-256
pub const key_braille_dots_1256 = 0x1002833 // U+2833 BRAILLE PATTERN DOTS-1256
pub const key_braille_dots_356 = 0x1002834 // U+2834 BRAILLE PATTERN DOTS-356
pub const key_braille_dots_1356 = 0x1002835 // U+2835 BRAILLE PATTERN DOTS-1356
pub const key_braille_dots_2356 = 0x1002836 // U+2836 BRAILLE PATTERN DOTS-2356
pub const key_braille_dots_12356 = 0x1002837 // U+2837 BRAILLE PATTERN DOTS-12356
pub const key_braille_dots_456 = 0x1002838 // U+2838 BRAILLE PATTERN DOTS-456
pub const key_braille_dots_1456 = 0x1002839 // U+2839 BRAILLE PATTERN DOTS-1456
pub const key_braille_dots_2456 = 0x100283a // U+283A BRAILLE PATTERN DOTS-2456
pub const key_braille_dots_12456 = 0x100283b // U+283B BRAILLE PATTERN DOTS-12456
pub const key_braille_dots_3456 = 0x100283c // U+283C BRAILLE PATTERN DOTS-3456
pub const key_braille_dots_13456 = 0x100283d // U+283D BRAILLE PATTERN DOTS-13456
pub const key_braille_dots_23456 = 0x100283e // U+283E BRAILLE PATTERN DOTS-23456
pub const key_braille_dots_123456 = 0x100283f // U+283F BRAILLE PATTERN DOTS-123456
pub const key_braille_dots_7 = 0x1002840 // U+2840 BRAILLE PATTERN DOTS-7
pub const key_braille_dots_17 = 0x1002841 // U+2841 BRAILLE PATTERN DOTS-17
pub const key_braille_dots_27 = 0x1002842 // U+2842 BRAILLE PATTERN DOTS-27
pub const key_braille_dots_127 = 0x1002843 // U+2843 BRAILLE PATTERN DOTS-127
pub const key_braille_dots_37 = 0x1002844 // U+2844 BRAILLE PATTERN DOTS-37
pub const key_braille_dots_137 = 0x1002845 // U+2845 BRAILLE PATTERN DOTS-137
pub const key_braille_dots_237 = 0x1002846 // U+2846 BRAILLE PATTERN DOTS-237
pub const key_braille_dots_1237 = 0x1002847 // U+2847 BRAILLE PATTERN DOTS-1237
pub const key_braille_dots_47 = 0x1002848 // U+2848 BRAILLE PATTERN DOTS-47
pub const key_braille_dots_147 = 0x1002849 // U+2849 BRAILLE PATTERN DOTS-147
pub const key_braille_dots_247 = 0x100284a // U+284A BRAILLE PATTERN DOTS-247
pub const key_braille_dots_1247 = 0x100284b // U+284B BRAILLE PATTERN DOTS-1247
pub const key_braille_dots_347 = 0x100284c // U+284C BRAILLE PATTERN DOTS-347
pub const key_braille_dots_1347 = 0x100284d // U+284D BRAILLE PATTERN DOTS-1347
pub const key_braille_dots_2347 = 0x100284e // U+284E BRAILLE PATTERN DOTS-2347
pub const key_braille_dots_12347 = 0x100284f // U+284F BRAILLE PATTERN DOTS-12347
pub const key_braille_dots_57 = 0x1002850 // U+2850 BRAILLE PATTERN DOTS-57
pub const key_braille_dots_157 = 0x1002851 // U+2851 BRAILLE PATTERN DOTS-157
pub const key_braille_dots_257 = 0x1002852 // U+2852 BRAILLE PATTERN DOTS-257
pub const key_braille_dots_1257 = 0x1002853 // U+2853 BRAILLE PATTERN DOTS-1257
pub const key_braille_dots_357 = 0x1002854 // U+2854 BRAILLE PATTERN DOTS-357
pub const key_braille_dots_1357 = 0x1002855 // U+2855 BRAILLE PATTERN DOTS-1357
pub const key_braille_dots_2357 = 0x1002856 // U+2856 BRAILLE PATTERN DOTS-2357
pub const key_braille_dots_12357 = 0x1002857 // U+2857 BRAILLE PATTERN DOTS-12357
pub const key_braille_dots_457 = 0x1002858 // U+2858 BRAILLE PATTERN DOTS-457
pub const key_braille_dots_1457 = 0x1002859 // U+2859 BRAILLE PATTERN DOTS-1457
pub const key_braille_dots_2457 = 0x100285a // U+285A BRAILLE PATTERN DOTS-2457
pub const key_braille_dots_12457 = 0x100285b // U+285B BRAILLE PATTERN DOTS-12457
pub const key_braille_dots_3457 = 0x100285c // U+285C BRAILLE PATTERN DOTS-3457
pub const key_braille_dots_13457 = 0x100285d // U+285D BRAILLE PATTERN DOTS-13457
pub const key_braille_dots_23457 = 0x100285e // U+285E BRAILLE PATTERN DOTS-23457
pub const key_braille_dots_123457 = 0x100285f // U+285F BRAILLE PATTERN DOTS-123457
pub const key_braille_dots_67 = 0x1002860 // U+2860 BRAILLE PATTERN DOTS-67
pub const key_braille_dots_167 = 0x1002861 // U+2861 BRAILLE PATTERN DOTS-167
pub const key_braille_dots_267 = 0x1002862 // U+2862 BRAILLE PATTERN DOTS-267
pub const key_braille_dots_1267 = 0x1002863 // U+2863 BRAILLE PATTERN DOTS-1267
pub const key_braille_dots_367 = 0x1002864 // U+2864 BRAILLE PATTERN DOTS-367
pub const key_braille_dots_1367 = 0x1002865 // U+2865 BRAILLE PATTERN DOTS-1367
pub const key_braille_dots_2367 = 0x1002866 // U+2866 BRAILLE PATTERN DOTS-2367
pub const key_braille_dots_12367 = 0x1002867 // U+2867 BRAILLE PATTERN DOTS-12367
pub const key_braille_dots_467 = 0x1002868 // U+2868 BRAILLE PATTERN DOTS-467
pub const key_braille_dots_1467 = 0x1002869 // U+2869 BRAILLE PATTERN DOTS-1467
pub const key_braille_dots_2467 = 0x100286a // U+286A BRAILLE PATTERN DOTS-2467
pub const key_braille_dots_12467 = 0x100286b // U+286B BRAILLE PATTERN DOTS-12467
pub const key_braille_dots_3467 = 0x100286c // U+286C BRAILLE PATTERN DOTS-3467
pub const key_braille_dots_13467 = 0x100286d // U+286D BRAILLE PATTERN DOTS-13467
pub const key_braille_dots_23467 = 0x100286e // U+286E BRAILLE PATTERN DOTS-23467
pub const key_braille_dots_123467 = 0x100286f // U+286F BRAILLE PATTERN DOTS-123467
pub const key_braille_dots_567 = 0x1002870 // U+2870 BRAILLE PATTERN DOTS-567
pub const key_braille_dots_1567 = 0x1002871 // U+2871 BRAILLE PATTERN DOTS-1567
pub const key_braille_dots_2567 = 0x1002872 // U+2872 BRAILLE PATTERN DOTS-2567
pub const key_braille_dots_12567 = 0x1002873 // U+2873 BRAILLE PATTERN DOTS-12567
pub const key_braille_dots_3567 = 0x1002874 // U+2874 BRAILLE PATTERN DOTS-3567
pub const key_braille_dots_13567 = 0x1002875 // U+2875 BRAILLE PATTERN DOTS-13567
pub const key_braille_dots_23567 = 0x1002876 // U+2876 BRAILLE PATTERN DOTS-23567
pub const key_braille_dots_123567 = 0x1002877 // U+2877 BRAILLE PATTERN DOTS-123567
pub const key_braille_dots_4567 = 0x1002878 // U+2878 BRAILLE PATTERN DOTS-4567
pub const key_braille_dots_14567 = 0x1002879 // U+2879 BRAILLE PATTERN DOTS-14567
pub const key_braille_dots_24567 = 0x100287a // U+287A BRAILLE PATTERN DOTS-24567
pub const key_braille_dots_124567 = 0x100287b // U+287B BRAILLE PATTERN DOTS-124567
pub const key_braille_dots_34567 = 0x100287c // U+287C BRAILLE PATTERN DOTS-34567
pub const key_braille_dots_134567 = 0x100287d // U+287D BRAILLE PATTERN DOTS-134567
pub const key_braille_dots_234567 = 0x100287e // U+287E BRAILLE PATTERN DOTS-234567
pub const key_braille_dots_1234567 = 0x100287f // U+287F BRAILLE PATTERN DOTS-1234567
pub const key_braille_dots_8 = 0x1002880 // U+2880 BRAILLE PATTERN DOTS-8
pub const key_braille_dots_18 = 0x1002881 // U+2881 BRAILLE PATTERN DOTS-18
pub const key_braille_dots_28 = 0x1002882 // U+2882 BRAILLE PATTERN DOTS-28
pub const key_braille_dots_128 = 0x1002883 // U+2883 BRAILLE PATTERN DOTS-128
pub const key_braille_dots_38 = 0x1002884 // U+2884 BRAILLE PATTERN DOTS-38
pub const key_braille_dots_138 = 0x1002885 // U+2885 BRAILLE PATTERN DOTS-138
pub const key_braille_dots_238 = 0x1002886 // U+2886 BRAILLE PATTERN DOTS-238
pub const key_braille_dots_1238 = 0x1002887 // U+2887 BRAILLE PATTERN DOTS-1238
pub const key_braille_dots_48 = 0x1002888 // U+2888 BRAILLE PATTERN DOTS-48
pub const key_braille_dots_148 = 0x1002889 // U+2889 BRAILLE PATTERN DOTS-148
pub const key_braille_dots_248 = 0x100288a // U+288A BRAILLE PATTERN DOTS-248
pub const key_braille_dots_1248 = 0x100288b // U+288B BRAILLE PATTERN DOTS-1248
pub const key_braille_dots_348 = 0x100288c // U+288C BRAILLE PATTERN DOTS-348
pub const key_braille_dots_1348 = 0x100288d // U+288D BRAILLE PATTERN DOTS-1348
pub const key_braille_dots_2348 = 0x100288e // U+288E BRAILLE PATTERN DOTS-2348
pub const key_braille_dots_12348 = 0x100288f // U+288F BRAILLE PATTERN DOTS-12348
pub const key_braille_dots_58 = 0x1002890 // U+2890 BRAILLE PATTERN DOTS-58
pub const key_braille_dots_158 = 0x1002891 // U+2891 BRAILLE PATTERN DOTS-158
pub const key_braille_dots_258 = 0x1002892 // U+2892 BRAILLE PATTERN DOTS-258
pub const key_braille_dots_1258 = 0x1002893 // U+2893 BRAILLE PATTERN DOTS-1258
pub const key_braille_dots_358 = 0x1002894 // U+2894 BRAILLE PATTERN DOTS-358
pub const key_braille_dots_1358 = 0x1002895 // U+2895 BRAILLE PATTERN DOTS-1358
pub const key_braille_dots_2358 = 0x1002896 // U+2896 BRAILLE PATTERN DOTS-2358
pub const key_braille_dots_12358 = 0x1002897 // U+2897 BRAILLE PATTERN DOTS-12358
pub const key_braille_dots_458 = 0x1002898 // U+2898 BRAILLE PATTERN DOTS-458
pub const key_braille_dots_1458 = 0x1002899 // U+2899 BRAILLE PATTERN DOTS-1458
pub const key_braille_dots_2458 = 0x100289a // U+289A BRAILLE PATTERN DOTS-2458
pub const key_braille_dots_12458 = 0x100289b // U+289B BRAILLE PATTERN DOTS-12458
pub const key_braille_dots_3458 = 0x100289c // U+289C BRAILLE PATTERN DOTS-3458
pub const key_braille_dots_13458 = 0x100289d // U+289D BRAILLE PATTERN DOTS-13458
pub const key_braille_dots_23458 = 0x100289e // U+289E BRAILLE PATTERN DOTS-23458
pub const key_braille_dots_123458 = 0x100289f // U+289F BRAILLE PATTERN DOTS-123458
pub const key_braille_dots_68 = 0x10028a0 // U+28A0 BRAILLE PATTERN DOTS-68
pub const key_braille_dots_168 = 0x10028a1 // U+28A1 BRAILLE PATTERN DOTS-168
pub const key_braille_dots_268 = 0x10028a2 // U+28A2 BRAILLE PATTERN DOTS-268
pub const key_braille_dots_1268 = 0x10028a3 // U+28A3 BRAILLE PATTERN DOTS-1268
pub const key_braille_dots_368 = 0x10028a4 // U+28A4 BRAILLE PATTERN DOTS-368
pub const key_braille_dots_1368 = 0x10028a5 // U+28A5 BRAILLE PATTERN DOTS-1368
pub const key_braille_dots_2368 = 0x10028a6 // U+28A6 BRAILLE PATTERN DOTS-2368
pub const key_braille_dots_12368 = 0x10028a7 // U+28A7 BRAILLE PATTERN DOTS-12368
pub const key_braille_dots_468 = 0x10028a8 // U+28A8 BRAILLE PATTERN DOTS-468
pub const key_braille_dots_1468 = 0x10028a9 // U+28A9 BRAILLE PATTERN DOTS-1468
pub const key_braille_dots_2468 = 0x10028aa // U+28AA BRAILLE PATTERN DOTS-2468
pub const key_braille_dots_12468 = 0x10028ab // U+28AB BRAILLE PATTERN DOTS-12468
pub const key_braille_dots_3468 = 0x10028ac // U+28AC BRAILLE PATTERN DOTS-3468
pub const key_braille_dots_13468 = 0x10028ad // U+28AD BRAILLE PATTERN DOTS-13468
pub const key_braille_dots_23468 = 0x10028ae // U+28AE BRAILLE PATTERN DOTS-23468
pub const key_braille_dots_123468 = 0x10028af // U+28AF BRAILLE PATTERN DOTS-123468
pub const key_braille_dots_568 = 0x10028b0 // U+28B0 BRAILLE PATTERN DOTS-568
pub const key_braille_dots_1568 = 0x10028b1 // U+28B1 BRAILLE PATTERN DOTS-1568
pub const key_braille_dots_2568 = 0x10028b2 // U+28B2 BRAILLE PATTERN DOTS-2568
pub const key_braille_dots_12568 = 0x10028b3 // U+28B3 BRAILLE PATTERN DOTS-12568
pub const key_braille_dots_3568 = 0x10028b4 // U+28B4 BRAILLE PATTERN DOTS-3568
pub const key_braille_dots_13568 = 0x10028b5 // U+28B5 BRAILLE PATTERN DOTS-13568
pub const key_braille_dots_23568 = 0x10028b6 // U+28B6 BRAILLE PATTERN DOTS-23568
pub const key_braille_dots_123568 = 0x10028b7 // U+28B7 BRAILLE PATTERN DOTS-123568
pub const key_braille_dots_4568 = 0x10028b8 // U+28B8 BRAILLE PATTERN DOTS-4568
pub const key_braille_dots_14568 = 0x10028b9 // U+28B9 BRAILLE PATTERN DOTS-14568
pub const key_braille_dots_24568 = 0x10028ba // U+28BA BRAILLE PATTERN DOTS-24568
pub const key_braille_dots_124568 = 0x10028bb // U+28BB BRAILLE PATTERN DOTS-124568
pub const key_braille_dots_34568 = 0x10028bc // U+28BC BRAILLE PATTERN DOTS-34568
pub const key_braille_dots_134568 = 0x10028bd // U+28BD BRAILLE PATTERN DOTS-134568
pub const key_braille_dots_234568 = 0x10028be // U+28BE BRAILLE PATTERN DOTS-234568
pub const key_braille_dots_1234568 = 0x10028bf // U+28BF BRAILLE PATTERN DOTS-1234568
pub const key_braille_dots_78 = 0x10028c0 // U+28C0 BRAILLE PATTERN DOTS-78
pub const key_braille_dots_178 = 0x10028c1 // U+28C1 BRAILLE PATTERN DOTS-178
pub const key_braille_dots_278 = 0x10028c2 // U+28C2 BRAILLE PATTERN DOTS-278
pub const key_braille_dots_1278 = 0x10028c3 // U+28C3 BRAILLE PATTERN DOTS-1278
pub const key_braille_dots_378 = 0x10028c4 // U+28C4 BRAILLE PATTERN DOTS-378
pub const key_braille_dots_1378 = 0x10028c5 // U+28C5 BRAILLE PATTERN DOTS-1378
pub const key_braille_dots_2378 = 0x10028c6 // U+28C6 BRAILLE PATTERN DOTS-2378
pub const key_braille_dots_12378 = 0x10028c7 // U+28C7 BRAILLE PATTERN DOTS-12378
pub const key_braille_dots_478 = 0x10028c8 // U+28C8 BRAILLE PATTERN DOTS-478
pub const key_braille_dots_1478 = 0x10028c9 // U+28C9 BRAILLE PATTERN DOTS-1478
pub const key_braille_dots_2478 = 0x10028ca // U+28CA BRAILLE PATTERN DOTS-2478
pub const key_braille_dots_12478 = 0x10028cb // U+28CB BRAILLE PATTERN DOTS-12478
pub const key_braille_dots_3478 = 0x10028cc // U+28CC BRAILLE PATTERN DOTS-3478
pub const key_braille_dots_13478 = 0x10028cd // U+28CD BRAILLE PATTERN DOTS-13478
pub const key_braille_dots_23478 = 0x10028ce // U+28CE BRAILLE PATTERN DOTS-23478
pub const key_braille_dots_123478 = 0x10028cf // U+28CF BRAILLE PATTERN DOTS-123478
pub const key_braille_dots_578 = 0x10028d0 // U+28D0 BRAILLE PATTERN DOTS-578
pub const key_braille_dots_1578 = 0x10028d1 // U+28D1 BRAILLE PATTERN DOTS-1578
pub const key_braille_dots_2578 = 0x10028d2 // U+28D2 BRAILLE PATTERN DOTS-2578
pub const key_braille_dots_12578 = 0x10028d3 // U+28D3 BRAILLE PATTERN DOTS-12578
pub const key_braille_dots_3578 = 0x10028d4 // U+28D4 BRAILLE PATTERN DOTS-3578
pub const key_braille_dots_13578 = 0x10028d5 // U+28D5 BRAILLE PATTERN DOTS-13578
pub const key_braille_dots_23578 = 0x10028d6 // U+28D6 BRAILLE PATTERN DOTS-23578
pub const key_braille_dots_123578 = 0x10028d7 // U+28D7 BRAILLE PATTERN DOTS-123578
pub const key_braille_dots_4578 = 0x10028d8 // U+28D8 BRAILLE PATTERN DOTS-4578
pub const key_braille_dots_14578 = 0x10028d9 // U+28D9 BRAILLE PATTERN DOTS-14578
pub const key_braille_dots_24578 = 0x10028da // U+28DA BRAILLE PATTERN DOTS-24578
pub const key_braille_dots_124578 = 0x10028db // U+28DB BRAILLE PATTERN DOTS-124578
pub const key_braille_dots_34578 = 0x10028dc // U+28DC BRAILLE PATTERN DOTS-34578
pub const key_braille_dots_134578 = 0x10028dd // U+28DD BRAILLE PATTERN DOTS-134578
pub const key_braille_dots_234578 = 0x10028de // U+28DE BRAILLE PATTERN DOTS-234578
pub const key_braille_dots_1234578 = 0x10028df // U+28DF BRAILLE PATTERN DOTS-1234578
pub const key_braille_dots_678 = 0x10028e0 // U+28E0 BRAILLE PATTERN DOTS-678
pub const key_braille_dots_1678 = 0x10028e1 // U+28E1 BRAILLE PATTERN DOTS-1678
pub const key_braille_dots_2678 = 0x10028e2 // U+28E2 BRAILLE PATTERN DOTS-2678
pub const key_braille_dots_12678 = 0x10028e3 // U+28E3 BRAILLE PATTERN DOTS-12678
pub const key_braille_dots_3678 = 0x10028e4 // U+28E4 BRAILLE PATTERN DOTS-3678
pub const key_braille_dots_13678 = 0x10028e5 // U+28E5 BRAILLE PATTERN DOTS-13678
pub const key_braille_dots_23678 = 0x10028e6 // U+28E6 BRAILLE PATTERN DOTS-23678
pub const key_braille_dots_123678 = 0x10028e7 // U+28E7 BRAILLE PATTERN DOTS-123678
pub const key_braille_dots_4678 = 0x10028e8 // U+28E8 BRAILLE PATTERN DOTS-4678
pub const key_braille_dots_14678 = 0x10028e9 // U+28E9 BRAILLE PATTERN DOTS-14678
pub const key_braille_dots_24678 = 0x10028ea // U+28EA BRAILLE PATTERN DOTS-24678
pub const key_braille_dots_124678 = 0x10028eb // U+28EB BRAILLE PATTERN DOTS-124678
pub const key_braille_dots_34678 = 0x10028ec // U+28EC BRAILLE PATTERN DOTS-34678
pub const key_braille_dots_134678 = 0x10028ed // U+28ED BRAILLE PATTERN DOTS-134678
pub const key_braille_dots_234678 = 0x10028ee // U+28EE BRAILLE PATTERN DOTS-234678
pub const key_braille_dots_1234678 = 0x10028ef // U+28EF BRAILLE PATTERN DOTS-1234678
pub const key_braille_dots_5678 = 0x10028f0 // U+28F0 BRAILLE PATTERN DOTS-5678
pub const key_braille_dots_15678 = 0x10028f1 // U+28F1 BRAILLE PATTERN DOTS-15678
pub const key_braille_dots_25678 = 0x10028f2 // U+28F2 BRAILLE PATTERN DOTS-25678
pub const key_braille_dots_125678 = 0x10028f3 // U+28F3 BRAILLE PATTERN DOTS-125678
pub const key_braille_dots_35678 = 0x10028f4 // U+28F4 BRAILLE PATTERN DOTS-35678
pub const key_braille_dots_135678 = 0x10028f5 // U+28F5 BRAILLE PATTERN DOTS-135678
pub const key_braille_dots_235678 = 0x10028f6 // U+28F6 BRAILLE PATTERN DOTS-235678
pub const key_braille_dots_1235678 = 0x10028f7 // U+28F7 BRAILLE PATTERN DOTS-1235678
pub const key_braille_dots_45678 = 0x10028f8 // U+28F8 BRAILLE PATTERN DOTS-45678
pub const key_braille_dots_145678 = 0x10028f9 // U+28F9 BRAILLE PATTERN DOTS-145678
pub const key_braille_dots_245678 = 0x10028fa // U+28FA BRAILLE PATTERN DOTS-245678
pub const key_braille_dots_1245678 = 0x10028fb // U+28FB BRAILLE PATTERN DOTS-1245678
pub const key_braille_dots_345678 = 0x10028fc // U+28FC BRAILLE PATTERN DOTS-345678
pub const key_braille_dots_1345678 = 0x10028fd // U+28FD BRAILLE PATTERN DOTS-1345678
pub const key_braille_dots_2345678 = 0x10028fe // U+28FE BRAILLE PATTERN DOTS-2345678
pub const key_braille_dots_12345678 = 0x10028ff // U+28FF BRAILLE PATTERN DOTS-12345678

//
////* Sinhala (http://unicode.org/charts/PDF/U0D80.pdf)
////* http://www.nongnu.org/sinhala/doc/transliteration/sinhala-transliteration_6.html
//

pub const key_sinh_ng = 0x1000d82 // U+0D82 SINHALA SIGN ANUSVARAYA
pub const key_sinh_h2 = 0x1000d83 // U+0D83 SINHALA SIGN VISARGAYA
pub const key_sinh_a = 0x1000d85 // U+0D85 SINHALA LETTER AYANNA
pub const key_sinh_aa = 0x1000d86 // U+0D86 SINHALA LETTER AAYANNA
pub const key_sinh_ae = 0x1000d87 // U+0D87 SINHALA LETTER AEYANNA
pub const key_sinh_aee = 0x1000d88 // U+0D88 SINHALA LETTER AEEYANNA
pub const key_sinh_i = 0x1000d89 // U+0D89 SINHALA LETTER IYANNA
pub const key_sinh_ii = 0x1000d8a // U+0D8A SINHALA LETTER IIYANNA
pub const key_sinh_u = 0x1000d8b // U+0D8B SINHALA LETTER UYANNA
pub const key_sinh_uu = 0x1000d8c // U+0D8C SINHALA LETTER UUYANNA
pub const key_sinh_ri = 0x1000d8d // U+0D8D SINHALA LETTER IRUYANNA
pub const key_sinh_rii = 0x1000d8e // U+0D8E SINHALA LETTER IRUUYANNA
pub const key_sinh_lu = 0x1000d8f // U+0D8F SINHALA LETTER ILUYANNA
pub const key_sinh_luu = 0x1000d90 // U+0D90 SINHALA LETTER ILUUYANNA
pub const key_sinh_e = 0x1000d91 // U+0D91 SINHALA LETTER EYANNA
pub const key_sinh_ee = 0x1000d92 // U+0D92 SINHALA LETTER EEYANNA
pub const key_sinh_ai = 0x1000d93 // U+0D93 SINHALA LETTER AIYANNA
pub const key_sinh_o = 0x1000d94 // U+0D94 SINHALA LETTER OYANNA
pub const key_sinh_oo = 0x1000d95 // U+0D95 SINHALA LETTER OOYANNA
pub const key_sinh_au = 0x1000d96 // U+0D96 SINHALA LETTER AUYANNA
pub const key_sinh_ka = 0x1000d9a // U+0D9A SINHALA LETTER ALPAPRAANA KAYANNA
pub const key_sinh_kha = 0x1000d9b // U+0D9B SINHALA LETTER MAHAAPRAANA KAYANNA
pub const key_sinh_ga = 0x1000d9c // U+0D9C SINHALA LETTER ALPAPRAANA GAYANNA
pub const key_sinh_gha = 0x1000d9d // U+0D9D SINHALA LETTER MAHAAPRAANA GAYANNA
pub const key_sinh_ng2 = 0x1000d9e // U+0D9E SINHALA LETTER KANTAJA NAASIKYAYA
pub const key_sinh_nga = 0x1000d9f // U+0D9F SINHALA LETTER SANYAKA GAYANNA
pub const key_sinh_ca = 0x1000da0 // U+0DA0 SINHALA LETTER ALPAPRAANA CAYANNA
pub const key_sinh_cha = 0x1000da1 // U+0DA1 SINHALA LETTER MAHAAPRAANA CAYANNA
pub const key_sinh_ja = 0x1000da2 // U+0DA2 SINHALA LETTER ALPAPRAANA JAYANNA
pub const key_sinh_jha = 0x1000da3 // U+0DA3 SINHALA LETTER MAHAAPRAANA JAYANNA
pub const key_sinh_nya = 0x1000da4 // U+0DA4 SINHALA LETTER TAALUJA NAASIKYAYA
pub const key_sinh_jnya = 0x1000da5 // U+0DA5 SINHALA LETTER TAALUJA SANYOOGA NAAKSIKYAYA
pub const key_sinh_nja = 0x1000da6 // U+0DA6 SINHALA LETTER SANYAKA JAYANNA
pub const key_sinh_tta = 0x1000da7 // U+0DA7 SINHALA LETTER ALPAPRAANA TTAYANNA
pub const key_sinh_ttha = 0x1000da8 // U+0DA8 SINHALA LETTER MAHAAPRAANA TTAYANNA
pub const key_sinh_dda = 0x1000da9 // U+0DA9 SINHALA LETTER ALPAPRAANA DDAYANNA
pub const key_sinh_ddha = 0x1000daa // U+0DAA SINHALA LETTER MAHAAPRAANA DDAYANNA
pub const key_sinh_nna = 0x1000dab // U+0DAB SINHALA LETTER MUURDHAJA NAYANNA
pub const key_sinh_ndda = 0x1000dac // U+0DAC SINHALA LETTER SANYAKA DDAYANNA
pub const key_sinh_tha = 0x1000dad // U+0DAD SINHALA LETTER ALPAPRAANA TAYANNA
pub const key_sinh_thha = 0x1000dae // U+0DAE SINHALA LETTER MAHAAPRAANA TAYANNA
pub const key_sinh_dha = 0x1000daf // U+0DAF SINHALA LETTER ALPAPRAANA DAYANNA
pub const key_sinh_dhha = 0x1000db0 // U+0DB0 SINHALA LETTER MAHAAPRAANA DAYANNA
pub const key_sinh_na = 0x1000db1 // U+0DB1 SINHALA LETTER DANTAJA NAYANNA
pub const key_sinh_ndha = 0x1000db3 // U+0DB3 SINHALA LETTER SANYAKA DAYANNA
pub const key_sinh_pa = 0x1000db4 // U+0DB4 SINHALA LETTER ALPAPRAANA PAYANNA
pub const key_sinh_pha = 0x1000db5 // U+0DB5 SINHALA LETTER MAHAAPRAANA PAYANNA
pub const key_sinh_ba = 0x1000db6 // U+0DB6 SINHALA LETTER ALPAPRAANA BAYANNA
pub const key_sinh_bha = 0x1000db7 // U+0DB7 SINHALA LETTER MAHAAPRAANA BAYANNA
pub const key_sinh_ma = 0x1000db8 // U+0DB8 SINHALA LETTER MAYANNA
pub const key_sinh_mba = 0x1000db9 // U+0DB9 SINHALA LETTER AMBA BAYANNA
pub const key_sinh_ya = 0x1000dba // U+0DBA SINHALA LETTER YAYANNA
pub const key_sinh_ra = 0x1000dbb // U+0DBB SINHALA LETTER RAYANNA
pub const key_sinh_la = 0x1000dbd // U+0DBD SINHALA LETTER DANTAJA LAYANNA
pub const key_sinh_va = 0x1000dc0 // U+0DC0 SINHALA LETTER VAYANNA
pub const key_sinh_sha = 0x1000dc1 // U+0DC1 SINHALA LETTER TAALUJA SAYANNA
pub const key_sinh_ssha = 0x1000dc2 // U+0DC2 SINHALA LETTER MUURDHAJA SAYANNA
pub const key_sinh_sa = 0x1000dc3 // U+0DC3 SINHALA LETTER DANTAJA SAYANNA
pub const key_sinh_ha = 0x1000dc4 // U+0DC4 SINHALA LETTER HAYANNA
pub const key_sinh_lla = 0x1000dc5 // U+0DC5 SINHALA LETTER MUURDHAJA LAYANNA
pub const key_sinh_fa = 0x1000dc6 // U+0DC6 SINHALA LETTER FAYANNA
pub const key_sinh_al = 0x1000dca // U+0DCA SINHALA SIGN AL-LAKUNA
pub const key_sinh_aa2 = 0x1000dcf // U+0DCF SINHALA VOWEL SIGN AELA-PILLA
pub const key_sinh_ae2 = 0x1000dd0 // U+0DD0 SINHALA VOWEL SIGN KETTI AEDA-PILLA
pub const key_sinh_aee2 = 0x1000dd1 // U+0DD1 SINHALA VOWEL SIGN DIGA AEDA-PILLA
pub const key_sinh_i2 = 0x1000dd2 // U+0DD2 SINHALA VOWEL SIGN KETTI IS-PILLA
pub const key_sinh_ii2 = 0x1000dd3 // U+0DD3 SINHALA VOWEL SIGN DIGA IS-PILLA
pub const key_sinh_u2 = 0x1000dd4 // U+0DD4 SINHALA VOWEL SIGN KETTI PAA-PILLA
pub const key_sinh_uu2 = 0x1000dd6 // U+0DD6 SINHALA VOWEL SIGN DIGA PAA-PILLA
pub const key_sinh_ru2 = 0x1000dd8 // U+0DD8 SINHALA VOWEL SIGN GAETTA-PILLA
pub const key_sinh_e2 = 0x1000dd9 // U+0DD9 SINHALA VOWEL SIGN KOMBUVA
pub const key_sinh_ee2 = 0x1000dda // U+0DDA SINHALA VOWEL SIGN DIGA KOMBUVA
pub const key_sinh_ai2 = 0x1000ddb // U+0DDB SINHALA VOWEL SIGN KOMBU DEKA
pub const key_sinh_o2 = 0x1000ddc // U+0DDC SINHALA VOWEL SIGN KOMBUVA HAA AELA-PILLA
pub const key_sinh_oo2 = 0x1000ddd // U+0DDD SINHALA VOWEL SIGN KOMBUVA HAA DIGA AELA-PILLA
pub const key_sinh_au2 = 0x1000dde // U+0DDE SINHALA VOWEL SIGN KOMBUVA HAA GAYANUKITTA
pub const key_sinh_lu2 = 0x1000ddf // U+0DDF SINHALA VOWEL SIGN GAYANUKITTA
pub const key_sinh_ruu2 = 0x1000df2 // U+0DF2 SINHALA VOWEL SIGN DIGA GAETTA-PILLA
pub const key_sinh_luu2 = 0x1000df3 // U+0DF3 SINHALA VOWEL SIGN DIGA GAYANUKITTA
pub const key_sinh_kunddaliya = 0x1000df4 // U+0DF4 SINHALA PUNCTUATION KUNDDALIYA
//
////* XFree86 vendor specific keysyms.
////*
////* The XFree86 keysym range is := 0x10080001 - := 0x1008ffff.
////*
////* The XF86 set of keysyms is a catch-all set of defines for keysyms found
////* on various multimedia keyboards. Originally specific to XFree86 they have
////* been been adopted over time and are considered a "standard" part of X
////* keysym definitions.
////* XFree86 never properly commented these keysyms, so we have done our
////* best to explain the semantic meaning of these keys.
////*
////* XFree86 has removed their mail archives of the period, that might have
////* shed more light on some of these definitions. Until/unless we resurrect
////* these archives, these are from memory and usage.
//

//
////* ModeLock
////*
////* This one is old, and not really used any more since XKB offers this
////* functionality.
//

pub const key_xf86modelock = 0x1008ff01 // Mode Switch Lock

// Backlight controls.
pub const key_xf86monbrightnessup = 0x1008ff02 // Monitor/panel brightness
pub const key_xf86monbrightnessdown = 0x1008ff03 // Monitor/panel brightness
pub const key_xf86kbdlightonoff = 0x1008ff04 // Keyboards may be lit
pub const key_xf86kbdbrightnessup = 0x1008ff05 // Keyboards may be lit
pub const key_xf86kbdbrightnessdown = 0x1008ff06 // Keyboards may be lit
pub const key_xf86monbrightnesscycle = 0x1008ff07 // Monitor/panel brightness

//
////* Keys found on some "Internet" keyboards.
//

pub const key_xf86standby = 0x1008ff10 // System into standby mode
pub const key_xf86audiolowervolume = 0x1008ff11 // Volume control down
pub const key_xf86audiomute = 0x1008ff12 // Mute sound from the system
pub const key_xf86audioraisevolume = 0x1008ff13 // Volume control up
pub const key_xf86audioplay = 0x1008ff14 // Start playing of audio >
pub const key_xf86audiostop = 0x1008ff15 // Stop playing audio
pub const key_xf86audioprev = 0x1008ff16 // Previous track
pub const key_xf86audionext = 0x1008ff17 // Next track
pub const key_xf86homepage = 0x1008ff18 // Display user's home page
pub const key_xf86mail = 0x1008ff19 // Invoke user's mail program
pub const key_xf86start = 0x1008ff1a // Start application
pub const key_xf86search = 0x1008ff1b // Search
pub const key_xf86audiorecord = 0x1008ff1c // Record audio application

// These are sometimes found on PDA's (e.g. Palm, PocketPC or elsewhere)
pub const key_xf86calculator = 0x1008ff1d // Invoke calculator program
pub const key_xf86memo = 0x1008ff1e // Invoke Memo taking program
pub const key_xf86todolist = 0x1008ff1f // Invoke To Do List program
pub const key_xf86calendar = 0x1008ff20 // Invoke Calendar program
pub const key_xf86powerdown = 0x1008ff21 // Deep sleep the system
pub const key_xf86contrastadjust = 0x1008ff22 // Adjust screen contrast
pub const key_xf86rockerup = 0x1008ff23 // Rocker switches exist up
pub const key_xf86rockerdown = 0x1008ff24 // and down
pub const key_xf86rockerenter = 0x1008ff25 // and let you press them

// Some more "Internet" keyboard symbols
pub const key_xf86back = 0x1008ff26 // Like back on a browser
pub const key_xf86forward = 0x1008ff27 // Like forward on a browser
pub const key_xf86stop = 0x1008ff28 // Stop current operation
pub const key_xf86refresh = 0x1008ff29 // Refresh the page
pub const key_xf86poweroff = 0x1008ff2a // Power off system entirely
pub const key_xf86wakeup = 0x1008ff2b // Wake up system from sleep
pub const key_xf86eject = 0x1008ff2c // Eject device (e.g. DVD)
pub const key_xf86screensaver = 0x1008ff2d // Invoke screensaver
pub const key_xf86www = 0x1008ff2e // Invoke web browser
pub const key_xf86sleep = 0x1008ff2f // Put system to sleep
pub const key_xf86favorites = 0x1008ff30 // Show favorite locations
pub const key_xf86audiopause = 0x1008ff31 // Pause audio playing
pub const key_xf86audiomedia = 0x1008ff32 // Launch media collection app
pub const key_xf86mycomputer = 0x1008ff33 // Display "My Computer" window
pub const key_xf86vendorhome = 0x1008ff34 // Display vendor home web site
pub const key_xf86lightbulb = 0x1008ff35 // Light bulb keys exist
pub const key_xf86shop = 0x1008ff36 // Display shopping web site
pub const key_xf86history = 0x1008ff37 // Show history of web surfing
pub const key_xf86openurl = 0x1008ff38 // Open selected URL
pub const key_xf86addfavorite = 0x1008ff39 // Add URL to favorites list
pub const key_xf86hotlinks = 0x1008ff3a // Show "hot" links
pub const key_xf86brightnessadjust = 0x1008ff3b // Invoke brightness adj. UI
pub const key_xf86finance = 0x1008ff3c // Display financial site
pub const key_xf86community = 0x1008ff3d // Display user's community
pub const key_xf86audiorewind = 0x1008ff3e // "rewind" audio track
pub const key_xf86backforward = 0x1008ff3f // ???
pub const key_xf86launch0 = 0x1008ff40 // Launch Application
pub const key_xf86launch1 = 0x1008ff41 // Launch Application
pub const key_xf86launch2 = 0x1008ff42 // Launch Application
pub const key_xf86launch3 = 0x1008ff43 // Launch Application
pub const key_xf86launch4 = 0x1008ff44 // Launch Application
pub const key_xf86launch5 = 0x1008ff45 // Launch Application
pub const key_xf86launch6 = 0x1008ff46 // Launch Application
pub const key_xf86launch7 = 0x1008ff47 // Launch Application
pub const key_xf86launch8 = 0x1008ff48 // Launch Application
pub const key_xf86launch9 = 0x1008ff49 // Launch Application
pub const key_xf86launcha = 0x1008ff4a // Launch Application
pub const key_xf86launchb = 0x1008ff4b // Launch Application
pub const key_xf86launchc = 0x1008ff4c // Launch Application
pub const key_xf86launchd = 0x1008ff4d // Launch Application
pub const key_xf86launche = 0x1008ff4e // Launch Application
pub const key_xf86launchf = 0x1008ff4f // Launch Application

pub const key_xf86applicationleft = 0x1008ff50 // switch to application, left
pub const key_xf86applicationright = 0x1008ff51 // switch to application, right
pub const key_xf86book = 0x1008ff52 // Launch bookreader
pub const key_xf86cd = 0x1008ff53 // Launch CD/DVD player
pub const key_xf86calculater = 0x1008ff54 // Launch Calculater
pub const key_xf86clear = 0x1008ff55 // Clear window, screen
pub const key_xf86close = 0x1008ff56 // Close window
pub const key_xf86copy = 0x1008ff57 // Copy selection
pub const key_xf86cut = 0x1008ff58 // Cut selection
pub const key_xf86display = 0x1008ff59 // Output switch key
pub const key_xf86dos = 0x1008ff5a // Launch DOS (emulation)
pub const key_xf86documents = 0x1008ff5b // Open documents window
pub const key_xf86excel = 0x1008ff5c // Launch spread sheet
pub const key_xf86explorer = 0x1008ff5d // Launch file explorer
pub const key_xf86game = 0x1008ff5e // Launch game
pub const key_xf86go = 0x1008ff5f // Go to URL
pub const key_xf86itouch = 0x1008ff60 // Logitech iTouch- don't use
pub const key_xf86logoff = 0x1008ff61 // Log off system
pub const key_xf86market = 0x1008ff62 // ??
pub const key_xf86meeting = 0x1008ff63 // enter meeting in calendar
pub const key_xf86menukb = 0x1008ff65 // distinguish keyboard from PB
pub const key_xf86menupb = 0x1008ff66 // distinguish PB from keyboard
pub const key_xf86mysites = 0x1008ff67 // Favourites
pub const key_xf86new = 0x1008ff68 // New (folder, document...
pub const key_xf86news = 0x1008ff69 // News
pub const key_xf86officehome = 0x1008ff6a // Office home (old Staroffice)
pub const key_xf86open = 0x1008ff6b // Open
pub const key_xf86option = 0x1008ff6c // ??
pub const key_xf86paste = 0x1008ff6d // Paste
pub const key_xf86phone = 0x1008ff6e // Launch phone; dial number
pub const key_xf86q = 0x1008ff70 // Compaq's Q - don't use
pub const key_xf86reply = 0x1008ff72 // Reply e.g., mail
pub const key_xf86reload = 0x1008ff73 // Reload web page, file, etc.
pub const key_xf86rotatewindows = 0x1008ff74 // Rotate windows e.g. xrandr
pub const key_xf86rotationpb = 0x1008ff75 // don't use
pub const key_xf86rotationkb = 0x1008ff76 // don't use
pub const key_xf86save = 0x1008ff77 // Save (file, document, state
pub const key_xf86scrollup = 0x1008ff78 // Scroll window/contents up
pub const key_xf86scrolldown = 0x1008ff79 // Scrool window/contentd down
pub const key_xf86scrollclick = 0x1008ff7a // Use XKB mousekeys instead
pub const key_xf86send = 0x1008ff7b // Send mail, file, object
pub const key_xf86spell = 0x1008ff7c // Spell checker
pub const key_xf86splitscreen = 0x1008ff7d // Split window or screen
pub const key_xf86support = 0x1008ff7e // Get support (??)
pub const key_xf86taskpane = 0x1008ff7f // Show tasks
pub const key_xf86terminal = 0x1008ff80 // Launch terminal emulator
pub const key_xf86tools = 0x1008ff81 // toolbox of desktop/app.
pub const key_xf86travel = 0x1008ff82 // ??
pub const key_xf86userpb = 0x1008ff84 // ??
pub const key_xf86user1kb = 0x1008ff85 // ??
pub const key_xf86user2kb = 0x1008ff86 // ??
pub const key_xf86video = 0x1008ff87 // Launch video player
pub const key_xf86wheelbutton = 0x1008ff88 // button from a mouse wheel
pub const key_xf86word = 0x1008ff89 // Launch word processor
pub const key_xf86xfer = 0x1008ff8a
pub const key_xf86zoomin = 0x1008ff8b // zoom in view, map, etc.
pub const key_xf86zoomout = 0x1008ff8c // zoom out view, map, etc.

pub const key_xf86away = 0x1008ff8d // mark yourself as away
pub const key_xf86messenger = 0x1008ff8e // as in instant messaging
pub const key_xf86webcam = 0x1008ff8f // Launch web camera app.
pub const key_xf86mailforward = 0x1008ff90 // Forward in mail
pub const key_xf86pictures = 0x1008ff91 // Show pictures
pub const key_xf86music = 0x1008ff92 // Launch music application

pub const key_xf86battery = 0x1008ff93 // Display battery information
pub const key_xf86bluetooth = 0x1008ff94 // Enable/disable Bluetooth
pub const key_xf86wlan = 0x1008ff95 // Enable/disable WLAN
pub const key_xf86uwb = 0x1008ff96 // Enable/disable UWB

pub const key_xf86audioforward = 0x1008ff97 // fast-forward audio track
pub const key_xf86audiorepeat = 0x1008ff98 // toggle repeat mode
pub const key_xf86audiorandomplay = 0x1008ff99 // toggle shuffle mode
pub const key_xf86subtitle = 0x1008ff9a // cycle through subtitle
pub const key_xf86audiocycletrack = 0x1008ff9b // cycle through audio tracks
pub const key_xf86cycleangle = 0x1008ff9c // cycle through angles
pub const key_xf86frameback = 0x1008ff9d // video: go one frame back
pub const key_xf86frameforward = 0x1008ff9e // video: go one frame forward
pub const key_xf86time = 0x1008ff9f // display, or shows an entry for time seeking
pub const key_xf86select = 0x1008ffa0 // Select button on joypads and remotes
pub const key_xf86view = 0x1008ffa1 // Show a view options/properties
pub const key_xf86topmenu = 0x1008ffa2 // Go to a top-level menu in a video

pub const key_xf86red = 0x1008ffa3 // Red button
pub const key_xf86green = 0x1008ffa4 // Green button
pub const key_xf86yellow = 0x1008ffa5 // Yellow button
pub const key_xf86blue = 0x1008ffa6 // Blue button

pub const key_xf86suspend = 0x1008ffa7 // Sleep to RAM
pub const key_xf86hibernate = 0x1008ffa8 // Sleep to disk
pub const key_xf86touchpadtoggle = 0x1008ffa9 // Toggle between touchpad/trackstick
pub const key_xf86touchpadon = 0x1008ffb0 // The touchpad got switched on
pub const key_xf86touchpadoff = 0x1008ffb1 // The touchpad got switched off

pub const key_xf86audiomicmute = 0x1008ffb2 // Mute the Mic from the system

pub const key_xf86keyboard = 0x1008ffb3 // User defined keyboard related action

pub const key_xf86wwan = 0x1008ffb4 // Toggle WWAN (LTE, UMTS, etc.) radio
pub const key_xf86rfkill = 0x1008ffb5 // Toggle radios on/off

pub const key_xf86audiopreset = 0x1008ffb6 // Select equalizer preset, e.g. theatre-mode

pub const key_xf86rotationlocktoggle = 0x1008ffb7 // Toggle screen rotation lock on/off

pub const key_xf86fullscreen = 0x1008ffb8 // Toggle fullscreen

// Keys for special action keys (hot keys)
// Virtual terminals on some operating systems
pub const key_xf86switch_vt_1 = 0x1008fe01
pub const key_xf86switch_vt_2 = 0x1008fe02
pub const key_xf86switch_vt_3 = 0x1008fe03
pub const key_xf86switch_vt_4 = 0x1008fe04
pub const key_xf86switch_vt_5 = 0x1008fe05
pub const key_xf86switch_vt_6 = 0x1008fe06
pub const key_xf86switch_vt_7 = 0x1008fe07
pub const key_xf86switch_vt_8 = 0x1008fe08
pub const key_xf86switch_vt_9 = 0x1008fe09
pub const key_xf86switch_vt_10 = 0x1008fe0a
pub const key_xf86switch_vt_11 = 0x1008fe0b
pub const key_xf86switch_vt_12 = 0x1008fe0c

pub const key_xf86ungrab = 0x1008fe20 // force ungrab
pub const key_xf86cleargrab = 0x1008fe21 // kill application with grab
pub const key_xf86next_vmode = 0x1008fe22 // next video mode available
pub const key_xf86prev_vmode = 0x1008fe23 // prev. video mode available
pub const key_xf86logwindowtree = 0x1008fe24 // print window tree to log
pub const key_xf86loggrabinfo = 0x1008fe25 // print all active grabs to log

//
//* Reserved range for evdev symbols: := 0x10081000-:= 0x10081FFF
//*
//* Key syms within this range must match the Linux kernel
//* input-event-codes.h file in the format:
//*     XF86CamelCaseKernelName	_EVDEVK(kernel value)
//* For example, the kernel
//*   pub const key_key_macro_record_start	:= 0x2b0
//* effectively ends up as:
//*   pub const key_xf86macrorecordstart	:= 0x100812b0
//*
//* For historical reasons, some keysyms within the reserved range will be
//* missing, most notably all "normal" keys that are mapped through default
//* XKB layouts (e.g. KEY_Q).
//*
//* CamelCasing is done with a human control as last authority, e.g. see VOD
//* instead of Vod for the Video on Demand key.
//*
//* The format for pub consts is strict:
//*
//* pub const key_xf86foo<tab...>_evdevk(:= 0xABC)<tab><tab> |//\* kver KEY_FOO //\*|
//*
//* Where
//* - alignment by tabs
//* - the _EVDEVK macro must be used
//* - the hex code must be in uppercase hex
//* - the kernel version (kver) is in the form v5.10
//* - kver and key name are within a slash-star comment (a pipe is used in
//*   this example for technical reasons)
//* These pub consts are parsed by scripts. Do not stray from the given format.
//*
//* Where the evdev keycode is mapped to a different symbol, please add a
//* comment line starting with Use: but otherwise the same format, e.g.
//\*  Use: XF86RotationLockToggle	_EVDEVK(:= 0x231)		   v4.16 KEY_ROTATE_LOCK_TOGGLE
//*

// Use: XF86Eject                    _EVDEVK(:= 0x0a2)             KEY_EJECTCLOSECD
// Use: XF86New                      _EVDEVK(:= 0x0b5)     v2.6.14 KEY_NEW
// Use: Redo                         _EVDEVK(:= 0x0b6)     v2.6.14 KEY_REDO
// KEY_DASHBOARD has been mapped to LaunchB in xkeyboard-config since 2011
// Use: XF86LaunchB                  _EVDEVK(:= 0x0cc)     v2.6.28 KEY_DASHBOARD
// Use: XF86Display                  _EVDEVK(:= 0x0e3)     v2.6.12 KEY_SWITCHVIDEOMODE
// Use: XF86KbdLightOnOff            _EVDEVK(:= 0x0e4)     v2.6.12 KEY_KBDILLUMTOGGLE
// Use: XF86KbdBrightnessDown        _EVDEVK(:= 0x0e5)     v2.6.12 KEY_KBDILLUMDOWN
// Use: XF86KbdBrightnessUp          _EVDEVK(:= 0x0e6)     v2.6.12 KEY_KBDILLUMUP
// Use: XF86Send                     _EVDEVK(:= 0x0e7)     v2.6.14 KEY_SEND
// Use: XF86Reply                    _EVDEVK(:= 0x0e8)     v2.6.14 KEY_REPLY
// Use: XF86MailForward              _EVDEVK(:= 0x0e9)     v2.6.14 KEY_FORWARDMAIL
// Use: XF86Save                     _EVDEVK(:= 0x0ea)     v2.6.14 KEY_SAVE
// Use: XF86Documents                _EVDEVK(:= 0x0eb)     v2.6.14 KEY_DOCUMENTS
// Use: XF86Battery                  _EVDEVK(:= 0x0ec)     v2.6.17 KEY_BATTERY
// Use: XF86Bluetooth                _EVDEVK(:= 0x0ed)     v2.6.19 KEY_BLUETOOTH
// Use: XF86WLAN                     _EVDEVK(:= 0x0ee)     v2.6.19 KEY_WLAN
// Use: XF86UWB                      _EVDEVK(:= 0x0ef)     v2.6.24 KEY_UWB
// Use: XF86Next_VMode               _EVDEVK(:= 0x0f1)     v2.6.23 KEY_VIDEO_NEXT
// Use: XF86Prev_VMode               _EVDEVK(:= 0x0f2)     v2.6.23 KEY_VIDEO_PREV
// Use: XF86MonBrightnessCycle       _EVDEVK(:= 0x0f3)     v2.6.23 KEY_BRIGHTNESS_CYCLE
pub const key_xf86brightnessauto = 0x100810f4 // v3.16   KEY_BRIGHTNESS_AUTO
pub const key_xf86displayoff = 0x100810f5 // v2.6.23 KEY_DISPLAY_OFF
// Use: XF86WWAN                     _EVDEVK(:= 0x0f6)     v3.13   KEY_WWAN
// Use: XF86RFKill                   _EVDEVK(:= 0x0f7)     v2.6.33 KEY_RFKILL
// Use: XF86AudioMicMute             _EVDEVK(:= 0x0f8)     v3.1    KEY_MICMUTE
pub const key_xf86info = 0x10081166 //         KEY_INFO
// Use: XF86CycleAngle               _EVDEVK(:= 0x173)             KEY_ANGLE
// Use: XF86FullScreen               _EVDEVK(:= 0x174)     v5.1    KEY_FULL_SCREEN
pub const key_xf86aspectratio = 0x10081177 // v5.1    KEY_ASPECT_RATIO
pub const key_xf86dvd = 0x10081185 //         KEY_DVD
pub const key_xf86audio = 0x10081188 //         KEY_AUDIO
// Use: XF86Video                    _EVDEVK(:= 0x189)             KEY_VIDEO
// Use: XF86Calendar                 _EVDEVK(:= 0x18d)             KEY_CALENDAR
pub const key_xf86channelup = 0x10081192 //         KEY_CHANNELUP
pub const key_xf86channeldown = 0x10081193 //         KEY_CHANNELDOWN
// Use: XF86AudioRandomPlay          _EVDEVK(:= 0x19a)             KEY_SHUFFLE
pub const key_xf86break = 0x1008119b //         KEY_BREAK
pub const key_xf86videophone = 0x100811a0 // v2.6.20 KEY_VIDEOPHONE
// Use: XF86Game                     _EVDEVK(:= 0x1a1)     v2.6.20 KEY_GAMES
// Use: XF86ZoomIn                   _EVDEVK(:= 0x1a2)     v2.6.20 KEY_ZOOMIN
// Use: XF86ZoomOut                  _EVDEVK(:= 0x1a3)     v2.6.20 KEY_ZOOMOUT
pub const key_xf86zoomreset = 0x100811a4 // v2.6.20 KEY_ZOOMRESET
// Use: XF86Word                     _EVDEVK(:= 0x1a5)     v2.6.20 KEY_WORDPROCESSOR
pub const key_xf86editor = 0x100811a6 // v2.6.20 KEY_EDITOR
// Use: XF86Excel                    _EVDEVK(:= 0x1a7)     v2.6.20 KEY_SPREADSHEET
pub const key_xf86graphicseditor = 0x100811a8 // v2.6.20 KEY_GRAPHICSEDITOR
pub const key_xf86presentation = 0x100811a9 // v2.6.20 KEY_PRESENTATION
pub const key_xf86database = 0x100811aa // v2.6.20 KEY_DATABASE
// Use: XF86News                     _EVDEVK(:= 0x1ab)     v2.6.20 KEY_NEWS
pub const key_xf86voicemail = 0x100811ac // v2.6.20 KEY_VOICEMAIL
pub const key_xf86addressbook = 0x100811ad // v2.6.20 KEY_ADDRESSBOOK
// Use: XF86Messenger                _EVDEVK(:= 0x1ae)     v2.6.20 KEY_MESSENGER
pub const key_xf86displaytoggle = 0x100811af // v2.6.20 KEY_DISPLAYTOGGLE
pub const key_xf86spellcheck = 0x100811b0 // v2.6.24 KEY_SPELLCHECK
// Use: XF86LogOff                   _EVDEVK(:= 0x1b1)     v2.6.24 KEY_LOGOFF
// Use: dollar                       _EVDEVK(:= 0x1b2)     v2.6.24 KEY_DOLLAR
// Use: EuroSign                     _EVDEVK(:= 0x1b3)     v2.6.24 KEY_EURO
// Use: XF86FrameBack                _EVDEVK(:= 0x1b4)     v2.6.24 KEY_FRAMEBACK
// Use: XF86FrameForward             _EVDEVK(:= 0x1b5)     v2.6.24 KEY_FRAMEFORWARD
pub const key_xf86contextmenu = 0x100811b6 // v2.6.24 KEY_CONTEXT_MENU
pub const key_xf86mediarepeat = 0x100811b7 // v2.6.26 KEY_MEDIA_REPEAT
pub const key_xf8610channelsup = 0x100811b8 // v2.6.38 KEY_10CHANNELSUP
pub const key_xf8610channelsdown = 0x100811b9 // v2.6.38 KEY_10CHANNELSDOWN
pub const key_xf86images = 0x100811ba // v2.6.39 KEY_IMAGES
pub const key_xf86notificationcenter = 0x100811bc // v5.10   KEY_NOTIFICATION_CENTER
pub const key_xf86pickupphone = 0x100811bd // v5.10   KEY_PICKUP_PHONE
pub const key_xf86hangupphone = 0x100811be // v5.10   KEY_HANGUP_PHONE
pub const key_xf86fn = 0x100811d0 //         KEY_FN
pub const key_xf86fn_esc = 0x100811d1 //         KEY_FN_ESC
pub const key_xf86fnrightshift = 0x100811e5 // v5.10   KEY_FN_RIGHT_SHIFT
// Use: braille_dot_1                _EVDEVK(:= 0x1f1)     v2.6.17 KEY_BRL_DOT1
// Use: braille_dot_2                _EVDEVK(:= 0x1f2)     v2.6.17 KEY_BRL_DOT2
// Use: braille_dot_3                _EVDEVK(:= 0x1f3)     v2.6.17 KEY_BRL_DOT3
// Use: braille_dot_4                _EVDEVK(:= 0x1f4)     v2.6.17 KEY_BRL_DOT4
// Use: braille_dot_5                _EVDEVK(:= 0x1f5)     v2.6.17 KEY_BRL_DOT5
// Use: braille_dot_6                _EVDEVK(:= 0x1f6)     v2.6.17 KEY_BRL_DOT6
// Use: braille_dot_7                _EVDEVK(:= 0x1f7)     v2.6.17 KEY_BRL_DOT7
// Use: braille_dot_8                _EVDEVK(:= 0x1f8)     v2.6.17 KEY_BRL_DOT8
// Use: braille_dot_9                _EVDEVK(:= 0x1f9)     v2.6.23 KEY_BRL_DOT9
// Use: braille_dot_1                _EVDEVK(:= 0x1fa)     v2.6.23 KEY_BRL_DOT10
pub const key_xf86numeric0 = 0x10081200 // v2.6.28 KEY_NUMERIC_0
pub const key_xf86numeric1 = 0x10081201 // v2.6.28 KEY_NUMERIC_1
pub const key_xf86numeric2 = 0x10081202 // v2.6.28 KEY_NUMERIC_2
pub const key_xf86numeric3 = 0x10081203 // v2.6.28 KEY_NUMERIC_3
pub const key_xf86numeric4 = 0x10081204 // v2.6.28 KEY_NUMERIC_4
pub const key_xf86numeric5 = 0x10081205 // v2.6.28 KEY_NUMERIC_5
pub const key_xf86numeric6 = 0x10081206 // v2.6.28 KEY_NUMERIC_6
pub const key_xf86numeric7 = 0x10081207 // v2.6.28 KEY_NUMERIC_7
pub const key_xf86numeric8 = 0x10081208 // v2.6.28 KEY_NUMERIC_8
pub const key_xf86numeric9 = 0x10081209 // v2.6.28 KEY_NUMERIC_9
pub const key_xf86numericstar = 0x1008120a // v2.6.28 KEY_NUMERIC_STAR
pub const key_xf86numericpound = 0x1008120b // v2.6.28 KEY_NUMERIC_POUND
pub const key_xf86numerica = 0x1008120c // v4.1    KEY_NUMERIC_A
pub const key_xf86numericb = 0x1008120d // v4.1    KEY_NUMERIC_B
pub const key_xf86numericc = 0x1008120e // v4.1    KEY_NUMERIC_C
pub const key_xf86numericd = 0x1008120f // v4.1    KEY_NUMERIC_D
pub const key_xf86camerafocus = 0x10081210 // v2.6.33 KEY_CAMERA_FOCUS
pub const key_xf86wpsbutton = 0x10081211 // v2.6.34 KEY_WPS_BUTTON
// Use: XF86TouchpadToggle           _EVDEVK(:= 0x212)     v2.6.37 KEY_TOUCHPAD_TOGGLE
// Use: XF86TouchpadOn               _EVDEVK(:= 0x213)     v2.6.37 KEY_TOUCHPAD_ON
// Use: XF86TouchpadOff              _EVDEVK(:= 0x214)     v2.6.37 KEY_TOUCHPAD_OFF
pub const key_xf86camerazoomin = 0x10081215 // v2.6.39 KEY_CAMERA_ZOOMIN
pub const key_xf86camerazoomout = 0x10081216 // v2.6.39 KEY_CAMERA_ZOOMOUT
pub const key_xf86cameraup = 0x10081217 // v2.6.39 KEY_CAMERA_UP
pub const key_xf86cameradown = 0x10081218 // v2.6.39 KEY_CAMERA_DOWN
pub const key_xf86cameraleft = 0x10081219 // v2.6.39 KEY_CAMERA_LEFT
pub const key_xf86cameraright = 0x1008121a // v2.6.39 KEY_CAMERA_RIGHT
pub const key_xf86attendanton = 0x1008121b // v3.10   KEY_ATTENDANT_ON
pub const key_xf86attendantoff = 0x1008121c // v3.10   KEY_ATTENDANT_OFF
pub const key_xf86attendanttoggle = 0x1008121d // v3.10   KEY_ATTENDANT_TOGGLE
pub const key_xf86lightstoggle = 0x1008121e // v3.10   KEY_LIGHTS_TOGGLE
pub const key_xf86alstoggle = 0x10081230 // v3.13   KEY_ALS_TOGGLE
// Use: XF86RotationLockToggle       _EVDEVK(:= 0x231)     v4.16   KEY_ROTATE_LOCK_TOGGLE
pub const key_xf86buttonconfig = 0x10081240 // v3.16   KEY_BUTTONCONFIG
pub const key_xf86taskmanager = 0x10081241 // v3.16   KEY_TASKMANAGER
pub const key_xf86journal = 0x10081242 // v3.16   KEY_JOURNAL
pub const key_xf86controlpanel = 0x10081243 // v3.16   KEY_CONTROLPANEL
pub const key_xf86appselect = 0x10081244 // v3.16   KEY_APPSELECT
pub const key_xf86screensaver_key = 0x10081245 // v3.16   KEY_SCREENSAVER
pub const key_xf86voicecommand = 0x10081246 // v3.16   KEY_VOICECOMMAND
pub const key_xf86assistant = 0x10081247 // v4.13   KEY_ASSISTANT
// Use: ISO_Next_Group               _EVDEVK(:= 0x248)     v5.2    KEY_KBD_LAYOUT_NEXT
pub const key_xf86emojipicker = 0x10081249 // v5.13   KEY_EMOJI_PICKER
pub const key_xf86dictate = 0x1008124a // v5.17   KEY_DICTATE
pub const key_xf86cameraaccessenable = 0x1008124b // v6.2    KEY_CAMERA_ACCESS_ENABLE
pub const key_xf86cameraaccessdisable = 0x1008124c // v6.2    KEY_CAMERA_ACCESS_DISABLE
pub const key_xf86cameraaccesstoggle = 0x1008124d // v6.2    KEY_CAMERA_ACCESS_TOGGLE
pub const key_xf86brightnessmin = 0x10081250 // v3.16   KEY_BRIGHTNESS_MIN
pub const key_xf86brightnessmax = 0x10081251 // v3.16   KEY_BRIGHTNESS_MAX
pub const key_xf86kbdinputassistprev = 0x10081260 // v3.18   KEY_KBDINPUTASSIST_PREV
pub const key_xf86kbdinputassistnext = 0x10081261 // v3.18   KEY_KBDINPUTASSIST_NEXT
pub const key_xf86kbdinputassistprevgroup = 0x10081262 // v3.18   KEY_KBDINPUTASSIST_PREVGROUP
pub const key_xf86kbdinputassistnextgroup = 0x10081263 // v3.18   KEY_KBDINPUTASSIST_NEXTGROUP
pub const key_xf86kbdinputassistaccept = 0x10081264 // v3.18   KEY_KBDINPUTASSIST_ACCEPT
pub const key_xf86kbdinputassistcancel = 0x10081265 // v3.18   KEY_KBDINPUTASSIST_CANCEL
pub const key_xf86rightup = 0x10081266 // v4.7    KEY_RIGHT_UP
pub const key_xf86rightdown = 0x10081267 // v4.7    KEY_RIGHT_DOWN
pub const key_xf86leftup = 0x10081268 // v4.7    KEY_LEFT_UP
pub const key_xf86leftdown = 0x10081269 // v4.7    KEY_LEFT_DOWN
pub const key_xf86rootmenu = 0x1008126a // v4.7    KEY_ROOT_MENU
pub const key_xf86mediatopmenu = 0x1008126b // v4.7    KEY_MEDIA_TOP_MENU
pub const key_xf86numeric11 = 0x1008126c // v4.7    KEY_NUMERIC_11
pub const key_xf86numeric12 = 0x1008126d // v4.7    KEY_NUMERIC_12
pub const key_xf86audiodesc = 0x1008126e // v4.7    KEY_AUDIO_DESC
pub const key_xf863dmode = 0x1008126f // v4.7    KEY_3D_MODE
pub const key_xf86nextfavorite = 0x10081270 // v4.7    KEY_NEXT_FAVORITE
pub const key_xf86stoprecord = 0x10081271 // v4.7    KEY_STOP_RECORD
pub const key_xf86pauserecord = 0x10081272 // v4.7    KEY_PAUSE_RECORD
pub const key_xf86vod = 0x10081273 // v4.7    KEY_VOD
pub const key_xf86unmute = 0x10081274 // v4.7    KEY_UNMUTE
pub const key_xf86fastreverse = 0x10081275 // v4.7    KEY_FASTREVERSE
pub const key_xf86slowreverse = 0x10081276 // v4.7    KEY_SLOWREVERSE
pub const key_xf86data = 0x10081277 // v4.7    KEY_DATA
pub const key_xf86onscreenkeyboard = 0x10081278 // v4.12   KEY_ONSCREEN_KEYBOARD
pub const key_xf86privacyscreentoggle = 0x10081279 // v5.5    KEY_PRIVACY_SCREEN_TOGGLE
pub const key_xf86selectivescreenshot = 0x1008127a // v5.6    KEY_SELECTIVE_SCREENSHOT
pub const key_xf86nextelement = 0x1008127b // v5.18   KEY_NEXT_ELEMENT
pub const key_xf86previouselement = 0x1008127c // v5.18   KEY_PREVIOUS_ELEMENT
pub const key_xf86autopilotengagetoggle = 0x1008127d // v5.18   KEY_AUTOPILOT_ENGAGE_TOGGLE
pub const key_xf86markwaypoint = 0x1008127e // v5.18   KEY_MARK_WAYPOINT
pub const key_xf86sos = 0x1008127f // v5.18   KEY_SOS
pub const key_xf86navchart = 0x10081280 // v5.18   KEY_NAV_CHART
pub const key_xf86fishingchart = 0x10081281 // v5.18   KEY_FISHING_CHART
pub const key_xf86singlerangeradar = 0x10081282 // v5.18   KEY_SINGLE_RANGE_RADAR
pub const key_xf86dualrangeradar = 0x10081283 // v5.18   KEY_DUAL_RANGE_RADAR
pub const key_xf86radaroverlay = 0x10081284 // v5.18   KEY_RADAR_OVERLAY
pub const key_xf86traditionalsonar = 0x10081285 // v5.18   KEY_TRADITIONAL_SONAR
pub const key_xf86clearvusonar = 0x10081286 // v5.18   KEY_CLEARVU_SONAR
pub const key_xf86sidevusonar = 0x10081287 // v5.18   KEY_SIDEVU_SONAR
pub const key_xf86navinfo = 0x10081288 // v5.18   KEY_NAV_INFO
// Use: XF86BrightnessAdjust         _EVDEVK(:= 0x289)     v5.18   KEY_BRIGHTNESS_MENU
pub const key_xf86macro1 = 0x10081290 // v5.5    KEY_MACRO1
pub const key_xf86macro2 = 0x10081291 // v5.5    KEY_MACRO2
pub const key_xf86macro3 = 0x10081292 // v5.5    KEY_MACRO3
pub const key_xf86macro4 = 0x10081293 // v5.5    KEY_MACRO4
pub const key_xf86macro5 = 0x10081294 // v5.5    KEY_MACRO5
pub const key_xf86macro6 = 0x10081295 // v5.5    KEY_MACRO6
pub const key_xf86macro7 = 0x10081296 // v5.5    KEY_MACRO7
pub const key_xf86macro8 = 0x10081297 // v5.5    KEY_MACRO8
pub const key_xf86macro9 = 0x10081298 // v5.5    KEY_MACRO9
pub const key_xf86macro10 = 0x10081299 // v5.5    KEY_MACRO10
pub const key_xf86macro11 = 0x1008129a // v5.5    KEY_MACRO11
pub const key_xf86macro12 = 0x1008129b // v5.5    KEY_MACRO12
pub const key_xf86macro13 = 0x1008129c // v5.5    KEY_MACRO13
pub const key_xf86macro14 = 0x1008129d // v5.5    KEY_MACRO14
pub const key_xf86macro15 = 0x1008129e // v5.5    KEY_MACRO15
pub const key_xf86macro16 = 0x1008129f // v5.5    KEY_MACRO16
pub const key_xf86macro17 = 0x100812a0 // v5.5    KEY_MACRO17
pub const key_xf86macro18 = 0x100812a1 // v5.5    KEY_MACRO18
pub const key_xf86macro19 = 0x100812a2 // v5.5    KEY_MACRO19
pub const key_xf86macro20 = 0x100812a3 // v5.5    KEY_MACRO20
pub const key_xf86macro21 = 0x100812a4 // v5.5    KEY_MACRO21
pub const key_xf86macro22 = 0x100812a5 // v5.5    KEY_MACRO22
pub const key_xf86macro23 = 0x100812a6 // v5.5    KEY_MACRO23
pub const key_xf86macro24 = 0x100812a7 // v5.5    KEY_MACRO24
pub const key_xf86macro25 = 0x100812a8 // v5.5    KEY_MACRO25
pub const key_xf86macro26 = 0x100812a9 // v5.5    KEY_MACRO26
pub const key_xf86macro27 = 0x100812aa // v5.5    KEY_MACRO27
pub const key_xf86macro28 = 0x100812ab // v5.5    KEY_MACRO28
pub const key_xf86macro29 = 0x100812ac // v5.5    KEY_MACRO29
pub const key_xf86macro30 = 0x100812ad // v5.5    KEY_MACRO30
pub const key_xf86macrorecordstart = 0x100812b0 // v5.5    KEY_MACRO_RECORD_START
pub const key_xf86macrorecordstop = 0x100812b1 // v5.5    KEY_MACRO_RECORD_STOP
pub const key_xf86macropresetcycle = 0x100812b2 // v5.5    KEY_MACRO_PRESET_CYCLE
pub const key_xf86macropreset1 = 0x100812b3 // v5.5    KEY_MACRO_PRESET1
pub const key_xf86macropreset2 = 0x100812b4 // v5.5    KEY_MACRO_PRESET2
pub const key_xf86macropreset3 = 0x100812b5 // v5.5    KEY_MACRO_PRESET3
pub const key_xf86kbdlcdmenu1 = 0x100812b8 // v5.5    KEY_KBD_LCD_MENU1
pub const key_xf86kbdlcdmenu2 = 0x100812b9 // v5.5    KEY_KBD_LCD_MENU2
pub const key_xf86kbdlcdmenu3 = 0x100812ba // v5.5    KEY_KBD_LCD_MENU3
pub const key_xf86kbdlcdmenu4 = 0x100812bb // v5.5    KEY_KBD_LCD_MENU4
pub const key_xf86kbdlcdmenu5 = 0x100812bc // v5.5    KEY_KBD_LCD_MENU5

//
////* Floating Accent
//

pub const key_sunfa_grave = 0x1005ff00
pub const key_sunfa_circum = 0x1005ff01
pub const key_sunfa_tilde = 0x1005ff02
pub const key_sunfa_acute = 0x1005ff03
pub const key_sunfa_diaeresis = 0x1005ff04
pub const key_sunfa_cedilla = 0x1005ff05

//
////* Miscellaneous Functions
//

pub const key_sunf36 = 0x1005ff10 // Labeled F11
pub const key_sunf37 = 0x1005ff11 // Labeled F12

pub const key_sunsys_req = 0x1005ff60
pub const key_sunprint_screen = 0x0000ff61 // Same as Print

//
////* International & Multi-Key Character Composition
//

pub const key_suncompose = 0x0000ff20 // Same as Multi_key
pub const key_sunaltgraph = 0x0000ff7e // Same as Mode_switch

//
////* Cursor Control
//

pub const key_sunpageup = 0x0000ff55 // Same as Prior
pub const key_sunpagedown = 0x0000ff56 // Same as Next

//
////* Open Look Functions
//

pub const key_sunundo = 0x0000ff65 // Same as Undo
pub const key_sunagain = 0x0000ff66 // Same as Redo
pub const key_sunfind = 0x0000ff68 // Same as Find
pub const key_sunstop = 0x0000ff69 // Same as Cancel
pub const key_sunprops = 0x1005ff70
pub const key_sunfront = 0x1005ff71
pub const key_suncopy = 0x1005ff72
pub const key_sunopen = 0x1005ff73
pub const key_sunpaste = 0x1005ff74
pub const key_suncut = 0x1005ff75

pub const key_sunpowerswitch = 0x1005ff76
pub const key_sunaudiolowervolume = 0x1005ff77
pub const key_sunaudiomute = 0x1005ff78
pub const key_sunaudioraisevolume = 0x1005ff79
pub const key_sunvideodegauss = 0x1005ff7a
pub const key_sunvideolowerbrightness = 0x1005ff7b
pub const key_sunvideoraisebrightness = 0x1005ff7c
pub const key_sunpowerswitchshift = 0x1005ff7d

//
////* DEC private keysyms
////* (29th bit set)
//

// two-key compose sequence initiators, chosen to map to Latin1 characters

pub const key_dring_accent = 0x1000feb0
pub const key_dcircumflex_accent = 0x1000fe5e
pub const key_dcedilla_accent = 0x1000fe2c
pub const key_dacute_accent = 0x1000fe27
pub const key_dgrave_accent = 0x1000fe60
pub const key_dtilde = 0x1000fe7e
pub const key_ddiaeresis = 0x1000fe22

// special keysym for LK2** "Remove" key on editing keypad

pub const key_dremove = 0x1000ff00 // Remove

pub const key_hpclearline = 0x1000ff6f
pub const key_hpinsertline = 0x1000ff70
pub const key_hpdeleteline = 0x1000ff71
pub const key_hpinsertchar = 0x1000ff72
pub const key_hpdeletechar = 0x1000ff73
pub const key_hpbacktab = 0x1000ff74
pub const key_hpkp_backtab = 0x1000ff75
pub const key_hpmodelock1 = 0x1000ff48
pub const key_hpmodelock2 = 0x1000ff49
pub const key_hpreset = 0x1000ff6c
pub const key_hpsystem = 0x1000ff6d
pub const key_hpuser = 0x1000ff6e
pub const key_hpmute_acute = 0x100000a8
pub const key_hpmute_grave = 0x100000a9
pub const key_hpmute_asciicircum = 0x100000aa
pub const key_hpmute_diaeresis = 0x100000ab
pub const key_hpmute_asciitilde = 0x100000ac
pub const key_hplira = 0x100000af
pub const key_hpguilder = 0x100000be
pub const key_hpydiaeresis = 0x100000ee
pub const key_hpio = 0x100000ee // deprecated alias for hpYdiaeresis
pub const key_hplongminus = 0x100000f6
pub const key_hpblock = 0x100000fc

pub const key_osfcopy = 0x1004ff02
pub const key_osfcut = 0x1004ff03
pub const key_osfpaste = 0x1004ff04
pub const key_osfbacktab = 0x1004ff07
pub const key_osfbackspace = 0x1004ff08
pub const key_osfclear = 0x1004ff0b
pub const key_osfescape = 0x1004ff1b
pub const key_osfaddmode = 0x1004ff31
pub const key_osfprimarypaste = 0x1004ff32
pub const key_osfquickpaste = 0x1004ff33
pub const key_osfpageleft = 0x1004ff40
pub const key_osfpageup = 0x1004ff41
pub const key_osfpagedown = 0x1004ff42
pub const key_osfpageright = 0x1004ff43
pub const key_osfactivate = 0x1004ff44
pub const key_osfmenubar = 0x1004ff45
pub const key_osfleft = 0x1004ff51
pub const key_osfup = 0x1004ff52
pub const key_osfright = 0x1004ff53
pub const key_osfdown = 0x1004ff54
pub const key_osfendline = 0x1004ff57
pub const key_osfbeginline = 0x1004ff58
pub const key_osfenddata = 0x1004ff59
pub const key_osfbegindata = 0x1004ff5a
pub const key_osfprevmenu = 0x1004ff5b
pub const key_osfnextmenu = 0x1004ff5c
pub const key_osfprevfield = 0x1004ff5d
pub const key_osfnextfield = 0x1004ff5e
pub const key_osfselect = 0x1004ff60
pub const key_osfinsert = 0x1004ff63
pub const key_osfundo = 0x1004ff65
pub const key_osfmenu = 0x1004ff67
pub const key_osfcancel = 0x1004ff69
pub const key_osfhelp = 0x1004ff6a
pub const key_osfselectall = 0x1004ff71
pub const key_osfdeselectall = 0x1004ff72
pub const key_osfreselect = 0x1004ff73
pub const key_osfextend = 0x1004ff74
pub const key_osfrestore = 0x1004ff78
pub const key_osfdelete = 0x1004ffff

//*************************************************************
// The use of the following macros is deprecated.
// They are listed below only for backwards compatibility.
//*************************************************************

pub const key_reset = 0x1000ff6c // deprecated alias for hpReset
pub const key_system = 0x1000ff6d // deprecated alias for hpSystem
pub const key_user = 0x1000ff6e // deprecated alias for hpUser
pub const key_clearline = 0x1000ff6f // deprecated alias for hpClearLine
pub const key_insertline = 0x1000ff70 // deprecated alias for hpInsertLine
pub const key_deleteline = 0x1000ff71 // deprecated alias for hpDeleteLine
pub const key_insertchar = 0x1000ff72 // deprecated alias for hpInsertChar
pub const key_deletechar = 0x1000ff73 // deprecated alias for hpDeleteChar
pub const key_backtab = 0x1000ff74 // deprecated alias for hpBackTab
pub const key_kp_backtab = 0x1000ff75 // deprecated alias for hpKP_BackTab
pub const key_ext16bit_l = 0x1000ff76 // deprecated
pub const key_ext16bit_r = 0x1000ff77 // deprecated
pub const key_mute_acute = 0x100000a8 // deprecated alias for hpmute_acute
pub const key_mute_grave = 0x100000a9 // deprecated alias for hpmute_grave
pub const key_mute_asciicircum = 0x100000aa // deprecated alias for hpmute_asciicircum
pub const key_mute_diaeresis = 0x100000ab // deprecated alias for hpmute_diaeresis
pub const key_mute_asciitilde = 0x100000ac // deprecated alias for hpmute_asciitilde
pub const key_lira = 0x100000af // deprecated alias for hplira
pub const key_guilder = 0x100000be // deprecated alias for hpguilder
pub const key_io = 0x100000ee // deprecated alias for hpYdiaeresis
pub const key_longminus = 0x100000f6 // deprecated alias for hplongminus
pub const key_block = 0x100000fc // deprecated alias for hpblock
