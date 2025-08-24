module xkb

pub enum Keysym as u32 {
nosymbol                    = 0x000000  /* special keysym */
voidsymbol                  = 0xffffff  /* void symbol */

/*
 * tty function keys, cleverly chosen to map to ascii, for convenience of
 * programming, but could have been arbitrary (at the cost of lookup
 * tables in client code).
 */

backspace                     = 0xff08  /* u+0008 backspace */
tab                           = 0xff09  /* u+0009 character tabulation */
linefeed                      = 0xff0a  /* u+000a line feed */
clear                         = 0xff0b  /* u+000b line tabulation */
return                        = 0xff0d  /* u+000d carriage return */
pause                         = 0xff13  /* pause, hold */
scroll_lock                   = 0xff14
sys_req                       = 0xff15
escape                        = 0xff1b  /* u+001b escape */
delete                        = 0xffff  /* u+007f delete */



/* international & multi-key character composition */

multi_key                     = 0xff20  /* multi-key character compose */
codeinput                     = 0xff37
singlecandidate               = 0xff3c
multiplecandidate             = 0xff3d
previouscandidate             = 0xff3e

/* japanese keyboard support */

kanji                         = 0xff21  /* kanji, kanji convert */
muhenkan                      = 0xff22  /* cancel conversion */
henkan                        = 0xff23  /* non-deprecated alias for henkan_mode */
romaji                        = 0xff24  /* to romaji */
hiragana                      = 0xff25  /* to hiragana */
katakana                      = 0xff26  /* to katakana */
hiragana_katakana             = 0xff27  /* hiragana/katakana toggle */
zenkaku                       = 0xff28  /* to zenkaku */
hankaku                       = 0xff29  /* to hankaku */
zenkaku_hankaku               = 0xff2a  /* zenkaku/hankaku toggle */
touroku                       = 0xff2b  /* add to dictionary */
massyo                        = 0xff2c  /* delete from dictionary */
kana_lock                     = 0xff2d  /* kana lock */
kana_shift                    = 0xff2e  /* kana shift */
eisu_shift                    = 0xff2f  /* alphanumeric shift */
eisu_toggle                   = 0xff30  /* alphanumeric toggle */

/* = 0xff31 thru 0xff3f are under xk_korean */

/* cursor control & motion */

home                          = 0xff50
left                          = 0xff51  /* move left, left arrow */
up                            = 0xff52  /* move up, up arrow */
right                         = 0xff53  /* move right, right arrow */
down                          = 0xff54  /* move down, down arrow */
prior                         = 0xff55  /* prior, previous */
next                          = 0xff56  /* next */
end                           = 0xff57  /* eol */
begin                         = 0xff58  /* bol */


/* misc functions */

select                        = 0xff60  /* select, mark */
print                         = 0xff61
execute                       = 0xff62  /* execute, run, do */
insert                        = 0xff63  /* insert, insert here */
undo                          = 0xff65
redo                          = 0xff66  /* redo, again */
menu                          = 0xff67
find                          = 0xff68  /* find, search */
cancel                        = 0xff69  /* cancel, stop, abort, exit */
help                          = 0xff6a  /* help */
break                         = 0xff6b
mode_switch                   = 0xff7e  /* character set switch */
num_lock                      = 0xff7f

/* keypad functions, keypad numbers cleverly chosen to map to ascii */

kp_space                      = 0xff80  /*<u+0020 space>*/
kp_tab                        = 0xff89  /*<u+0009 character tabulation>*/
kp_enter                      = 0xff8d  /*<u+000d carriage return>*/
kp_f1                         = 0xff91  /* pf1, kp_a, ... */
kp_f2                         = 0xff92
kp_f3                         = 0xff93
kp_f4                         = 0xff94
kp_home                       = 0xff95
kp_left                       = 0xff96
kp_up                         = 0xff97
kp_right                      = 0xff98
kp_down                       = 0xff99
kp_prior                      = 0xff9a
kp_next                       = 0xff9b
kp_end                        = 0xff9c
kp_begin                      = 0xff9d
kp_insert                     = 0xff9e
kp_delete                     = 0xff9f
kp_equal                      = 0xffbd  /*<u+003d equals sign>*/
kp_multiply                   = 0xffaa  /*<u+002a asterisk>*/
kp_add                        = 0xffab  /*<u+002b plus sign>*/
kp_separator                  = 0xffac  /*<u+002c comma>*/
kp_subtract                   = 0xffad  /*<u+002d hyphen-minus>*/
kp_decimal                    = 0xffae  /*<u+002e full stop>*/
kp_divide                     = 0xffaf  /*<u+002f solidus>*/

kp_0                          = 0xffb0  /*<u+0030 digit zero>*/
kp_1                          = 0xffb1  /*<u+0031 digit one>*/
kp_2                          = 0xffb2  /*<u+0032 digit two>*/
kp_3                          = 0xffb3  /*<u+0033 digit three>*/
kp_4                          = 0xffb4  /*<u+0034 digit four>*/
kp_5                          = 0xffb5  /*<u+0035 digit five>*/
kp_6                          = 0xffb6  /*<u+0036 digit six>*/
kp_7                          = 0xffb7  /*<u+0037 digit seven>*/
kp_8                          = 0xffb8  /*<u+0038 digit eight>*/
kp_9                          = 0xffb9  /*<u+0039 digit nine>*/



/*
 * auxiliary functions; note the duplicate definitions for left and right
 * function keys;  sun keyboards and a few other manufacturers have such
 * function key groups on the left and/or right sides of the keyboard.
 * we've not found a keyboard with more than 35 function keys total.
 */

f1                            = 0xffbe
f2                            = 0xffbf
f3                            = 0xffc0
f4                            = 0xffc1
f5                            = 0xffc2
f6                            = 0xffc3
f7                            = 0xffc4
f8                            = 0xffc5
f9                            = 0xffc6
f10                           = 0xffc7
f11                           = 0xffc8
f12                           = 0xffc9
f13                           = 0xffca
f14                           = 0xffcb
f15                           = 0xffcc
f16                           = 0xffcd
f17                           = 0xffce
f18                           = 0xffcf
f19                           = 0xffd0
f20                           = 0xffd1
f21                           = 0xffd2
f22                           = 0xffd3
f23                           = 0xffd4
f24                           = 0xffd5
f25                           = 0xffd6
f26                           = 0xffd7
f27                           = 0xffd8
f28                           = 0xffd9
f29                           = 0xffda
f30                           = 0xffdb
f31                           = 0xffdc
f32                           = 0xffdd
f33                           = 0xffde
f34                           = 0xffdf
f35                           = 0xffe0

/* modifiers */

shift_l                       = 0xffe1  /* left shift */
shift_r                       = 0xffe2  /* right shift */
control_l                     = 0xffe3  /* left control */
control_r                     = 0xffe4  /* right control */
caps_lock                     = 0xffe5  /* caps lock */
shift_lock                    = 0xffe6  /* shift lock */

meta_l                        = 0xffe7  /* left meta */
meta_r                        = 0xffe8  /* right meta */
alt_l                         = 0xffe9  /* left alt */
alt_r                         = 0xffea  /* right alt */
super_l                       = 0xffeb  /* left super */
super_r                       = 0xffec  /* right super */
hyper_l                       = 0xffed  /* left hyper */
hyper_r                       = 0xffee  /* right hyper */

/*
 * keyboard (xkb) extension function and modifier keys
 * (from appendix c of "the x keyboard extension: protocol specification")
 * byte 3 = = 0xfe
 */

iso_lock                      = 0xfe01
iso_level2_latch              = 0xfe02
iso_level3_shift              = 0xfe03
iso_level3_latch              = 0xfe04
iso_level3_lock               = 0xfe05
iso_level5_shift              = 0xfe11
iso_level5_latch              = 0xfe12
iso_level5_lock               = 0xfe13
iso_group_latch               = 0xfe06
iso_group_lock                = 0xfe07
iso_next_group                = 0xfe08
iso_next_group_lock           = 0xfe09
iso_prev_group                = 0xfe0a
iso_prev_group_lock           = 0xfe0b
iso_first_group               = 0xfe0c
iso_first_group_lock          = 0xfe0d
iso_last_group                = 0xfe0e
iso_last_group_lock           = 0xfe0f

iso_left_tab                  = 0xfe20
iso_move_line_up              = 0xfe21
iso_move_line_down            = 0xfe22
iso_partial_line_up           = 0xfe23
iso_partial_line_down         = 0xfe24
iso_partial_space_left        = 0xfe25
iso_partial_space_right       = 0xfe26
iso_set_margin_left           = 0xfe27
iso_set_margin_right          = 0xfe28
iso_release_margin_left       = 0xfe29
iso_release_margin_right      = 0xfe2a
iso_release_both_margins      = 0xfe2b
iso_fast_cursor_left          = 0xfe2c
iso_fast_cursor_right         = 0xfe2d
iso_fast_cursor_up            = 0xfe2e
iso_fast_cursor_down          = 0xfe2f
iso_continuous_underline      = 0xfe30
iso_discontinuous_underline   = 0xfe31
iso_emphasize                 = 0xfe32
iso_center_object             = 0xfe33
iso_enter                     = 0xfe34

dead_grave                    = 0xfe50
dead_acute                    = 0xfe51
dead_circumflex               = 0xfe52
dead_tilde                    = 0xfe53
dead_macron                   = 0xfe54
dead_breve                    = 0xfe55
dead_abovedot                 = 0xfe56
dead_diaeresis                = 0xfe57
dead_abovering                = 0xfe58
dead_doubleacute              = 0xfe59
dead_caron                    = 0xfe5a
dead_cedilla                  = 0xfe5b
dead_ogonek                   = 0xfe5c
dead_iota                     = 0xfe5d
dead_voiced_sound             = 0xfe5e
dead_semivoiced_sound         = 0xfe5f
dead_belowdot                 = 0xfe60
dead_hook                     = 0xfe61
dead_horn                     = 0xfe62
dead_stroke                   = 0xfe63
dead_abovecomma               = 0xfe64
dead_abovereversedcomma       = 0xfe65
dead_doublegrave              = 0xfe66
dead_belowring                = 0xfe67
dead_belowmacron              = 0xfe68
dead_belowcircumflex          = 0xfe69
dead_belowtilde               = 0xfe6a
dead_belowbreve               = 0xfe6b
dead_belowdiaeresis           = 0xfe6c
dead_invertedbreve            = 0xfe6d
dead_belowcomma               = 0xfe6e
dead_currency                 = 0xfe6f

/* extra dead elements for german t3 layout */
dead_lowline                  = 0xfe90
dead_aboveverticalline        = 0xfe91
dead_belowverticalline        = 0xfe92
dead_longsolidusoverlay       = 0xfe93

/* dead vowels for universal syllable entry */
dead_a                        = 0xfe80
dead_a_upper                        = 0xfe81
dead_e                        = 0xfe82
dead_e_upper                        = 0xfe83
dead_i                        = 0xfe84
dead_i_upper                        = 0xfe85
dead_o                        = 0xfe86
dead_o_upper                  = 0xfe87
dead_u                        = 0xfe88
dead_u_upper                  = 0xfe89
dead_schwa                    = 0xfe8a
dead_schwa_upper              = 0xfe8b

dead_greek                    = 0xfe8c
dead_hamza                    = 0xfe8d

first_virtual_screen          = 0xfed0
prev_virtual_screen           = 0xfed1
next_virtual_screen           = 0xfed2
last_virtual_screen           = 0xfed4
terminate_server              = 0xfed5

accessx_enable                = 0xfe70
accessx_feedback_enable       = 0xfe71
repeatkeys_enable             = 0xfe72
slowkeys_enable               = 0xfe73
bouncekeys_enable             = 0xfe74
stickykeys_enable             = 0xfe75
mousekeys_enable              = 0xfe76
mousekeys_accel_enable        = 0xfe77
overlay1_enable               = 0xfe78
overlay2_enable               = 0xfe79
audiblebell_enable            = 0xfe7a

pointer_left                  = 0xfee0
pointer_right                 = 0xfee1
pointer_up                    = 0xfee2
pointer_down                  = 0xfee3
pointer_upleft                = 0xfee4
pointer_upright               = 0xfee5
pointer_downleft              = 0xfee6
pointer_downright             = 0xfee7
pointer_button_dflt           = 0xfee8
pointer_button1               = 0xfee9
pointer_button2               = 0xfeea
pointer_button3               = 0xfeeb
pointer_button4               = 0xfeec
pointer_button5               = 0xfeed
pointer_dblclick_dflt         = 0xfeee
pointer_dblclick1             = 0xfeef
pointer_dblclick2             = 0xfef0
pointer_dblclick3             = 0xfef1
pointer_dblclick4             = 0xfef2
pointer_dblclick5             = 0xfef3
pointer_drag_dflt             = 0xfef4
pointer_drag1                 = 0xfef5
pointer_drag2                 = 0xfef6
pointer_drag3                 = 0xfef7
pointer_drag4                 = 0xfef8
pointer_drag5                 = 0xfefd

pointer_enablekeys            = 0xfef9
pointer_accelerate            = 0xfefa
pointer_dfltbtnnext           = 0xfefb
pointer_dfltbtnprev           = 0xfefc

/* single-stroke multiple-character n-graph keysyms for the x input method */

ch                            = 0xfea0
ch_upper                            = 0xfea1
ch_upper_upper                            = 0xfea2
c_h                           = 0xfea3
c_h_upper                     = 0xfea4
c_h_upper_upper               = 0xfea5


/*
 * 3270 terminal keys
 * byte 3 = = 0xfd
 */

_3270_duplicate                = 0xfd01
_3270_fieldmark                = 0xfd02
_3270_right2                   = 0xfd03
_3270_left2                    = 0xfd04
_3270_backtab                  = 0xfd05
_3270_eraseeof                 = 0xfd06
_3270_eraseinput               = 0xfd07
_3270_reset                    = 0xfd08
_3270_quit                     = 0xfd09
_3270_pa1                      = 0xfd0a
_3270_pa2                      = 0xfd0b
_3270_pa3                      = 0xfd0c
_3270_test                     = 0xfd0d
_3270_attn                     = 0xfd0e
_3270_cursorblink              = 0xfd0f
_3270_altcursor                = 0xfd10
_3270_keyclick                 = 0xfd11
_3270_jump                     = 0xfd12
_3270_ident                    = 0xfd13
_3270_rule                     = 0xfd14
_3270_copy                     = 0xfd15
_3270_play                     = 0xfd16
_3270_setup                    = 0xfd17
_3270_record                   = 0xfd18
_3270_changescreen             = 0xfd19
_3270_deleteword               = 0xfd1a
_3270_exselect                 = 0xfd1b
_3270_cursorselect             = 0xfd1c
_3270_printscreen              = 0xfd1d
_3270_enter                    = 0xfd1e

/*
 * latin 1
 * (iso/iec 8859-1 = unicode u+0020..u+00ff)
 * byte 3 = 0
 */
space                         = 0x0020  /* u+0020 space */
exclam                        = 0x0021  /* u+0021 exclamation mark */
quotedbl                      = 0x0022  /* u+0022 quotation mark */
numbersign                    = 0x0023  /* u+0023 number sign */
dollar                        = 0x0024  /* u+0024 dollar sign */
percent                       = 0x0025  /* u+0025 percent sign */
ampersand                     = 0x0026  /* u+0026 ampersand */
apostrophe                    = 0x0027  /* u+0027 apostrophe */
parenleft                     = 0x0028  /* u+0028 left parenthesis */
parenright                    = 0x0029  /* u+0029 right parenthesis */
asterisk                      = 0x002a  /* u+002a asterisk */
plus                          = 0x002b  /* u+002b plus sign */
comma                         = 0x002c  /* u+002c comma */
minus                         = 0x002d  /* u+002d hyphen-minus */
period                        = 0x002e  /* u+002e full stop */
slash                         = 0x002f  /* u+002f solidus */
_0                             = 0x0030  /* u+0030 digit zero */
_1                             = 0x0031  /* u+0031 digit one */
_2                             = 0x0032  /* u+0032 digit two */
_3                             = 0x0033  /* u+0033 digit three */
_4                             = 0x0034  /* u+0034 digit four */
_5                             = 0x0035  /* u+0035 digit five */
_6                             = 0x0036  /* u+0036 digit six */
_7                             = 0x0037  /* u+0037 digit seven */
_8                             = 0x0038  /* u+0038 digit eight */
_9                             = 0x0039  /* u+0039 digit nine */
colon                         = 0x003a  /* u+003a colon */
semicolon                     = 0x003b  /* u+003b semicolon */
less                          = 0x003c  /* u+003c less-than sign */
equal                         = 0x003d  /* u+003d equals sign */
greater                       = 0x003e  /* u+003e greater-than sign */
question                      = 0x003f  /* u+003f question mark */
at                            = 0x0040  /* u+0040 commercial at */
a_upper                            = 0x0041  /* u+0041 latin capital letter a */
b_upper                            = 0x0042  /* u+0042 latin capital letter b */
c_upper                            = 0x0043  /* u+0043 latin capital letter c */
d_upper                            = 0x0044  /* u+0044 latin capital letter d */
e_upper                            = 0x0045  /* u+0045 latin capital letter e */
f_upper                            = 0x0046  /* u+0046 latin capital letter f */
g_upper                            = 0x0047  /* u+0047 latin capital letter g */
h_upper                            = 0x0048  /* u+0048 latin capital letter h */
i_upper                            = 0x0049  /* u+0049 latin capital letter i */
j_upper                            = 0x004a  /* u+004a latin capital letter j */
k_upper                            = 0x004b  /* u+004b latin capital letter k */
l_upper                            = 0x004c  /* u+004c latin capital letter l */
m_upper                            = 0x004d  /* u+004d latin capital letter m */
n_upper                            = 0x004e  /* u+004e latin capital letter n */
o_upper                            = 0x004f  /* u+004f latin capital letter o */
p_upper                            = 0x0050  /* u+0050 latin capital letter p */
q_upper                            = 0x0051  /* u+0051 latin capital letter q */
r_upper                            = 0x0052  /* u+0052 latin capital letter r */
s_upper                            = 0x0053  /* u+0053 latin capital letter s */
t_upper                            = 0x0054  /* u+0054 latin capital letter t */
u_upper                            = 0x0055  /* u+0055 latin capital letter u */
v_upper                            = 0x0056  /* u+0056 latin capital letter v */
w_upper                            = 0x0057  /* u+0057 latin capital letter w */
x_upper                            = 0x0058  /* u+0058 latin capital letter x */
y_upper                            = 0x0059  /* u+0059 latin capital letter y */
z_upper                            = 0x005a  /* u+005a latin capital letter z */
bracketleft                   = 0x005b  /* u+005b left square bracket */
backslash                     = 0x005c  /* u+005c reverse solidus */
bracketright                  = 0x005d  /* u+005d right square bracket */
asciicircum                   = 0x005e  /* u+005e circumflex accent */
underscore                    = 0x005f  /* u+005f low line */
grave                         = 0x0060  /* u+0060 grave accent */
a                             = 0x0061  /* u+0061 latin small letter a */
b                             = 0x0062  /* u+0062 latin small letter b */
c                             = 0x0063  /* u+0063 latin small letter c */
d                             = 0x0064  /* u+0064 latin small letter d */
e                             = 0x0065  /* u+0065 latin small letter e */
f                             = 0x0066  /* u+0066 latin small letter f */
g                             = 0x0067  /* u+0067 latin small letter g */
h                             = 0x0068  /* u+0068 latin small letter h */
i                             = 0x0069  /* u+0069 latin small letter i */
j                             = 0x006a  /* u+006a latin small letter j */
k                             = 0x006b  /* u+006b latin small letter k */
l                             = 0x006c  /* u+006c latin small letter l */
m                             = 0x006d  /* u+006d latin small letter m */
n                             = 0x006e  /* u+006e latin small letter n */
o                             = 0x006f  /* u+006f latin small letter o */
p                             = 0x0070  /* u+0070 latin small letter p */
q                             = 0x0071  /* u+0071 latin small letter q */
r                             = 0x0072  /* u+0072 latin small letter r */
s                             = 0x0073  /* u+0073 latin small letter s */
t                             = 0x0074  /* u+0074 latin small letter t */
u                             = 0x0075  /* u+0075 latin small letter u */
v                             = 0x0076  /* u+0076 latin small letter v */
w                             = 0x0077  /* u+0077 latin small letter w */
x                             = 0x0078  /* u+0078 latin small letter x */
y                             = 0x0079  /* u+0079 latin small letter y */
z                             = 0x007a  /* u+007a latin small letter z */
braceleft                     = 0x007b  /* u+007b left curly bracket */
bar                           = 0x007c  /* u+007c vertical line */
braceright                    = 0x007d  /* u+007d right curly bracket */
asciitilde                    = 0x007e  /* u+007e tilde */

nobreakspace                  = 0x00a0  /* u+00a0 no-break space */
exclamdown                    = 0x00a1  /* u+00a1 inverted exclamation mark */
cent                          = 0x00a2  /* u+00a2 cent sign */
sterling                      = 0x00a3  /* u+00a3 pound sign */
currency                      = 0x00a4  /* u+00a4 currency sign */
yen                           = 0x00a5  /* u+00a5 yen sign */
brokenbar                     = 0x00a6  /* u+00a6 broken bar */
section                       = 0x00a7  /* u+00a7 section sign */
diaeresis                     = 0x00a8  /* u+00a8 diaeresis */
copyright                     = 0x00a9  /* u+00a9 copyright sign */
ordfeminine                   = 0x00aa  /* u+00aa feminine ordinal indicator */
guillemetleft                 = 0x00ab  /* u+00ab left-pointing double angle quotation mark */
notsign                       = 0x00ac  /* u+00ac not sign */
hyphen                        = 0x00ad  /* u+00ad soft hyphen */
registered                    = 0x00ae  /* u+00ae registered sign */
macron                        = 0x00af  /* u+00af macron */
degree                        = 0x00b0  /* u+00b0 degree sign */
plusminus                     = 0x00b1  /* u+00b1 plus-minus sign */
twosuperior                   = 0x00b2  /* u+00b2 superscript two */
threesuperior                 = 0x00b3  /* u+00b3 superscript three */
acute                         = 0x00b4  /* u+00b4 acute accent */
mu                            = 0x00b5  /* u+00b5 micro sign */
paragraph                     = 0x00b6  /* u+00b6 pilcrow sign */
periodcentered                = 0x00b7  /* u+00b7 middle dot */
cedilla                       = 0x00b8  /* u+00b8 cedilla */
onesuperior                   = 0x00b9  /* u+00b9 superscript one */
ordmasculine                  = 0x00ba  /* u+00ba masculine ordinal indicator */
guillemetright                = 0x00bb  /* u+00bb right-pointing double angle quotation mark */
onequarter                    = 0x00bc  /* u+00bc vulgar fraction one quarter */
onehalf                       = 0x00bd  /* u+00bd vulgar fraction one half */
threequarters                 = 0x00be  /* u+00be vulgar fraction three quarters */
questiondown                  = 0x00bf  /* u+00bf inverted question mark */
agrave_upper                       = 0x00c0  /* u+00c0 latin capital letter a with grave */
aacute_upper                       = 0x00c1  /* u+00c1 latin capital letter a with acute */
acircumflex_upper                  = 0x00c2  /* u+00c2 latin capital letter a with circumflex */
atilde_upper                       = 0x00c3  /* u+00c3 latin capital letter a with tilde */
adiaeresis_upper                   = 0x00c4  /* u+00c4 latin capital letter a with diaeresis */
aring_upper                        = 0x00c5  /* u+00c5 latin capital letter a with ring above */
ae_upper                           = 0x00c6  /* u+00c6 latin capital letter ae */
ccedilla_upper                     = 0x00c7  /* u+00c7 latin capital letter c with cedilla */
egrave_upper                       = 0x00c8  /* u+00c8 latin capital letter e with grave */
eacute_upper                       = 0x00c9  /* u+00c9 latin capital letter e with acute */
ecircumflex_upper                  = 0x00ca  /* u+00ca latin capital letter e with circumflex */
ediaeresis_upper                   = 0x00cb  /* u+00cb latin capital letter e with diaeresis */
igrave_upper                       = 0x00cc  /* u+00cc latin capital letter i with grave */
iacute_upper                       = 0x00cd  /* u+00cd latin capital letter i with acute */
icircumflex_upper                  = 0x00ce  /* u+00ce latin capital letter i with circumflex */
idiaeresis_upper                   = 0x00cf  /* u+00cf latin capital letter i with diaeresis */
eth_upper                          = 0x00d0  /* u+00d0 latin capital letter eth */
ntilde_upper                       = 0x00d1  /* u+00d1 latin capital letter n with tilde */
ograve_upper                       = 0x00d2  /* u+00d2 latin capital letter o with grave */
oacute_upper                       = 0x00d3  /* u+00d3 latin capital letter o with acute */
ocircumflex_upper                  = 0x00d4  /* u+00d4 latin capital letter o with circumflex */
otilde_upper                       = 0x00d5  /* u+00d5 latin capital letter o with tilde */
odiaeresis_upper                   = 0x00d6  /* u+00d6 latin capital letter o with diaeresis */
multiply                      = 0x00d7  /* u+00d7 multiplication sign */
oslash_upper                       = 0x00d8  /* u+00d8 latin capital letter o with stroke */
ugrave_upper                       = 0x00d9  /* u+00d9 latin capital letter u with grave */
uacute_upper                       = 0x00da  /* u+00da latin capital letter u with acute */
ucircumflex_upper                  = 0x00db  /* u+00db latin capital letter u with circumflex */
udiaeresis_upper                   = 0x00dc  /* u+00dc latin capital letter u with diaeresis */
yacute_upper                       = 0x00dd  /* u+00dd latin capital letter y with acute */
thorn_upper                        = 0x00de  /* u+00de latin capital letter thorn */
ssharp_upper                       = 0x00df  /* u+00df latin small letter sharp s */
agrave                        = 0x00e0  /* u+00e0 latin small letter a with grave */
aacute                        = 0x00e1  /* u+00e1 latin small letter a with acute */
acircumflex                   = 0x00e2  /* u+00e2 latin small letter a with circumflex */
atilde                        = 0x00e3  /* u+00e3 latin small letter a with tilde */
adiaeresis                    = 0x00e4  /* u+00e4 latin small letter a with diaeresis */
aring                         = 0x00e5  /* u+00e5 latin small letter a with ring above */
ae                            = 0x00e6  /* u+00e6 latin small letter ae */
ccedilla                      = 0x00e7  /* u+00e7 latin small letter c with cedilla */
egrave                        = 0x00e8  /* u+00e8 latin small letter e with grave */
eacute                        = 0x00e9  /* u+00e9 latin small letter e with acute */
ecircumflex                   = 0x00ea  /* u+00ea latin small letter e with circumflex */
ediaeresis                    = 0x00eb  /* u+00eb latin small letter e with diaeresis */
igrave                        = 0x00ec  /* u+00ec latin small letter i with grave */
iacute                        = 0x00ed  /* u+00ed latin small letter i with acute */
icircumflex                   = 0x00ee  /* u+00ee latin small letter i with circumflex */
idiaeresis                    = 0x00ef  /* u+00ef latin small letter i with diaeresis */
eth                           = 0x00f0  /* u+00f0 latin small letter eth */
ntilde                        = 0x00f1  /* u+00f1 latin small letter n with tilde */
ograve                        = 0x00f2  /* u+00f2 latin small letter o with grave */
oacute                        = 0x00f3  /* u+00f3 latin small letter o with acute */
ocircumflex                   = 0x00f4  /* u+00f4 latin small letter o with circumflex */
otilde                        = 0x00f5  /* u+00f5 latin small letter o with tilde */
odiaeresis                    = 0x00f6  /* u+00f6 latin small letter o with diaeresis */
division                      = 0x00f7  /* u+00f7 division sign */
oslash                        = 0x00f8  /* u+00f8 latin small letter o with stroke */
ugrave                        = 0x00f9  /* u+00f9 latin small letter u with grave */
uacute                        = 0x00fa  /* u+00fa latin small letter u with acute */
ucircumflex                   = 0x00fb  /* u+00fb latin small letter u with circumflex */
udiaeresis                    = 0x00fc  /* u+00fc latin small letter u with diaeresis */
yacute                        = 0x00fd  /* u+00fd latin small letter y with acute */
thorn                         = 0x00fe  /* u+00fe latin small letter thorn */
ydiaeresis                    = 0x00ff  /* u+00ff latin small letter y with diaeresis */

/*
 * latin 2
 * byte 3 = 1
 */

aogonek_upper                       = 0x01a1  /* u+0104 latin capital letter a with ogonek */
breve                         = 0x01a2  /* u+02d8 breve */
lstroke_upper                      = 0x01a3  /* u+0141 latin capital letter l with stroke */
lcaron_upper                       = 0x01a5  /* u+013d latin capital letter l with caron */
sacute_upper                       = 0x01a6  /* u+015a latin capital letter s with acute */
scaron_upper                       = 0x01a9  /* u+0160 latin capital letter s with caron */
scedilla_upper                     = 0x01aa  /* u+015e latin capital letter s with cedilla */
tcaron_upper                       = 0x01ab  /* u+0164 latin capital letter t with caron */
zacute_upper                       = 0x01ac  /* u+0179 latin capital letter z with acute */
zcaron_upper                       = 0x01ae  /* u+017d latin capital letter z with caron */
zabovedot_upper                    = 0x01af  /* u+017b latin capital letter z with dot above */
aogonek                       = 0x01b1  /* u+0105 latin small letter a with ogonek */
ogonek                        = 0x01b2  /* u+02db ogonek */
lstroke                       = 0x01b3  /* u+0142 latin small letter l with stroke */
lcaron                        = 0x01b5  /* u+013e latin small letter l with caron */
sacute                        = 0x01b6  /* u+015b latin small letter s with acute */
caron                         = 0x01b7  /* u+02c7 caron */
scaron                        = 0x01b9  /* u+0161 latin small letter s with caron */
scedilla                      = 0x01ba  /* u+015f latin small letter s with cedilla */
tcaron                        = 0x01bb  /* u+0165 latin small letter t with caron */
zacute                        = 0x01bc  /* u+017a latin small letter z with acute */
doubleacute                   = 0x01bd  /* u+02dd double acute accent */
zcaron                        = 0x01be  /* u+017e latin small letter z with caron */
zabovedot                     = 0x01bf  /* u+017c latin small letter z with dot above */
racute_upper                       = 0x01c0  /* u+0154 latin capital letter r with acute */
abreve_upper                       = 0x01c3  /* u+0102 latin capital letter a with breve */
lacute_upper                       = 0x01c5  /* u+0139 latin capital letter l with acute */
cacute_upper                       = 0x01c6  /* u+0106 latin capital letter c with acute */
ccaron_upper                       = 0x01c8  /* u+010c latin capital letter c with caron */
eogonek_upper                      = 0x01ca  /* u+0118 latin capital letter e with ogonek */
ecaron_upper                       = 0x01cc  /* u+011a latin capital letter e with caron */
dcaron_upper                       = 0x01cf  /* u+010e latin capital letter d with caron */
dstroke_upper                      = 0x01d0  /* u+0110 latin capital letter d with stroke */
nacute_upper                       = 0x01d1  /* u+0143 latin capital letter n with acute */
ncaron_upper                       = 0x01d2  /* u+0147 latin capital letter n with caron */
odoubleacute_upper                 = 0x01d5  /* u+0150 latin capital letter o with double acute */
rcaron_upper                       = 0x01d8  /* u+0158 latin capital letter r with caron */
uring_upper                        = 0x01d9  /* u+016e latin capital letter u with ring above */
udoubleacute_upper                 = 0x01db  /* u+0170 latin capital letter u with double acute */
tcedilla_upper                     = 0x01de  /* u+0162 latin capital letter t with cedilla */
racute                        = 0x01e0  /* u+0155 latin small letter r with acute */
abreve                        = 0x01e3  /* u+0103 latin small letter a with breve */
lacute                        = 0x01e5  /* u+013a latin small letter l with acute */
cacute                        = 0x01e6  /* u+0107 latin small letter c with acute */
ccaron                        = 0x01e8  /* u+010d latin small letter c with caron */
eogonek                       = 0x01ea  /* u+0119 latin small letter e with ogonek */
ecaron                        = 0x01ec  /* u+011b latin small letter e with caron */
dcaron                        = 0x01ef  /* u+010f latin small letter d with caron */
dstroke                       = 0x01f0  /* u+0111 latin small letter d with stroke */
nacute                        = 0x01f1  /* u+0144 latin small letter n with acute */
ncaron                        = 0x01f2  /* u+0148 latin small letter n with caron */
odoubleacute                  = 0x01f5  /* u+0151 latin small letter o with double acute */
rcaron                        = 0x01f8  /* u+0159 latin small letter r with caron */
uring                         = 0x01f9  /* u+016f latin small letter u with ring above */
udoubleacute                  = 0x01fb  /* u+0171 latin small letter u with double acute */
tcedilla                      = 0x01fe  /* u+0163 latin small letter t with cedilla */
abovedot                      = 0x01ff  /* u+02d9 dot above */

/*
 * latin 3
 * byte 3 = 2
 */

hstroke_upper                      = 0x02a1  /* u+0126 latin capital letter h with stroke */
hcircumflex_upper                  = 0x02a6  /* u+0124 latin capital letter h with circumflex */
iabovedot_upper                    = 0x02a9  /* u+0130 latin capital letter i with dot above */
gbreve_upper                       = 0x02ab  /* u+011e latin capital letter g with breve */
jcircumflex_upper                  = 0x02ac  /* u+0134 latin capital letter j with circumflex */
hstroke                       = 0x02b1  /* u+0127 latin small letter h with stroke */
hcircumflex                   = 0x02b6  /* u+0125 latin small letter h with circumflex */
idotless                      = 0x02b9  /* u+0131 latin small letter dotless i */
gbreve                        = 0x02bb  /* u+011f latin small letter g with breve */
jcircumflex                   = 0x02bc  /* u+0135 latin small letter j with circumflex */
cabovedot_upper                    = 0x02c5  /* u+010a latin capital letter c with dot above */
ccircumflex_upper                  = 0x02c6  /* u+0108 latin capital letter c with circumflex */
gabovedot_upper                    = 0x02d5  /* u+0120 latin capital letter g with dot above */
gcircumflex_upper                  = 0x02d8  /* u+011c latin capital letter g with circumflex */
ubreve_upper                       = 0x02dd  /* u+016c latin capital letter u with breve */
scircumflex_upper                  = 0x02de  /* u+015c latin capital letter s with circumflex */
cabovedot                     = 0x02e5  /* u+010b latin small letter c with dot above */
ccircumflex                   = 0x02e6  /* u+0109 latin small letter c with circumflex */
gabovedot                     = 0x02f5  /* u+0121 latin small letter g with dot above */
gcircumflex                   = 0x02f8  /* u+011d latin small letter g with circumflex */
ubreve                        = 0x02fd  /* u+016d latin small letter u with breve */
scircumflex                   = 0x02fe  /* u+015d latin small letter s with circumflex */


/*
 * latin 4
 * byte 3 = 3
 */

kra                           = 0x03a2  /* u+0138 latin small letter kra */
rcedilla_upper                     = 0x03a3  /* u+0156 latin capital letter r with cedilla */
itilde_upper                       = 0x03a5  /* u+0128 latin capital letter i with tilde */
lcedilla_upper                     = 0x03a6  /* u+013b latin capital letter l with cedilla */
emacron_upper                      = 0x03aa  /* u+0112 latin capital letter e with macron */
gcedilla_upper                     = 0x03ab  /* u+0122 latin capital letter g with cedilla */
tslash_upper                       = 0x03ac  /* u+0166 latin capital letter t with stroke */
rcedilla                      = 0x03b3  /* u+0157 latin small letter r with cedilla */
itilde                        = 0x03b5  /* u+0129 latin small letter i with tilde */
lcedilla                      = 0x03b6  /* u+013c latin small letter l with cedilla */
emacron                       = 0x03ba  /* u+0113 latin small letter e with macron */
gcedilla                      = 0x03bb  /* u+0123 latin small letter g with cedilla */
tslash                        = 0x03bc  /* u+0167 latin small letter t with stroke */
eng_upper                           = 0x03bd  /* u+014a latin capital letter eng */
eng                           = 0x03bf  /* u+014b latin small letter eng */
amacron_upper                      = 0x03c0  /* u+0100 latin capital letter a with macron */
iogonek_upper                      = 0x03c7  /* u+012e latin capital letter i with ogonek */
eabovedot_upper                    = 0x03cc  /* u+0116 latin capital letter e with dot above */
imacron_upper                      = 0x03cf  /* u+012a latin capital letter i with macron */
ncedilla_upper                     = 0x03d1  /* u+0145 latin capital letter n with cedilla */
omacron_upper                      = 0x03d2  /* u+014c latin capital letter o with macron */
kcedilla_upper                     = 0x03d3  /* u+0136 latin capital letter k with cedilla */
uogonek_upper                      = 0x03d9  /* u+0172 latin capital letter u with ogonek */
utilde_upper                       = 0x03dd  /* u+0168 latin capital letter u with tilde */
umacron_upper                      = 0x03de  /* u+016a latin capital letter u with macron */
amacron                       = 0x03e0  /* u+0101 latin small letter a with macron */
iogonek                       = 0x03e7  /* u+012f latin small letter i with ogonek */
eabovedot                     = 0x03ec  /* u+0117 latin small letter e with dot above */
imacron                       = 0x03ef  /* u+012b latin small letter i with macron */
ncedilla                      = 0x03f1  /* u+0146 latin small letter n with cedilla */
omacron                       = 0x03f2  /* u+014d latin small letter o with macron */
kcedilla                      = 0x03f3  /* u+0137 latin small letter k with cedilla */
uogonek                       = 0x03f9  /* u+0173 latin small letter u with ogonek */
utilde                        = 0x03fd  /* u+0169 latin small letter u with tilde */
umacron                       = 0x03fe  /* u+016b latin small letter u with macron */

/*
 * latin 8
 */
wcircumflex_upper                = 0x1000174  /* u+0174 latin capital letter w with circumflex */
wcircumflex                = 0x1000175  /* u+0175 latin small letter w with circumflex */
ycircumflex_upper                = 0x1000176  /* u+0176 latin capital letter y with circumflex */
ycircumflex                = 0x1000177  /* u+0177 latin small letter y with circumflex */
babovedot_upper                  = 0x1001e02  /* u+1e02 latin capital letter b with dot above */
babovedot                  = 0x1001e03  /* u+1e03 latin small letter b with dot above */
dabovedot_upper                  = 0x1001e0a  /* u+1e0a latin capital letter d with dot above */
dabovedot                  = 0x1001e0b  /* u+1e0b latin small letter d with dot above */
fabovedot_upper                  = 0x1001e1e  /* u+1e1e latin capital letter f with dot above */
fabovedot                  = 0x1001e1f  /* u+1e1f latin small letter f with dot above */
mabovedot_upper                  = 0x1001e40  /* u+1e40 latin capital letter m with dot above */
mabovedot                  = 0x1001e41  /* u+1e41 latin small letter m with dot above */
pabovedot_upper                  = 0x1001e56  /* u+1e56 latin capital letter p with dot above */
pabovedot                  = 0x1001e57  /* u+1e57 latin small letter p with dot above */
sabovedot_upper                  = 0x1001e60  /* u+1e60 latin capital letter s with dot above */
sabovedot                  = 0x1001e61  /* u+1e61 latin small letter s with dot above */
tabovedot_upper                  = 0x1001e6a  /* u+1e6a latin capital letter t with dot above */
tabovedot                  = 0x1001e6b  /* u+1e6b latin small letter t with dot above */
wgrave_upper                     = 0x1001e80  /* u+1e80 latin capital letter w with grave */
wgrave                     = 0x1001e81  /* u+1e81 latin small letter w with grave */
wacute_upper                     = 0x1001e82  /* u+1e82 latin capital letter w with acute */
wacute                     = 0x1001e83  /* u+1e83 latin small letter w with acute */
wdiaeresis_upper                 = 0x1001e84  /* u+1e84 latin capital letter w with diaeresis */
wdiaeresis                 = 0x1001e85  /* u+1e85 latin small letter w with diaeresis */
ygrave_upper                     = 0x1001ef2  /* u+1ef2 latin capital letter y with grave */
ygrave                     = 0x1001ef3  /* u+1ef3 latin small letter y with grave */

/*
 * latin 9
 * byte 3 = = 0x13
 */

oe                            = 0x13bc  /* u+0152 latin capital ligature oe */
oe_upper                            = 0x13bd  /* u+0153 latin small ligature oe */
ydiaeresis_upper                    = 0x13be  /* u+0178 latin capital letter y with diaeresis */

/*
 * katakana
 * byte 3 = 4
 */

overline                      = 0x047e  /* u+203e overline */
kana_fullstop                 = 0x04a1  /* u+3002 ideographic full stop */
kana_openingbracket           = 0x04a2  /* u+300c left corner bracket */
kana_closingbracket           = 0x04a3  /* u+300d right corner bracket */
kana_comma                    = 0x04a4  /* u+3001 ideographic comma */
kana_conjunctive              = 0x04a5  /* u+30fb katakana middle dot */
kana_wo_small                      = 0x04a6  /* u+30f2 katakana letter wo */
kana_a_small                       = 0x04a7  /* u+30a1 katakana letter small a */
kana_i_small                       = 0x04a8  /* u+30a3 katakana letter small i */
kana_u_small                       = 0x04a9  /* u+30a5 katakana letter small u */
kana_e_small                       = 0x04aa  /* u+30a7 katakana letter small e */
kana_o_small                       = 0x04ab  /* u+30a9 katakana letter small o */
kana_ya_small                      = 0x04ac  /* u+30e3 katakana letter small ya */
kana_yu_small                      = 0x04ad  /* u+30e5 katakana letter small yu */
kana_yo_small                      = 0x04ae  /* u+30e7 katakana letter small yo */
kana_tsu_small                     = 0x04af  /* u+30c3 katakana letter small tu */
prolongedsound                = 0x04b0  /* u+30fc katakana-hiragana prolonged sound mark */
kana_a                        = 0x04b1  /* u+30a2 katakana letter a */
kana_i                        = 0x04b2  /* u+30a4 katakana letter i */
kana_u                        = 0x04b3  /* u+30a6 katakana letter u */
kana_e                        = 0x04b4  /* u+30a8 katakana letter e */
kana_o                        = 0x04b5  /* u+30aa katakana letter o */
kana_ka                       = 0x04b6  /* u+30ab katakana letter ka */
kana_ki                       = 0x04b7  /* u+30ad katakana letter ki */
kana_ku                       = 0x04b8  /* u+30af katakana letter ku */
kana_ke                       = 0x04b9  /* u+30b1 katakana letter ke */
kana_ko                       = 0x04ba  /* u+30b3 katakana letter ko */
kana_sa                       = 0x04bb  /* u+30b5 katakana letter sa */
kana_shi                      = 0x04bc  /* u+30b7 katakana letter si */
kana_su                       = 0x04bd  /* u+30b9 katakana letter su */
kana_se                       = 0x04be  /* u+30bb katakana letter se */
kana_so                       = 0x04bf  /* u+30bd katakana letter so */
kana_ta                       = 0x04c0  /* u+30bf katakana letter ta */
kana_chi                      = 0x04c1  /* u+30c1 katakana letter ti */
kana_tsu                      = 0x04c2  /* u+30c4 katakana letter tu */
kana_te                       = 0x04c3  /* u+30c6 katakana letter te */
kana_to                       = 0x04c4  /* u+30c8 katakana letter to */
kana_na                       = 0x04c5  /* u+30ca katakana letter na */
kana_ni                       = 0x04c6  /* u+30cb katakana letter ni */
kana_nu                       = 0x04c7  /* u+30cc katakana letter nu */
kana_ne                       = 0x04c8  /* u+30cd katakana letter ne */
kana_no                       = 0x04c9  /* u+30ce katakana letter no */
kana_ha                       = 0x04ca  /* u+30cf katakana letter ha */
kana_hi                       = 0x04cb  /* u+30d2 katakana letter hi */
kana_fu                       = 0x04cc  /* u+30d5 katakana letter hu */
kana_he                       = 0x04cd  /* u+30d8 katakana letter he */
kana_ho                       = 0x04ce  /* u+30db katakana letter ho */
kana_ma                       = 0x04cf  /* u+30de katakana letter ma */
kana_mi                       = 0x04d0  /* u+30df katakana letter mi */
kana_mu                       = 0x04d1  /* u+30e0 katakana letter mu */
kana_me                       = 0x04d2  /* u+30e1 katakana letter me */
kana_mo                       = 0x04d3  /* u+30e2 katakana letter mo */
kana_ya                       = 0x04d4  /* u+30e4 katakana letter ya */
kana_yu                       = 0x04d5  /* u+30e6 katakana letter yu */
kana_yo                       = 0x04d6  /* u+30e8 katakana letter yo */
kana_ra                       = 0x04d7  /* u+30e9 katakana letter ra */
kana_ri                       = 0x04d8  /* u+30ea katakana letter ri */
kana_ru                       = 0x04d9  /* u+30eb katakana letter ru */
kana_re                       = 0x04da  /* u+30ec katakana letter re */
kana_ro                       = 0x04db  /* u+30ed katakana letter ro */
kana_wa                       = 0x04dc  /* u+30ef katakana letter wa */
kana_n                        = 0x04dd  /* u+30f3 katakana letter n */
voicedsound                   = 0x04de  /* u+309b katakana-hiragana voiced sound mark */
semivoicedsound               = 0x04df  /* u+309c katakana-hiragana semi-voiced sound mark */

/*
 * arabic
 * byte 3 = 5
 */

farsi_0                    = 0x10006f0  /* u+06f0 extended arabic-indic digit zero */
farsi_1                    = 0x10006f1  /* u+06f1 extended arabic-indic digit one */
farsi_2                    = 0x10006f2  /* u+06f2 extended arabic-indic digit two */
farsi_3                    = 0x10006f3  /* u+06f3 extended arabic-indic digit three */
farsi_4                    = 0x10006f4  /* u+06f4 extended arabic-indic digit four */
farsi_5                    = 0x10006f5  /* u+06f5 extended arabic-indic digit five */
farsi_6                    = 0x10006f6  /* u+06f6 extended arabic-indic digit six */
farsi_7                    = 0x10006f7  /* u+06f7 extended arabic-indic digit seven */
farsi_8                    = 0x10006f8  /* u+06f8 extended arabic-indic digit eight */
farsi_9                    = 0x10006f9  /* u+06f9 extended arabic-indic digit nine */
arabic_percent             = 0x100066a  /* u+066a arabic percent sign */
arabic_superscript_alef    = 0x1000670  /* u+0670 arabic letter superscript alef */
arabic_tteh                = 0x1000679  /* u+0679 arabic letter tteh */
arabic_peh                 = 0x100067e  /* u+067e arabic letter peh */
arabic_tcheh               = 0x1000686  /* u+0686 arabic letter tcheh */
arabic_ddal                = 0x1000688  /* u+0688 arabic letter ddal */
arabic_rreh                = 0x1000691  /* u+0691 arabic letter rreh */
arabic_comma                  = 0x05ac  /* u+060c arabic comma */
arabic_fullstop            = 0x10006d4  /* u+06d4 arabic full stop */
arabic_0                   = 0x1000660  /* u+0660 arabic-indic digit zero */
arabic_1                   = 0x1000661  /* u+0661 arabic-indic digit one */
arabic_2                   = 0x1000662  /* u+0662 arabic-indic digit two */
arabic_3                   = 0x1000663  /* u+0663 arabic-indic digit three */
arabic_4                   = 0x1000664  /* u+0664 arabic-indic digit four */
arabic_5                   = 0x1000665  /* u+0665 arabic-indic digit five */
arabic_6                   = 0x1000666  /* u+0666 arabic-indic digit six */
arabic_7                   = 0x1000667  /* u+0667 arabic-indic digit seven */
arabic_8                   = 0x1000668  /* u+0668 arabic-indic digit eight */
arabic_9                   = 0x1000669  /* u+0669 arabic-indic digit nine */
arabic_semicolon              = 0x05bb  /* u+061b arabic semicolon */
arabic_question_mark          = 0x05bf  /* u+061f arabic question mark */
arabic_hamza                  = 0x05c1  /* u+0621 arabic letter hamza */
arabic_maddaonalef            = 0x05c2  /* u+0622 arabic letter alef with madda above */
arabic_hamzaonalef            = 0x05c3  /* u+0623 arabic letter alef with hamza above */
arabic_hamzaonwaw             = 0x05c4  /* u+0624 arabic letter waw with hamza above */
arabic_hamzaunderalef         = 0x05c5  /* u+0625 arabic letter alef with hamza below */
arabic_hamzaonyeh             = 0x05c6  /* u+0626 arabic letter yeh with hamza above */
arabic_alef                   = 0x05c7  /* u+0627 arabic letter alef */
arabic_beh                    = 0x05c8  /* u+0628 arabic letter beh */
arabic_tehmarbuta             = 0x05c9  /* u+0629 arabic letter teh marbuta */
arabic_teh                    = 0x05ca  /* u+062a arabic letter teh */
arabic_theh                   = 0x05cb  /* u+062b arabic letter theh */
arabic_jeem                   = 0x05cc  /* u+062c arabic letter jeem */
arabic_hah                    = 0x05cd  /* u+062d arabic letter hah */
arabic_khah                   = 0x05ce  /* u+062e arabic letter khah */
arabic_dal                    = 0x05cf  /* u+062f arabic letter dal */
arabic_thal                   = 0x05d0  /* u+0630 arabic letter thal */
arabic_ra                     = 0x05d1  /* u+0631 arabic letter reh */
arabic_zain                   = 0x05d2  /* u+0632 arabic letter zain */
arabic_seen                   = 0x05d3  /* u+0633 arabic letter seen */
arabic_sheen                  = 0x05d4  /* u+0634 arabic letter sheen */
arabic_sad                    = 0x05d5  /* u+0635 arabic letter sad */
arabic_dad                    = 0x05d6  /* u+0636 arabic letter dad */
arabic_tah                    = 0x05d7  /* u+0637 arabic letter tah */
arabic_zah                    = 0x05d8  /* u+0638 arabic letter zah */
arabic_ain                    = 0x05d9  /* u+0639 arabic letter ain */
arabic_ghain                  = 0x05da  /* u+063a arabic letter ghain */
arabic_tatweel                = 0x05e0  /* u+0640 arabic tatweel */
arabic_feh                    = 0x05e1  /* u+0641 arabic letter feh */
arabic_qaf                    = 0x05e2  /* u+0642 arabic letter qaf */
arabic_kaf                    = 0x05e3  /* u+0643 arabic letter kaf */
arabic_lam                    = 0x05e4  /* u+0644 arabic letter lam */
arabic_meem                   = 0x05e5  /* u+0645 arabic letter meem */
arabic_noon                   = 0x05e6  /* u+0646 arabic letter noon */
arabic_ha                     = 0x05e7  /* u+0647 arabic letter heh */
arabic_waw                    = 0x05e8  /* u+0648 arabic letter waw */
arabic_alefmaksura            = 0x05e9  /* u+0649 arabic letter alef maksura */
arabic_yeh                    = 0x05ea  /* u+064a arabic letter yeh */
arabic_fathatan               = 0x05eb  /* u+064b arabic fathatan */
arabic_dammatan               = 0x05ec  /* u+064c arabic dammatan */
arabic_kasratan               = 0x05ed  /* u+064d arabic kasratan */
arabic_fatha                  = 0x05ee  /* u+064e arabic fatha */
arabic_damma                  = 0x05ef  /* u+064f arabic damma */
arabic_kasra                  = 0x05f0  /* u+0650 arabic kasra */
arabic_shadda                 = 0x05f1  /* u+0651 arabic shadda */
arabic_sukun                  = 0x05f2  /* u+0652 arabic sukun */
arabic_madda_above         = 0x1000653  /* u+0653 arabic maddah above */
arabic_hamza_above         = 0x1000654  /* u+0654 arabic hamza above */
arabic_hamza_below         = 0x1000655  /* u+0655 arabic hamza below */
arabic_jeh                 = 0x1000698  /* u+0698 arabic letter jeh */
arabic_veh                 = 0x10006a4  /* u+06a4 arabic letter veh */
arabic_keheh               = 0x10006a9  /* u+06a9 arabic letter keheh */
arabic_gaf                 = 0x10006af  /* u+06af arabic letter gaf */
arabic_noon_ghunna         = 0x10006ba  /* u+06ba arabic letter noon ghunna */
arabic_heh_doachashmee     = 0x10006be  /* u+06be arabic letter heh doachashmee */
farsi_yeh                  = 0x10006cc  /* u+06cc arabic letter farsi yeh */
arabic_yeh_baree           = 0x10006d2  /* u+06d2 arabic letter yeh barree */
arabic_heh_goal            = 0x10006c1  /* u+06c1 arabic letter heh goal */

/*
 * cyrillic
 * byte 3 = 6
 */
cyrillic_ghe_bar_upper           = 0x1000492  /* u+0492 cyrillic capital letter ghe with stroke */
cyrillic_ghe_bar           = 0x1000493  /* u+0493 cyrillic small letter ghe with stroke */
cyrillic_zhe_descender_upper     = 0x1000496  /* u+0496 cyrillic capital letter zhe with descender */
cyrillic_zhe_descender     = 0x1000497  /* u+0497 cyrillic small letter zhe with descender */
cyrillic_ka_descender_upper      = 0x100049a  /* u+049a cyrillic capital letter ka with descender */
cyrillic_ka_descender      = 0x100049b  /* u+049b cyrillic small letter ka with descender */
cyrillic_ka_vertstroke_upper     = 0x100049c  /* u+049c cyrillic capital letter ka with vertical stroke */
cyrillic_ka_vertstroke     = 0x100049d  /* u+049d cyrillic small letter ka with vertical stroke */
cyrillic_en_descender_upper      = 0x10004a2  /* u+04a2 cyrillic capital letter en with descender */
cyrillic_en_descender      = 0x10004a3  /* u+04a3 cyrillic small letter en with descender */
cyrillic_u_straight_upper        = 0x10004ae  /* u+04ae cyrillic capital letter straight u */
cyrillic_u_straight        = 0x10004af  /* u+04af cyrillic small letter straight u */
cyrillic_u_straight_bar_upper    = 0x10004b0  /* u+04b0 cyrillic capital letter straight u with stroke */
cyrillic_u_straight_bar    = 0x10004b1  /* u+04b1 cyrillic small letter straight u with stroke */
cyrillic_ha_descender_upper      = 0x10004b2  /* u+04b2 cyrillic capital letter ha with descender */
cyrillic_ha_descender      = 0x10004b3  /* u+04b3 cyrillic small letter ha with descender */
cyrillic_che_descender_upper     = 0x10004b6  /* u+04b6 cyrillic capital letter che with descender */
cyrillic_che_descender     = 0x10004b7  /* u+04b7 cyrillic small letter che with descender */
cyrillic_che_vertstroke_upper    = 0x10004b8  /* u+04b8 cyrillic capital letter che with vertical stroke */
cyrillic_che_vertstroke    = 0x10004b9  /* u+04b9 cyrillic small letter che with vertical stroke */
cyrillic_shha_upper              = 0x10004ba  /* u+04ba cyrillic capital letter shha */
cyrillic_shha              = 0x10004bb  /* u+04bb cyrillic small letter shha */

cyrillic_schwa_upper             = 0x10004d8  /* u+04d8 cyrillic capital letter schwa */
cyrillic_schwa             = 0x10004d9  /* u+04d9 cyrillic small letter schwa */
cyrillic_i_macron_upper          = 0x10004e2  /* u+04e2 cyrillic capital letter i with macron */
cyrillic_i_macron          = 0x10004e3  /* u+04e3 cyrillic small letter i with macron */
cyrillic_o_bar_upper             = 0x10004e8  /* u+04e8 cyrillic capital letter barred o */
cyrillic_o_bar             = 0x10004e9  /* u+04e9 cyrillic small letter barred o */
cyrillic_u_macron_upper          = 0x10004ee  /* u+04ee cyrillic capital letter u with macron */
cyrillic_u_macron          = 0x10004ef  /* u+04ef cyrillic small letter u with macron */

serbian_dje                   = 0x06a1  /* u+0452 cyrillic small letter dje */
macedonia_gje                 = 0x06a2  /* u+0453 cyrillic small letter gje */
cyrillic_io                   = 0x06a3  /* u+0451 cyrillic small letter io */
ukrainian_ie                  = 0x06a4  /* u+0454 cyrillic small letter ukrainian ie */
macedonia_dse                 = 0x06a5  /* u+0455 cyrillic small letter dze */
ukrainian_i                   = 0x06a6  /* u+0456 cyrillic small letter byelorussian-ukrainian i */
ukrainian_yi                  = 0x06a7  /* u+0457 cyrillic small letter yi */
cyrillic_je                   = 0x06a8  /* u+0458 cyrillic small letter je */
cyrillic_lje                  = 0x06a9  /* u+0459 cyrillic small letter lje */
cyrillic_nje                  = 0x06aa  /* u+045a cyrillic small letter nje */
serbian_tshe                  = 0x06ab  /* u+045b cyrillic small letter tshe */
macedonia_kje                 = 0x06ac  /* u+045c cyrillic small letter kje */
ukrainian_ghe_with_upturn     = 0x06ad  /* u+0491 cyrillic small letter ghe with upturn */
byelorussian_shortu           = 0x06ae  /* u+045e cyrillic small letter short u */
cyrillic_dzhe                 = 0x06af  /* u+045f cyrillic small letter dzhe */
numerosign                    = 0x06b0  /* u+2116 numero sign */
serbian_dje_upper                  = 0x06b1  /* u+0402 cyrillic capital letter dje */
macedonia_gje_upper                = 0x06b2  /* u+0403 cyrillic capital letter gje */
cyrillic_io_upper                  = 0x06b3  /* u+0401 cyrillic capital letter io */
ukrainian_ie_upper                 = 0x06b4  /* u+0404 cyrillic capital letter ukrainian ie */
macedonia_dse_upper                = 0x06b5  /* u+0405 cyrillic capital letter dze */
ukrainian_i_upper                  = 0x06b6  /* u+0406 cyrillic capital letter byelorussian-ukrainian i */
ukrainian_yi_upper                 = 0x06b7  /* u+0407 cyrillic capital letter yi */
cyrillic_je_upper                  = 0x06b8  /* u+0408 cyrillic capital letter je */
cyrillic_lje_upper                 = 0x06b9  /* u+0409 cyrillic capital letter lje */
cyrillic_nje_upper                 = 0x06ba  /* u+040a cyrillic capital letter nje */
serbian_tshe_upper                 = 0x06bb  /* u+040b cyrillic capital letter tshe */
macedonia_kje_upper                = 0x06bc  /* u+040c cyrillic capital letter kje */
ukrainian_ghe_with_upturn_upper    = 0x06bd  /* u+0490 cyrillic capital letter ghe with upturn */
byelorussian_shortu_upper          = 0x06be  /* u+040e cyrillic capital letter short u */
cyrillic_dzhe_upper                = 0x06bf  /* u+040f cyrillic capital letter dzhe */
cyrillic_yu                   = 0x06c0  /* u+044e cyrillic small letter yu */
cyrillic_a                    = 0x06c1  /* u+0430 cyrillic small letter a */
cyrillic_be                   = 0x06c2  /* u+0431 cyrillic small letter be */
cyrillic_tse                  = 0x06c3  /* u+0446 cyrillic small letter tse */
cyrillic_de                   = 0x06c4  /* u+0434 cyrillic small letter de */
cyrillic_ie                   = 0x06c5  /* u+0435 cyrillic small letter ie */
cyrillic_ef                   = 0x06c6  /* u+0444 cyrillic small letter ef */
cyrillic_ghe                  = 0x06c7  /* u+0433 cyrillic small letter ghe */
cyrillic_ha                   = 0x06c8  /* u+0445 cyrillic small letter ha */
cyrillic_i                    = 0x06c9  /* u+0438 cyrillic small letter i */
cyrillic_shorti               = 0x06ca  /* u+0439 cyrillic small letter short i */
cyrillic_ka                   = 0x06cb  /* u+043a cyrillic small letter ka */
cyrillic_el                   = 0x06cc  /* u+043b cyrillic small letter el */
cyrillic_em                   = 0x06cd  /* u+043c cyrillic small letter em */
cyrillic_en                   = 0x06ce  /* u+043d cyrillic small letter en */
cyrillic_o                    = 0x06cf  /* u+043e cyrillic small letter o */
cyrillic_pe                   = 0x06d0  /* u+043f cyrillic small letter pe */
cyrillic_ya                   = 0x06d1  /* u+044f cyrillic small letter ya */
cyrillic_er                   = 0x06d2  /* u+0440 cyrillic small letter er */
cyrillic_es                   = 0x06d3  /* u+0441 cyrillic small letter es */
cyrillic_te                   = 0x06d4  /* u+0442 cyrillic small letter te */
cyrillic_u                    = 0x06d5  /* u+0443 cyrillic small letter u */
cyrillic_zhe                  = 0x06d6  /* u+0436 cyrillic small letter zhe */
cyrillic_ve                   = 0x06d7  /* u+0432 cyrillic small letter ve */
cyrillic_softsign             = 0x06d8  /* u+044c cyrillic small letter soft sign */
cyrillic_yeru                 = 0x06d9  /* u+044b cyrillic small letter yeru */
cyrillic_ze                   = 0x06da  /* u+0437 cyrillic small letter ze */
cyrillic_sha                  = 0x06db  /* u+0448 cyrillic small letter sha */
cyrillic_e                    = 0x06dc  /* u+044d cyrillic small letter e */
cyrillic_shcha                = 0x06dd  /* u+0449 cyrillic small letter shcha */
cyrillic_che                  = 0x06de  /* u+0447 cyrillic small letter che */
cyrillic_hardsign             = 0x06df  /* u+044a cyrillic small letter hard sign */
cyrillic_yu_upper                  = 0x06e0  /* u+042e cyrillic capital letter yu */
cyrillic_a_upper                   = 0x06e1  /* u+0410 cyrillic capital letter a */
cyrillic_be_upper                  = 0x06e2  /* u+0411 cyrillic capital letter be */
cyrillic_tse_upper                 = 0x06e3  /* u+0426 cyrillic capital letter tse */
cyrillic_de_upper                  = 0x06e4  /* u+0414 cyrillic capital letter de */
cyrillic_ie_upper                  = 0x06e5  /* u+0415 cyrillic capital letter ie */
cyrillic_ef_upper                  = 0x06e6  /* u+0424 cyrillic capital letter ef */
cyrillic_ghe_upper                 = 0x06e7  /* u+0413 cyrillic capital letter ghe */
cyrillic_ha_upper                  = 0x06e8  /* u+0425 cyrillic capital letter ha */
cyrillic_i_upper                   = 0x06e9  /* u+0418 cyrillic capital letter i */
cyrillic_shorti_upper              = 0x06ea  /* u+0419 cyrillic capital letter short i */
cyrillic_ka_upper                  = 0x06eb  /* u+041a cyrillic capital letter ka */
cyrillic_el_upper                  = 0x06ec  /* u+041b cyrillic capital letter el */
cyrillic_em_upper                  = 0x06ed  /* u+041c cyrillic capital letter em */
cyrillic_en_upper                  = 0x06ee  /* u+041d cyrillic capital letter en */
cyrillic_o_upper                   = 0x06ef  /* u+041e cyrillic capital letter o */
cyrillic_pe_upper                  = 0x06f0  /* u+041f cyrillic capital letter pe */
cyrillic_ya_upper                  = 0x06f1  /* u+042f cyrillic capital letter ya */
cyrillic_er_upper                  = 0x06f2  /* u+0420 cyrillic capital letter er */
cyrillic_es_upper                  = 0x06f3  /* u+0421 cyrillic capital letter es */
cyrillic_te_upper                  = 0x06f4  /* u+0422 cyrillic capital letter te */
cyrillic_u_upper                   = 0x06f5  /* u+0423 cyrillic capital letter u */
cyrillic_zhe_upper                 = 0x06f6  /* u+0416 cyrillic capital letter zhe */
cyrillic_ve_upper                  = 0x06f7  /* u+0412 cyrillic capital letter ve */
cyrillic_softsign_upper            = 0x06f8  /* u+042c cyrillic capital letter soft sign */
cyrillic_yeru_upper                = 0x06f9  /* u+042b cyrillic capital letter yeru */
cyrillic_ze_upper                  = 0x06fa  /* u+0417 cyrillic capital letter ze */
cyrillic_sha_upper                 = 0x06fb  /* u+0428 cyrillic capital letter sha */
cyrillic_e_upper                   = 0x06fc  /* u+042d cyrillic capital letter e */
cyrillic_shcha_upper               = 0x06fd  /* u+0429 cyrillic capital letter shcha */
cyrillic_che_upper                 = 0x06fe  /* u+0427 cyrillic capital letter che */
cyrillic_hardsign_upper            = 0x06ff  /* u+042a cyrillic capital letter hard sign */

/*
 * greek
 * (based on an early draft of, and not quite identical to, iso/iec 8859-7)
 * byte 3 = 7
 */

greek_alphaaccent_upper            = 0x07a1  /* u+0386 greek capital letter alpha with tonos */
greek_epsilonaccent_upper          = 0x07a2  /* u+0388 greek capital letter epsilon with tonos */
greek_etaaccent_upper              = 0x07a3  /* u+0389 greek capital letter eta with tonos */
greek_iotaaccent_upper             = 0x07a4  /* u+038a greek capital letter iota with tonos */
greek_iotadieresis_upper           = 0x07a5  /* u+03aa greek capital letter iota with dialytika */
greek_omicronaccent_upper          = 0x07a7  /* u+038c greek capital letter omicron with tonos */
greek_upsilonaccent_upper          = 0x07a8  /* u+038e greek capital letter upsilon with tonos */
greek_upsilondieresis_upper        = 0x07a9  /* u+03ab greek capital letter upsilon with dialytika */
greek_omegaaccent_upper            = 0x07ab  /* u+038f greek capital letter omega with tonos */
greek_accentdieresis          = 0x07ae  /* u+0385 greek dialytika tonos */
greek_horizbar                = 0x07af  /* u+2015 horizontal bar */
greek_alphaaccent             = 0x07b1  /* u+03ac greek small letter alpha with tonos */
greek_epsilonaccent           = 0x07b2  /* u+03ad greek small letter epsilon with tonos */
greek_etaaccent               = 0x07b3  /* u+03ae greek small letter eta with tonos */
greek_iotaaccent              = 0x07b4  /* u+03af greek small letter iota with tonos */
greek_iotadieresis            = 0x07b5  /* u+03ca greek small letter iota with dialytika */
greek_iotaaccentdieresis      = 0x07b6  /* u+0390 greek small letter iota with dialytika and tonos */
greek_omicronaccent           = 0x07b7  /* u+03cc greek small letter omicron with tonos */
greek_upsilonaccent           = 0x07b8  /* u+03cd greek small letter upsilon with tonos */
greek_upsilondieresis         = 0x07b9  /* u+03cb greek small letter upsilon with dialytika */
greek_upsilonaccentdieresis   = 0x07ba  /* u+03b0 greek small letter upsilon with dialytika and tonos */
greek_omegaaccent             = 0x07bb  /* u+03ce greek small letter omega with tonos */
greek_alpha_upper                  = 0x07c1  /* u+0391 greek capital letter alpha */
greek_beta_upper                   = 0x07c2  /* u+0392 greek capital letter beta */
greek_gamma_upper                  = 0x07c3  /* u+0393 greek capital letter gamma */
greek_delta_upper                  = 0x07c4  /* u+0394 greek capital letter delta */
greek_epsilon_upper                = 0x07c5  /* u+0395 greek capital letter epsilon */
greek_zeta_upper                   = 0x07c6  /* u+0396 greek capital letter zeta */
greek_eta_upper                    = 0x07c7  /* u+0397 greek capital letter eta */
greek_theta_upper                  = 0x07c8  /* u+0398 greek capital letter theta */
greek_iota_upper                   = 0x07c9  /* u+0399 greek capital letter iota */
greek_kappa_upper                  = 0x07ca  /* u+039a greek capital letter kappa */
greek_lamda_upper                  = 0x07cb  /* u+039b greek capital letter lamda */
greek_mu_upper                     = 0x07cc  /* u+039c greek capital letter mu */
greek_nu_upper                     = 0x07cd  /* u+039d greek capital letter nu */
greek_xi_upper                     = 0x07ce  /* u+039e greek capital letter xi */
greek_omicron_upper                = 0x07cf  /* u+039f greek capital letter omicron */
greek_pi_upper                     = 0x07d0  /* u+03a0 greek capital letter pi */
greek_rho_upper                    = 0x07d1  /* u+03a1 greek capital letter rho */
greek_sigma_upper                  = 0x07d2  /* u+03a3 greek capital letter sigma */
greek_tau_upper                    = 0x07d4  /* u+03a4 greek capital letter tau */
greek_upsilon_upper                = 0x07d5  /* u+03a5 greek capital letter upsilon */
greek_phi_upper                    = 0x07d6  /* u+03a6 greek capital letter phi */
greek_chi_upper                    = 0x07d7  /* u+03a7 greek capital letter chi */
greek_psi_upper                    = 0x07d8  /* u+03a8 greek capital letter psi */
greek_omega_upper                  = 0x07d9  /* u+03a9 greek capital letter omega */
greek_alpha                   = 0x07e1  /* u+03b1 greek small letter alpha */
greek_beta                    = 0x07e2  /* u+03b2 greek small letter beta */
greek_gamma                   = 0x07e3  /* u+03b3 greek small letter gamma */
greek_delta                   = 0x07e4  /* u+03b4 greek small letter delta */
greek_epsilon                 = 0x07e5  /* u+03b5 greek small letter epsilon */
greek_zeta                    = 0x07e6  /* u+03b6 greek small letter zeta */
greek_eta                     = 0x07e7  /* u+03b7 greek small letter eta */
greek_theta                   = 0x07e8  /* u+03b8 greek small letter theta */
greek_iota                    = 0x07e9  /* u+03b9 greek small letter iota */
greek_kappa                   = 0x07ea  /* u+03ba greek small letter kappa */
greek_lamda                   = 0x07eb  /* u+03bb greek small letter lamda */
greek_mu                      = 0x07ec  /* u+03bc greek small letter mu */
greek_nu                      = 0x07ed  /* u+03bd greek small letter nu */
greek_xi                      = 0x07ee  /* u+03be greek small letter xi */
greek_omicron                 = 0x07ef  /* u+03bf greek small letter omicron */
greek_pi                      = 0x07f0  /* u+03c0 greek small letter pi */
greek_rho                     = 0x07f1  /* u+03c1 greek small letter rho */
greek_sigma                   = 0x07f2  /* u+03c3 greek small letter sigma */
greek_finalsmallsigma         = 0x07f3  /* u+03c2 greek small letter final sigma */
greek_tau                     = 0x07f4  /* u+03c4 greek small letter tau */
greek_upsilon                 = 0x07f5  /* u+03c5 greek small letter upsilon */
greek_phi                     = 0x07f6  /* u+03c6 greek small letter phi */
greek_chi                     = 0x07f7  /* u+03c7 greek small letter chi */
greek_psi                     = 0x07f8  /* u+03c8 greek small letter psi */
greek_omega                   = 0x07f9  /* u+03c9 greek small letter omega */

/*
 * technical
 * (from the dec vt330/vt420 technical character set, http://vt100.net/charsets/technical.html)
 * byte 3 = 8
 */

leftradical                   = 0x08a1  /* u+23b7 radical symbol bottom */
topleftradical                = 0x08a2  /*(u+250c box drawings light down and right)*/
horizconnector                = 0x08a3  /*(u+2500 box drawings light horizontal)*/
topintegral                   = 0x08a4  /* u+2320 top half integral */
botintegral                   = 0x08a5  /* u+2321 bottom half integral */
vertconnector                 = 0x08a6  /*(u+2502 box drawings light vertical)*/
topleftsqbracket              = 0x08a7  /* u+23a1 left square bracket upper corner */
botleftsqbracket              = 0x08a8  /* u+23a3 left square bracket lower corner */
toprightsqbracket             = 0x08a9  /* u+23a4 right square bracket upper corner */
botrightsqbracket             = 0x08aa  /* u+23a6 right square bracket lower corner */
topleftparens                 = 0x08ab  /* u+239b left parenthesis upper hook */
botleftparens                 = 0x08ac  /* u+239d left parenthesis lower hook */
toprightparens                = 0x08ad  /* u+239e right parenthesis upper hook */
botrightparens                = 0x08ae  /* u+23a0 right parenthesis lower hook */
leftmiddlecurlybrace          = 0x08af  /* u+23a8 left curly bracket middle piece */
rightmiddlecurlybrace         = 0x08b0  /* u+23ac right curly bracket middle piece */
topleftsummation              = 0x08b1
botleftsummation              = 0x08b2
topvertsummationconnector     = 0x08b3
botvertsummationconnector     = 0x08b4
toprightsummation             = 0x08b5
botrightsummation             = 0x08b6
rightmiddlesummation          = 0x08b7
lessthanequal                 = 0x08bc  /* u+2264 less-than or equal to */
notequal                      = 0x08bd  /* u+2260 not equal to */
greaterthanequal              = 0x08be  /* u+2265 greater-than or equal to */
integral                      = 0x08bf  /* u+222b integral */
therefore                     = 0x08c0  /* u+2234 therefore */
variation                     = 0x08c1  /* u+221d proportional to */
infinity                      = 0x08c2  /* u+221e infinity */
nabla                         = 0x08c5  /* u+2207 nabla */
approximate                   = 0x08c8  /* u+223c tilde operator */
similarequal                  = 0x08c9  /* u+2243 asymptotically equal to */
ifonlyif                      = 0x08cd  /* u+21d4 left right double arrow */
implies                       = 0x08ce  /* u+21d2 rightwards double arrow */
identical                     = 0x08cf  /* u+2261 identical to */
radical                       = 0x08d6  /* u+221a square root */
includedin                    = 0x08da  /* u+2282 subset of */
includes                      = 0x08db  /* u+2283 superset of */
intersection                  = 0x08dc  /* u+2229 intersection */
union                         = 0x08dd  /* u+222a union */
logicaland                    = 0x08de  /* u+2227 logical and */
logicalor                     = 0x08df  /* u+2228 logical or */
partialderivative             = 0x08ef  /* u+2202 partial differential */
function                      = 0x08f6  /* u+0192 latin small letter f with hook */
leftarrow                     = 0x08fb  /* u+2190 leftwards arrow */
uparrow                       = 0x08fc  /* u+2191 upwards arrow */
rightarrow                    = 0x08fd  /* u+2192 rightwards arrow */
downarrow                     = 0x08fe  /* u+2193 downwards arrow */

/*
 * special
 * (from the dec vt100 special graphics character set)
 * byte 3 = 9
 */

blank                         = 0x09df
soliddiamond                  = 0x09e0  /* u+25c6 black diamond */
checkerboard                  = 0x09e1  /* u+2592 medium shade */
ht                            = 0x09e2  /* u+2409 symbol for horizontal tabulation */
ff                            = 0x09e3  /* u+240c symbol for form feed */
cr                            = 0x09e4  /* u+240d symbol for carriage return */
lf                            = 0x09e5  /* u+240a symbol for line feed */
nl                            = 0x09e8  /* u+2424 symbol for newline */
vt                            = 0x09e9  /* u+240b symbol for vertical tabulation */
lowrightcorner                = 0x09ea  /* u+2518 box drawings light up and left */
uprightcorner                 = 0x09eb  /* u+2510 box drawings light down and left */
upleftcorner                  = 0x09ec  /* u+250c box drawings light down and right */
lowleftcorner                 = 0x09ed  /* u+2514 box drawings light up and right */
crossinglines                 = 0x09ee  /* u+253c box drawings light vertical and horizontal */
horizlinescan1                = 0x09ef  /* u+23ba horizontal scan line-1 */
horizlinescan3                = 0x09f0  /* u+23bb horizontal scan line-3 */
horizlinescan5                = 0x09f1  /* u+2500 box drawings light horizontal */
horizlinescan7                = 0x09f2  /* u+23bc horizontal scan line-7 */
horizlinescan9                = 0x09f3  /* u+23bd horizontal scan line-9 */
leftt                         = 0x09f4  /* u+251c box drawings light vertical and right */
rightt                        = 0x09f5  /* u+2524 box drawings light vertical and left */
bott                          = 0x09f6  /* u+2534 box drawings light up and horizontal */
topt                          = 0x09f7  /* u+252c box drawings light down and horizontal */
vertbar                       = 0x09f8  /* u+2502 box drawings light vertical */

/*
 * publishing
 * (these are probably from a long forgotten dec publishing
 * font that once shipped with decwrite)
 * byte 3 = = 0x0a
 */

emspace                       = 0x0aa1  /* u+2003 em space */
enspace                       = 0x0aa2  /* u+2002 en space */
em3space                      = 0x0aa3  /* u+2004 three-per-em space */
em4space                      = 0x0aa4  /* u+2005 four-per-em space */
digitspace                    = 0x0aa5  /* u+2007 figure space */
punctspace                    = 0x0aa6  /* u+2008 punctuation space */
thinspace                     = 0x0aa7  /* u+2009 thin space */
hairspace                     = 0x0aa8  /* u+200a hair space */
emdash                        = 0x0aa9  /* u+2014 em dash */
endash                        = 0x0aaa  /* u+2013 en dash */
signifblank                   = 0x0aac  /*(u+2423 open box)*/
ellipsis                      = 0x0aae  /* u+2026 horizontal ellipsis */
doubbaselinedot               = 0x0aaf  /* u+2025 two dot leader */
onethird                      = 0x0ab0  /* u+2153 vulgar fraction one third */
twothirds                     = 0x0ab1  /* u+2154 vulgar fraction two thirds */
onefifth                      = 0x0ab2  /* u+2155 vulgar fraction one fifth */
twofifths                     = 0x0ab3  /* u+2156 vulgar fraction two fifths */
threefifths                   = 0x0ab4  /* u+2157 vulgar fraction three fifths */
fourfifths                    = 0x0ab5  /* u+2158 vulgar fraction four fifths */
onesixth                      = 0x0ab6  /* u+2159 vulgar fraction one sixth */
fivesixths                    = 0x0ab7  /* u+215a vulgar fraction five sixths */
careof                        = 0x0ab8  /* u+2105 care of */
figdash                       = 0x0abb  /* u+2012 figure dash */
leftanglebracket              = 0x0abc  /*(u+2329 left-pointing angle bracket)*/
decimalpoint                  = 0x0abd  /*(u+002e full stop)*/
rightanglebracket             = 0x0abe  /*(u+232a right-pointing angle bracket)*/
marker                        = 0x0abf
oneeighth                     = 0x0ac3  /* u+215b vulgar fraction one eighth */
threeeighths                  = 0x0ac4  /* u+215c vulgar fraction three eighths */
fiveeighths                   = 0x0ac5  /* u+215d vulgar fraction five eighths */
seveneighths                  = 0x0ac6  /* u+215e vulgar fraction seven eighths */
trademark                     = 0x0ac9  /* u+2122 trade mark sign */
signaturemark                 = 0x0aca  /*(u+2613 saltire)*/
trademarkincircle             = 0x0acb
leftopentriangle              = 0x0acc  /*(u+25c1 white left-pointing triangle)*/
rightopentriangle             = 0x0acd  /*(u+25b7 white right-pointing triangle)*/
emopencircle                  = 0x0ace  /*(u+25cb white circle)*/
emopenrectangle               = 0x0acf  /*(u+25af white vertical rectangle)*/
leftsinglequotemark           = 0x0ad0  /* u+2018 left single quotation mark */
rightsinglequotemark          = 0x0ad1  /* u+2019 right single quotation mark */
leftdoublequotemark           = 0x0ad2  /* u+201c left double quotation mark */
rightdoublequotemark          = 0x0ad3  /* u+201d right double quotation mark */
prescription                  = 0x0ad4  /* u+211e prescription take */
permille                      = 0x0ad5  /* u+2030 per mille sign */
minutes                       = 0x0ad6  /* u+2032 prime */
seconds                       = 0x0ad7  /* u+2033 double prime */
latincross                    = 0x0ad9  /* u+271d latin cross */
hexagram                      = 0x0ada
filledrectbullet              = 0x0adb  /*(u+25ac black rectangle)*/
filledlefttribullet           = 0x0adc  /*(u+25c0 black left-pointing triangle)*/
filledrighttribullet          = 0x0add  /*(u+25b6 black right-pointing triangle)*/
emfilledcircle                = 0x0ade  /*(u+25cf black circle)*/
emfilledrect                  = 0x0adf  /*(u+25ae black vertical rectangle)*/
enopencircbullet              = 0x0ae0  /*(u+25e6 white bullet)*/
enopensquarebullet            = 0x0ae1  /*(u+25ab white small square)*/
openrectbullet                = 0x0ae2  /*(u+25ad white rectangle)*/
opentribulletup               = 0x0ae3  /*(u+25b3 white up-pointing triangle)*/
opentribulletdown             = 0x0ae4  /*(u+25bd white down-pointing triangle)*/
openstar                      = 0x0ae5  /*(u+2606 white star)*/
enfilledcircbullet            = 0x0ae6  /*(u+2022 bullet)*/
enfilledsqbullet              = 0x0ae7  /*(u+25aa black small square)*/
filledtribulletup             = 0x0ae8  /*(u+25b2 black up-pointing triangle)*/
filledtribulletdown           = 0x0ae9  /*(u+25bc black down-pointing triangle)*/
leftpointer                   = 0x0aea  /*(u+261c white left pointing index)*/
rightpointer                  = 0x0aeb  /*(u+261e white right pointing index)*/
club                          = 0x0aec  /* u+2663 black club suit */
diamond                       = 0x0aed  /* u+2666 black diamond suit */
heart                         = 0x0aee  /* u+2665 black heart suit */
maltesecross                  = 0x0af0  /* u+2720 maltese cross */
dagger                        = 0x0af1  /* u+2020 dagger */
doubledagger                  = 0x0af2  /* u+2021 double dagger */
checkmark                     = 0x0af3  /* u+2713 check mark */
ballotcross                   = 0x0af4  /* u+2717 ballot x */
musicalsharp                  = 0x0af5  /* u+266f music sharp sign */
musicalflat                   = 0x0af6  /* u+266d music flat sign */
malesymbol                    = 0x0af7  /* u+2642 male sign */
femalesymbol                  = 0x0af8  /* u+2640 female sign */
telephone                     = 0x0af9  /* u+260e black telephone */
telephonerecorder             = 0x0afa  /* u+2315 telephone recorder */
phonographcopyright           = 0x0afb  /* u+2117 sound recording copyright */
caret                         = 0x0afc  /* u+2038 caret */
singlelowquotemark            = 0x0afd  /* u+201a single low-9 quotation mark */
doublelowquotemark            = 0x0afe  /* u+201e double low-9 quotation mark */
cursor                        = 0x0aff

/*
 * apl
 * byte 3 = = 0x0b
 */

leftcaret                     = 0x0ba3  /*(u+003c less-than sign)*/
rightcaret                    = 0x0ba6  /*(u+003e greater-than sign)*/
downcaret                     = 0x0ba8  /*(u+2228 logical or)*/
upcaret                       = 0x0ba9  /*(u+2227 logical and)*/
overbar                       = 0x0bc0  /*(u+00af macron)*/
downtack                      = 0x0bc2  /* u+22a4 down tack */
upshoe                        = 0x0bc3  /*(u+2229 intersection)*/
downstile                     = 0x0bc4  /* u+230a left floor */
underbar                      = 0x0bc6  /*(u+005f low line)*/
jot                           = 0x0bca  /* u+2218 ring operator */
quad                          = 0x0bcc  /* u+2395 apl functional symbol quad */
uptack                        = 0x0bce  /* u+22a5 up tack */
circle                        = 0x0bcf  /* u+25cb white circle */
upstile                       = 0x0bd3  /* u+2308 left ceiling */
downshoe                      = 0x0bd6  /*(u+222a union)*/
rightshoe                     = 0x0bd8  /*(u+2283 superset of)*/
leftshoe                      = 0x0bda  /*(u+2282 subset of)*/
lefttack                      = 0x0bdc  /* u+22a3 left tack */
righttack                     = 0x0bfc  /* u+22a2 right tack */

/*
 * hebrew
 * byte 3 = = 0x0c
 */

hebrew_doublelowline          = 0x0cdf  /* u+2017 double low line */
hebrew_aleph                  = 0x0ce0  /* u+05d0 hebrew letter alef */
hebrew_bet                    = 0x0ce1  /* u+05d1 hebrew letter bet */
hebrew_gimel                  = 0x0ce2  /* u+05d2 hebrew letter gimel */
hebrew_dalet                  = 0x0ce3  /* u+05d3 hebrew letter dalet */
hebrew_he                     = 0x0ce4  /* u+05d4 hebrew letter he */
hebrew_waw                    = 0x0ce5  /* u+05d5 hebrew letter vav */
hebrew_zain                   = 0x0ce6  /* u+05d6 hebrew letter zayin */
hebrew_chet                   = 0x0ce7  /* u+05d7 hebrew letter het */
hebrew_tet                    = 0x0ce8  /* u+05d8 hebrew letter tet */
hebrew_yod                    = 0x0ce9  /* u+05d9 hebrew letter yod */
hebrew_finalkaph              = 0x0cea  /* u+05da hebrew letter final kaf */
hebrew_kaph                   = 0x0ceb  /* u+05db hebrew letter kaf */
hebrew_lamed                  = 0x0cec  /* u+05dc hebrew letter lamed */
hebrew_finalmem               = 0x0ced  /* u+05dd hebrew letter final mem */
hebrew_mem                    = 0x0cee  /* u+05de hebrew letter mem */
hebrew_finalnun               = 0x0cef  /* u+05df hebrew letter final nun */
hebrew_nun                    = 0x0cf0  /* u+05e0 hebrew letter nun */
hebrew_samech                 = 0x0cf1  /* u+05e1 hebrew letter samekh */
hebrew_ayin                   = 0x0cf2  /* u+05e2 hebrew letter ayin */
hebrew_finalpe                = 0x0cf3  /* u+05e3 hebrew letter final pe */
hebrew_pe                     = 0x0cf4  /* u+05e4 hebrew letter pe */
hebrew_finalzade              = 0x0cf5  /* u+05e5 hebrew letter final tsadi */
hebrew_zade                   = 0x0cf6  /* u+05e6 hebrew letter tsadi */
hebrew_qoph                   = 0x0cf7  /* u+05e7 hebrew letter qof */
hebrew_resh                   = 0x0cf8  /* u+05e8 hebrew letter resh */
hebrew_shin                   = 0x0cf9  /* u+05e9 hebrew letter shin */
hebrew_taw                    = 0x0cfa  /* u+05ea hebrew letter tav */

/*
 * thai
 * byte 3 = = 0x0d
 */

thai_kokai                    = 0x0da1  /* u+0e01 thai character ko kai */
thai_khokhai                  = 0x0da2  /* u+0e02 thai character kho khai */
thai_khokhuat                 = 0x0da3  /* u+0e03 thai character kho khuat */
thai_khokhwai                 = 0x0da4  /* u+0e04 thai character kho khwai */
thai_khokhon                  = 0x0da5  /* u+0e05 thai character kho khon */
thai_khorakhang               = 0x0da6  /* u+0e06 thai character kho rakhang */
thai_ngongu                   = 0x0da7  /* u+0e07 thai character ngo ngu */
thai_chochan                  = 0x0da8  /* u+0e08 thai character cho chan */
thai_choching                 = 0x0da9  /* u+0e09 thai character cho ching */
thai_chochang                 = 0x0daa  /* u+0e0a thai character cho chang */
thai_soso                     = 0x0dab  /* u+0e0b thai character so so */
thai_chochoe                  = 0x0dac  /* u+0e0c thai character cho choe */
thai_yoying                   = 0x0dad  /* u+0e0d thai character yo ying */
thai_dochada                  = 0x0dae  /* u+0e0e thai character do chada */
thai_topatak                  = 0x0daf  /* u+0e0f thai character to patak */
thai_thothan                  = 0x0db0  /* u+0e10 thai character tho than */
thai_thonangmontho            = 0x0db1  /* u+0e11 thai character tho nangmontho */
thai_thophuthao               = 0x0db2  /* u+0e12 thai character tho phuthao */
thai_nonen                    = 0x0db3  /* u+0e13 thai character no nen */
thai_dodek                    = 0x0db4  /* u+0e14 thai character do dek */
thai_totao                    = 0x0db5  /* u+0e15 thai character to tao */
thai_thothung                 = 0x0db6  /* u+0e16 thai character tho thung */
thai_thothahan                = 0x0db7  /* u+0e17 thai character tho thahan */
thai_thothong                 = 0x0db8  /* u+0e18 thai character tho thong */
thai_nonu                     = 0x0db9  /* u+0e19 thai character no nu */
thai_bobaimai                 = 0x0dba  /* u+0e1a thai character bo baimai */
thai_popla                    = 0x0dbb  /* u+0e1b thai character po pla */
thai_phophung                 = 0x0dbc  /* u+0e1c thai character pho phung */
thai_fofa                     = 0x0dbd  /* u+0e1d thai character fo fa */
thai_phophan                  = 0x0dbe  /* u+0e1e thai character pho phan */
thai_fofan                    = 0x0dbf  /* u+0e1f thai character fo fan */
thai_phosamphao               = 0x0dc0  /* u+0e20 thai character pho samphao */
thai_moma                     = 0x0dc1  /* u+0e21 thai character mo ma */
thai_yoyak                    = 0x0dc2  /* u+0e22 thai character yo yak */
thai_rorua                    = 0x0dc3  /* u+0e23 thai character ro rua */
thai_ru                       = 0x0dc4  /* u+0e24 thai character ru */
thai_loling                   = 0x0dc5  /* u+0e25 thai character lo ling */
thai_lu                       = 0x0dc6  /* u+0e26 thai character lu */
thai_wowaen                   = 0x0dc7  /* u+0e27 thai character wo waen */
thai_sosala                   = 0x0dc8  /* u+0e28 thai character so sala */
thai_sorusi                   = 0x0dc9  /* u+0e29 thai character so rusi */
thai_sosua                    = 0x0dca  /* u+0e2a thai character so sua */
thai_hohip                    = 0x0dcb  /* u+0e2b thai character ho hip */
thai_lochula                  = 0x0dcc  /* u+0e2c thai character lo chula */
thai_oang                     = 0x0dcd  /* u+0e2d thai character o ang */
thai_honokhuk                 = 0x0dce  /* u+0e2e thai character ho nokhuk */
thai_paiyannoi                = 0x0dcf  /* u+0e2f thai character paiyannoi */
thai_saraa                    = 0x0dd0  /* u+0e30 thai character sara a */
thai_maihanakat               = 0x0dd1  /* u+0e31 thai character mai han-akat */
thai_saraaa                   = 0x0dd2  /* u+0e32 thai character sara aa */
thai_saraam                   = 0x0dd3  /* u+0e33 thai character sara am */
thai_sarai                    = 0x0dd4  /* u+0e34 thai character sara i */
thai_saraii                   = 0x0dd5  /* u+0e35 thai character sara ii */
thai_saraue                   = 0x0dd6  /* u+0e36 thai character sara ue */
thai_sarauee                  = 0x0dd7  /* u+0e37 thai character sara uee */
thai_sarau                    = 0x0dd8  /* u+0e38 thai character sara u */
thai_sarauu                   = 0x0dd9  /* u+0e39 thai character sara uu */
thai_phinthu                  = 0x0dda  /* u+0e3a thai character phinthu */
thai_maihanakat_maitho        = 0x0dde  /*(u+0e3e unassigned code point)*/
thai_baht                     = 0x0ddf  /* u+0e3f thai currency symbol baht */
thai_sarae                    = 0x0de0  /* u+0e40 thai character sara e */
thai_saraae                   = 0x0de1  /* u+0e41 thai character sara ae */
thai_sarao                    = 0x0de2  /* u+0e42 thai character sara o */
thai_saraaimaimuan            = 0x0de3  /* u+0e43 thai character sara ai maimuan */
thai_saraaimaimalai           = 0x0de4  /* u+0e44 thai character sara ai maimalai */
thai_lakkhangyao              = 0x0de5  /* u+0e45 thai character lakkhangyao */
thai_maiyamok                 = 0x0de6  /* u+0e46 thai character maiyamok */
thai_maitaikhu                = 0x0de7  /* u+0e47 thai character maitaikhu */
thai_maiek                    = 0x0de8  /* u+0e48 thai character mai ek */
thai_maitho                   = 0x0de9  /* u+0e49 thai character mai tho */
thai_maitri                   = 0x0dea  /* u+0e4a thai character mai tri */
thai_maichattawa              = 0x0deb  /* u+0e4b thai character mai chattawa */
thai_thanthakhat              = 0x0dec  /* u+0e4c thai character thanthakhat */
thai_nikhahit                 = 0x0ded  /* u+0e4d thai character nikhahit */
thai_leksun                   = 0x0df0  /* u+0e50 thai digit zero */
thai_leknung                  = 0x0df1  /* u+0e51 thai digit one */
thai_leksong                  = 0x0df2  /* u+0e52 thai digit two */
thai_leksam                   = 0x0df3  /* u+0e53 thai digit three */
thai_leksi                    = 0x0df4  /* u+0e54 thai digit four */
thai_lekha                    = 0x0df5  /* u+0e55 thai digit five */
thai_lekhok                   = 0x0df6  /* u+0e56 thai digit six */
thai_lekchet                  = 0x0df7  /* u+0e57 thai digit seven */
thai_lekpaet                  = 0x0df8  /* u+0e58 thai digit eight */
thai_lekkao                   = 0x0df9  /* u+0e59 thai digit nine */

/*
 * korean
 * byte 3 = = 0x0e
 */


hangul                        = 0xff31  /* hangul start/stop(toggle) */
hangul_start                  = 0xff32  /* hangul start */
hangul_end                    = 0xff33  /* hangul end, english start */
hangul_hanja                  = 0xff34  /* start hangul->hanja conversion */
hangul_jamo                   = 0xff35  /* hangul jamo mode */
hangul_romaja                 = 0xff36  /* hangul romaja mode */
hangul_jeonja                 = 0xff38  /* jeonja mode */
hangul_banja                  = 0xff39  /* banja mode */
hangul_prehanja               = 0xff3a  /* pre hanja conversion */
hangul_posthanja              = 0xff3b  /* post hanja conversion */
hangul_special                = 0xff3f  /* special symbols */

/* hangul consonant characters */
hangul_kiyeog                 = 0x0ea1  /* u+3131 hangul letter kiyeok */
hangul_ssangkiyeog            = 0x0ea2  /* u+3132 hangul letter ssangkiyeok */
hangul_kiyeogsios             = 0x0ea3  /* u+3133 hangul letter kiyeok-sios */
hangul_nieun                  = 0x0ea4  /* u+3134 hangul letter nieun */
hangul_nieunjieuj             = 0x0ea5  /* u+3135 hangul letter nieun-cieuc */
hangul_nieunhieuh             = 0x0ea6  /* u+3136 hangul letter nieun-hieuh */
hangul_dikeud                 = 0x0ea7  /* u+3137 hangul letter tikeut */
hangul_ssangdikeud            = 0x0ea8  /* u+3138 hangul letter ssangtikeut */
hangul_rieul                  = 0x0ea9  /* u+3139 hangul letter rieul */
hangul_rieulkiyeog            = 0x0eaa  /* u+313a hangul letter rieul-kiyeok */
hangul_rieulmieum             = 0x0eab  /* u+313b hangul letter rieul-mieum */
hangul_rieulpieub             = 0x0eac  /* u+313c hangul letter rieul-pieup */
hangul_rieulsios              = 0x0ead  /* u+313d hangul letter rieul-sios */
hangul_rieultieut             = 0x0eae  /* u+313e hangul letter rieul-thieuth */
hangul_rieulphieuf            = 0x0eaf  /* u+313f hangul letter rieul-phieuph */
hangul_rieulhieuh             = 0x0eb0  /* u+3140 hangul letter rieul-hieuh */
hangul_mieum                  = 0x0eb1  /* u+3141 hangul letter mieum */
hangul_pieub                  = 0x0eb2  /* u+3142 hangul letter pieup */
hangul_ssangpieub             = 0x0eb3  /* u+3143 hangul letter ssangpieup */
hangul_pieubsios              = 0x0eb4  /* u+3144 hangul letter pieup-sios */
hangul_sios                   = 0x0eb5  /* u+3145 hangul letter sios */
hangul_ssangsios              = 0x0eb6  /* u+3146 hangul letter ssangsios */
hangul_ieung                  = 0x0eb7  /* u+3147 hangul letter ieung */
hangul_jieuj                  = 0x0eb8  /* u+3148 hangul letter cieuc */
hangul_ssangjieuj             = 0x0eb9  /* u+3149 hangul letter ssangcieuc */
hangul_cieuc                  = 0x0eba  /* u+314a hangul letter chieuch */
hangul_khieuq                 = 0x0ebb  /* u+314b hangul letter khieukh */
hangul_tieut                  = 0x0ebc  /* u+314c hangul letter thieuth */
hangul_phieuf                 = 0x0ebd  /* u+314d hangul letter phieuph */
hangul_hieuh                  = 0x0ebe  /* u+314e hangul letter hieuh */

/* hangul vowel characters */
hangul_a                      = 0x0ebf  /* u+314f hangul letter a */
hangul_ae                     = 0x0ec0  /* u+3150 hangul letter ae */
hangul_ya                     = 0x0ec1  /* u+3151 hangul letter ya */
hangul_yae                    = 0x0ec2  /* u+3152 hangul letter yae */
hangul_eo                     = 0x0ec3  /* u+3153 hangul letter eo */
hangul_e                      = 0x0ec4  /* u+3154 hangul letter e */
hangul_yeo                    = 0x0ec5  /* u+3155 hangul letter yeo */
hangul_ye                     = 0x0ec6  /* u+3156 hangul letter ye */
hangul_o                      = 0x0ec7  /* u+3157 hangul letter o */
hangul_wa                     = 0x0ec8  /* u+3158 hangul letter wa */
hangul_wae                    = 0x0ec9  /* u+3159 hangul letter wae */
hangul_oe                     = 0x0eca  /* u+315a hangul letter oe */
hangul_yo                     = 0x0ecb  /* u+315b hangul letter yo */
hangul_u                      = 0x0ecc  /* u+315c hangul letter u */
hangul_weo                    = 0x0ecd  /* u+315d hangul letter weo */
hangul_we                     = 0x0ece  /* u+315e hangul letter we */
hangul_wi                     = 0x0ecf  /* u+315f hangul letter wi */
hangul_yu                     = 0x0ed0  /* u+3160 hangul letter yu */
hangul_eu                     = 0x0ed1  /* u+3161 hangul letter eu */
hangul_yi                     = 0x0ed2  /* u+3162 hangul letter yi */
hangul_i                      = 0x0ed3  /* u+3163 hangul letter i */

/* hangul syllable-final (jongseong) characters */
hangul_j_kiyeog               = 0x0ed4  /* u+11a8 hangul jongseong kiyeok */
hangul_j_ssangkiyeog          = 0x0ed5  /* u+11a9 hangul jongseong ssangkiyeok */
hangul_j_kiyeogsios           = 0x0ed6  /* u+11aa hangul jongseong kiyeok-sios */
hangul_j_nieun                = 0x0ed7  /* u+11ab hangul jongseong nieun */
hangul_j_nieunjieuj           = 0x0ed8  /* u+11ac hangul jongseong nieun-cieuc */
hangul_j_nieunhieuh           = 0x0ed9  /* u+11ad hangul jongseong nieun-hieuh */
hangul_j_dikeud               = 0x0eda  /* u+11ae hangul jongseong tikeut */
hangul_j_rieul                = 0x0edb  /* u+11af hangul jongseong rieul */
hangul_j_rieulkiyeog          = 0x0edc  /* u+11b0 hangul jongseong rieul-kiyeok */
hangul_j_rieulmieum           = 0x0edd  /* u+11b1 hangul jongseong rieul-mieum */
hangul_j_rieulpieub           = 0x0ede  /* u+11b2 hangul jongseong rieul-pieup */
hangul_j_rieulsios            = 0x0edf  /* u+11b3 hangul jongseong rieul-sios */
hangul_j_rieultieut           = 0x0ee0  /* u+11b4 hangul jongseong rieul-thieuth */
hangul_j_rieulphieuf          = 0x0ee1  /* u+11b5 hangul jongseong rieul-phieuph */
hangul_j_rieulhieuh           = 0x0ee2  /* u+11b6 hangul jongseong rieul-hieuh */
hangul_j_mieum                = 0x0ee3  /* u+11b7 hangul jongseong mieum */
hangul_j_pieub                = 0x0ee4  /* u+11b8 hangul jongseong pieup */
hangul_j_pieubsios            = 0x0ee5  /* u+11b9 hangul jongseong pieup-sios */
hangul_j_sios                 = 0x0ee6  /* u+11ba hangul jongseong sios */
hangul_j_ssangsios            = 0x0ee7  /* u+11bb hangul jongseong ssangsios */
hangul_j_ieung                = 0x0ee8  /* u+11bc hangul jongseong ieung */
hangul_j_jieuj                = 0x0ee9  /* u+11bd hangul jongseong cieuc */
hangul_j_cieuc                = 0x0eea  /* u+11be hangul jongseong chieuch */
hangul_j_khieuq               = 0x0eeb  /* u+11bf hangul jongseong khieukh */
hangul_j_tieut                = 0x0eec  /* u+11c0 hangul jongseong thieuth */
hangul_j_phieuf               = 0x0eed  /* u+11c1 hangul jongseong phieuph */
hangul_j_hieuh                = 0x0eee  /* u+11c2 hangul jongseong hieuh */

/* ancient hangul consonant characters */
hangul_rieulyeorinhieuh       = 0x0eef  /* u+316d hangul letter rieul-yeorinhieuh */
hangul_sunkyeongeummieum      = 0x0ef0  /* u+3171 hangul letter kapyeounmieum */
hangul_sunkyeongeumpieub      = 0x0ef1  /* u+3178 hangul letter kapyeounpieup */
hangul_pansios                = 0x0ef2  /* u+317f hangul letter pansios */
hangul_kkogjidalrinieung      = 0x0ef3  /* u+3181 hangul letter yesieung */
hangul_sunkyeongeumphieuf     = 0x0ef4  /* u+3184 hangul letter kapyeounphieuph */
hangul_yeorinhieuh            = 0x0ef5  /* u+3186 hangul letter yeorinhieuh */

/* ancient hangul vowel characters */
hangul_araea                  = 0x0ef6  /* u+318d hangul letter araea */
hangul_araeae                 = 0x0ef7  /* u+318e hangul letter araeae */

/* ancient hangul syllable-final (jongseong) characters */
hangul_j_pansios              = 0x0ef8  /* u+11eb hangul jongseong pansios */
hangul_j_kkogjidalrinieung    = 0x0ef9  /* u+11f0 hangul jongseong yesieung */
hangul_j_yeorinhieuh          = 0x0efa  /* u+11f9 hangul jongseong yeorinhieuh */

/* korean currency symbol */
korean_won                    = 0x0eff  /*(u+20a9 won sign)*/


/*
 * armenian
 */

armenian_ligature_ew       = 0x1000587  /* u+0587 armenian small ligature ech yiwn */
armenian_full_stop         = 0x1000589  /* u+0589 armenian full stop */
armenian_separation_mark   = 0x100055d  /* u+055d armenian comma */
armenian_hyphen            = 0x100058a  /* u+058a armenian hyphen */
armenian_exclam            = 0x100055c  /* u+055c armenian exclamation mark */
armenian_accent            = 0x100055b  /* u+055b armenian emphasis mark */
armenian_question          = 0x100055e  /* u+055e armenian question mark */
armenian_ayb_upper               = 0x1000531  /* u+0531 armenian capital letter ayb */
armenian_ayb               = 0x1000561  /* u+0561 armenian small letter ayb */
armenian_ben_upper               = 0x1000532  /* u+0532 armenian capital letter ben */
armenian_ben               = 0x1000562  /* u+0562 armenian small letter ben */
armenian_gim_upper               = 0x1000533  /* u+0533 armenian capital letter gim */
armenian_gim               = 0x1000563  /* u+0563 armenian small letter gim */
armenian_da_upper                = 0x1000534  /* u+0534 armenian capital letter da */
armenian_da                = 0x1000564  /* u+0564 armenian small letter da */
armenian_yech_upper              = 0x1000535  /* u+0535 armenian capital letter ech */
armenian_yech              = 0x1000565  /* u+0565 armenian small letter ech */
armenian_za_upper                = 0x1000536  /* u+0536 armenian capital letter za */
armenian_za                = 0x1000566  /* u+0566 armenian small letter za */
armenian_e_upper                 = 0x1000537  /* u+0537 armenian capital letter eh */
armenian_e                 = 0x1000567  /* u+0567 armenian small letter eh */
armenian_at_upper                = 0x1000538  /* u+0538 armenian capital letter et */
armenian_at                = 0x1000568  /* u+0568 armenian small letter et */
armenian_to_upper                = 0x1000539  /* u+0539 armenian capital letter to */
armenian_to                = 0x1000569  /* u+0569 armenian small letter to */
armenian_zhe_upper               = 0x100053a  /* u+053a armenian capital letter zhe */
armenian_zhe               = 0x100056a  /* u+056a armenian small letter zhe */
armenian_ini_upper               = 0x100053b  /* u+053b armenian capital letter ini */
armenian_ini               = 0x100056b  /* u+056b armenian small letter ini */
armenian_lyun_upper              = 0x100053c  /* u+053c armenian capital letter liwn */
armenian_lyun              = 0x100056c  /* u+056c armenian small letter liwn */
armenian_khe_upper               = 0x100053d  /* u+053d armenian capital letter xeh */
armenian_khe               = 0x100056d  /* u+056d armenian small letter xeh */
armenian_tsa_upper               = 0x100053e  /* u+053e armenian capital letter ca */
armenian_tsa               = 0x100056e  /* u+056e armenian small letter ca */
armenian_ken_upper               = 0x100053f  /* u+053f armenian capital letter ken */
armenian_ken               = 0x100056f  /* u+056f armenian small letter ken */
armenian_ho_upper                = 0x1000540  /* u+0540 armenian capital letter ho */
armenian_ho                = 0x1000570  /* u+0570 armenian small letter ho */
armenian_dza_upper               = 0x1000541  /* u+0541 armenian capital letter ja */
armenian_dza               = 0x1000571  /* u+0571 armenian small letter ja */
armenian_ghat_upper              = 0x1000542  /* u+0542 armenian capital letter ghad */
armenian_ghat              = 0x1000572  /* u+0572 armenian small letter ghad */
armenian_tche_upper              = 0x1000543  /* u+0543 armenian capital letter cheh */
armenian_tche              = 0x1000573  /* u+0573 armenian small letter cheh */
armenian_men_upper               = 0x1000544  /* u+0544 armenian capital letter men */
armenian_men               = 0x1000574  /* u+0574 armenian small letter men */
armenian_hi_upper                = 0x1000545  /* u+0545 armenian capital letter yi */
armenian_hi                = 0x1000575  /* u+0575 armenian small letter yi */
armenian_nu_upper                = 0x1000546  /* u+0546 armenian capital letter now */
armenian_nu                = 0x1000576  /* u+0576 armenian small letter now */
armenian_sha_upper               = 0x1000547  /* u+0547 armenian capital letter sha */
armenian_sha               = 0x1000577  /* u+0577 armenian small letter sha */
armenian_vo_upper                = 0x1000548  /* u+0548 armenian capital letter vo */
armenian_vo                = 0x1000578  /* u+0578 armenian small letter vo */
armenian_cha_upper               = 0x1000549  /* u+0549 armenian capital letter cha */
armenian_cha               = 0x1000579  /* u+0579 armenian small letter cha */
armenian_pe_upper                = 0x100054a  /* u+054a armenian capital letter peh */
armenian_pe                = 0x100057a  /* u+057a armenian small letter peh */
armenian_je_upper                = 0x100054b  /* u+054b armenian capital letter jheh */
armenian_je                = 0x100057b  /* u+057b armenian small letter jheh */
armenian_ra_upper                = 0x100054c  /* u+054c armenian capital letter ra */
armenian_ra                = 0x100057c  /* u+057c armenian small letter ra */
armenian_se_upper                = 0x100054d  /* u+054d armenian capital letter seh */
armenian_se                = 0x100057d  /* u+057d armenian small letter seh */
armenian_vev_upper               = 0x100054e  /* u+054e armenian capital letter vew */
armenian_vev               = 0x100057e  /* u+057e armenian small letter vew */
armenian_tyun_upper              = 0x100054f  /* u+054f armenian capital letter tiwn */
armenian_tyun              = 0x100057f  /* u+057f armenian small letter tiwn */
armenian_re_upper                = 0x1000550  /* u+0550 armenian capital letter reh */
armenian_re                = 0x1000580  /* u+0580 armenian small letter reh */
armenian_tso_upper               = 0x1000551  /* u+0551 armenian capital letter co */
armenian_tso               = 0x1000581  /* u+0581 armenian small letter co */
armenian_vyun_upper              = 0x1000552  /* u+0552 armenian capital letter yiwn */
armenian_vyun              = 0x1000582  /* u+0582 armenian small letter yiwn */
armenian_pyur_upper              = 0x1000553  /* u+0553 armenian capital letter piwr */
armenian_pyur              = 0x1000583  /* u+0583 armenian small letter piwr */
armenian_ke_upper                = 0x1000554  /* u+0554 armenian capital letter keh */
armenian_ke                = 0x1000584  /* u+0584 armenian small letter keh */
armenian_o_upper                 = 0x1000555  /* u+0555 armenian capital letter oh */
armenian_o                 = 0x1000585  /* u+0585 armenian small letter oh */
armenian_fe_upper                = 0x1000556  /* u+0556 armenian capital letter feh */
armenian_fe                = 0x1000586  /* u+0586 armenian small letter feh */
armenian_apostrophe        = 0x100055a  /* u+055a armenian apostrophe */

/*
 * georgian
 */

georgian_an                = 0x10010d0  /* u+10d0 georgian letter an */
georgian_ban               = 0x10010d1  /* u+10d1 georgian letter ban */
georgian_gan               = 0x10010d2  /* u+10d2 georgian letter gan */
georgian_don               = 0x10010d3  /* u+10d3 georgian letter don */
georgian_en                = 0x10010d4  /* u+10d4 georgian letter en */
georgian_vin               = 0x10010d5  /* u+10d5 georgian letter vin */
georgian_zen               = 0x10010d6  /* u+10d6 georgian letter zen */
georgian_tan               = 0x10010d7  /* u+10d7 georgian letter tan */
georgian_in                = 0x10010d8  /* u+10d8 georgian letter in */
georgian_kan               = 0x10010d9  /* u+10d9 georgian letter kan */
georgian_las               = 0x10010da  /* u+10da georgian letter las */
georgian_man               = 0x10010db  /* u+10db georgian letter man */
georgian_nar               = 0x10010dc  /* u+10dc georgian letter nar */
georgian_on                = 0x10010dd  /* u+10dd georgian letter on */
georgian_par               = 0x10010de  /* u+10de georgian letter par */
georgian_zhar              = 0x10010df  /* u+10df georgian letter zhar */
georgian_rae               = 0x10010e0  /* u+10e0 georgian letter rae */
georgian_san               = 0x10010e1  /* u+10e1 georgian letter san */
georgian_tar               = 0x10010e2  /* u+10e2 georgian letter tar */
georgian_un                = 0x10010e3  /* u+10e3 georgian letter un */
georgian_phar              = 0x10010e4  /* u+10e4 georgian letter phar */
georgian_khar              = 0x10010e5  /* u+10e5 georgian letter khar */
georgian_ghan              = 0x10010e6  /* u+10e6 georgian letter ghan */
georgian_qar               = 0x10010e7  /* u+10e7 georgian letter qar */
georgian_shin              = 0x10010e8  /* u+10e8 georgian letter shin */
georgian_chin              = 0x10010e9  /* u+10e9 georgian letter chin */
georgian_can               = 0x10010ea  /* u+10ea georgian letter can */
georgian_jil               = 0x10010eb  /* u+10eb georgian letter jil */
georgian_cil               = 0x10010ec  /* u+10ec georgian letter cil */
georgian_char              = 0x10010ed  /* u+10ed georgian letter char */
georgian_xan               = 0x10010ee  /* u+10ee georgian letter xan */
georgian_jhan              = 0x10010ef  /* u+10ef georgian letter jhan */
georgian_hae               = 0x10010f0  /* u+10f0 georgian letter hae */
georgian_he                = 0x10010f1  /* u+10f1 georgian letter he */
georgian_hie               = 0x10010f2  /* u+10f2 georgian letter hie */
georgian_we                = 0x10010f3  /* u+10f3 georgian letter we */
georgian_har               = 0x10010f4  /* u+10f4 georgian letter har */
georgian_hoe               = 0x10010f5  /* u+10f5 georgian letter hoe */
georgian_fi                = 0x10010f6  /* u+10f6 georgian letter fi */

/*
 * azeri (and other turkic or caucasian languages)
 */

/* latin */
xabovedot_upper                 = 0x1001e8a  /* u+1e8a latin capital letter x with dot above */
ibreve_upper                    = 0x100012c  /* u+012c latin capital letter i with breve */
zstroke_upper                   = 0x10001b5  /* u+01b5 latin capital letter z with stroke */
gcaron_upper                    = 0x10001e6  /* u+01e6 latin capital letter g with caron */
ocaron_upper                    = 0x10001d1  /* u+01d1 latin capital letter o with caron */
obarred_upper                   = 0x100019f  /* u+019f latin capital letter o with middle tilde */
xabovedot                  = 0x1001e8b  /* u+1e8b latin small letter x with dot above */
ibreve                     = 0x100012d  /* u+012d latin small letter i with breve */
zstroke                    = 0x10001b6  /* u+01b6 latin small letter z with stroke */
gcaron                     = 0x10001e7  /* u+01e7 latin small letter g with caron */
ocaron                     = 0x10001d2  /* u+01d2 latin small letter o with caron */
obarred                    = 0x1000275  /* u+0275 latin small letter barred o */
schwa_upper                      = 0x100018f  /* u+018f latin capital letter schwa */
schwa                      = 0x1000259  /* u+0259 latin small letter schwa */
ezh_upper                        = 0x10001b7  /* u+01b7 latin capital letter ezh */
ezh                        = 0x1000292  /* u+0292 latin small letter ezh */
/* those are not really caucasus */
/* for inupiak */
lbelowdot_upper                  = 0x1001e36  /* u+1e36 latin capital letter l with dot below */
lbelowdot                  = 0x1001e37  /* u+1e37 latin small letter l with dot below */

/*
 * vietnamese
 */

abelowdot_upper                  = 0x1001ea0  /* u+1ea0 latin capital letter a with dot below */
abelowdot                  = 0x1001ea1  /* u+1ea1 latin small letter a with dot below */
ahook_upper                      = 0x1001ea2  /* u+1ea2 latin capital letter a with hook above */
ahook                      = 0x1001ea3  /* u+1ea3 latin small letter a with hook above */
acircumflexacute_upper           = 0x1001ea4  /* u+1ea4 latin capital letter a with circumflex and acute */
acircumflexacute           = 0x1001ea5  /* u+1ea5 latin small letter a with circumflex and acute */
acircumflexgrave_upper           = 0x1001ea6  /* u+1ea6 latin capital letter a with circumflex and grave */
acircumflexgrave           = 0x1001ea7  /* u+1ea7 latin small letter a with circumflex and grave */
acircumflexhook_upper            = 0x1001ea8  /* u+1ea8 latin capital letter a with circumflex and hook above */
acircumflexhook            = 0x1001ea9  /* u+1ea9 latin small letter a with circumflex and hook above */
acircumflextilde_upper           = 0x1001eaa  /* u+1eaa latin capital letter a with circumflex and tilde */
acircumflextilde           = 0x1001eab  /* u+1eab latin small letter a with circumflex and tilde */
acircumflexbelowdot_upper        = 0x1001eac  /* u+1eac latin capital letter a with circumflex and dot below */
acircumflexbelowdot        = 0x1001ead  /* u+1ead latin small letter a with circumflex and dot below */
abreveacute_upper                = 0x1001eae  /* u+1eae latin capital letter a with breve and acute */
abreveacute                = 0x1001eaf  /* u+1eaf latin small letter a with breve and acute */
abrevegrave_upper                = 0x1001eb0  /* u+1eb0 latin capital letter a with breve and grave */
abrevegrave                = 0x1001eb1  /* u+1eb1 latin small letter a with breve and grave */
abrevehook_upper                 = 0x1001eb2  /* u+1eb2 latin capital letter a with breve and hook above */
abrevehook                 = 0x1001eb3  /* u+1eb3 latin small letter a with breve and hook above */
abrevetilde_upper                = 0x1001eb4  /* u+1eb4 latin capital letter a with breve and tilde */
abrevetilde                = 0x1001eb5  /* u+1eb5 latin small letter a with breve and tilde */
abrevebelowdot_upper             = 0x1001eb6  /* u+1eb6 latin capital letter a with breve and dot below */
abrevebelowdot             = 0x1001eb7  /* u+1eb7 latin small letter a with breve and dot below */
ebelowdot_upper                  = 0x1001eb8  /* u+1eb8 latin capital letter e with dot below */
ebelowdot                  = 0x1001eb9  /* u+1eb9 latin small letter e with dot below */
ehook_upper                      = 0x1001eba  /* u+1eba latin capital letter e with hook above */
ehook                      = 0x1001ebb  /* u+1ebb latin small letter e with hook above */
etilde_upper                     = 0x1001ebc  /* u+1ebc latin capital letter e with tilde */
etilde                     = 0x1001ebd  /* u+1ebd latin small letter e with tilde */
ecircumflexacute_upper           = 0x1001ebe  /* u+1ebe latin capital letter e with circumflex and acute */
ecircumflexacute           = 0x1001ebf  /* u+1ebf latin small letter e with circumflex and acute */
ecircumflexgrave_upper           = 0x1001ec0  /* u+1ec0 latin capital letter e with circumflex and grave */
ecircumflexgrave           = 0x1001ec1  /* u+1ec1 latin small letter e with circumflex and grave */
ecircumflexhook_upper            = 0x1001ec2  /* u+1ec2 latin capital letter e with circumflex and hook above */
ecircumflexhook            = 0x1001ec3  /* u+1ec3 latin small letter e with circumflex and hook above */
ecircumflextilde_upper           = 0x1001ec4  /* u+1ec4 latin capital letter e with circumflex and tilde */
ecircumflextilde           = 0x1001ec5  /* u+1ec5 latin small letter e with circumflex and tilde */
ecircumflexbelowdot_upper        = 0x1001ec6  /* u+1ec6 latin capital letter e with circumflex and dot below */
ecircumflexbelowdot        = 0x1001ec7  /* u+1ec7 latin small letter e with circumflex and dot below */
ihook_upper                      = 0x1001ec8  /* u+1ec8 latin capital letter i with hook above */
ihook                      = 0x1001ec9  /* u+1ec9 latin small letter i with hook above */
ibelowdot_upper                  = 0x1001eca  /* u+1eca latin capital letter i with dot below */
ibelowdot                  = 0x1001ecb  /* u+1ecb latin small letter i with dot below */
obelowdot_upper                  = 0x1001ecc  /* u+1ecc latin capital letter o with dot below */
obelowdot                  = 0x1001ecd  /* u+1ecd latin small letter o with dot below */
ohook_upper                      = 0x1001ece  /* u+1ece latin capital letter o with hook above */
ohook                      = 0x1001ecf  /* u+1ecf latin small letter o with hook above */
ocircumflexacute_upper           = 0x1001ed0  /* u+1ed0 latin capital letter o with circumflex and acute */
ocircumflexacute           = 0x1001ed1  /* u+1ed1 latin small letter o with circumflex and acute */
ocircumflexgrave_upper           = 0x1001ed2  /* u+1ed2 latin capital letter o with circumflex and grave */
ocircumflexgrave           = 0x1001ed3  /* u+1ed3 latin small letter o with circumflex and grave */
ocircumflexhook_upper            = 0x1001ed4  /* u+1ed4 latin capital letter o with circumflex and hook above */
ocircumflexhook            = 0x1001ed5  /* u+1ed5 latin small letter o with circumflex and hook above */
ocircumflextilde_upper           = 0x1001ed6  /* u+1ed6 latin capital letter o with circumflex and tilde */
ocircumflextilde           = 0x1001ed7  /* u+1ed7 latin small letter o with circumflex and tilde */
ocircumflexbelowdot_upper        = 0x1001ed8  /* u+1ed8 latin capital letter o with circumflex and dot below */
ocircumflexbelowdot        = 0x1001ed9  /* u+1ed9 latin small letter o with circumflex and dot below */
ohornacute_upper                 = 0x1001eda  /* u+1eda latin capital letter o with horn and acute */
ohornacute                 = 0x1001edb  /* u+1edb latin small letter o with horn and acute */
ohorngrave_upper                 = 0x1001edc  /* u+1edc latin capital letter o with horn and grave */
ohorngrave                 = 0x1001edd  /* u+1edd latin small letter o with horn and grave */
ohornhook_upper                  = 0x1001ede  /* u+1ede latin capital letter o with horn and hook above */
ohornhook                  = 0x1001edf  /* u+1edf latin small letter o with horn and hook above */
ohorntilde_upper                 = 0x1001ee0  /* u+1ee0 latin capital letter o with horn and tilde */
ohorntilde                 = 0x1001ee1  /* u+1ee1 latin small letter o with horn and tilde */
ohornbelowdot_upper              = 0x1001ee2  /* u+1ee2 latin capital letter o with horn and dot below */
ohornbelowdot              = 0x1001ee3  /* u+1ee3 latin small letter o with horn and dot below */
ubelowdot_upper                  = 0x1001ee4  /* u+1ee4 latin capital letter u with dot below */
ubelowdot                  = 0x1001ee5  /* u+1ee5 latin small letter u with dot below */
uhook_upper                      = 0x1001ee6  /* u+1ee6 latin capital letter u with hook above */
uhook                      = 0x1001ee7  /* u+1ee7 latin small letter u with hook above */
uhornacute_upper                 = 0x1001ee8  /* u+1ee8 latin capital letter u with horn and acute */
uhornacute                 = 0x1001ee9  /* u+1ee9 latin small letter u with horn and acute */
uhorngrave_upper                 = 0x1001eea  /* u+1eea latin capital letter u with horn and grave */
uhorngrave                 = 0x1001eeb  /* u+1eeb latin small letter u with horn and grave */
uhornhook_upper                  = 0x1001eec  /* u+1eec latin capital letter u with horn and hook above */
uhornhook                  = 0x1001eed  /* u+1eed latin small letter u with horn and hook above */
uhorntilde_upper                 = 0x1001eee  /* u+1eee latin capital letter u with horn and tilde */
uhorntilde                 = 0x1001eef  /* u+1eef latin small letter u with horn and tilde */
uhornbelowdot_upper              = 0x1001ef0  /* u+1ef0 latin capital letter u with horn and dot below */
uhornbelowdot              = 0x1001ef1  /* u+1ef1 latin small letter u with horn and dot below */
ybelowdot_upper                  = 0x1001ef4  /* u+1ef4 latin capital letter y with dot below */
ybelowdot                  = 0x1001ef5  /* u+1ef5 latin small letter y with dot below */
yhook_upper                      = 0x1001ef6  /* u+1ef6 latin capital letter y with hook above */
yhook                      = 0x1001ef7  /* u+1ef7 latin small letter y with hook above */
ytilde_upper                     = 0x1001ef8  /* u+1ef8 latin capital letter y with tilde */
ytilde                     = 0x1001ef9  /* u+1ef9 latin small letter y with tilde */
ohorn_upper                      = 0x10001a0  /* u+01a0 latin capital letter o with horn */
ohorn                      = 0x10001a1  /* u+01a1 latin small letter o with horn */
uhorn_upper                      = 0x10001af  /* u+01af latin capital letter u with horn */
uhorn                      = 0x10001b0  /* u+01b0 latin small letter u with horn */
combining_tilde            = 0x1000303  /* u+0303 combining tilde */
combining_grave            = 0x1000300  /* u+0300 combining grave accent */
combining_acute            = 0x1000301  /* u+0301 combining acute accent */
combining_hook             = 0x1000309  /* u+0309 combining hook above */
combining_belowdot         = 0x1000323  /* u+0323 combining dot below */


ecusign                    = 0x10020a0  /* u+20a0 euro-currency sign */
colonsign                  = 0x10020a1  /* u+20a1 colon sign */
cruzeirosign               = 0x10020a2  /* u+20a2 cruzeiro sign */
ffrancsign                 = 0x10020a3  /* u+20a3 french franc sign */
lirasign                   = 0x10020a4  /* u+20a4 lira sign */
millsign                   = 0x10020a5  /* u+20a5 mill sign */
nairasign                  = 0x10020a6  /* u+20a6 naira sign */
pesetasign                 = 0x10020a7  /* u+20a7 peseta sign */
rupeesign                  = 0x10020a8  /* u+20a8 rupee sign */
wonsign                    = 0x10020a9  /* u+20a9 won sign */
newsheqelsign              = 0x10020aa  /* u+20aa new sheqel sign */
dongsign                   = 0x10020ab  /* u+20ab dong sign */
eurosign                      = 0x20ac  /* u+20ac euro sign */

/* one, two and three are defined above. */
zerosuperior               = 0x1002070  /* u+2070 superscript zero */
foursuperior               = 0x1002074  /* u+2074 superscript four */
fivesuperior               = 0x1002075  /* u+2075 superscript five */
sixsuperior                = 0x1002076  /* u+2076 superscript six */
sevensuperior              = 0x1002077  /* u+2077 superscript seven */
eightsuperior              = 0x1002078  /* u+2078 superscript eight */
ninesuperior               = 0x1002079  /* u+2079 superscript nine */
zerosubscript              = 0x1002080  /* u+2080 subscript zero */
onesubscript               = 0x1002081  /* u+2081 subscript one */
twosubscript               = 0x1002082  /* u+2082 subscript two */
threesubscript             = 0x1002083  /* u+2083 subscript three */
foursubscript              = 0x1002084  /* u+2084 subscript four */
fivesubscript              = 0x1002085  /* u+2085 subscript five */
sixsubscript               = 0x1002086  /* u+2086 subscript six */
sevensubscript             = 0x1002087  /* u+2087 subscript seven */
eightsubscript             = 0x1002088  /* u+2088 subscript eight */
ninesubscript              = 0x1002089  /* u+2089 subscript nine */
partdifferential           = 0x1002202  /* u+2202 partial differential */
emptyset                   = 0x1002205  /* u+2205 empty set */
elementof                  = 0x1002208  /* u+2208 element of */
notelementof               = 0x1002209  /* u+2209 not an element of */
containsas                 = 0x100220b  /* u+220b contains as member */
squareroot                 = 0x100221a  /* u+221a square root */
cuberoot                   = 0x100221b  /* u+221b cube root */
fourthroot                 = 0x100221c  /* u+221c fourth root */
dintegral                  = 0x100222c  /* u+222c double integral */
tintegral                  = 0x100222d  /* u+222d triple integral */
because                    = 0x1002235  /* u+2235 because */
approxeq                   = 0x1002248  /*(u+2248 almost equal to)*/
notapproxeq                = 0x1002247  /*(u+2247 neither approximately nor actually equal to)*/
notidentical               = 0x1002262  /* u+2262 not identical to */
stricteq                   = 0x1002263  /* u+2263 strictly equivalent to */

braille_dot_1                 = 0xfff1
braille_dot_2                 = 0xfff2
braille_dot_3                 = 0xfff3
braille_dot_4                 = 0xfff4
braille_dot_5                 = 0xfff5
braille_dot_6                 = 0xfff6
braille_dot_7                 = 0xfff7
braille_dot_8                 = 0xfff8
braille_dot_9                 = 0xfff9
braille_dot_10                = 0xfffa
braille_blank              = 0x1002800  /* u+2800 braille pattern blank */
braille_dots_1             = 0x1002801  /* u+2801 braille pattern dots-1 */
braille_dots_2             = 0x1002802  /* u+2802 braille pattern dots-2 */
braille_dots_12            = 0x1002803  /* u+2803 braille pattern dots-12 */
braille_dots_3             = 0x1002804  /* u+2804 braille pattern dots-3 */
braille_dots_13            = 0x1002805  /* u+2805 braille pattern dots-13 */
braille_dots_23            = 0x1002806  /* u+2806 braille pattern dots-23 */
braille_dots_123           = 0x1002807  /* u+2807 braille pattern dots-123 */
braille_dots_4             = 0x1002808  /* u+2808 braille pattern dots-4 */
braille_dots_14            = 0x1002809  /* u+2809 braille pattern dots-14 */
braille_dots_24            = 0x100280a  /* u+280a braille pattern dots-24 */
braille_dots_124           = 0x100280b  /* u+280b braille pattern dots-124 */
braille_dots_34            = 0x100280c  /* u+280c braille pattern dots-34 */
braille_dots_134           = 0x100280d  /* u+280d braille pattern dots-134 */
braille_dots_234           = 0x100280e  /* u+280e braille pattern dots-234 */
braille_dots_1234          = 0x100280f  /* u+280f braille pattern dots-1234 */
braille_dots_5             = 0x1002810  /* u+2810 braille pattern dots-5 */
braille_dots_15            = 0x1002811  /* u+2811 braille pattern dots-15 */
braille_dots_25            = 0x1002812  /* u+2812 braille pattern dots-25 */
braille_dots_125           = 0x1002813  /* u+2813 braille pattern dots-125 */
braille_dots_35            = 0x1002814  /* u+2814 braille pattern dots-35 */
braille_dots_135           = 0x1002815  /* u+2815 braille pattern dots-135 */
braille_dots_235           = 0x1002816  /* u+2816 braille pattern dots-235 */
braille_dots_1235          = 0x1002817  /* u+2817 braille pattern dots-1235 */
braille_dots_45            = 0x1002818  /* u+2818 braille pattern dots-45 */
braille_dots_145           = 0x1002819  /* u+2819 braille pattern dots-145 */
braille_dots_245           = 0x100281a  /* u+281a braille pattern dots-245 */
braille_dots_1245          = 0x100281b  /* u+281b braille pattern dots-1245 */
braille_dots_345           = 0x100281c  /* u+281c braille pattern dots-345 */
braille_dots_1345          = 0x100281d  /* u+281d braille pattern dots-1345 */
braille_dots_2345          = 0x100281e  /* u+281e braille pattern dots-2345 */
braille_dots_12345         = 0x100281f  /* u+281f braille pattern dots-12345 */
braille_dots_6             = 0x1002820  /* u+2820 braille pattern dots-6 */
braille_dots_16            = 0x1002821  /* u+2821 braille pattern dots-16 */
braille_dots_26            = 0x1002822  /* u+2822 braille pattern dots-26 */
braille_dots_126           = 0x1002823  /* u+2823 braille pattern dots-126 */
braille_dots_36            = 0x1002824  /* u+2824 braille pattern dots-36 */
braille_dots_136           = 0x1002825  /* u+2825 braille pattern dots-136 */
braille_dots_236           = 0x1002826  /* u+2826 braille pattern dots-236 */
braille_dots_1236          = 0x1002827  /* u+2827 braille pattern dots-1236 */
braille_dots_46            = 0x1002828  /* u+2828 braille pattern dots-46 */
braille_dots_146           = 0x1002829  /* u+2829 braille pattern dots-146 */
braille_dots_246           = 0x100282a  /* u+282a braille pattern dots-246 */
braille_dots_1246          = 0x100282b  /* u+282b braille pattern dots-1246 */
braille_dots_346           = 0x100282c  /* u+282c braille pattern dots-346 */
braille_dots_1346          = 0x100282d  /* u+282d braille pattern dots-1346 */
braille_dots_2346          = 0x100282e  /* u+282e braille pattern dots-2346 */
braille_dots_12346         = 0x100282f  /* u+282f braille pattern dots-12346 */
braille_dots_56            = 0x1002830  /* u+2830 braille pattern dots-56 */
braille_dots_156           = 0x1002831  /* u+2831 braille pattern dots-156 */
braille_dots_256           = 0x1002832  /* u+2832 braille pattern dots-256 */
braille_dots_1256          = 0x1002833  /* u+2833 braille pattern dots-1256 */
braille_dots_356           = 0x1002834  /* u+2834 braille pattern dots-356 */
braille_dots_1356          = 0x1002835  /* u+2835 braille pattern dots-1356 */
braille_dots_2356          = 0x1002836  /* u+2836 braille pattern dots-2356 */
braille_dots_12356         = 0x1002837  /* u+2837 braille pattern dots-12356 */
braille_dots_456           = 0x1002838  /* u+2838 braille pattern dots-456 */
braille_dots_1456          = 0x1002839  /* u+2839 braille pattern dots-1456 */
braille_dots_2456          = 0x100283a  /* u+283a braille pattern dots-2456 */
braille_dots_12456         = 0x100283b  /* u+283b braille pattern dots-12456 */
braille_dots_3456          = 0x100283c  /* u+283c braille pattern dots-3456 */
braille_dots_13456         = 0x100283d  /* u+283d braille pattern dots-13456 */
braille_dots_23456         = 0x100283e  /* u+283e braille pattern dots-23456 */
braille_dots_123456        = 0x100283f  /* u+283f braille pattern dots-123456 */
braille_dots_7             = 0x1002840  /* u+2840 braille pattern dots-7 */
braille_dots_17            = 0x1002841  /* u+2841 braille pattern dots-17 */
braille_dots_27            = 0x1002842  /* u+2842 braille pattern dots-27 */
braille_dots_127           = 0x1002843  /* u+2843 braille pattern dots-127 */
braille_dots_37            = 0x1002844  /* u+2844 braille pattern dots-37 */
braille_dots_137           = 0x1002845  /* u+2845 braille pattern dots-137 */
braille_dots_237           = 0x1002846  /* u+2846 braille pattern dots-237 */
braille_dots_1237          = 0x1002847  /* u+2847 braille pattern dots-1237 */
braille_dots_47            = 0x1002848  /* u+2848 braille pattern dots-47 */
braille_dots_147           = 0x1002849  /* u+2849 braille pattern dots-147 */
braille_dots_247           = 0x100284a  /* u+284a braille pattern dots-247 */
braille_dots_1247          = 0x100284b  /* u+284b braille pattern dots-1247 */
braille_dots_347           = 0x100284c  /* u+284c braille pattern dots-347 */
braille_dots_1347          = 0x100284d  /* u+284d braille pattern dots-1347 */
braille_dots_2347          = 0x100284e  /* u+284e braille pattern dots-2347 */
braille_dots_12347         = 0x100284f  /* u+284f braille pattern dots-12347 */
braille_dots_57            = 0x1002850  /* u+2850 braille pattern dots-57 */
braille_dots_157           = 0x1002851  /* u+2851 braille pattern dots-157 */
braille_dots_257           = 0x1002852  /* u+2852 braille pattern dots-257 */
braille_dots_1257          = 0x1002853  /* u+2853 braille pattern dots-1257 */
braille_dots_357           = 0x1002854  /* u+2854 braille pattern dots-357 */
braille_dots_1357          = 0x1002855  /* u+2855 braille pattern dots-1357 */
braille_dots_2357          = 0x1002856  /* u+2856 braille pattern dots-2357 */
braille_dots_12357         = 0x1002857  /* u+2857 braille pattern dots-12357 */
braille_dots_457           = 0x1002858  /* u+2858 braille pattern dots-457 */
braille_dots_1457          = 0x1002859  /* u+2859 braille pattern dots-1457 */
braille_dots_2457          = 0x100285a  /* u+285a braille pattern dots-2457 */
braille_dots_12457         = 0x100285b  /* u+285b braille pattern dots-12457 */
braille_dots_3457          = 0x100285c  /* u+285c braille pattern dots-3457 */
braille_dots_13457         = 0x100285d  /* u+285d braille pattern dots-13457 */
braille_dots_23457         = 0x100285e  /* u+285e braille pattern dots-23457 */
braille_dots_123457        = 0x100285f  /* u+285f braille pattern dots-123457 */
braille_dots_67            = 0x1002860  /* u+2860 braille pattern dots-67 */
braille_dots_167           = 0x1002861  /* u+2861 braille pattern dots-167 */
braille_dots_267           = 0x1002862  /* u+2862 braille pattern dots-267 */
braille_dots_1267          = 0x1002863  /* u+2863 braille pattern dots-1267 */
braille_dots_367           = 0x1002864  /* u+2864 braille pattern dots-367 */
braille_dots_1367          = 0x1002865  /* u+2865 braille pattern dots-1367 */
braille_dots_2367          = 0x1002866  /* u+2866 braille pattern dots-2367 */
braille_dots_12367         = 0x1002867  /* u+2867 braille pattern dots-12367 */
braille_dots_467           = 0x1002868  /* u+2868 braille pattern dots-467 */
braille_dots_1467          = 0x1002869  /* u+2869 braille pattern dots-1467 */
braille_dots_2467          = 0x100286a  /* u+286a braille pattern dots-2467 */
braille_dots_12467         = 0x100286b  /* u+286b braille pattern dots-12467 */
braille_dots_3467          = 0x100286c  /* u+286c braille pattern dots-3467 */
braille_dots_13467         = 0x100286d  /* u+286d braille pattern dots-13467 */
braille_dots_23467         = 0x100286e  /* u+286e braille pattern dots-23467 */
braille_dots_123467        = 0x100286f  /* u+286f braille pattern dots-123467 */
braille_dots_567           = 0x1002870  /* u+2870 braille pattern dots-567 */
braille_dots_1567          = 0x1002871  /* u+2871 braille pattern dots-1567 */
braille_dots_2567          = 0x1002872  /* u+2872 braille pattern dots-2567 */
braille_dots_12567         = 0x1002873  /* u+2873 braille pattern dots-12567 */
braille_dots_3567          = 0x1002874  /* u+2874 braille pattern dots-3567 */
braille_dots_13567         = 0x1002875  /* u+2875 braille pattern dots-13567 */
braille_dots_23567         = 0x1002876  /* u+2876 braille pattern dots-23567 */
braille_dots_123567        = 0x1002877  /* u+2877 braille pattern dots-123567 */
braille_dots_4567          = 0x1002878  /* u+2878 braille pattern dots-4567 */
braille_dots_14567         = 0x1002879  /* u+2879 braille pattern dots-14567 */
braille_dots_24567         = 0x100287a  /* u+287a braille pattern dots-24567 */
braille_dots_124567        = 0x100287b  /* u+287b braille pattern dots-124567 */
braille_dots_34567         = 0x100287c  /* u+287c braille pattern dots-34567 */
braille_dots_134567        = 0x100287d  /* u+287d braille pattern dots-134567 */
braille_dots_234567        = 0x100287e  /* u+287e braille pattern dots-234567 */
braille_dots_1234567       = 0x100287f  /* u+287f braille pattern dots-1234567 */
braille_dots_8             = 0x1002880  /* u+2880 braille pattern dots-8 */
braille_dots_18            = 0x1002881  /* u+2881 braille pattern dots-18 */
braille_dots_28            = 0x1002882  /* u+2882 braille pattern dots-28 */
braille_dots_128           = 0x1002883  /* u+2883 braille pattern dots-128 */
braille_dots_38            = 0x1002884  /* u+2884 braille pattern dots-38 */
braille_dots_138           = 0x1002885  /* u+2885 braille pattern dots-138 */
braille_dots_238           = 0x1002886  /* u+2886 braille pattern dots-238 */
braille_dots_1238          = 0x1002887  /* u+2887 braille pattern dots-1238 */
braille_dots_48            = 0x1002888  /* u+2888 braille pattern dots-48 */
braille_dots_148           = 0x1002889  /* u+2889 braille pattern dots-148 */
braille_dots_248           = 0x100288a  /* u+288a braille pattern dots-248 */
braille_dots_1248          = 0x100288b  /* u+288b braille pattern dots-1248 */
braille_dots_348           = 0x100288c  /* u+288c braille pattern dots-348 */
braille_dots_1348          = 0x100288d  /* u+288d braille pattern dots-1348 */
braille_dots_2348          = 0x100288e  /* u+288e braille pattern dots-2348 */
braille_dots_12348         = 0x100288f  /* u+288f braille pattern dots-12348 */
braille_dots_58            = 0x1002890  /* u+2890 braille pattern dots-58 */
braille_dots_158           = 0x1002891  /* u+2891 braille pattern dots-158 */
braille_dots_258           = 0x1002892  /* u+2892 braille pattern dots-258 */
braille_dots_1258          = 0x1002893  /* u+2893 braille pattern dots-1258 */
braille_dots_358           = 0x1002894  /* u+2894 braille pattern dots-358 */
braille_dots_1358          = 0x1002895  /* u+2895 braille pattern dots-1358 */
braille_dots_2358          = 0x1002896  /* u+2896 braille pattern dots-2358 */
braille_dots_12358         = 0x1002897  /* u+2897 braille pattern dots-12358 */
braille_dots_458           = 0x1002898  /* u+2898 braille pattern dots-458 */
braille_dots_1458          = 0x1002899  /* u+2899 braille pattern dots-1458 */
braille_dots_2458          = 0x100289a  /* u+289a braille pattern dots-2458 */
braille_dots_12458         = 0x100289b  /* u+289b braille pattern dots-12458 */
braille_dots_3458          = 0x100289c  /* u+289c braille pattern dots-3458 */
braille_dots_13458         = 0x100289d  /* u+289d braille pattern dots-13458 */
braille_dots_23458         = 0x100289e  /* u+289e braille pattern dots-23458 */
braille_dots_123458        = 0x100289f  /* u+289f braille pattern dots-123458 */
braille_dots_68            = 0x10028a0  /* u+28a0 braille pattern dots-68 */
braille_dots_168           = 0x10028a1  /* u+28a1 braille pattern dots-168 */
braille_dots_268           = 0x10028a2  /* u+28a2 braille pattern dots-268 */
braille_dots_1268          = 0x10028a3  /* u+28a3 braille pattern dots-1268 */
braille_dots_368           = 0x10028a4  /* u+28a4 braille pattern dots-368 */
braille_dots_1368          = 0x10028a5  /* u+28a5 braille pattern dots-1368 */
braille_dots_2368          = 0x10028a6  /* u+28a6 braille pattern dots-2368 */
braille_dots_12368         = 0x10028a7  /* u+28a7 braille pattern dots-12368 */
braille_dots_468           = 0x10028a8  /* u+28a8 braille pattern dots-468 */
braille_dots_1468          = 0x10028a9  /* u+28a9 braille pattern dots-1468 */
braille_dots_2468          = 0x10028aa  /* u+28aa braille pattern dots-2468 */
braille_dots_12468         = 0x10028ab  /* u+28ab braille pattern dots-12468 */
braille_dots_3468          = 0x10028ac  /* u+28ac braille pattern dots-3468 */
braille_dots_13468         = 0x10028ad  /* u+28ad braille pattern dots-13468 */
braille_dots_23468         = 0x10028ae  /* u+28ae braille pattern dots-23468 */
braille_dots_123468        = 0x10028af  /* u+28af braille pattern dots-123468 */
braille_dots_568           = 0x10028b0  /* u+28b0 braille pattern dots-568 */
braille_dots_1568          = 0x10028b1  /* u+28b1 braille pattern dots-1568 */
braille_dots_2568          = 0x10028b2  /* u+28b2 braille pattern dots-2568 */
braille_dots_12568         = 0x10028b3  /* u+28b3 braille pattern dots-12568 */
braille_dots_3568          = 0x10028b4  /* u+28b4 braille pattern dots-3568 */
braille_dots_13568         = 0x10028b5  /* u+28b5 braille pattern dots-13568 */
braille_dots_23568         = 0x10028b6  /* u+28b6 braille pattern dots-23568 */
braille_dots_123568        = 0x10028b7  /* u+28b7 braille pattern dots-123568 */
braille_dots_4568          = 0x10028b8  /* u+28b8 braille pattern dots-4568 */
braille_dots_14568         = 0x10028b9  /* u+28b9 braille pattern dots-14568 */
braille_dots_24568         = 0x10028ba  /* u+28ba braille pattern dots-24568 */
braille_dots_124568        = 0x10028bb  /* u+28bb braille pattern dots-124568 */
braille_dots_34568         = 0x10028bc  /* u+28bc braille pattern dots-34568 */
braille_dots_134568        = 0x10028bd  /* u+28bd braille pattern dots-134568 */
braille_dots_234568        = 0x10028be  /* u+28be braille pattern dots-234568 */
braille_dots_1234568       = 0x10028bf  /* u+28bf braille pattern dots-1234568 */
braille_dots_78            = 0x10028c0  /* u+28c0 braille pattern dots-78 */
braille_dots_178           = 0x10028c1  /* u+28c1 braille pattern dots-178 */
braille_dots_278           = 0x10028c2  /* u+28c2 braille pattern dots-278 */
braille_dots_1278          = 0x10028c3  /* u+28c3 braille pattern dots-1278 */
braille_dots_378           = 0x10028c4  /* u+28c4 braille pattern dots-378 */
braille_dots_1378          = 0x10028c5  /* u+28c5 braille pattern dots-1378 */
braille_dots_2378          = 0x10028c6  /* u+28c6 braille pattern dots-2378 */
braille_dots_12378         = 0x10028c7  /* u+28c7 braille pattern dots-12378 */
braille_dots_478           = 0x10028c8  /* u+28c8 braille pattern dots-478 */
braille_dots_1478          = 0x10028c9  /* u+28c9 braille pattern dots-1478 */
braille_dots_2478          = 0x10028ca  /* u+28ca braille pattern dots-2478 */
braille_dots_12478         = 0x10028cb  /* u+28cb braille pattern dots-12478 */
braille_dots_3478          = 0x10028cc  /* u+28cc braille pattern dots-3478 */
braille_dots_13478         = 0x10028cd  /* u+28cd braille pattern dots-13478 */
braille_dots_23478         = 0x10028ce  /* u+28ce braille pattern dots-23478 */
braille_dots_123478        = 0x10028cf  /* u+28cf braille pattern dots-123478 */
braille_dots_578           = 0x10028d0  /* u+28d0 braille pattern dots-578 */
braille_dots_1578          = 0x10028d1  /* u+28d1 braille pattern dots-1578 */
braille_dots_2578          = 0x10028d2  /* u+28d2 braille pattern dots-2578 */
braille_dots_12578         = 0x10028d3  /* u+28d3 braille pattern dots-12578 */
braille_dots_3578          = 0x10028d4  /* u+28d4 braille pattern dots-3578 */
braille_dots_13578         = 0x10028d5  /* u+28d5 braille pattern dots-13578 */
braille_dots_23578         = 0x10028d6  /* u+28d6 braille pattern dots-23578 */
braille_dots_123578        = 0x10028d7  /* u+28d7 braille pattern dots-123578 */
braille_dots_4578          = 0x10028d8  /* u+28d8 braille pattern dots-4578 */
braille_dots_14578         = 0x10028d9  /* u+28d9 braille pattern dots-14578 */
braille_dots_24578         = 0x10028da  /* u+28da braille pattern dots-24578 */
braille_dots_124578        = 0x10028db  /* u+28db braille pattern dots-124578 */
braille_dots_34578         = 0x10028dc  /* u+28dc braille pattern dots-34578 */
braille_dots_134578        = 0x10028dd  /* u+28dd braille pattern dots-134578 */
braille_dots_234578        = 0x10028de  /* u+28de braille pattern dots-234578 */
braille_dots_1234578       = 0x10028df  /* u+28df braille pattern dots-1234578 */
braille_dots_678           = 0x10028e0  /* u+28e0 braille pattern dots-678 */
braille_dots_1678          = 0x10028e1  /* u+28e1 braille pattern dots-1678 */
braille_dots_2678          = 0x10028e2  /* u+28e2 braille pattern dots-2678 */
braille_dots_12678         = 0x10028e3  /* u+28e3 braille pattern dots-12678 */
braille_dots_3678          = 0x10028e4  /* u+28e4 braille pattern dots-3678 */
braille_dots_13678         = 0x10028e5  /* u+28e5 braille pattern dots-13678 */
braille_dots_23678         = 0x10028e6  /* u+28e6 braille pattern dots-23678 */
braille_dots_123678        = 0x10028e7  /* u+28e7 braille pattern dots-123678 */
braille_dots_4678          = 0x10028e8  /* u+28e8 braille pattern dots-4678 */
braille_dots_14678         = 0x10028e9  /* u+28e9 braille pattern dots-14678 */
braille_dots_24678         = 0x10028ea  /* u+28ea braille pattern dots-24678 */
braille_dots_124678        = 0x10028eb  /* u+28eb braille pattern dots-124678 */
braille_dots_34678         = 0x10028ec  /* u+28ec braille pattern dots-34678 */
braille_dots_134678        = 0x10028ed  /* u+28ed braille pattern dots-134678 */
braille_dots_234678        = 0x10028ee  /* u+28ee braille pattern dots-234678 */
braille_dots_1234678       = 0x10028ef  /* u+28ef braille pattern dots-1234678 */
braille_dots_5678          = 0x10028f0  /* u+28f0 braille pattern dots-5678 */
braille_dots_15678         = 0x10028f1  /* u+28f1 braille pattern dots-15678 */
braille_dots_25678         = 0x10028f2  /* u+28f2 braille pattern dots-25678 */
braille_dots_125678        = 0x10028f3  /* u+28f3 braille pattern dots-125678 */
braille_dots_35678         = 0x10028f4  /* u+28f4 braille pattern dots-35678 */
braille_dots_135678        = 0x10028f5  /* u+28f5 braille pattern dots-135678 */
braille_dots_235678        = 0x10028f6  /* u+28f6 braille pattern dots-235678 */
braille_dots_1235678       = 0x10028f7  /* u+28f7 braille pattern dots-1235678 */
braille_dots_45678         = 0x10028f8  /* u+28f8 braille pattern dots-45678 */
braille_dots_145678        = 0x10028f9  /* u+28f9 braille pattern dots-145678 */
braille_dots_245678        = 0x10028fa  /* u+28fa braille pattern dots-245678 */
braille_dots_1245678       = 0x10028fb  /* u+28fb braille pattern dots-1245678 */
braille_dots_345678        = 0x10028fc  /* u+28fc braille pattern dots-345678 */
braille_dots_1345678       = 0x10028fd  /* u+28fd braille pattern dots-1345678 */
braille_dots_2345678       = 0x10028fe  /* u+28fe braille pattern dots-2345678 */
braille_dots_12345678      = 0x10028ff  /* u+28ff braille pattern dots-12345678 */

/*
 * sinhala (http://unicode.org/charts/pdf/u0d80.pdf)
 * http://www.nongnu.org/sinhala/doc/transliteration/sinhala-transliteration_6.html
 */

sinh_ng                    = 0x1000d82  /* u+0d82 sinhala sign anusvaraya */
sinh_h2                    = 0x1000d83  /* u+0d83 sinhala sign visargaya */
sinh_a                     = 0x1000d85  /* u+0d85 sinhala letter ayanna */
sinh_aa                    = 0x1000d86  /* u+0d86 sinhala letter aayanna */
sinh_ae                    = 0x1000d87  /* u+0d87 sinhala letter aeyanna */
sinh_aee                   = 0x1000d88  /* u+0d88 sinhala letter aeeyanna */
sinh_i                     = 0x1000d89  /* u+0d89 sinhala letter iyanna */
sinh_ii                    = 0x1000d8a  /* u+0d8a sinhala letter iiyanna */
sinh_u                     = 0x1000d8b  /* u+0d8b sinhala letter uyanna */
sinh_uu                    = 0x1000d8c  /* u+0d8c sinhala letter uuyanna */
sinh_ri                    = 0x1000d8d  /* u+0d8d sinhala letter iruyanna */
sinh_rii                   = 0x1000d8e  /* u+0d8e sinhala letter iruuyanna */
sinh_lu                    = 0x1000d8f  /* u+0d8f sinhala letter iluyanna */
sinh_luu                   = 0x1000d90  /* u+0d90 sinhala letter iluuyanna */
sinh_e                     = 0x1000d91  /* u+0d91 sinhala letter eyanna */
sinh_ee                    = 0x1000d92  /* u+0d92 sinhala letter eeyanna */
sinh_ai                    = 0x1000d93  /* u+0d93 sinhala letter aiyanna */
sinh_o                     = 0x1000d94  /* u+0d94 sinhala letter oyanna */
sinh_oo                    = 0x1000d95  /* u+0d95 sinhala letter ooyanna */
sinh_au                    = 0x1000d96  /* u+0d96 sinhala letter auyanna */
sinh_ka                    = 0x1000d9a  /* u+0d9a sinhala letter alpapraana kayanna */
sinh_kha                   = 0x1000d9b  /* u+0d9b sinhala letter mahaapraana kayanna */
sinh_ga                    = 0x1000d9c  /* u+0d9c sinhala letter alpapraana gayanna */
sinh_gha                   = 0x1000d9d  /* u+0d9d sinhala letter mahaapraana gayanna */
sinh_ng2                   = 0x1000d9e  /* u+0d9e sinhala letter kantaja naasikyaya */
sinh_nga                   = 0x1000d9f  /* u+0d9f sinhala letter sanyaka gayanna */
sinh_ca                    = 0x1000da0  /* u+0da0 sinhala letter alpapraana cayanna */
sinh_cha                   = 0x1000da1  /* u+0da1 sinhala letter mahaapraana cayanna */
sinh_ja                    = 0x1000da2  /* u+0da2 sinhala letter alpapraana jayanna */
sinh_jha                   = 0x1000da3  /* u+0da3 sinhala letter mahaapraana jayanna */
sinh_nya                   = 0x1000da4  /* u+0da4 sinhala letter taaluja naasikyaya */
sinh_jnya                  = 0x1000da5  /* u+0da5 sinhala letter taaluja sanyooga naaksikyaya */
sinh_nja                   = 0x1000da6  /* u+0da6 sinhala letter sanyaka jayanna */
sinh_tta                   = 0x1000da7  /* u+0da7 sinhala letter alpapraana ttayanna */
sinh_ttha                  = 0x1000da8  /* u+0da8 sinhala letter mahaapraana ttayanna */
sinh_dda                   = 0x1000da9  /* u+0da9 sinhala letter alpapraana ddayanna */
sinh_ddha                  = 0x1000daa  /* u+0daa sinhala letter mahaapraana ddayanna */
sinh_nna                   = 0x1000dab  /* u+0dab sinhala letter muurdhaja nayanna */
sinh_ndda                  = 0x1000dac  /* u+0dac sinhala letter sanyaka ddayanna */
sinh_tha                   = 0x1000dad  /* u+0dad sinhala letter alpapraana tayanna */
sinh_thha                  = 0x1000dae  /* u+0dae sinhala letter mahaapraana tayanna */
sinh_dha                   = 0x1000daf  /* u+0daf sinhala letter alpapraana dayanna */
sinh_dhha                  = 0x1000db0  /* u+0db0 sinhala letter mahaapraana dayanna */
sinh_na                    = 0x1000db1  /* u+0db1 sinhala letter dantaja nayanna */
sinh_ndha                  = 0x1000db3  /* u+0db3 sinhala letter sanyaka dayanna */
sinh_pa                    = 0x1000db4  /* u+0db4 sinhala letter alpapraana payanna */
sinh_pha                   = 0x1000db5  /* u+0db5 sinhala letter mahaapraana payanna */
sinh_ba                    = 0x1000db6  /* u+0db6 sinhala letter alpapraana bayanna */
sinh_bha                   = 0x1000db7  /* u+0db7 sinhala letter mahaapraana bayanna */
sinh_ma                    = 0x1000db8  /* u+0db8 sinhala letter mayanna */
sinh_mba                   = 0x1000db9  /* u+0db9 sinhala letter amba bayanna */
sinh_ya                    = 0x1000dba  /* u+0dba sinhala letter yayanna */
sinh_ra                    = 0x1000dbb  /* u+0dbb sinhala letter rayanna */
sinh_la                    = 0x1000dbd  /* u+0dbd sinhala letter dantaja layanna */
sinh_va                    = 0x1000dc0  /* u+0dc0 sinhala letter vayanna */
sinh_sha                   = 0x1000dc1  /* u+0dc1 sinhala letter taaluja sayanna */
sinh_ssha                  = 0x1000dc2  /* u+0dc2 sinhala letter muurdhaja sayanna */
sinh_sa                    = 0x1000dc3  /* u+0dc3 sinhala letter dantaja sayanna */
sinh_ha                    = 0x1000dc4  /* u+0dc4 sinhala letter hayanna */
sinh_lla                   = 0x1000dc5  /* u+0dc5 sinhala letter muurdhaja layanna */
sinh_fa                    = 0x1000dc6  /* u+0dc6 sinhala letter fayanna */
sinh_al                    = 0x1000dca  /* u+0dca sinhala sign al-lakuna */
sinh_aa2                   = 0x1000dcf  /* u+0dcf sinhala vowel sign aela-pilla */
sinh_ae2                   = 0x1000dd0  /* u+0dd0 sinhala vowel sign ketti aeda-pilla */
sinh_aee2                  = 0x1000dd1  /* u+0dd1 sinhala vowel sign diga aeda-pilla */
sinh_i2                    = 0x1000dd2  /* u+0dd2 sinhala vowel sign ketti is-pilla */
sinh_ii2                   = 0x1000dd3  /* u+0dd3 sinhala vowel sign diga is-pilla */
sinh_u2                    = 0x1000dd4  /* u+0dd4 sinhala vowel sign ketti paa-pilla */
sinh_uu2                   = 0x1000dd6  /* u+0dd6 sinhala vowel sign diga paa-pilla */
sinh_ru2                   = 0x1000dd8  /* u+0dd8 sinhala vowel sign gaetta-pilla */
sinh_e2                    = 0x1000dd9  /* u+0dd9 sinhala vowel sign kombuva */
sinh_ee2                   = 0x1000dda  /* u+0dda sinhala vowel sign diga kombuva */
sinh_ai2                   = 0x1000ddb  /* u+0ddb sinhala vowel sign kombu deka */
sinh_o2                    = 0x1000ddc  /* u+0ddc sinhala vowel sign kombuva haa aela-pilla */
sinh_oo2                   = 0x1000ddd  /* u+0ddd sinhala vowel sign kombuva haa diga aela-pilla */
sinh_au2                   = 0x1000dde  /* u+0dde sinhala vowel sign kombuva haa gayanukitta */
sinh_lu2                   = 0x1000ddf  /* u+0ddf sinhala vowel sign gayanukitta */
sinh_ruu2                  = 0x1000df2  /* u+0df2 sinhala vowel sign diga gaetta-pilla */
sinh_luu2                  = 0x1000df3  /* u+0df3 sinhala vowel sign diga gayanukitta */
sinh_kunddaliya            = 0x1000df4  /* u+0df4 sinhala punctuation kunddaliya */
/*
 * xfree86 vendor specific keysyms.
 *
 * the xfree86 keysym range is = 0x10080001 - 0x1008ffff.
 *
 * the xf86 set of keysyms is a catch-all set of defines for keysyms found
 * on various multimedia keyboards. originally specific to xfree86 they have
 * been been adopted over time and are considered a "standard" part of x
 * keysym definitions.
 * xfree86 never properly commented these keysyms, so we have done our
 * best to explain the semantic meaning of these keys.
 *
 * xfree86 has removed their mail archives of the period, that might have
 * shed more light on some of these definitions. until/unless we resurrect
 * these archives, these are from memory and usage.
 */

/*
 * modelock
 *
 * this one is old, and not really used any more since xkb offers this
 * functionality.
 */

xf86modelock              = 0x1008ff01  /* mode switch lock */

/* backlight controls. */
xf86monbrightnessup       = 0x1008ff02  /* monitor/panel brightness */
xf86monbrightnessdown     = 0x1008ff03  /* monitor/panel brightness */
xf86kbdlightonoff         = 0x1008ff04  /* keyboards may be lit     */
xf86kbdbrightnessup       = 0x1008ff05  /* keyboards may be lit     */
xf86kbdbrightnessdown     = 0x1008ff06  /* keyboards may be lit     */
xf86monbrightnesscycle    = 0x1008ff07  /* monitor/panel brightness */

/*
 * keys found on some "internet" keyboards.
 */
xf86standby               = 0x1008ff10  /* system into standby mode   */
xf86audiolowervolume      = 0x1008ff11  /* volume control down        */
xf86audiomute             = 0x1008ff12  /* mute sound from the system */
xf86audioraisevolume      = 0x1008ff13  /* volume control up          */
xf86audioplay             = 0x1008ff14  /* start playing of audio >   */
xf86audiostop             = 0x1008ff15  /* stop playing audio         */
xf86audioprev             = 0x1008ff16  /* previous track             */
xf86audionext             = 0x1008ff17  /* next track                 */
xf86homepage              = 0x1008ff18  /* display user's home page   */
xf86mail                  = 0x1008ff19  /* invoke user's mail program */
xf86start                 = 0x1008ff1a  /* start application          */
xf86search                = 0x1008ff1b  /* search                     */
xf86audiorecord           = 0x1008ff1c  /* record audio application   */

/* these are sometimes found on pda's (e.g. palm, pocketpc or elsewhere)   */
xf86calculator            = 0x1008ff1d  /* invoke calculator program  */
xf86memo                  = 0x1008ff1e  /* invoke memo taking program */
xf86todolist              = 0x1008ff1f  /* invoke to do list program  */
xf86calendar              = 0x1008ff20  /* invoke calendar program    */
xf86powerdown             = 0x1008ff21  /* deep sleep the system      */
xf86contrastadjust        = 0x1008ff22  /* adjust screen contrast     */
xf86rockerup              = 0x1008ff23  /* rocker switches exist up   */
xf86rockerdown            = 0x1008ff24  /* and down                   */
xf86rockerenter           = 0x1008ff25  /* and let you press them     */

/* some more "internet" keyboard symbols */
xf86back                  = 0x1008ff26  /* like back on a browser     */
xf86forward               = 0x1008ff27  /* like forward on a browser  */
xf86stop                  = 0x1008ff28  /* stop current operation     */
xf86refresh               = 0x1008ff29  /* refresh the page           */
xf86poweroff              = 0x1008ff2a  /* power off system entirely  */
xf86wakeup                = 0x1008ff2b  /* wake up system from sleep  */
xf86eject                 = 0x1008ff2c  /* eject device (e.g. dvd)    */
xf86screensaver           = 0x1008ff2d  /* invoke screensaver         */
xf86www                   = 0x1008ff2e  /* invoke web browser         */
xf86sleep                 = 0x1008ff2f  /* put system to sleep        */
xf86favorites             = 0x1008ff30  /* show favorite locations    */
xf86audiopause            = 0x1008ff31  /* pause audio playing        */
xf86audiomedia            = 0x1008ff32  /* launch media collection app */
xf86mycomputer            = 0x1008ff33  /* display "my computer" window */
xf86vendorhome            = 0x1008ff34  /* display vendor home web site */
xf86lightbulb             = 0x1008ff35  /* light bulb keys exist       */
xf86shop                  = 0x1008ff36  /* display shopping web site   */
xf86history               = 0x1008ff37  /* show history of web surfing */
xf86openurl               = 0x1008ff38  /* open selected url           */
xf86addfavorite           = 0x1008ff39  /* add url to favorites list   */
xf86hotlinks              = 0x1008ff3a  /* show "hot" links            */
xf86brightnessadjust      = 0x1008ff3b  /* invoke brightness adj. ui   */
xf86finance               = 0x1008ff3c  /* display financial site      */
xf86community             = 0x1008ff3d  /* display user's community    */
xf86audiorewind           = 0x1008ff3e  /* "rewind" audio track        */
xf86backforward           = 0x1008ff3f  /* ??? */
xf86launch0               = 0x1008ff40  /* launch application          */
xf86launch1               = 0x1008ff41  /* launch application          */
xf86launch2               = 0x1008ff42  /* launch application          */
xf86launch3               = 0x1008ff43  /* launch application          */
xf86launch4               = 0x1008ff44  /* launch application          */
xf86launch5               = 0x1008ff45  /* launch application          */
xf86launch6               = 0x1008ff46  /* launch application          */
xf86launch7               = 0x1008ff47  /* launch application          */
xf86launch8               = 0x1008ff48  /* launch application          */
xf86launch9               = 0x1008ff49  /* launch application          */
xf86launcha               = 0x1008ff4a  /* launch application          */
xf86launchb               = 0x1008ff4b  /* launch application          */
xf86launchc               = 0x1008ff4c  /* launch application          */
xf86launchd               = 0x1008ff4d  /* launch application          */
xf86launche               = 0x1008ff4e  /* launch application          */
xf86launchf               = 0x1008ff4f  /* launch application          */

xf86applicationleft       = 0x1008ff50  /* switch to application, left */
xf86applicationright      = 0x1008ff51  /* switch to application, right*/
xf86book                  = 0x1008ff52  /* launch bookreader           */
xf86cd                    = 0x1008ff53  /* launch cd/dvd player        */
xf86calculater            = 0x1008ff54  /* launch calculater           */
xf86clear                 = 0x1008ff55  /* clear window, screen        */
xf86close                 = 0x1008ff56  /* close window                */
xf86copy                  = 0x1008ff57  /* copy selection              */
xf86cut                   = 0x1008ff58  /* cut selection               */
xf86display               = 0x1008ff59  /* output switch key           */
xf86dos                   = 0x1008ff5a  /* launch dos (emulation)      */
xf86documents             = 0x1008ff5b  /* open documents window       */
xf86excel                 = 0x1008ff5c  /* launch spread sheet         */
xf86explorer              = 0x1008ff5d  /* launch file explorer        */
xf86game                  = 0x1008ff5e  /* launch game                 */
xf86go                    = 0x1008ff5f  /* go to url                   */
xf86itouch                = 0x1008ff60  /* logitech itouch- don't use  */
xf86logoff                = 0x1008ff61  /* log off system              */
xf86market                = 0x1008ff62  /* ??                          */
xf86meeting               = 0x1008ff63  /* enter meeting in calendar   */
xf86menukb                = 0x1008ff65  /* distinguish keyboard from pb */
xf86menupb                = 0x1008ff66  /* distinguish pb from keyboard */
xf86mysites               = 0x1008ff67  /* favourites                  */
xf86new                   = 0x1008ff68  /* new (folder, document...    */
xf86news                  = 0x1008ff69  /* news                        */
xf86officehome            = 0x1008ff6a  /* office home (old staroffice)*/
xf86open                  = 0x1008ff6b  /* open                        */
xf86option                = 0x1008ff6c  /* ?? */
xf86paste                 = 0x1008ff6d  /* paste                       */
xf86phone                 = 0x1008ff6e  /* launch phone; dial number   */
xf86q                     = 0x1008ff70  /* compaq's q - don't use      */
xf86reply                 = 0x1008ff72  /* reply e.g., mail            */
xf86reload                = 0x1008ff73  /* reload web page, file, etc. */
xf86rotatewindows         = 0x1008ff74  /* rotate windows e.g. xrandr  */
xf86rotationpb            = 0x1008ff75  /* don't use                   */
xf86rotationkb            = 0x1008ff76  /* don't use                   */
xf86save                  = 0x1008ff77  /* save (file, document, state */
xf86scrollup              = 0x1008ff78  /* scroll window/contents up   */
xf86scrolldown            = 0x1008ff79  /* scrool window/contentd down */
xf86scrollclick           = 0x1008ff7a  /* use xkb mousekeys instead   */
xf86send                  = 0x1008ff7b  /* send mail, file, object     */
xf86spell                 = 0x1008ff7c  /* spell checker               */
xf86splitscreen           = 0x1008ff7d  /* split window or screen      */
xf86support               = 0x1008ff7e  /* get support (??)            */
xf86taskpane              = 0x1008ff7f  /* show tasks */
xf86terminal              = 0x1008ff80  /* launch terminal emulator    */
xf86tools                 = 0x1008ff81  /* toolbox of desktop/app.     */
xf86travel                = 0x1008ff82  /* ?? */
xf86userpb                = 0x1008ff84  /* ?? */
xf86user1kb               = 0x1008ff85  /* ?? */
xf86user2kb               = 0x1008ff86  /* ?? */
xf86video                 = 0x1008ff87  /* launch video player       */
xf86wheelbutton           = 0x1008ff88  /* button from a mouse wheel */
xf86word                  = 0x1008ff89  /* launch word processor     */
xf86xfer                  = 0x1008ff8a
xf86zoomin                = 0x1008ff8b  /* zoom in view, map, etc.   */
xf86zoomout               = 0x1008ff8c  /* zoom out view, map, etc.  */

xf86away                  = 0x1008ff8d  /* mark yourself as away     */
xf86messenger             = 0x1008ff8e  /* as in instant messaging   */
xf86webcam                = 0x1008ff8f  /* launch web camera app.    */
xf86mailforward           = 0x1008ff90  /* forward in mail           */
xf86pictures              = 0x1008ff91  /* show pictures             */
xf86music                 = 0x1008ff92  /* launch music application  */

xf86battery               = 0x1008ff93  /* display battery information */
xf86bluetooth             = 0x1008ff94  /* enable/disable bluetooth    */
xf86wlan                  = 0x1008ff95  /* enable/disable wlan         */
xf86uwb                   = 0x1008ff96  /* enable/disable uwb	    */

xf86audioforward          = 0x1008ff97  /* fast-forward audio track    */
xf86audiorepeat           = 0x1008ff98  /* toggle repeat mode          */
xf86audiorandomplay       = 0x1008ff99  /* toggle shuffle mode         */
xf86subtitle              = 0x1008ff9a  /* cycle through subtitle      */
xf86audiocycletrack       = 0x1008ff9b  /* cycle through audio tracks  */
xf86cycleangle            = 0x1008ff9c  /* cycle through angles        */
xf86frameback             = 0x1008ff9d  /* video: go one frame back    */
xf86frameforward          = 0x1008ff9e  /* video: go one frame forward */
xf86time                  = 0x1008ff9f  /* display, or shows an entry for time seeking */
xf86select                = 0x1008ffa0  /* select button on joypads and remotes */
xf86view                  = 0x1008ffa1  /* show a view options/properties */
xf86topmenu               = 0x1008ffa2  /* go to a top-level menu in a video */

xf86red                   = 0x1008ffa3  /* red button                  */
xf86green                 = 0x1008ffa4  /* green button                */
xf86yellow                = 0x1008ffa5  /* yellow button               */
xf86blue                  = 0x1008ffa6  /* blue button                 */

xf86suspend               = 0x1008ffa7  /* sleep to ram                */
xf86hibernate             = 0x1008ffa8  /* sleep to disk               */
xf86touchpadtoggle        = 0x1008ffa9  /* toggle between touchpad/trackstick */
xf86touchpadon            = 0x1008ffb0  /* the touchpad got switched on */
xf86touchpadoff           = 0x1008ffb1  /* the touchpad got switched off */

xf86audiomicmute          = 0x1008ffb2  /* mute the mic from the system */

xf86keyboard              = 0x1008ffb3  /* user defined keyboard related action */

xf86wwan                  = 0x1008ffb4  /* toggle wwan (lte, umts, etc.) radio */
xf86rfkill                = 0x1008ffb5  /* toggle radios on/off */

xf86audiopreset           = 0x1008ffb6  /* select equalizer preset, e.g. theatre-mode */

xf86rotationlocktoggle    = 0x1008ffb7  /* toggle screen rotation lock on/off */

xf86fullscreen            = 0x1008ffb8  /* toggle fullscreen */

/* keys for special action keys (hot keys) */
/* virtual terminals on some operating systems */
xf86switch_vt_1           = 0x1008fe01
xf86switch_vt_2           = 0x1008fe02
xf86switch_vt_3           = 0x1008fe03
xf86switch_vt_4           = 0x1008fe04
xf86switch_vt_5           = 0x1008fe05
xf86switch_vt_6           = 0x1008fe06
xf86switch_vt_7           = 0x1008fe07
xf86switch_vt_8           = 0x1008fe08
xf86switch_vt_9           = 0x1008fe09
xf86switch_vt_10          = 0x1008fe0a
xf86switch_vt_11          = 0x1008fe0b
xf86switch_vt_12          = 0x1008fe0c

xf86ungrab                = 0x1008fe20  /* force ungrab               */
xf86cleargrab             = 0x1008fe21  /* kill application with grab */
xf86next_vmode            = 0x1008fe22  /* next video mode available  */
xf86prev_vmode            = 0x1008fe23  /* prev. video mode available */
xf86logwindowtree         = 0x1008fe24  /* print window tree to log   */
xf86loggrabinfo           = 0x1008fe25  /* print all active grabs to log */


/*
 * reserved range for evdev symbols: = 0x10081000-0x10081fff
 *
 * key symbols within this range are intended for a 1:1 mapping to the
 * linux kernel input-event-codes.h file:
 * - keysym value: `_evdevk(kernel value)`
 * - keysym name: it must be prefixed by `xf86`. the recommended *default*
 *   name uses the following pattern: `xf86camelcasekernelname`. camelcasing
 *   is done with a human control as last authority, e.g. see vod instead of vod
 *   for the video on demand key. in case that the kernel key name is too
 *   ambiguous, it is recommended to create a more explicit name with the
 *   following guidelines:
 *   1. names should be mnemonic.
 *   2. names should avoid acronyms, unless sufficiently common and documented
 *      in a comment.
 *   3. names should identify a function.
 *   4. keysyms share a common namespace, so keys with a generic name should
 *      denote a generic function, otherwise it should be renamed to add context.
 *      e.g. `key_ok` has the associated keysym `xf86ok`, while `key_title`
 *      (used to open a menu to select a chapter of a media) is associated to
 *      the keysym `xf86mediatitlemenu` to avoid ambiguity.
 *   5. keysyms should support designing *portable* applications, therefore
 *      their names should be self-explaining to facilitate finding them and
 *      to avoid misuse.
 *   6. the “hid usage tables for usb” can be used if there is an unambiguous
 *      mapping. see:
 *      - reference document: https://usb.org/document-library/hid-usage-tables-16
 *      - mapping in the linux source file: `drivers/hid/hid-input.c` as of 2025-07
 *
 * for example, the kernel
 *     key_macro_record_start	= 0x2b0
 * effectively ends up as:
 *     xf86macrorecordstart	= 0x100812b0
 *
 * for historical reasons, some keysyms within the reserved range will be
 * missing, most notably all "normal" keys that are mapped through default
 * xkb layouts (e.g. key_q).
 *
 * the format for #defines is strict:
 *
 *     xf86foo<spaces…>_evdevk(= 0xabc)<spaces…> |* kver key_foo *|
 *     xf86foo<spaces…>_evdevk(= 0xabc)<spaces…> |* alias for xf86bar *|
 *     xf86foo<spaces…>_evdevk(= 0xabc)<spaces…> |* deprecated alias for xf86bar *|
 *
 * where
 * - alignment by spaces
 * - the _evdevk macro must be used
 * - the hex code must be in uppercase hex
 * - the kernel version (kver) is in the form v5.10
 * - kver and key name are within a slash-star comment (a pipe is used in
 *   this example for technical reasons)
 * these #defines are parsed by scripts. do not stray from the given format.
 *
 * where the evdev keycode is mapped to a different symbol, please add a
 * comment line starting with use: but otherwise the same format, e.g.
 *  use: xf86rotationlocktoggle	_evdevk(= 0x231)		   v4.16 key_rotate_lock_toggle
 *
 */
/* use: xf86eject                    _evdevk(= 0x0a2)             key_ejectclosecd */
/* use: xf86new                      _evdevk(= 0x0b5)     v2.6.14 key_new */
/* use: redo                         _evdevk(= 0x0b6)     v2.6.14 key_redo */
/* key_dashboard has been mapped to launchb in xkeyboard-config since 2011 */
/* use: xf86launchb                  _evdevk(= 0x0cc)     v2.6.28 key_dashboard */
/* use: xf86display                  _evdevk(= 0x0e3)     v2.6.12 key_switchvideomode */
/* use: xf86kbdlightonoff            _evdevk(= 0x0e4)     v2.6.12 key_kbdillumtoggle */
/* use: xf86kbdbrightnessdown        _evdevk(= 0x0e5)     v2.6.12 key_kbdillumdown */
/* use: xf86kbdbrightnessup          _evdevk(= 0x0e6)     v2.6.12 key_kbdillumup */
/* use: xf86send                     _evdevk(= 0x0e7)     v2.6.14 key_send */
/* use: xf86reply                    _evdevk(= 0x0e8)     v2.6.14 key_reply */
/* use: xf86mailforward              _evdevk(= 0x0e9)     v2.6.14 key_forwardmail */
/* use: xf86save                     _evdevk(= 0x0ea)     v2.6.14 key_save */
/* use: xf86documents                _evdevk(= 0x0eb)     v2.6.14 key_documents */
/* use: xf86battery                  _evdevk(= 0x0ec)     v2.6.17 key_battery */
/* use: xf86bluetooth                _evdevk(= 0x0ed)     v2.6.19 key_bluetooth */
/* use: xf86wlan                     _evdevk(= 0x0ee)     v2.6.19 key_wlan */
/* use: xf86uwb                      _evdevk(= 0x0ef)     v2.6.24 key_uwb */
/* use: xf86next_vmode               _evdevk(= 0x0f1)     v2.6.23 key_video_next */
/* use: xf86prev_vmode               _evdevk(= 0x0f2)     v2.6.23 key_video_prev */
/* use: xf86monbrightnesscycle       _evdevk(= 0x0f3)     v2.6.23 key_brightness_cycle */
xf86brightnessauto           = 0x100810f4      /* v3.16   key_brightness_auto */
xf86displayoff               = 0x100810f5      /* v2.6.23 key_display_off */
/* use: xf86wwan                     _evdevk(= 0x0f6)     v3.13   key_wwan */
/* use: xf86rfkill                   _evdevk(= 0x0f7)     v2.6.33 key_rfkill */
/* use: xf86audiomicmute             _evdevk(= 0x0f8)     v3.1    key_micmute */
xf86ok                       = 0x10081160      /* v2.5.26 key_ok */
/* use: xf86select                   _evdevk(= 0x161)     v2.5.26 key_select */
xf86goto                     = 0x10081162      /* v2.5.26 key_goto */
/* use: xf86clear                    _evdevk(= 0x163)     v2.5.26 key_clear */
/* todo: unclear function                    _evdevk(= 0x164)     v2.5.26 key_power2 */
/* use: xf86option                   _evdevk(= 0x165)     v2.5.26 key_option */
xf86info                     = 0x10081166      /* v2.5.26 key_info */
/* use: xf86time                     _evdevk(= 0x167)     v2.5.26 key_time */
xf86vendorlogo               = 0x10081168      /* v2.5.26 key_vendor */
/* todo: unclear function                    _evdevk(= 0x169)     v2.5.26 key_archive */
xf86mediaselectprogramguide  = 0x1008116a      /* v2.5.26 key_program */
/* use: xf86nextfavorite             _evdevk(= 0x16b)     v2.5.26 key_channel */
/* use: xf86favorites                _evdevk(= 0x16c)     v2.5.26 key_favorites */
/* use: xf86mediaselectprogramguide  _evdevk(= 0x16d)     v2.5.26 key_epg */
xf86mediaselecthome          = 0x1008116e      /* v2.5.26 key_pvr */
/* todo: multimedia home platform            _evdevk(= 0x16f)     v2.5.26 key_mhp */
xf86medialanguagemenu        = 0x10081170      /* v2.5.26 key_language */
xf86mediatitlemenu           = 0x10081171      /* v2.5.26 key_title */
/* use: xf86subtitle                 _evdevk(= 0x172)     v2.5.26 key_subtitle */
/* use: xf86cycleangle               _evdevk(= 0x173)     v2.5.26 key_angle */
/* use: xf86fullscreen               _evdevk(= 0x174)     v5.1    key_full_screen */
xf86audiochannelmode         = 0x10081175      /* v2.5.26 key_mode */
/* use: xf86keyboard                 _evdevk(= 0x176)     v2.5.26 key_keyboard */
xf86aspectratio              = 0x10081177      /* v5.1    key_aspect_ratio */
xf86mediaselectpc            = 0x10081178      /* v2.5.26 key_pc */
xf86mediaselecttv            = 0x10081179      /* v2.5.26 key_tv */
xf86mediaselectcable         = 0x1008117a      /* v2.5.26 key_tv2 */
xf86mediaselectvcr           = 0x1008117b      /* v2.5.26 key_vcr */
xf86mediaselectvcrplus       = 0x1008117c      /* v2.5.26 key_vcr2 */
xf86mediaselectsatellite     = 0x1008117d      /* v2.5.26 key_sat */
/* todo: unclear media selector              _evdevk(= 0x17e)     v2.5.26 key_sat2 */
/* use: xf86mediaselectcd            _evdevk(= 0x17f)     v2.5.26 key_cd */
xf86mediaselecttape          = 0x10081180      /* v2.5.26 key_tape */
xf86mediaselectradio         = 0x10081181      /* v2.5.26 key_radio */
xf86mediaselecttuner         = 0x10081182      /* v2.5.26 key_tuner */
xf86mediaplayer              = 0x10081183      /* v2.5.26 key_player */
xf86mediaselectteletext      = 0x10081184      /* v2.5.26 key_text */
xf86dvd                      = 0x10081185      /* v2.5.26 key_dvd */
xf86mediaselectauxiliary     = 0x10081186      /* v2.5.26 key_aux */
/* todo: unclear media selector              _evdevk(= 0x187)     v2.5.26 key_mp3 */
xf86audio                    = 0x10081188      /* v2.5.26 key_audio */
/* use: xf86video                    _evdevk(= 0x189)     v2.5.26 key_video */
/* todo: unclear function                    _evdevk(= 0x18a)     v2.5.26 key_directory */
/* todo: unclear function                    _evdevk(= 0x18b)     v2.5.26 key_list */
/* use: xf86memo                     _evdevk(= 0x18c)     v2.5.26 key_memo */
/* use: xf86calendar                 _evdevk(= 0x18d)     v2.5.26 key_calendar */
/* use: xf86red                      _evdevk(= 0x18e)     v2.5.26 key_red */
/* use: xf86green                    _evdevk(= 0x18f)     v2.5.26 key_green */
/* use: xf86yellow                   _evdevk(= 0x190)     v2.5.26 key_yellow */
/* use: xf86blue                     _evdevk(= 0x191)     v2.5.26 key_blue */
xf86channelup                = 0x10081192      /* v2.5.26 key_channelup */
xf86channeldown              = 0x10081193      /* v2.5.26 key_channeldown */
/* todo: unclear function                    _evdevk(= 0x194)     v2.5.26 key_first */
/* todo: unclear function                    _evdevk(= 0x195)     v2.5.26 key_last */
/* todo: unclear function                    _evdevk(= 0x196)     v2.5.26 key_ab */
/* todo: unclear function                    _evdevk(= 0x197)     v2.5.26 key_next */
/* todo: unclear function                    _evdevk(= 0x198)     v2.5.26 key_restart */
xf86mediaplayslow            = 0x10081199      /* v2.5.26 key_slow */
/* use: xf86audiorandomplay          _evdevk(= 0x19a)     v2.5.26 key_shuffle */
xf86break                    = 0x1008119b      /* v2.5.26 key_break */
/* todo: unclear function                    _evdevk(= 0x19c)     v2.5.26 key_previous */
xf86numberentrymode          = 0x1008119d      /* v2.5.26 key_digits */
/* todo: unclear function                    _evdevk(= 0x19e)     v2.5.26 key_teen */
/* todo: unclear function (twenties?)        _evdevk(= 0x19f)     v2.5.26 key_twen */
xf86videophone               = 0x100811a0      /* v2.6.20 key_videophone */
/* use: xf86game                     _evdevk(= 0x1a1)     v2.6.20 key_games */
/* use: xf86zoomin                   _evdevk(= 0x1a2)     v2.6.20 key_zoomin */
/* use: xf86zoomout                  _evdevk(= 0x1a3)     v2.6.20 key_zoomout */
xf86zoomreset                = 0x100811a4      /* v2.6.20 key_zoomreset */
/* use: xf86word                     _evdevk(= 0x1a5)     v2.6.20 key_wordprocessor */
xf86editor                   = 0x100811a6      /* v2.6.20 key_editor */
/* use: xf86excel                    _evdevk(= 0x1a7)     v2.6.20 key_spreadsheet */
xf86graphicseditor           = 0x100811a8      /* v2.6.20 key_graphicseditor */
xf86presentation             = 0x100811a9      /* v2.6.20 key_presentation */
xf86database                 = 0x100811aa      /* v2.6.20 key_database */
/* use: xf86news                     _evdevk(= 0x1ab)     v2.6.20 key_news */
xf86voicemail                = 0x100811ac      /* v2.6.20 key_voicemail */
xf86addressbook              = 0x100811ad      /* v2.6.20 key_addressbook */
/* use: xf86messenger                _evdevk(= 0x1ae)     v2.6.20 key_messenger */
xf86displaytoggle            = 0x100811af      /* v2.6.20 key_displaytoggle */
xf86spellcheck               = 0x100811b0      /* v2.6.24 key_spellcheck */
/* use: xf86logoff                   _evdevk(= 0x1b1)     v2.6.24 key_logoff */
/* use: dollar                       _evdevk(= 0x1b2)     v2.6.24 key_dollar */
/* use: eurosign                     _evdevk(= 0x1b3)     v2.6.24 key_euro */
/* use: xf86frameback                _evdevk(= 0x1b4)     v2.6.24 key_frameback */
/* use: xf86frameforward             _evdevk(= 0x1b5)     v2.6.24 key_frameforward */
xf86contextmenu              = 0x100811b6      /* v2.6.24 key_context_menu */
xf86mediarepeat              = 0x100811b7      /* v2.6.26 key_media_repeat */
xf8610channelsup             = 0x100811b8      /* v2.6.38 key_10channelsup */
xf8610channelsdown           = 0x100811b9      /* v2.6.38 key_10channelsdown */
xf86images                   = 0x100811ba      /* v2.6.39 key_images */
xf86notificationcenter       = 0x100811bc      /* v5.10   key_notification_center */
xf86pickupphone              = 0x100811bd      /* v5.10   key_pickup_phone */
xf86hangupphone              = 0x100811be      /* v5.10   key_hangup_phone */
xf86fn                       = 0x100811d0      /*         key_fn */
xf86fn_esc                   = 0x100811d1      /*         key_fn_esc */
xf86fnrightshift             = 0x100811e5      /* v5.10   key_fn_right_shift */
/* use: braille_dot_1                _evdevk(= 0x1f1)     v2.6.17 key_brl_dot1 */
/* use: braille_dot_2                _evdevk(= 0x1f2)     v2.6.17 key_brl_dot2 */
/* use: braille_dot_3                _evdevk(= 0x1f3)     v2.6.17 key_brl_dot3 */
/* use: braille_dot_4                _evdevk(= 0x1f4)     v2.6.17 key_brl_dot4 */
/* use: braille_dot_5                _evdevk(= 0x1f5)     v2.6.17 key_brl_dot5 */
/* use: braille_dot_6                _evdevk(= 0x1f6)     v2.6.17 key_brl_dot6 */
/* use: braille_dot_7                _evdevk(= 0x1f7)     v2.6.17 key_brl_dot7 */
/* use: braille_dot_8                _evdevk(= 0x1f8)     v2.6.17 key_brl_dot8 */
/* use: braille_dot_9                _evdevk(= 0x1f9)     v2.6.23 key_brl_dot9 */
/* use: braille_dot_1                _evdevk(= 0x1fa)     v2.6.23 key_brl_dot10 */
xf86numeric0                 = 0x10081200      /* v2.6.28 key_numeric_0 */
xf86numeric1                 = 0x10081201      /* v2.6.28 key_numeric_1 */
xf86numeric2                 = 0x10081202      /* v2.6.28 key_numeric_2 */
xf86numeric3                 = 0x10081203      /* v2.6.28 key_numeric_3 */
xf86numeric4                 = 0x10081204      /* v2.6.28 key_numeric_4 */
xf86numeric5                 = 0x10081205      /* v2.6.28 key_numeric_5 */
xf86numeric6                 = 0x10081206      /* v2.6.28 key_numeric_6 */
xf86numeric7                 = 0x10081207      /* v2.6.28 key_numeric_7 */
xf86numeric8                 = 0x10081208      /* v2.6.28 key_numeric_8 */
xf86numeric9                 = 0x10081209      /* v2.6.28 key_numeric_9 */
xf86numericstar              = 0x1008120a      /* v2.6.28 key_numeric_star */
xf86numericpound             = 0x1008120b      /* v2.6.28 key_numeric_pound */
xf86numerica                 = 0x1008120c      /* v4.1    key_numeric_a */
xf86numericb                 = 0x1008120d      /* v4.1    key_numeric_b */
xf86numericc                 = 0x1008120e      /* v4.1    key_numeric_c */
xf86numericd                 = 0x1008120f      /* v4.1    key_numeric_d */
xf86camerafocus              = 0x10081210      /* v2.6.33 key_camera_focus */
xf86wpsbutton                = 0x10081211      /* v2.6.34 key_wps_button */
/* use: xf86touchpadtoggle           _evdevk(= 0x212)     v2.6.37 key_touchpad_toggle */
/* use: xf86touchpadon               _evdevk(= 0x213)     v2.6.37 key_touchpad_on */
/* use: xf86touchpadoff              _evdevk(= 0x214)     v2.6.37 key_touchpad_off */
xf86camerazoomin             = 0x10081215      /* v2.6.39 key_camera_zoomin */
xf86camerazoomout            = 0x10081216      /* v2.6.39 key_camera_zoomout */
xf86cameraup                 = 0x10081217      /* v2.6.39 key_camera_up */
xf86cameradown               = 0x10081218      /* v2.6.39 key_camera_down */
xf86cameraleft               = 0x10081219      /* v2.6.39 key_camera_left */
xf86cameraright              = 0x1008121a      /* v2.6.39 key_camera_right */
xf86attendanton              = 0x1008121b      /* v3.10   key_attendant_on */
xf86attendantoff             = 0x1008121c      /* v3.10   key_attendant_off */
xf86attendanttoggle          = 0x1008121d      /* v3.10   key_attendant_toggle */
xf86lightstoggle             = 0x1008121e      /* v3.10   key_lights_toggle */
xf86alstoggle                = 0x10081230      /* v3.13   key_als_toggle */
/* use: xf86rotationlocktoggle       _evdevk(= 0x231)     v4.16   key_rotate_lock_toggle */
xf86refreshratetoggle        = 0x10081232      /* v6.9    key_refresh_rate_toggle */
xf86buttonconfig             = 0x10081240      /* v3.16   key_buttonconfig */
xf86taskmanager              = 0x10081241      /* v3.16   key_taskmanager */
xf86journal                  = 0x10081242      /* v3.16   key_journal */
xf86controlpanel             = 0x10081243      /* v3.16   key_controlpanel */
xf86appselect                = 0x10081244      /* v3.16   key_appselect */
xf86screensaver_2              = 0x10081245      /* v3.16   key_screensaver */
xf86voicecommand             = 0x10081246      /* v3.16   key_voicecommand */
xf86assistant                = 0x10081247      /* v4.13   key_assistant */
/* use: iso_next_group               _evdevk(= 0x248)     v5.2    key_kbd_layout_next */
xf86emojipicker              = 0x10081249      /* v5.13   key_emoji_picker */
xf86dictate                  = 0x1008124a      /* v5.17   key_dictate */
xf86cameraaccessenable       = 0x1008124b      /* v6.2    key_camera_access_enable */
xf86cameraaccessdisable      = 0x1008124c      /* v6.2    key_camera_access_disable */
xf86cameraaccesstoggle       = 0x1008124d      /* v6.2    key_camera_access_toggle */
xf86accessibility            = 0x1008124e      /* v6.10   key_accessibility */
xf86donotdisturb             = 0x1008124f      /* v6.10   key_do_not_disturb */
xf86brightnessmin            = 0x10081250      /* v3.16   key_brightness_min */
xf86brightnessmax            = 0x10081251      /* v3.16   key_brightness_max */
xf86kbdinputassistprev       = 0x10081260      /* v3.18   key_kbdinputassist_prev */
xf86kbdinputassistnext       = 0x10081261      /* v3.18   key_kbdinputassist_next */
xf86kbdinputassistprevgroup  = 0x10081262      /* v3.18   key_kbdinputassist_prevgroup */
xf86kbdinputassistnextgroup  = 0x10081263      /* v3.18   key_kbdinputassist_nextgroup */
xf86kbdinputassistaccept     = 0x10081264      /* v3.18   key_kbdinputassist_accept */
xf86kbdinputassistcancel     = 0x10081265      /* v3.18   key_kbdinputassist_cancel */
xf86rightup                  = 0x10081266      /* v4.7    key_right_up */
xf86rightdown                = 0x10081267      /* v4.7    key_right_down */
xf86leftup                   = 0x10081268      /* v4.7    key_left_up */
xf86leftdown                 = 0x10081269      /* v4.7    key_left_down */
xf86rootmenu                 = 0x1008126a      /* v4.7    key_root_menu */
xf86mediatopmenu             = 0x1008126b      /* v4.7    key_media_top_menu */
xf86numeric11                = 0x1008126c      /* v4.7    key_numeric_11 */
xf86numeric12                = 0x1008126d      /* v4.7    key_numeric_12 */
xf86audiodesc                = 0x1008126e      /* v4.7    key_audio_desc */
xf863dmode                   = 0x1008126f      /* v4.7    key_3d_mode */
xf86nextfavorite             = 0x10081270      /* v4.7    key_next_favorite */
xf86stoprecord               = 0x10081271      /* v4.7    key_stop_record */
xf86pauserecord              = 0x10081272      /* v4.7    key_pause_record */
xf86vod                      = 0x10081273      /* v4.7    key_vod */
xf86unmute                   = 0x10081274      /* v4.7    key_unmute */
xf86fastreverse              = 0x10081275      /* v4.7    key_fastreverse */
xf86slowreverse              = 0x10081276      /* v4.7    key_slowreverse */
xf86data                     = 0x10081277      /* v4.7    key_data */
xf86onscreenkeyboard         = 0x10081278      /* v4.12   key_onscreen_keyboard */
xf86privacyscreentoggle      = 0x10081279      /* v5.5    key_privacy_screen_toggle */
xf86selectivescreenshot      = 0x1008127a      /* v5.6    key_selective_screenshot */
xf86nextelement              = 0x1008127b      /* v5.18   key_next_element */
xf86previouselement          = 0x1008127c      /* v5.18   key_previous_element */
xf86autopilotengagetoggle    = 0x1008127d      /* v5.18   key_autopilot_engage_toggle */
xf86markwaypoint             = 0x1008127e      /* v5.18   key_mark_waypoint */
xf86sos                      = 0x1008127f      /* v5.18   key_sos */
xf86navchart                 = 0x10081280      /* v5.18   key_nav_chart */
xf86fishingchart             = 0x10081281      /* v5.18   key_fishing_chart */
xf86singlerangeradar         = 0x10081282      /* v5.18   key_single_range_radar */
xf86dualrangeradar           = 0x10081283      /* v5.18   key_dual_range_radar */
xf86radaroverlay             = 0x10081284      /* v5.18   key_radar_overlay */
xf86traditionalsonar         = 0x10081285      /* v5.18   key_traditional_sonar */
xf86clearvusonar             = 0x10081286      /* v5.18   key_clearvu_sonar */
xf86sidevusonar              = 0x10081287      /* v5.18   key_sidevu_sonar */
xf86navinfo                  = 0x10081288      /* v5.18   key_nav_info */
/* use: xf86brightnessadjust         _evdevk(= 0x289)     v5.18   key_brightness_menu */
xf86macro1                   = 0x10081290      /* v5.5    key_macro1 */
xf86macro2                   = 0x10081291      /* v5.5    key_macro2 */
xf86macro3                   = 0x10081292      /* v5.5    key_macro3 */
xf86macro4                   = 0x10081293      /* v5.5    key_macro4 */
xf86macro5                   = 0x10081294      /* v5.5    key_macro5 */
xf86macro6                   = 0x10081295      /* v5.5    key_macro6 */
xf86macro7                   = 0x10081296      /* v5.5    key_macro7 */
xf86macro8                   = 0x10081297      /* v5.5    key_macro8 */
xf86macro9                   = 0x10081298      /* v5.5    key_macro9 */
xf86macro10                  = 0x10081299      /* v5.5    key_macro10 */
xf86macro11                  = 0x1008129a      /* v5.5    key_macro11 */
xf86macro12                  = 0x1008129b      /* v5.5    key_macro12 */
xf86macro13                  = 0x1008129c      /* v5.5    key_macro13 */
xf86macro14                  = 0x1008129d      /* v5.5    key_macro14 */
xf86macro15                  = 0x1008129e      /* v5.5    key_macro15 */
xf86macro16                  = 0x1008129f      /* v5.5    key_macro16 */
xf86macro17                  = 0x100812a0      /* v5.5    key_macro17 */
xf86macro18                  = 0x100812a1      /* v5.5    key_macro18 */
xf86macro19                  = 0x100812a2      /* v5.5    key_macro19 */
xf86macro20                  = 0x100812a3      /* v5.5    key_macro20 */
xf86macro21                  = 0x100812a4      /* v5.5    key_macro21 */
xf86macro22                  = 0x100812a5      /* v5.5    key_macro22 */
xf86macro23                  = 0x100812a6      /* v5.5    key_macro23 */
xf86macro24                  = 0x100812a7      /* v5.5    key_macro24 */
xf86macro25                  = 0x100812a8      /* v5.5    key_macro25 */
xf86macro26                  = 0x100812a9      /* v5.5    key_macro26 */
xf86macro27                  = 0x100812aa      /* v5.5    key_macro27 */
xf86macro28                  = 0x100812ab      /* v5.5    key_macro28 */
xf86macro29                  = 0x100812ac      /* v5.5    key_macro29 */
xf86macro30                  = 0x100812ad      /* v5.5    key_macro30 */
xf86macrorecordstart         = 0x100812b0      /* v5.5    key_macro_record_start */
xf86macrorecordstop          = 0x100812b1      /* v5.5    key_macro_record_stop */
xf86macropresetcycle         = 0x100812b2      /* v5.5    key_macro_preset_cycle */
xf86macropreset1             = 0x100812b3      /* v5.5    key_macro_preset1 */
xf86macropreset2             = 0x100812b4      /* v5.5    key_macro_preset2 */
xf86macropreset3             = 0x100812b5      /* v5.5    key_macro_preset3 */
xf86kbdlcdmenu1              = 0x100812b8      /* v5.5    key_kbd_lcd_menu1 */
xf86kbdlcdmenu2              = 0x100812b9      /* v5.5    key_kbd_lcd_menu2 */
xf86kbdlcdmenu3              = 0x100812ba      /* v5.5    key_kbd_lcd_menu3 */
xf86kbdlcdmenu4              = 0x100812bb      /* v5.5    key_kbd_lcd_menu4 */
xf86kbdlcdmenu5              = 0x100812bc      /* v5.5    key_kbd_lcd_menu5 */
/*
 * copyright (c) 1991, oracle and/or its affiliates.
 *
 * permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "software"),
 * to deal in the software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the software, and to permit persons to whom the
 * software is furnished to do so, subject to the following conditions:
 *
 * the above copyright notice and this permission notice (including the next
 * paragraph) shall be included in all copies or substantial portions of the
 * software.
 *
 * the software is provided "as is", without warranty of any kind, express or
 * implied, including but not limited to the warranties of merchantability,
 * fitness for a particular purpose and noninfringement.  in no event shall
 * the authors or copyright holders be liable for any claim, damages or other
 * liability, whether in an action of contract, tort or otherwise, arising
 * from, out of or in connection with the software or the use or other
 * dealings in the software.
 */
/************************************************************

copyright 1991, 1998  the open group

permission to use, copy, modify, distribute, and sell this software and its
documentation for any purpose is hereby granted without fee, provided that
the above copyright notice appear in all copies and that both that
copyright notice and this permission notice appear in supporting
documentation.

the above copyright notice and this permission notice shall be included in
all copies or substantial portions of the software.

the software is provided "as is", without warranty of any kind, express or
implied, including but not limited to the warranties of merchantability,
fitness for a particular purpose and noninfringement.  in no event shall the
open group be liable for any claim, damages or other liability, whether in
an action of contract, tort or otherwise, arising from, out of or in
connection with the software or the use or other dealings in the software.

except as contained in this notice, the name of the open group shall not be
used in advertising or otherwise to promote the sale, use or other dealings
in this software without prior written authorization from the open group.

***********************************************************/

/*
 * floating accent
 */

sunfa_grave               = 0x1005ff00
sunfa_circum              = 0x1005ff01
sunfa_tilde               = 0x1005ff02
sunfa_acute               = 0x1005ff03
sunfa_diaeresis           = 0x1005ff04
sunfa_cedilla             = 0x1005ff05

/*
 * miscellaneous functions
 */

sunf36                    = 0x1005ff10  /* labeled f11 */
sunf37                    = 0x1005ff11  /* labeled f12 */

sunsys_req                = 0x1005ff60

/*
 * open look functions
 */

sunprops                  = 0x1005ff70
sunfront                  = 0x1005ff71
suncopy                   = 0x1005ff72
sunopen                   = 0x1005ff73
sunpaste                  = 0x1005ff74
suncut                    = 0x1005ff75

sunpowerswitch            = 0x1005ff76
sunaudiolowervolume       = 0x1005ff77
sunaudiomute              = 0x1005ff78
sunaudioraisevolume       = 0x1005ff79
sunvideodegauss           = 0x1005ff7a
sunvideolowerbrightness   = 0x1005ff7b
sunvideoraisebrightness   = 0x1005ff7c
sunpowerswitchshift       = 0x1005ff7d
/***********************************************************

copyright 1988, 1998  the open group

permission to use, copy, modify, distribute, and sell this software and its
documentation for any purpose is hereby granted without fee, provided that
the above copyright notice appear in all copies and that both that
copyright notice and this permission notice appear in supporting
documentation.

the above copyright notice and this permission notice shall be included in
all copies or substantial portions of the software.

the software is provided "as is", without warranty of any kind, express or
implied, including but not limited to the warranties of merchantability,
fitness for a particular purpose and noninfringement.  in no event shall the
open group be liable for any claim, damages or other liability, whether in
an action of contract, tort or otherwise, arising from, out of or in
connection with the software or the use or other dealings in the software.

except as contained in this notice, the name of the open group shall not be
used in advertising or otherwise to promote the sale, use or other dealings
in this software without prior written authorization from the open group.


copyright 1988 by digital equipment corporation, maynard, massachusetts.

                        all rights reserved

permission to use, copy, modify, and distribute this software and its
documentation for any purpose and without fee is hereby granted,
provided that the above copyright notice appear in all copies and that
both that copyright notice and this permission notice appear in
supporting documentation, and that the name of digital not be
used in advertising or publicity pertaining to distribution of the
software without specific, written prior permission.

digital disclaims all warranties with regard to this software, including
all implied warranties of merchantability and fitness, in no event shall
digital be liable for any special, indirect or consequential damages or
any damages whatsoever resulting from loss of use, data or profits,
whether in an action of contract, negligence or other tortious action,
arising out of or in connection with the use or performance of this
software.

******************************************************************/

/*
 * dec private keysyms
 * (29th bit set)
 */

/* two-key compose sequence initiators, chosen to map to latin1 characters */

dring_accent              = 0x1000feb0
dcircumflex_accent        = 0x1000fe5e
dcedilla_accent           = 0x1000fe2c
dacute_accent             = 0x1000fe27
dgrave_accent             = 0x1000fe60
dtilde                    = 0x1000fe7e
ddiaeresis                = 0x1000fe22

/* special keysym for lk2** "remove" key on editing keypad */

dremove                   = 0x1000ff00  /* remove */
/*

copyright 1987, 1998  the open group

permission to use, copy, modify, distribute, and sell this software and its
documentation for any purpose is hereby granted without fee, provided that
the above copyright notice appear in all copies and that both that
copyright notice and this permission notice appear in supporting
documentation.

the above copyright notice and this permission notice shall be included
in all copies or substantial portions of the software.

the software is provided "as is", without warranty of any kind, express
or implied, including but not limited to the warranties of
merchantability, fitness for a particular purpose and noninfringement.
in no event shall the open group be liable for any claim, damages or
other liability, whether in an action of contract, tort or otherwise,
arising from, out of or in connection with the software or the use or
other dealings in the software.

except as contained in this notice, the name of the open group shall
not be used in advertising or otherwise to promote the sale, use or
other dealings in this software without prior written authorization
from the open group.

copyright 1987 by digital equipment corporation, maynard, massachusetts,

                        all rights reserved

permission to use, copy, modify, and distribute this software and its
documentation for any purpose and without fee is hereby granted,
provided that the above copyright notice appear in all copies and that
both that copyright notice and this permission notice appear in
supporting documentation, and that the names of hewlett packard
or digital not be
used in advertising or publicity pertaining to distribution of the
software without specific, written prior permission.

digital disclaims all warranties with regard to this software, including
all implied warranties of merchantability and fitness, in no event shall
digital be liable for any special, indirect or consequential damages or
any damages whatsoever resulting from loss of use, data or profits,
whether in an action of contract, negligence or other tortious action,
arising out of or in connection with the use or performance of this
software.

hewlett-packard makes no warranty of any kind with regard
to this software, including, but not limited to, the implied
warranties of merchantability and fitness for a particular
purpose.  hewlett-packard shall not be liable for errors
contained herein or direct, indirect, special, incidental or
consequential damages in connection with the furnishing,
performance, or use of this material.

*/



hpclearline               = 0x1000ff6f
hpinsertline              = 0x1000ff70
hpdeleteline              = 0x1000ff71
hpinsertchar              = 0x1000ff72
hpdeletechar              = 0x1000ff73
hpbacktab                 = 0x1000ff74
hpkp_backtab              = 0x1000ff75
hpmodelock1               = 0x1000ff48
hpmodelock2               = 0x1000ff49
hpreset                   = 0x1000ff6c
hpsystem                  = 0x1000ff6d
hpuser                    = 0x1000ff6e
hpmute_acute              = 0x100000a8
hpmute_grave              = 0x100000a9
hpmute_asciicircum        = 0x100000aa
hpmute_diaeresis          = 0x100000ab
hpmute_asciitilde         = 0x100000ac
hplira                    = 0x100000af
hpguilder                 = 0x100000be
hpydiaeresis              = 0x100000ee
hplongminus               = 0x100000f6
hpblock                   = 0x100000fc



osfcopy                   = 0x1004ff02
osfcut                    = 0x1004ff03
osfpaste                  = 0x1004ff04
osfbacktab                = 0x1004ff07
osfbackspace              = 0x1004ff08
osfclear                  = 0x1004ff0b
osfescape                 = 0x1004ff1b
osfaddmode                = 0x1004ff31
osfprimarypaste           = 0x1004ff32
osfquickpaste             = 0x1004ff33
osfpageleft               = 0x1004ff40
osfpageup                 = 0x1004ff41
osfpagedown               = 0x1004ff42
osfpageright              = 0x1004ff43
osfactivate               = 0x1004ff44
osfmenubar                = 0x1004ff45
osfleft                   = 0x1004ff51
osfup                     = 0x1004ff52
osfright                  = 0x1004ff53
osfdown                   = 0x1004ff54
osfendline                = 0x1004ff57
osfbeginline              = 0x1004ff58
osfenddata                = 0x1004ff59
osfbegindata              = 0x1004ff5a
osfprevmenu               = 0x1004ff5b
osfnextmenu               = 0x1004ff5c
osfprevfield              = 0x1004ff5d
osfnextfield              = 0x1004ff5e
osfselect                 = 0x1004ff60
osfinsert                 = 0x1004ff63
osfundo                   = 0x1004ff65
osfmenu                   = 0x1004ff67
osfcancel                 = 0x1004ff69
osfhelp                   = 0x1004ff6a
osfselectall              = 0x1004ff71
osfdeselectall            = 0x1004ff72
osfreselect               = 0x1004ff73
osfextend                 = 0x1004ff74
osfrestore                = 0x1004ff78
osfdelete                 = 0x1004ffff
}
