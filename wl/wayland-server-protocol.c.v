module wl

#pkgconfig wayland-server
#include <wayland-server-protocol.h>

// enums only

pub enum Wl_shm_erreor {
	invalid_format = 0
	invalid_stride = 1
	invalid_fd     = 2
}

pub enum Wl_shm_format {
	/**
	 * 32-bit argb format [31:0] a:r:g:b 8:8:8:8 little endian
	 */
	argb8888             = 0
	/**
	 * 32-bit rgb format [31:0] x:r:g:b 8:8:8:8 little endian
	 */
	xrgb8888             = 1
	/**
	 * 8-bit color index format [7:0] c
	 */
	c8                   = 0x20203843
	/**
	 * 8-bit rgb format [7:0] r:g:b 3:3:2
	 */
	rgb332               = 0x38424752
	/**
	 * 8-bit bgr format [7:0] b:g:r 2:3:3
	 */
	bgr233               = 0x38524742
	/**
	 * 16-bit xrgb format [15:0] x:r:g:b 4:4:4:4 little endian
	 */
	xrgb4444             = 0x32315258
	/**
	 * 16-bit xbgr format [15:0] x:b:g:r 4:4:4:4 little endian
	 */
	xbgr4444             = 0x32314258
	/**
	 * 16-bit rgbx format [15:0] r:g:b:x 4:4:4:4 little endian
	 */
	rgbx4444             = 0x32315852
	/**
	 * 16-bit bgrx format [15:0] b:g:r:x 4:4:4:4 little endian
	 */
	bgrx4444             = 0x32315842
	/**
	 * 16-bit argb format [15:0] a:r:g:b 4:4:4:4 little endian
	 */
	argb4444             = 0x32315241
	/**
	 * 16-bit abgr format [15:0] a:b:g:r 4:4:4:4 little endian
	 */
	abgr4444             = 0x32314241
	/**
	 * 16-bit rbga format [15:0] r:g:b:a 4:4:4:4 little endian
	 */
	rgba4444             = 0x32314152
	/**
	 * 16-bit bgra format [15:0] b:g:r:a 4:4:4:4 little endian
	 */
	bgra4444             = 0x32314142
	/**
	 * 16-bit xrgb format [15:0] x:r:g:b 1:5:5:5 little endian
	 */
	xrgb1555             = 0x35315258
	/**
	 * 16-bit xbgr 1555 format [15:0] x:b:g:r 1:5:5:5 little endian
	 */
	xbgr1555             = 0x35314258
	/**
	 * 16-bit rgbx 5551 format [15:0] r:g:b:x 5:5:5:1 little endian
	 */
	rgbx5551             = 0x35315852
	/**
	 * 16-bit bgrx 5551 format [15:0] b:g:r:x 5:5:5:1 little endian
	 */
	bgrx5551             = 0x35315842
	/**
	 * 16-bit argb 1555 format [15:0] a:r:g:b 1:5:5:5 little endian
	 */
	argb1555             = 0x35315241
	/**
	 * 16-bit abgr 1555 format [15:0] a:b:g:r 1:5:5:5 little endian
	 */
	abgr1555             = 0x35314241
	/**
	 * 16-bit rgba 5551 format [15:0] r:g:b:a 5:5:5:1 little endian
	 */
	rgba5551             = 0x35314152
	/**
	 * 16-bit bgra 5551 format [15:0] b:g:r:a 5:5:5:1 little endian
	 */
	bgra5551             = 0x35314142
	/**
	 * 16-bit rgb 565 format [15:0] r:g:b 5:6:5 little endian
	 */
	rgb565               = 0x36314752
	/**
	 * 16-bit bgr 565 format [15:0] b:g:r 5:6:5 little endian
	 */
	bgr565               = 0x36314742
	/**
	 * 24-bit rgb format [23:0] r:g:b little endian
	 */
	rgb888               = 0x34324752
	/**
	 * 24-bit bgr format [23:0] b:g:r little endian
	 */
	bgr888               = 0x34324742
	/**
	 * 32-bit xbgr format [31:0] x:b:g:r 8:8:8:8 little endian
	 */
	xbgr8888             = 0x34324258
	/**
	 * 32-bit rgbx format [31:0] r:g:b:x 8:8:8:8 little endian
	 */
	rgbx8888             = 0x34325852
	/**
	 * 32-bit bgrx format [31:0] b:g:r:x 8:8:8:8 little endian
	 */
	bgrx8888             = 0x34325842
	/**
	 * 32-bit abgr format [31:0] a:b:g:r 8:8:8:8 little endian
	 */
	abgr8888             = 0x34324241
	/**
	 * 32-bit rgba format [31:0] r:g:b:a 8:8:8:8 little endian
	 */
	rgba8888             = 0x34324152
	/**
	 * 32-bit bgra format [31:0] b:g:r:a 8:8:8:8 little endian
	 */
	bgra8888             = 0x34324142
	/**
	 * 32-bit xrgb format [31:0] x:r:g:b 2:10:10:10 little endian
	 */
	xrgb2101010          = 0x30335258
	/**
	 * 32-bit xbgr format [31:0] x:b:g:r 2:10:10:10 little endian
	 */
	xbgr2101010          = 0x30334258
	/**
	 * 32-bit rgbx format [31:0] r:g:b:x 10:10:10:2 little endian
	 */
	rgbx1010102          = 0x30335852
	/**
	 * 32-bit bgrx format [31:0] b:g:r:x 10:10:10:2 little endian
	 */
	bgrx1010102          = 0x30335842
	/**
	 * 32-bit argb format [31:0] a:r:g:b 2:10:10:10 little endian
	 */
	argb2101010          = 0x30335241
	/**
	 * 32-bit abgr format [31:0] a:b:g:r 2:10:10:10 little endian
	 */
	abgr2101010          = 0x30334241
	/**
	 * 32-bit rgba format [31:0] r:g:b:a 10:10:10:2 little endian
	 */
	rgba1010102          = 0x30334152
	/**
	 * 32-bit bgra format [31:0] b:g:r:a 10:10:10:2 little endian
	 */
	bgra1010102          = 0x30334142
	/**
	 * packed ycbcr format [31:0] cr0:y1:cb0:y0 8:8:8:8 little endian
	 */
	yuyv                 = 0x56595559
	/**
	 * packed ycbcr format [31:0] cb0:y1:cr0:y0 8:8:8:8 little endian
	 */
	yvyu                 = 0x55595659
	/**
	 * packed ycbcr format [31:0] y1:cr0:y0:cb0 8:8:8:8 little endian
	 */
	uyvy                 = 0x59565955
	/**
	 * packed ycbcr format [31:0] y1:cb0:y0:cr0 8:8:8:8 little endian
	 */
	vyuy                 = 0x59555956
	/**
	 * packed aycbcr format [31:0] a:y:cb:cr 8:8:8:8 little endian
	 */
	ayuv                 = 0x56555941
	/**
	 * 2 plane ycbcr cr:cb format 2x2 subsampled cr:cb plane
	 */
	nv12                 = 0x3231564e
	/**
	 * 2 plane ycbcr cb:cr format 2x2 subsampled cb:cr plane
	 */
	nv21                 = 0x3132564e
	/**
	 * 2 plane ycbcr cr:cb format 2x1 subsampled cr:cb plane
	 */
	nv16                 = 0x3631564e
	/**
	 * 2 plane ycbcr cb:cr format 2x1 subsampled cb:cr plane
	 */
	nv61                 = 0x3136564e
	/**
	 * 3 plane ycbcr format 4x4 subsampled cb (1) and cr (2) planes
	 */
	yuv410               = 0x39565559
	/**
	 * 3 plane ycbcr format 4x4 subsampled cr (1) and cb (2) planes
	 */
	yvu410               = 0x39555659
	/**
	 * 3 plane ycbcr format 4x1 subsampled cb (1) and cr (2) planes
	 */
	yuv411               = 0x31315559
	/**
	 * 3 plane ycbcr format 4x1 subsampled cr (1) and cb (2) planes
	 */
	yvu411               = 0x31315659
	/**
	 * 3 plane ycbcr format 2x2 subsampled cb (1) and cr (2) planes
	 */
	yuv420               = 0x32315559
	/**
	 * 3 plane ycbcr format 2x2 subsampled cr (1) and cb (2) planes
	 */
	yvu420               = 0x32315659
	/**
	 * 3 plane ycbcr format 2x1 subsampled cb (1) and cr (2) planes
	 */
	yuv422               = 0x36315559
	/**
	 * 3 plane ycbcr format 2x1 subsampled cr (1) and cb (2) planes
	 */
	yvu422               = 0x36315659
	/**
	 * 3 plane ycbcr format non-subsampled cb (1) and cr (2) planes
	 */
	yuv444               = 0x34325559
	/**
	 * 3 plane ycbcr format non-subsampled cr (1) and cb (2) planes
	 */
	yvu444               = 0x34325659
	/**
	 * [7:0] r
	 */
	r8                   = 0x20203852
	/**
	 * [15:0] r little endian
	 */
	r16                  = 0x20363152
	/**
	 * [15:0] r:g 8:8 little endian
	 */
	rg88                 = 0x38384752
	/**
	 * [15:0] g:r 8:8 little endian
	 */
	gr88                 = 0x38385247
	/**
	 * [31:0] r:g 16:16 little endian
	 */
	rg1616               = 0x32334752
	/**
	 * [31:0] g:r 16:16 little endian
	 */
	gr1616               = 0x32335247
	/**
	 * [63:0] x:r:g:b 16:16:16:16 little endian
	 */
	xrgb16161616f        = 0x48345258
	/**
	 * [63:0] x:b:g:r 16:16:16:16 little endian
	 */
	xbgr16161616f        = 0x48344258
	/**
	 * [63:0] a:r:g:b 16:16:16:16 little endian
	 */
	argb16161616f        = 0x48345241
	/**
	 * [63:0] a:b:g:r 16:16:16:16 little endian
	 */
	abgr16161616f        = 0x48344241
	/**
	 * [31:0] x:y:cb:cr 8:8:8:8 little endian
	 */
	xyuv8888             = 0x56555958
	/**
	 * [23:0] cr:cb:y 8:8:8 little endian
	 */
	vuy888               = 0x34325556
	/**
	 * y followed by u then v 10:10:10. non-linear modifier only
	 */
	vuy101010            = 0x30335556
	/**
	 * [63:0] cr0:0:y1:0:cb0:0:y0:0 10:6:10:6:10:6:10:6 little endian per 2 y pixels
	 */
	y210                 = 0x30313259
	/**
	 * [63:0] cr0:0:y1:0:cb0:0:y0:0 12:4:12:4:12:4:12:4 little endian per 2 y pixels
	 */
	y212                 = 0x32313259
	/**
	 * [63:0] cr0:y1:cb0:y0 16:16:16:16 little endian per 2 y pixels
	 */
	y216                 = 0x36313259
	/**
	 * [31:0] a:cr:y:cb 2:10:10:10 little endian
	 */
	y410                 = 0x30313459
	/**
	 * [63:0] a:0:cr:0:y:0:cb:0 12:4:12:4:12:4:12:4 little endian
	 */
	y412                 = 0x32313459
	/**
	 * [63:0] a:cr:y:cb 16:16:16:16 little endian
	 */
	y416                 = 0x36313459
	/**
	 * [31:0] x:cr:y:cb 2:10:10:10 little endian
	 */
	xvyu2101010          = 0x30335658
	/**
	 * [63:0] x:0:cr:0:y:0:cb:0 12:4:12:4:12:4:12:4 little endian
	 */
	xvyu12_16161616      = 0x36335658
	/**
	 * [63:0] x:cr:y:cb 16:16:16:16 little endian
	 */
	xvyu16161616         = 0x38345658
	/**
	 * [63:0]   a3:a2:y3:0:cr0:0:y2:0:a1:a0:y1:0:cb0:0:y0:0  1:1:8:2:8:2:8:2:1:1:8:2:8:2:8:2 little endian
	 */
	y0l0                 = 0x304c3059
	/**
	 * [63:0]   x3:x2:y3:0:cr0:0:y2:0:x1:x0:y1:0:cb0:0:y0:0  1:1:8:2:8:2:8:2:1:1:8:2:8:2:8:2 little endian
	 */
	x0l0                 = 0x304c3058
	/**
	 * [63:0]   a3:a2:y3:cr0:y2:a1:a0:y1:cb0:y0  1:1:10:10:10:1:1:10:10:10 little endian
	 */
	y0l2                 = 0x324c3059
	/**
	 * [63:0]   x3:x2:y3:cr0:y2:x1:x0:y1:cb0:y0  1:1:10:10:10:1:1:10:10:10 little endian
	 */
	x0l2                 = 0x324c3058
	yuv420_8bit          = 0x38305559
	yuv420_10bit         = 0x30315559
	xrgb8888_a8          = 0x38415258
	xbgr8888_a8          = 0x38414258
	rgbx8888_a8          = 0x38415852
	bgrx8888_a8          = 0x38415842
	rgb888_a8            = 0x38413852
	bgr888_a8            = 0x38413842
	rgb565_a8            = 0x38413552
	bgr565_a8            = 0x38413542
	/**
	 * non-subsampled cr:cb plane
	 */
	nv24                 = 0x3432564e
	/**
	 * non-subsampled cb:cr plane
	 */
	nv42                 = 0x3234564e
	/**
	 * 2x1 subsampled cr:cb plane 10 bit per channel
	 */
	p210                 = 0x30313250
	/**
	 * 2x2 subsampled cr:cb plane 10 bits per channel
	 */
	p010                 = 0x30313050
	/**
	 * 2x2 subsampled cr:cb plane 12 bits per channel
	 */
	p012                 = 0x32313050
	/**
	 * 2x2 subsampled cr:cb plane 16 bits per channel
	 */
	p016                 = 0x36313050
	/**
	 * [63:0] a:x:b:x:g:x:r:x 10:6:10:6:10:6:10:6 little endian
	 */
	axbxgxrx106106106106 = 0x30314241
	/**
	 * 2x2 subsampled cr:cb plane
	 */
	nv15                 = 0x3531564e
	q410                 = 0x30313451
	q401                 = 0x31303451
	/**
	 * [63:0] x:r:g:b 16:16:16:16 little endian
	 */
	xrgb16161616         = 0x38345258
	/**
	 * [63:0] x:b:g:r 16:16:16:16 little endian
	 */
	xbgr16161616         = 0x38344258
	/**
	 * [63:0] a:r:g:b 16:16:16:16 little endian
	 */
	argb16161616         = 0x38345241
	/**
	 * [63:0] a:b:g:r 16:16:16:16 little endian
	 */
	abgr16161616         = 0x38344241
	/**
	 * [7:0] c0:c1:c2:c3:c4:c5:c6:c7 1:1:1:1:1:1:1:1 eight pixels/byte
	 */
	c1                   = 0x20203143
	/**
	 * [7:0] c0:c1:c2:c3 2:2:2:2 four pixels/byte
	 */
	c2                   = 0x20203243
	/**
	 * [7:0] c0:c1 4:4 two pixels/byte
	 */
	c4                   = 0x20203443
	/**
	 * [7:0] d0:d1:d2:d3:d4:d5:d6:d7 1:1:1:1:1:1:1:1 eight pixels/byte
	 */
	d1                   = 0x20203144
	/**
	 * [7:0] d0:d1:d2:d3 2:2:2:2 four pixels/byte
	 */
	d2                   = 0x20203244
	/**
	 * [7:0] d0:d1 4:4 two pixels/byte
	 */
	d4                   = 0x20203444
	/**
	 * [7:0] d
	 */
	d8                   = 0x20203844
	/**
	 * [7:0] r0:r1:r2:r3:r4:r5:r6:r7 1:1:1:1:1:1:1:1 eight pixels/byte
	 */
	r1                   = 0x20203152
	/**
	 * [7:0] r0:r1:r2:r3 2:2:2:2 four pixels/byte
	 */
	r2                   = 0x20203252
	/**
	 * [7:0] r0:r1 4:4 two pixels/byte
	 */
	r4                   = 0x20203452
	/**
	 * [15:0] x:r 6:10 little endian
	 */
	r10                  = 0x20303152
	/**
	 * [15:0] x:r 4:12 little endian
	 */
	r12                  = 0x20323152
	/**
	 * [31:0] a:cr:cb:y 8:8:8:8 little endian
	 */
	avuy8888             = 0x59555641
	/**
	 * [31:0] x:cr:cb:y 8:8:8:8 little endian
	 */
	xvuy8888             = 0x59555658
	/**
	 * 2x2 subsampled cr:cb plane 10 bits per channel packed
	 */
	p030                 = 0x30333050
}

pub enum Wl_data_offer_error {
	invalid_finish      = 0
	invalid_action_mask = 1
	invalid_action      = 2
	invalid_offer       = 3
}

pub enum Wl_data_source_error {
	invalid_action_mask = 0
	invalid_source      = 1
}

pub enum Wl_data_device_error {
	role        = 0
	used_source = 1
}

pub enum Wl_data_device_manager_dnd_action {
	none = 0
	copy = 1
	move = 2
	ask  = 3
}

pub enum Wl_shell_error {
	role = 0
}

pub enum Wl_shell_surface_resize {
	none         = 0
	top          = 1
	bottom       = 2
	left         = 4
	top_left     = 5
	bottom_left  = 6
	right        = 8
	top_right    = 9
	bottom_right = 10
}

pub enum Wl_shell_surface_transient {
	inactive = 0x1
}

pub enum Wl_shell_surface_fullscreen_method {
	default = 0
	scale   = 1
	driver  = 2
	fill    = 3
}

pub enum Wl_surface_error {
	invalid_scale       = 0
	invalid_transform   = 1
	invalid_size        = 2
	invalid_offset      = 3
	defunct_role_object = 4
}

pub enum Wl_seat_capability as u32 {
	pointer  = 1
	keyboard = 2
	touch    = 4
}

pub fn Wl_seat_capability.combine(first Wl_seat_capability, other ...Wl_seat_capability) u32 {
	mut res := u32(first)
	for val in other {
		res |= u32(val)
	}
	return res
}

pub enum Wl_seat_error {
	missing_capability = 0
}

pub enum Wl_pointer_error {
	role = 0
}

pub enum Wl_pointer_button_state {
	released = 0
	pressed  = 1
}

pub enum Wl_pointer_axis {
	vertical_scroll   = 0
	horizontal_scroll = 1
}

pub enum Wl_pointer_axis_source {
	wheel      = 0
	finger     = 1
	continuous = 2
	wheel_tilt = 3
}

pub enum Wl_pointer_axis_relative_direction {
	identical
	inverted
}

pub enum Wl_keyboard_keymap_format {
	no_keymap = 0
	xkb_v1    = 1
}

pub enum Wl_keyboard_key_state {
	released = 0
	pressed  = 1
	repeated = 2
}

pub enum Wl_output_subpixel {
	unknown
	none
	horizontal_rgb
	horizontal_bgr
	vertical_rgb
	vertical_bgr
}

pub enum Wl_output_transform {
	normal
	_90
	_180
	_270
	flipped
	flipped_90
	flipped_180
	flipped_270
}

pub enum Wl_output_mode {
	current   = 0x1
	preferred = 0x2
}

pub enum Wl_subcompositor_error {
	bad_surface = 0
	bad_parent  = 1
}

pub enum Wl_subsurface_error {
	bad_surface = 0
}
