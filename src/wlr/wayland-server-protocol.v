module wlr

#flag linux -I/usr/include
#flag linux -I/usr/include/pixman-1
#flag linux -I/usr/include/wayland-protocols
#flag -I @VMODROOT
#flag linux -I/usr/include/wlroots-0.19
#flag linux -lwayland-server
#flag linux -lwlroots-0.19
#flag linux -DWLR_USE_UNSTABLE

#include "wayland-server-protocol.h"

pub struct C.wl_client {}

pub struct C.wl_resource {}

pub struct C.wl_buffer {}

pub struct C.wl_callback {}

pub struct C.wl_compositor {}

pub struct C.wl_data_device {}

pub struct C.wl_data_device_manager {}

pub struct C.wl_data_offer {}

pub struct C.wl_data_source {}

pub struct C.wl_display {}

pub struct C.wl_keyboard {}

pub struct C.wl_output {}

pub struct C.wl_pointer {}

pub struct C.wl_region {}

pub struct C.wl_registry {}

pub struct C.wl_seat {}

pub struct C.wl_shell {}

pub struct C.wl_shell_surface {}

pub struct C.wl_shm {}

pub struct C.wl_shm_pool {}

pub struct C.wl_subcompositor {}

pub struct C.wl_surface {}

pub struct C.wl_touch {}

pub enum Wl_display_error {
	invalid_object = 0
	invalid_method = 1
	no_memory      = 2
	implementation = 3
}

pub fn C.wl_display_error_is_valid(value u32, version u32) bool

@[inline]
pub fn wl_display_error_is_valid(value u32, version u32) bool {
	return match value {
		0...3 { version >= 1 }
		else { false }
	}
}

pub struct C.wl_display_interface {
	sync         fn (client &C.wl_client, resource &C.wl_resource, callback u32)
	get_registry fn (client &C.wl_client, resource &C.wl_resource, registry u32)
}

const wl_display_error = 0
const wl_display_delete_id = 1
const wl_display_error_since_version = 1
const wl_display_delete_id_since_version = 1
const wl_display_sync_since_version = 1
const wl_display_get_registry_since_version = 1

pub struct C.wl_registry_interface {
	bind fn (client &C.wl_client, resource &C.wl_resource, name u32, interface string, version u32, id u32)
}

const wl_registry_global = 0
const wl_registry_global_remove = 1
const wl_registry_global_since_version = 1
const wl_registry_global_remove_since_version = 1
const wl_registry_bind_since_version = 1

pub fn C.wl_registry_send_global(resource &C.wl_resource, name u32, interface_ &char, version u32)
pub fn C.wl_registry_send_global_remove(resource &C.wl_resource, name u32)

const wl_callback_done = 0
const wl_callback_done_since_version = 1

pub fn C.wl_callback_send_done(resource &C.wl_resource, callback_data u32)

pub struct C.wl_compositor_interface {
	create_surface fn (client &C.wl_client, resource &C.wl_resource, id u32)
	create_region  fn (client &C.wl_client, resource &C.wl_resource, id u32)
}

const wl_compositor_create_surface_since_version = 1
const wl_compositor_create_region_since_version = 1

pub struct C.wl_shm_pool_interface {
	create_buffer fn (client &C.wl_client, resource &C.wl_resource, id u32, offset int, width int, height int, stride int, format u32)
	destroy       fn (client &C.wl_client, resource &C.wl_resource)
	resize        fn (client &C.wl_client, resource &C.wl_resource, size int)
}

const wl_shm_pool_create_buffer_since_version = 1
const wl_shm_pool_destroy_since_version = 1
const wl_shm_pool_resize_since_version = 1

pub enum Wl_shm_error {
	invalid_format = 0
	invalid_stride = 1
	invalid_fd     = 2
}

fn C.wl_shm_error_is_valid(value u32, version u32) bool
pub fn wl_shm_error_is_valid(value u32, version u32) bool {
	return match value {
		0...2 { version >= 1 }
		else { false }
	}
}

pub enum Wl_shm_format {
	argb8888             = 0
	xrgb8888             = 1
	c8                   = 0x20203843
	rgb332               = 0x38424752
	bgr233               = 0x38524742
	xrgb4444             = 0x32315258
	xbgr4444             = 0x32314258
	rgbx4444             = 0x32315852
	bgrx4444             = 0x32315842
	argb4444             = 0x32315241
	abgr4444             = 0x32314241
	rgba4444             = 0x32314152
	bgra4444             = 0x32314142
	xrgb1555             = 0x35315258
	xbgr1555             = 0x35314258
	rgbx5551             = 0x35315852
	bgrx5551             = 0x35315842
	argb1555             = 0x35315241
	abgr1555             = 0x35314241
	rgba5551             = 0x35314152
	bgra5551             = 0x35314142
	rgb565               = 0x36314752
	bgr565               = 0x36314742
	rgb888               = 0x34324752
	bgr888               = 0x34324742
	xbgr8888             = 0x34324258
	rgbx8888             = 0x34325852
	bgrx8888             = 0x34325842
	abgr8888             = 0x34324241
	rgba8888             = 0x34324152
	bgra8888             = 0x34324142
	xrgb2101010          = 0x30335258
	xbgr2101010          = 0x30334258
	rgbx1010102          = 0x30335852
	bgrx1010102          = 0x30335842
	argb2101010          = 0x30335241
	abgr2101010          = 0x30334241
	rgba1010102          = 0x30334152
	bgra1010102          = 0x30334142
	yuyv                 = 0x56595559
	vvyu                 = 0x55595659
	uyvy                 = 0x59565955
	vyuy                 = 0x59555956
	ayuv                 = 0x56555941
	nv21                 = 0x3132564e
	nv16                 = 0x3631564e
	nv61                 = 0x3136564e
	yuv410               = 0x39565559
	yvu410               = 0x39555659
	yuv411               = 0x31315559
	yvu411               = 0x31315659
	yuv420               = 0x32315559
	yvu420               = 0x32315659
	yuv422               = 0x36315559
	yvu422               = 0x36315659
	yuv444               = 0x34325559
	yvu444               = 0x34325659
	r8                   = 0x20203852
	r16                  = 0x20363152
	rg88                 = 0x38384752
	gr88                 = 0x38385247
	rg1616               = 0x32334752
	gr1616               = 0x32335247
	xrgb16161616f        = 0x48345258
	xbgr16161616f        = 0x48344258
	argb16161616f        = 0x48345241
	abgr16161616f        = 0x48344241
	xyuv8888             = 0x56555958
	vuy888               = 0x34325556
	vuy101010            = 0x30335556
	y210                 = 0x30313259
	y212                 = 0x32313259
	y216                 = 0x36313259
	y410                 = 0x30313459
	y412                 = 0x32313459
	y416                 = 0x36313459
	xvyu2101010          = 0x30335658
	xvyu12_16161616      = 0x36335658
	xvyu16161616         = 0x38345658
	y0l0                 = 0x304c3059
	x0l0                 = 0x304c3058
	y0l2                 = 0x324c3059
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
	nv24                 = 0x3432564e
	nv42                 = 0x3234564e
	p210                 = 0x30313250
	p010                 = 0x30313050
	p012                 = 0x32313050
	p016                 = 0x36313050
	axbxgxrx106106106106 = 0x30314241
	nv15                 = 0x3531564e
	q410                 = 0x30313451
	q401                 = 0x31303451
	xrgb16161616         = 0x38345258
	xbgr16161616         = 0x38344258
	argb16161616         = 0x38345241
	abgr16161616         = 0x38344241
	c1                   = 0x20203143
	c2                   = 0x20203243
	c4                   = 0x20203443
	d1                   = 0x20203144
	d2                   = 0x20203244
	d4                   = 0x20203444
	d8                   = 0x20203844
	r1                   = 0x20203152
	r2                   = 0x20203252
	r4                   = 0x20203452
	r10                  = 0x20303152
	r12                  = 0x20323152
	avuy8888             = 0x59555641
	xvuy8888             = 0x59555658
	p030                 = 0x30333050
}

pub fn wl_shm_format_is_valid(value u32, version u32) bool {
	if int(value) in [0, 1, 0x20203843, 0x38424752, 0x38524742, 0x32315258, 0x32314258, 0x32315852,
		0x32315842, 0x32315241, 0x32314241, 0x32314152, 0x32314142, 0x35315258, 0x35314258,
		0x35315852, 0x35315842, 0x35315241, 0x35314241, 0x35314152, 0x35314142, 0x36314752,
		0x36314742, 0x34324752, 0x34324742, 0x34324258, 0x34325852, 0x34325842, 0x34324241,
		0x34324152, 0x34324142, 0x30335258, 0x30334258, 0x30335852, 0x30335842, 0x30335241,
		0x30334241, 0x30334152, 0x30334142, 0x56595559, 0x55595659, 0x59565955, 0x59555956,
		0x56555941, 0x3132564e, 0x3631564e, 0x3136564e, 0x39565559, 0x39555659, 0x31315559,
		0x31315659, 0x32315559, 0x32315659, 0x36315559, 0x36315659, 0x34325559, 0x34325659,
		0x20203852, 0x20363152, 0x38384752, 0x38385247, 0x32334752, 0x32335247, 0x48345258,
		0x48344258, 0x48345241, 0x48344241, 0x56555958, 0x34325556, 0x30335556, 0x30313259,
		0x32313259, 0x36313259, 0x30313459, 0x32313459, 0x36313459, 0x30335658, 0x36335658,
		0x38345658, 0x304c3059, 0x304c3058, 0x324c3059, 0x324c3058, 0x38305559, 0x30315559,
		0x38415258, 0x38414258, 0x38415852, 0x38415842, 0x38413852, 0x38413842, 0x38413552,
		0x38413542, 0x3432564e, 0x3234564e, 0x30313250, 0x30313050, 0x32313050, 0x36313050,
		0x30314241, 0x3531564e, 0x30313451, 0x31303451, 0x38345258, 0x38344258, 0x38345241,
		0x38344241, 0x20203143, 0x20203243, 0x20203443, 0x20203144, 0x20203244, 0x20203444,
		0x20203844, 0x20203152, 0x20203252, 0x20203452, 0x20303152, 0x20323152, 0x59555641,
		0x59555658, 0x30333050] {
		return version >= 1
	}
	return false
}

pub struct C.wl_shm_interface {
	create_pool fn (client &C.wl_client, resource &C.wl_resource, id u32, fd int, size int)
	release     fn (client &C.wl_client, resource &C.wl_resource)
}

const wl_shm_format = 0
const wl_shm_format_since_version = 1
const wl_shm_pool_since_version = 1
const wl_shm_release_since_version = 2

pub fn C.wl_shm_send_format(resource &C.wl_resource, format u32)
@[inline]
pub fn wl_shm_send_format(resource &C.wl_resource, format u32) {
	C.wl_resource_post_event(resource, wl_shm_format, format)
}

pub struct C.wl_buffer_interface {
	destroy fn (client &C.wl_client, resource &C.wl_resource)
}

const wl_buffer_release = 0
const wl_buffer_release_since_version = 1
const wl_buffer_destroy_since_version = 1

pub fn C.wl_buffer_send_release(resource &C.wl_resource)
@[inline]
pub fn wl_buffer_send_release(resource &C.wl_resource) {
	C.wl_resource_post_event(resource, wl_buffer_release)
}

pub enum Wl_data_offer_error {
	invalid_finish       = 0
	finvalid_action_mask = 1
	invalid_action       = 2
	invalid_offer        = 3
}

pub fn C.wl_data_offer_error_is_valid(value u32, version u32) bool
@[inline]
pub fn wl_data_offer_error_is_valid(value u32, version u32) bool {
	return match value {
		0...3 { version >= 1 }
		else { false }
	}
}

pub struct C.wl_data_offer_interface {
	accept      fn (client &C.wl_client, resource &C.wl_resource, serial u32, mime_type string)
	receive     fn (client &C.wl_client, resource &C.wl_resource, mime_type string, fd int)
	destory     fn (client &C.wl_client, resource &C.wl_resource)
	finish      fn (client &C.wl_client, resource &C.wl_resource)
	set_actions fn (client &C.wl_client, resource &C.wl_resource, dnd_actions u32, preferred_action u32)
}

const wl_data_offer_offer = 0
const wl_data_offer_source_actions = 1
const wl_data_offer_action = 2

const wl_data_offer_offer_since_version = 1
const wl_data_offer_source_actions_since_version = 3
const wl_data_offer_action_since_version = 3
const wl_data_offer_accept_since_version = 1
const wl_data_offer_receive_since_version = 1
const wl_data_offer_destory_since_version = 1
const wl_data_offer_finish_since_version = 3
const wl_data_offer_set_actions_since_version = 3

pub fn C.wl_data_offer_send_offer(resource &C.wl_resource, mime_type &char)
pub fn wl_data_offer_send_offer(resource &C.wl_resource, mime_type &char) {
	C.wl_data_offer_send_offer(resource, mime_type)
}

pub fn C.wl_data_offer_send_source_actions(resource &C.wl_resource, source_actions u32)
pub fn wl_data_offer_send_source_actions(resource &C.wl_resource, source_actions u32) {
	C.wl_data_offer_send_source_actions(resource, source_actions)
}

pub fn C.wl_data_offer_send_action(resource &C.wl_resource, dnd_action u32)
pub fn wl_data_offer_send_action(resource &C.wl_resource, dnd_action u32) {
	C.wl_data_offer_send_action(resource, dnd_action)
}

pub enum Wl_data_source_error {
	invalid_action_mask = 0
	invalid_source      = 1
}

@[inline]
pub fn wl_data_source_error_is_valid(value u32, version u32) bool {
	return match value {
		0...1 { version >= 1 }
		else { false }
	}
}

pub struct C.wl_data_source_interface {
	offer       fn (client &C.wl_client, resource &C.wl_resource, mime_type string)
	destroy     fn (client &C.wl_client, resource &C.wl_resource)
	set_actions fn (client &C.wl_client, resource &C.wl_resource, dnd_actions u32)
}

const wl_data_source_target = 0
const wl_data_source_send = 1
const wl_data_source_cancelled = 2
const wl_data_source_dnd_drop_performed = 3
const wl_data_source_dnd_finished = 4
const wl_data_source_action = 5

const wl_data_source_target_since_version = 1
const wl_data_source_send_since_version = 1
const wl_data_source_cancelled_since_version = 1
const wl_data_source_dnd_drop_performed_since_version = 3
const wl_data_source_dnd_finished_since_version = 3
const wl_data_source_action_since_version = 3
const wl_data_source_offer_since_version = 1
const wl_data_source_destroy_since_version = 1
const wl_data_source_set_actions_since_version = 3

fn C.wl_data_source_send_target(resource &C.wl_resource, mime_type &char)
pub fn wl_data_source_send_target(resource &C.wl_resource, mime_type &char) {
	C.wl_data_source_send_target(resource, mime_type)
}

fn C.wl_data_source_send_send(resource &C.wl_resource, mime_type &char, fd int)
pub fn wl_data_source_send_send(resource &C.wl_resource, mime_type &char, fd int) {
	C.wl_data_source_send_send(resource, mime_type, fd)
}

fn C.wl_data_source_send_cancelled(resource &C.wl_resource)
pub fn wl_data_source_send_cancelled(resource &C.wl_resource) {
	C.wl_data_source_send_cancelled(resource)
}

fn C.wl_data_source_send_dnd_drop_performed(resource &C.wl_resource)
pub fn wl_data_source_send_dnd_drop_performed(resource &C.wl_resource) {
	C.wl_data_source_send_dnd_drop_performed(resource)
}

fn C.wl_data_source_send_dnd_finished(resource &C.wl_resource)
pub fn wl_data_source_send_dnd_finished(resource &C.wl_resource) {
	C.wl_data_source_send_dnd_finished(resource)
}

fn C.wl_data_source_send_action(resource &C.wl_resource, dnd_action u32)
pub fn wl_data_source_send_action(resource &C.wl_resource, dnd_action u32) {
	C.wl_data_source_send_action(resource, dnd_action)
}

pub enum Wl_data_device_error {
	role        = 0
	used_source = 1
}

fn C.wl_data_device_error_is_valid(value u32, version u32) bool
pub fn wl_data_device_error_is_valid(value u32, version u32) bool {
	return match value {
		0...1 { version >= 1 }
		else { false }
	}
}

pub struct C.wl_data_device_interface {
	start_drag    fn (client &C.wl_client, resource &C.wl_resource, source &C.wl_data_source, origin &C.wl_surface, icon &C.wl_surface, serial u32)
	set_selection fn (client &C.wl_client, resource &C.wl_resource, source &C.wl_data_source, serial u32)
	release       fn (client &C.wl_client, resource &C.wl_resource)
}

const wl_data_device_data_offer = 0
const wl_data_device_enter = 1
const wl_data_device_leave = 2
const wl_data_device_motion = 3
const wl_data_device_drop = 4
const wl_data_device_selection = 5

const wl_data_device_data_offer_since_version = 1
const wl_data_device_enter_since_version = 1
const wl_data_device_leave_since_version = 1
const wl_data_device_motion_since_version = 1
const wl_data_device_drop_since_version = 1
const wl_data_device_selection_since_version = 1
const wl_data_device_start_drag_since_version = 3
const wl_data_device_set_selection_since_version = 3
const wl_data_device_release_since_version = 3

fn C.wl_data_device_send_data_offer(resource &C.wl_resource, id u32)
pub fn wl_data_device_send_data_offer(resource &C.wl_resource, id u32) {
	C.wl_data_device_send_data_offer(resource, id)
}

fn C.wl_data_device_send_enter(resource &C.wl_resource, serial u32, surface &C.wl_surface, x f64, y f64, id u32)
pub fn wl_data_device_send_enter(resource &C.wl_resource, serial u32, surface &C.wl_surface, x f64, y f64, id u32) {
	C.wl_data_device_send_enter(resource, serial, surface, x, y, id)
}

fn C.wl_data_device_send_leave(resource &C.wl_resource)
pub fn wl_data_device_send_leave(resource &C.wl_resource) {
	C.wl_data_device_send_leave(resource)
}

fn C.wl_data_device_send_motion(resource &C.wl_resource, time u32, x f64, y f64)
pub fn wl_data_device_send_motion(resource &C.wl_resource, time u32, x f64, y f64) {
	C.wl_data_device_send_motion(resource, time, x, y)
}

fn C.wl_data_device_send_drop(resource &C.wl_resource)
pub fn wl_data_device_send_drop(resource &C.wl_resource) {
	C.wl_data_device_send_drop(resource)
}

fn C.wl_data_device_send_selection(resource &C.wl_resource, id u32)
pub fn wl_data_device_send_selection(resource &C.wl_resource, id u32) {
	C.wl_data_device_send_selection(resource, id)
}

pub enum Wl_data_device_manager_dnd_action {
	none = 0
	copy = 1
	move = 2
	ask  = 4
}

fn C.wl_data_device_manager_dnd_action_is_valid(value u32, version u32) bool
pub fn wl_data_device_manager_dnd_action_is_valid(value u32, version u32) bool {
	valid := if version >= 1 {
		u32(Wl_data_device_manager_dnd_action.none) | u32(Wl_data_device_manager_dnd_action.copy) | u32(Wl_data_device_manager_dnd_action.move) | u32(Wl_data_device_manager_dnd_action.ask)
	} else {
		0
	}
	return (value & ~valid) == 0
}

pub struct C.wl_data_device_manager_interface {
	create_data_source fn (client &C.wl_client, resource &C.wl_resource, id u32)
	get_data_device    fn (client &C.wl_client, resource &C.wl_resource, seat &C.wl_seat) u32
}

const wl_data_device_manager_create_data_source_since_version = 1
const wl_data_device_manager_get_data_device_since_version = 1

pub enum Wl_shell_error {
	role = 0
}

fn C.wl_shell_error_is_valid(value u32, version u32) bool
pub fn wl_shell_error_is_valid(value u32, version u32) bool {
	return version >= 1 && value == 0
}

pub struct C.wl_shell_interface {
	get_shell_surface fn (client &C.wl_client, resource &C.wl_resource, id u32, surface &C.wl_surface)
}

const wl_shell_get_shell_surface_since_version = 1

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

fn C.wl_shell_surface_resize_is_valid(value u32, version u32) bool
pub fn wl_shell_surface_resize_is_valid(value u32, version u32) bool {
	valid := if version >= 1 {
		u32(Wl_shell_surface_resize.none) | u32(Wl_shell_surface_resize.top) | u32(Wl_shell_surface_resize.bottom) | u32(Wl_shell_surface_resize.left) | u32(Wl_shell_surface_resize.top_left) | u32(Wl_shell_surface_resize.bottom_left) | u32(Wl_shell_surface_resize.right) | u32(Wl_shell_surface_resize.top_right) | u32(Wl_shell_surface_resize.bottom_right)
	} else {
		0
	}
	return (value & ~valid) == 0
}

pub enum Wl_shell_surface_transient {
	parent = 0x1
}

fn C.wl_shell_surface_transient_is_valid(value u32, version u32) bool
pub fn wl_shell_surface_transient_is_valid(value u32, version u32) bool {
	valid := if version >= 1 {
		u32(Wl_shell_surface_transient.parent)
	} else {
		0
	}
	return (value & ~valid) == 0
}

pub enum Wl_shell_surface_fullscreen_method {
	default = 0
	scale   = 1
	driver  = 2
	fill    = 3
}

fn C.wl_shell_surface_fullscreen_method_is_valid(value u32, version u32) bool
pub fn wl_shell_surface_fullscreen_method_is_valid(value u32, version u32) bool {
	valid := if version >= 1 {
		u32(Wl_shell_surface_fullscreen_method.default) | u32(Wl_shell_surface_fullscreen_method.scale) | u32(Wl_shell_surface_fullscreen_method.driver) | u32(Wl_shell_surface_fullscreen_method.fill)
	} else {
		0
	}
	return (value & ~valid) == 0
}

pub struct C.wl_shell_surface_interface {
	pong           fn (client &C.wl_client, resource &C.wl_resource, serial u32)
	move           fn (client &C.wl_client, resource &C.wl_resource, seat &C.wl_seat, serial u32)
	resize         fn (client &C.wl_client, resource &C.wl_resource, seat &C.wl_seat, serial u32, edges u32)
	set_toplevel   fn (client &C.wl_client, resource &C.wl_resource)
	set_transient  fn (client &C.wl_client, resource &C.wl_resource, parent &C.wl_surface, x int, y int, flags u32)
	set_fullscreen fn (client &C.wl_client, resource &C.wl_resource, method u32, framerate u32, output &C.wl_output)
	set_popup      fn (client &C.wl_client, resource &C.wl_resource, seat &C.wl_seat, serial u32, parent &C.wl_surface, x int, y int, flags u32)
	set_maximized  fn (client &C.wl_client, resource &C.wl_resource, output &C.wl_output)
	set_title      fn (client &C.wl_client, resource &C.wl_resource, title &char)
	set_class      fn (client &C.wl_client, resource &C.wl_resource, class &char)
}

const wl_shell_surface_ping = 0
const wl_shell_surface_configure = 1
const wl_shell_surface_popup_done = 2

const wl_shell_surface_ping_since_version = 1
const wl_shell_surface_configure_since_version = 1
const wl_shell_surface_popup_done_since_version = 1
const wl_shell_suface_pong_since_version = 1
const wl_shell_surface_move_since_version = 1
const wl_shell_surface_resize_since_version = 1
const wl_shell_surface_set_toplevel_since_version = 1
const wl_shell_surface_set_transient_since_version = 1
const wl_shell_surface_set_fullscreen_since_version = 1
const wl_shell_surface_set_popup_since_version = 1
const wl_shell_surface_set_maximized_since_version = 1
const wl_shell_surface_set_title_since_version = 1
const wl_shell_surface_set_class_since_version = 1

fn C.wl_shell_surface_send_ping(resource &C.wl_resource, serial u32)
pub fn wl_shell_surface_send_ping(resource &C.wl_resource, serial u32) {
	C.wl_shell_surface_send_ping(resource, serial)
}

fn C.wl_shell_surface_send_configure(resource &C.wl_resource, edges u32, width int, height int)
pub fn wl_shell_surface_send_configure(resource &C.wl_resource, edges u32, width int, height int) {
	C.wl_shell_surface_send_configure(resource, edges, width, height)
}

fn C.wl_shell_surface_send_popup_done(resource &C.wl_resource)
pub fn wl_shell_surface_send_popup_done(resource &C.wl_resource) {
	C.wl_shell_surface_send_popup_done(resource)
}

pub enum Wl_surface_error {
	invalid_scale       = 0
	invalid_transform   = 1
	invalid_size        = 2
	invalid_offset      = 3
	defunct_role_object = 4
}

fn C.wl_surface_error_is_valid(value u32, version u32) bool
pub fn wl_surface_error_is_valid(value u32, version u32) bool {
	return match value {
		0...4 { version >= 1 }
		else { false }
	}
}

pub struct C.wl_surface_interface {
	destroy              fn (client &C.wl_client, resource &C.wl_resource)
	attach               fn (client &C.wl_client, resource &C.wl_resource, buffer &C.wl_buffer, x int, y int)
	damage               fn (client &C.wl_client, resource &C.wl_resource, x int, y int, width int, height int)
	frame                fn (client &C.wl_client, resource &C.wl_resource, callback u32)
	set_opaque_region    fn (client &C.wl_client, resource &C.wl_resource, region &C.wl_region)
	set_input_region     fn (client &C.wl_client, resource &C.wl_resource, region &C.wl_region)
	commit               fn (client &C.wl_client, resource &C.wl_resource)
	set_buffer_transform fn (client &C.wl_client, resource &C.wl_resource, transform int)
	set_buffer_scale     fn (client &C.wl_client, resource &C.wl_resource, scale int)
	damage_buffer        fn (client &C.wl_client, resource &C.wl_resource, x int, y int, width int, height int)
	offset               fn (client &C.wl_client, resource &C.wl_resource, x int, y int)
}

const wl_surface_enter = 0
const wl_surface_leave = 1
const wl_surface_preferred_buffer_scale = 2
const wl_surface_preferred_buffer_transform = 3

const wl_surface_enter_since_version = 1
const wl_surface_leave_since_version = 1
const wl_surface_preferred_buffer_scale_since_version = 6
const wl_surface_preferred_buffer_transform_since_version = 6
const wl_surface_destroy_since_version = 1
const wl_surface_attach_since_version = 1
const wl_surface_damage_since_version = 1
const wl_surface_frame_since_version = 1
const wl_surface_set_opaque_region_since_version = 1
const wl_surface_set_input_region_since_version = 1
const wl_surface_commit_since_version = 1
const wl_surface_set_buffer_transform_since_version = 2
const wl_surface_set_buffer_scale_since_version = 3
const wl_surface_damage_buffer_since_version = 4
const wl_surface_offset_since_version = 5

fn C.wl_surface_send_enter(resource &C.wl_resource, output &C.wl_output)
pub fn wl_surface_send_enter(resource &C.wl_resource, output &C.wl_output) {
	C.wl_surface_send_enter(resource, output)
}

fn C.wl_surface_send_leave(resource &C.wl_resource, output &C.wl_output)
pub fn wl_surface_send_leave(resource &C.wl_resource, output &C.wl_output) {
	C.wl_surface_send_leave(resource, output)
}

fn C.wl_surface_send_preferred_buffer_scale(resource &C.wl_resource, scale int)
pub fn wl_surface_send_preferred_buffer_scale(resource &C.wl_resource, scale int) {
	C.wl_surface_send_preferred_buffer_scale(resource, scale)
}

fn C.wl_surface_send_preferred_buffer_transform(resource &C.wl_resource, transform int)
pub fn wl_surface_send_preferred_buffer_transform(resource &C.wl_resource, transform int) {
	C.wl_surface_send_preferred_buffer_transform(resource, transform)
}

pub enum Wl_seat_capability {
	pointer  = 1
	keyboard = 2
	touch    = 4
}

fn C.wl_seat_capability_is_valid(value u32, version u32) bool
pub fn wl_seat_capability_is_valid(value u32, version u32) bool {
	valid := if version >= 1 {
		u32(Wl_seat_capability.pointer) | u32(Wl_seat_capability.keyboard) | u32(Wl_seat_capability.touch)
	} else {
		0
	}
	return (value & ~valid) == 0
}

pub enum Wl_seat_error {
	missing_capability = 0
}

fn C.wl_seat_error_is_valid(value u32, version u32) bool
pub fn wl_seat_error_is_valid(value u32, version u32) bool {
	return version >= 1 && value == 0
}

pub struct C.wl_seat_interface {
	get_pointer  fn (client &C.wl_client, resource &C.wl_resource, id u32)
	get_keyboard fn (client &C.wl_client, resource &C.wl_resource, id u32)
	get_touch    fn (client &C.wl_client, resource &C.wl_resource, id u32)
	release      fn (client &C.wl_client, resource &C.wl_resource)
}

const wl_seat_capabilities = 0
const wl_seat_name = 1

const wl_seat_capabilities_since_version = 1
const wl_seat_name_since_version = 2
const wl_seat_get_pointer_since_version = 1
const wl_seat_get_keyboard_since_version = 1
const wl_seat_get_touch_since_version = 1
const wl_seat_release_since_version = 5

fn C.wl_seat_send_capabilities(resource &C.wl_resource, capabilities u32)
pub fn wl_seat_send_capabilities(resource &C.wl_resource, capabilities u32) {
	C.wl_seat_send_capabilities(resource, capabilities)
}

fn C.wl_seat_send_name(resource &C.wl_resource, name &char)
pub fn wl_seat_send_name(resource &C.wl_resource, name &char) {
	C.wl_seat_send_name(resource, name)
}

pub enum Wl_pointer_error {
	role = 0
}

fn C.wl_pointer_error_is_valid(value u32, version u32) bool
fn wl_pointer_error_is_valid(value u32, version u32) bool {
	return version >= 1 && value == 0
}

pub enum Wl_pointer_button_state {
	released = 0
	pressed  = 1
}

fn C.wl_pointer_button_state_is_valid(value u32, version u32) bool
pub fn wl_pointer_button_state_is_valid(value u32, version u32) bool {
	return version >= 1 && int(value) in [0, 1]
}

pub enum Wl_pointer_axis {
	vertical_scroll   = 0
	horizontal_scroll = 1
}

fn C.wl_pointer_axis_is_valid(value u32, version u32) bool
pub fn wl_pointer_axis_is_valid(value u32, version u32) bool {
	return version >= 1 && int(value) in [0, 1]
}

pub enum Wl_pointer_axis_source {
	wheel      = 0
	finger     = 1
	continuous = 2
	wheel_tilt = 3
}

const wl_pointer_axis_source_wheel_tilt_since_version = 6

fn C.wl_pointer_axis_source_is_valid(value u32, version u32) bool
pub fn wl_pointer_axis_source_is_valid(value u32, version u32) bool {
	return match version {
		u32(Wl_pointer_axis_source.wheel), u32(Wl_pointer_axis_source.finger),
		u32(Wl_pointer_axis_source.continuous) {
			version >= 1
		}
		u32(Wl_pointer_axis_source.wheel_tilt) {
			version >= 6
		}
		else {
			false
		}
	}
}

pub enum Wl_pointer_axis_relative_direction {
	identical = 0
	inverted  = 1
}

fn C.wl_pointer_axis_relative_direction_is_valid(value u32, version u32) bool
pub fn wl_pointer_axis_relative_direction_is_valid(value u32, version u32) bool {
	return version >= 1 && int(value) in [0, 1]
}

pub struct C.wl_pointer_interface {
	set_cursor fn (client &C.wl_client, resource &C.wl_resource, serial u32, surface &C.wl_surface, hotspot_x int, hotspot_y int)
	release    fn (client &C.wl_client, resource &C.wl_resource)
}

const wl_pointer_enter = 0
const wl_pointer_leave = 1
const wl_pointer_motion = 2
const wl_pointer_button = 3
const wl_pointer_axis = 4
const wl_pointer_frame = 5
const wl_pointer_axis_source = 6
const wl_pointer_axis_stop = 7
const wl_pointer_axis_discrete = 8
const wl_pointer_axis_value120 = 9
const wl_pointer_axis_relative_direction = 10

const wl_pointer_enter_since_version = 1
const wl_pointer_leave_since_version = 1
const wl_pointer_motion_since_version = 1
const wl_pointer_button_since_version = 1
const wl_pointer_axis_since_version = 1
const wl_pointer_frame_since_version = 5
const wl_pointer_axis_source_since_version = 5
const wl_pointer_axis_stop_since_version = 5
const wl_pointer_axis_discrete_since_version = 5
const wl_pointer_axis_value120_since_version = 8
const wl_pointer_axis_relative_direction_since_version = 9
const wl_pointer_set_cursor_since_version = 1
const wl_pointer_release_since_version = 3

fn C.wl_pointer_send_enter(resource &C.wl_resource, serial u32, surface &C.wl_surface, surface_x f64, surface_y f64)
pub fn wl_pointer_send_enter(resource &C.wl_resource, serial u32, surface &C.wl_surface, surface_x f64, surface_y f64) {
	C.wl_pointer_send_enter(resource, serial, surface, surface_x, surface_y)
}

fn C.wl_pointer_send_leave(resource &C.wl_resource, serial u32, surface &C.wl_surface)
pub fn wl_pointer_send_leave(resource &C.wl_resource, serial u32, surface &C.wl_surface) {
	C.wl_pointer_send_leave(resource, serial, surface)
}

fn C.wl_pointer_send_motion(resource &C.wl_resource, time u32, surface_x f64, surface_y f64)
pub fn wl_pointer_send_motion(resource &C.wl_resource, time u32, surface_x f64, surface_y f64) {
	C.wl_pointer_send_motion(resource, time, surface_x, surface_y)
}

fn C.wl_pointer_send_button(resource &C.wl_resource, serial u32, time u32, button u32, state u32)
pub fn wl_pointer_send_button(resource &C.wl_resource, serial u32, time u32, button u32, state u32) {
	C.wl_pointer_send_button(resource, serial, time, button, state)
}

fn C.wl_pointer_send_axis(resource &C.wl_resource, time u32, axis u32, value f64)
pub fn wl_pointer_send_axis(resource &C.wl_resource, time u32, axis u32, value f64) {
	C.wl_pointer_send_axis(resource, time, axis, value)
}

fn C.wl_pointer_send_frame(resource &C.wl_resource)
pub fn wl_pointer_send_frame(resource &C.wl_resource) {
	C.wl_pointer_send_frame(resource)
}

fn C.wl_pointer_send_axis_source(resource &C.wl_resource, axis_source u32)
pub fn wl_pointer_send_axis_source(resource &C.wl_resource, axis_source u32) {
	C.wl_pointer_send_axis_source(resource, axis_source)
}

fn C.wl_pointer_send_axis_stop(resource &C.wl_resource, time u32, axis u32)
pub fn wl_pointer_send_axis_stop(resource &C.wl_resource, time u32, axis u32) {
	C.wl_pointer_send_axis_stop(resource, time, axis)
}

fn C.wl_pointer_send_axis_discrete(resource &C.wl_resource, axis u32, discrete int)
pub fn wl_pointer_send_axis_discrete(resource &C.wl_resource, axis u32, discrete int) {
	C.wl_pointer_send_axis_discrete(resource, axis, discrete)
}

fn C.wl_pointer_send_axis_value120(resource &C.wl_resource, axis u32, value f64)
pub fn wl_pointer_send_axis_value120(resource &C.wl_resource, axis u32, value f64) {
	C.wl_pointer_send_axis_value120(resource, axis, value)
}

fn C.wl_pointer_send_axis_relative_direction(resource &C.wl_resource, direction u32)
pub fn wl_pointer_send_axis_relative_direction(resource &C.wl_resource, direction u32) {
	C.wl_pointer_send_axis_relative_direction(resource, direction)
}

pub enum Wl_keyboard_keymap_format {
	no_keymap = 0
	xkb_v1    = 1
}

fn C.wl_keyboard_keymap_format_is_valid(value u32, version u32) bool
pub fn wl_keyboard_keymap_format_is_valid(value u32, version u32) bool {
	return match value {
		0, 1 { version >= 1 }
		else { false }
	}
}

pub enum Wl_keyboard_key_state {
	released = 0
	pressed  = 1
}

fn C.wl_keyboard_key_state_is_valid(value u32, version u32) bool
pub fn wl_keyboard_key_state_is_valid(value u32, version u32) bool {
	return version >= 1 && int(value) in [0, 1]
}

pub struct C.wl_keyboarde_interface {
	release fn (client &C.wl_client, resource &C.wl_resource)
}

const wl_keyboard_keymap = 0
const wl_keyboard_enter = 1
const wl_keyboard_leave = 2
const wl_keyboard_key = 3
const wl_keyboard_modifiers = 4
const wl_keyboard_repeat_info = 5

const wl_keyboard_keymap_since_version = 1
const wl_keyboard_enter_since_version = 1
const wl_keyboard_leave_since_version = 1
const wl_keyboard_key_since_version = 1
const wl_keyboard_modifiers_since_version = 1
const wl_keyboard_repeat_info_since_version = 4
const wl_keyboard_release_since_version = 3

fn C.wl_keyboard_send_keymap(resource &C.wl_resource, format u32, fd int, size int)
pub fn wl_keyboard_send_keymap(resource &C.wl_resource, format u32, fd int, size int) {
	C.wl_keyboard_send_keymap(resource, format, fd, size)
}

fn C.wl_keyboard_send_enter(resource &C.wl_resource, serial u32, surface &C.wl_surface, keys &int, keymap &char)
pub fn wl_keyboard_send_enter(resource &C.wl_resource, serial u32, surface &C.wl_surface, keys &int, keymap &char) {
	C.wl_keyboard_send_enter(resource, serial, surface, keys, keymap)
}

fn C.wl_keyboard_send_leave(resource &C.wl_resource, serial u32, surface &C.wl_surface)
pub fn wl_keyboard_send_leave(resource &C.wl_resource, serial u32, surface &C.wl_surface) {
	C.wl_keyboard_send_leave(resource, serial, surface)
}

fn C.wl_keyboard_send_key(resource &C.wl_resource, serial u32, time u32, key u32, state u32)
pub fn wl_keyboard_send_key(resource &C.wl_resource, serial u32, time u32, key u32, state u32) {
	C.wl_keyboard_send_key(resource, serial, time, key, state)
}

fn C.wl_keyboard_send_modifiers(resource &C.wl_resource, serial u32, mods_depressed u32, mods_latched u32, mods_locked u32, group u32)
pub fn wl_keyboard_send_modifiers(resource &C.wl_resource, serial u32, mods_depressed u32, mods_latched u32, mods_locked u32, group u32) {
	C.wl_keyboard_send_modifiers(resource, serial, mods_depressed, mods_latched, mods_locked,
		group)
}

pub struct C.wl_touch_interface {
	release fn (client &C.wl_client, resource &C.wl_resource)
}

const wl_touch_down = 0
const wl_touch_up = 1
const wl_touch_motion = 2
const wl_touch_frame = 3
const wl_touch_cancel = 4
const wl_touch_shape = 5
const wl_touch_orientation = 6

const wl_touch_down_since_version = 1
const wl_touch_up_since_version = 1
const wl_touch_motion_since_version = 1
const wl_touch_frame_since_version = 1
const wl_touch_cancel_since_version = 1
const wl_touch_shape_since_version = 6
const wl_touch_orientation_since_version = 6
const wl_touch_release_since_version = 3

fn C.wl_touch_send_down(resource &C.wl_resource, serial u32, time u32, surface &C.wl_surface, id i32, x f64, y f64)
pub fn wl_touch_send_down(resource &C.wl_resource, serial u32, time u32, surface &C.wl_surface, id i32, x f64, y f64) {
	C.wl_touch_send_down(resource, serial, time, surface, id, x, y)
}

fn C.wl_touch_send_up(resource &C.wl_resource, serial u32, time u32, id i32)
pub fn wl_touch_send_up(resource &C.wl_resource, serial u32, time u32, id i32) {
	C.wl_touch_send_up(resource, serial, time, id)
}

fn C.wl_touch_send_motion(resource &C.wl_resource, time u32, id i32, x f64, y f64)
pub fn wl_touch_send_motion(resource &C.wl_resource, time u32, id i32, x f64, y f64) {
	C.wl_touch_send_motion(resource, time, id, x, y)
}

fn C.wl_touch_send_frame(resource &C.wl_resource)
pub fn wl_touch_send_frame(resource &C.wl_resource) {
	C.wl_touch_send_frame(resource)
}

fn C.wl_touch_send_cancel(resource &C.wl_resource)
pub fn wl_touch_send_cancel(resource &C.wl_resource) {
	C.wl_touch_send_cancel(resource)
}

fn C.wl_touch_send_shape(resource &C.wl_resource, id i32, major f32, minor f32)
pub fn wl_touch_send_shape(resource &C.wl_resource, id i32, major f32, minor f32) {
	C.wl_touch_send_shape(resource, id, major, minor)
}

fn C.wl_touch_send_orientation(resource &C.wl_resource, id i32, orientation f32, tilt f32)
pub fn wl_touch_send_orientation(resource &C.wl_resource, id i32, orientation f32, tilt f32) {
	C.wl_touch_send_orientation(resource, id, orientation, tilt)
}

pub enum Wl_output_subpixel {
	unkown         = 0
	none           = 1
	horizontal_rgb = 2
	horiztonal_bgr = 3
	vertical_rgb   = 4
	vertical_bgr   = 5
}

fn C.wl_output_subpixel_is_valid(value u32, version u32) bool
pub fn wl_output_subpixel_is_valid(value u32, version u32) bool {
	return match value {
		0...5 { version >= 1 }
		else { false }
	}
}

pub enum Wl_output_transform {
	normal       = 0
	_90          = 1
	_180         = 2
	_270         = 3
	flipped      = 4
	flipped_90   = 5
	flippped_180 = 6
	flipped_270  = 7
}

fn C.wl_output_transform_is_valid(value u32, version u32) bool
pub fn wl_output_transform_is_valid(value u32, version u32) bool {
	return match value {
		0...7 { version >= 1 }
		else { false }
	}
}

pub enum Wl_output_mode {
	current   = 0x1
	preferred = 0x2
}

fn C.wl_output_mode_is_valid(value u32, version u32) bool
pub fn wl_output_mode_is_valid(value u32, version u32) bool {
	valid := if version >= 1 {
		u32(Wl_output_mode.current) | u32(Wl_output_mode.preferred)
	} else {
		0
	}
	return (value & ~valid) == 0
}

pub struct C.wl_output_interface {
	release fn (client &C.wl_client, resource &C.wl_resource)
}

const wl_output_geometry = 0
const wl_output_mode = 1
const wl_output_done = 2
const wl_output_scale = 3
const wl_output_name = 4

const wl_output_geometry_since_version = 1
const wl_output_mode_since_version = 1
const wl_output_done_since_version = 2
const wl_output_scale_since_version = 2
const wl_output_name_since_version = 4
const wl_output_description_since_version = 4
const wl_output_release_since_version = 3

fn C.wl_output_send_geometry(resource &C.wl_resource, x int, y int, physical_width int, physical_height int, subpixel u32, make &char, model &char, transform u32)
pub fn wl_output_send_geometry(resource &C.wl_resource, x int, y int, physical_width int, physical_height int, subpixel u32, make &char, model &char, transform u32) {
	C.wl_output_send_geometry(resource, x, y, physical_width, physical_height, subpixel,
		make, model, transform)
}

fn C.wl_output_send_mode(resource &C.wl_resource, flags u32, width int, height int, refresh int)
pub fn wl_output_send_mode(resource &C.wl_resource, flags u32, width int, height int, refresh int) {
	C.wl_output_send_mode(resource, flags, width, height, refresh)
}

fn C.wl_output_send_done(resource &C.wl_resource)
pub fn wl_output_send_done(resource &C.wl_resource) {
	C.wl_output_send_done(resource)
}

fn C.wl_output_send_scale(resource &C.wl_resource, factor int)
pub fn wl_output_send_scale(resource &C.wl_resource, factor int) {
	C.wl_output_send_scale(resource, factor)
}

fn C.wl_output_send_name(resource &C.wl_resource, name &char)
pub fn wl_output_send_name(resource &C.wl_resource, name &char) {
	C.wl_output_send_name(resource, name)
}

pub struct C.wl_region_interface {
	destroy  fn (client &C.wl_client, resource &C.wl_resource)
	add      fn (client &C.wl_client, resource &C.wl_resource, x int, y int, width int, height int)
	subtract fn (client &C.wl_client, resource &C.wl_resource, x int, y int, width int, height int)
}

pub enum Wl_subcompositor_error {
	bad_surface = 0
	bad_parent  = 1
}

fn C.wl_subcompositor_error_is_valid(value u32, version u32) bool
pub fn wl_subcompositor_error_is_valid(value u32, version u32) bool {
	return match value {
		0, 1 { version >= 1 }
		else { false }
	}
}

pub struct C.wl_subcompositor_inteface {
	destroy        fn (client &C.wl_client, resource &C.wl_resource)
	get_subsurface fn (client &C.wl_client, resource &C.wl_resource, id u32, surface &C.wl_surface, parent &C.wl_surface) u32
}

const wl_subcompositor_destroy_since_version = 1
const wl_subcompositor_get_subsurface_since_version = 1

pub enum Wl_subsurface_error {
	bad_surface = 0
}

fn C.wl_subsurface_error_is_valid(value u32, version u32) bool
pub fn wl_subsurface_error_is_valid(value u32, version u32) bool {
	return version >= 1 && value == 0
}

pub struct C.wl_subsurface_interface {
	destroy      fn (client &C.wl_client, resource &C.wl_resource)
	set_position fn (client &C.wl_client, resource &C.wl_resource, x int, y int)
	place_above  fn (client &C.wl_client, resource &C.wl_resource, sibling &C.wl_surface)
	place_below  fn (client &C.wl_client, resource &C.wl_resource, sibling &C.wl_surface)
	set_sync     fn (client &C.wl_client, resource &C.wl_resource)
	set_desync   fn (client &C.wl_client, resource &C.wl_resource)
}

const wl_subsurface_destroy_since_version = 1
const wl_subsurface_set_position_since_version = 1
const wl_subsurface_place_above_since_version = 1
const wl_subsurface_place_below_since_version = 1
const wl_subsurface_set_sync_since_version = 1
const wl_subsurface_set_desync_since_version = 1
