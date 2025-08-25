module wl

#flag linux -I/usr/include
#flag linux -lwayland-server
#include <wayland-server-core.h>

pub enum Wl_event {
	readable = 0x01
	writable = 0x02
	hangup   = 0x04
	error    = 0x08
}

type Wl_event_loop_fd_func_t = fn (fd int, mask u32, data voidptr)

type Wl_event_loop_timer_func_t = fn (data voidptr) int

type Wl_event_loop_signal_func_t = fn (signal_number int, data voidptr) int

type Wl_event_loop_idle_func_t = fn (data voidptr)

pub struct C.wl_event_loop {
}

pub struct C.wl_event_source {
}

fn C.wl_event_loop_create() &C.wl_event_loop
fn C.wl_event_loop_destroy(loop &C.wl_event_loop)
fn C.wl_event_loop_add_fd(loop &C.wl_event_loop, fd int, mask u32, func Wl_event_loop_fd_func_t, data voidptr) &C.wl_event_source
fn C.wl_event_source_fd_update(source &C.wl_event_source, mask u32) int
fn C.wl_event_loop_add_timer(loop &C.wl_event_loop, func Wl_event_loop_timer_func_t, data voidptr) &C.wl_event_source
fn C.wl_event_loop_add_signal(loop &C.wl_event_loop, signal_number int, func Wl_event_loop_signal_func_t, data voidptr) &C.wl_event_source
fn C.wl_event_source_timer_update(source &C.wl_event_source, ms_delay int) int
fn C.wl_event_source_remove(source &C.wl_event_source) int
fn C.wl_event_source_check(source &C.wl_event_source)
fn C.wl_event_loop_dispatch(loop &C.wl_event_loop, timeout int) int
fn C.wl_event_loop_dispatch_idle(loop &C.wl_event_loop)
fn C.wl_event_loop_add_idle(loop &C.wl_event_loop, func Wl_event_loop_idle_func_t, data voidptr) &C.wl_event_source
fn C.wl_event_loop_get_fd(loop &C.wl_event_loop) int

type Wl_notify_func_t = fn (listener &C.wl_listener, data voidptr)

fn C.wl_event_loop_add_destroy_listener(loop &C.wl_event_loop, listener &C.wl_listener)
fn C.wl_event_loop_get_destroy_listener(loop &C.wl_event_loop, notify Wl_notify_func_t) &C.wl_listener

pub struct C.wl_display {
}

fn C.wl_display_create() &C.wl_display
fn C.wl_display_destroy(display &C.wl_display)
fn C.wl_display_get_event_loop(display &C.wl_display) &C.wl_event_loop
fn C.wl_display_add_socket(display &C.wl_display, name &char) int
fn C.wl_display_add_socket_auto(display &C.wl_display) &char
fn C.wl_display_add_socket_fd(display &C.wl_display, sock_fd int) int
fn C.wl_display_terminate(display &C.wl_display)
fn C.wl_display_run(display &C.wl_display)
fn C.wl_display_flush_clients(display &C.wl_display)
fn C.wl_display_destroy_clients(display &C.wl_display)
fn C.wl_display_set_default_max_buffer_size(display &C.wl_display, size usize)

pub struct C.wl_client {
}

type Wl_global_bind_func_t = fn (client &C.wl_client, data voidptr, version u32, id u32)

fn C.wl_display_get_serial(display &C.wl_display) u32
fn C.wl_display_next_serial(display &C.wl_display) u32
fn C.wl_display_add_destroy_listener(display &C.wl_display, listener &C.wl_listener)
fn C.wl_display_add_client_create_listener(display &C.wl_display, listener &C.wl_listener)
fn C.wl_display_get_destroy_listener(display &C.wl_display, notify Wl_notify_func_t) &C.wl_listener

pub struct C.wl_global {
}

fn C.wl_global_create(display &C.wl_display, interface, &C.wl_interface, version u32, data voidptr, bind Wl_global_bind_func_t) &C.wl_global
fn C.wl_global_remove(global &C.wl_global)
fn C.wl_global_destroy(global &C.wl_global)

type Wl_display_global_filter_func_t = fn (client &C.wl_client, global &C.wl_global, data voidptr) bool

fn C.wl_display_set_global_filter(display &C.wl_display, filter Wl_display_global_filter_func_t, data voidptr)
fn C.wl_global_get_interface(global &C.wl_global) &C.wl_interface
fn C.wl_global_get_name(global &C.wl_global, client &C.wl_client) u32
fn C.wl_global_get_version(global &C.wl_global) u32
fn C.wl_global_get_display(global &C.wl_global) &C.wl_display
fn C.wl_global_get_user_data(global &C.wl_global) voidptr
fn C.wl_global_set_user_data(global &C.wl_global, data voidptr)

fn C.wl_client_create(display &C.wl_display, fd int) &C.wl_client
fn C.wl_display_get_client_list(display &C.wl_display) &C.wl_list
fn C.wl_client_get_link(client &C.wl_client) &C.wl_list
fn C.wl_client_from_link(link &C.wl_list) &C.wl_client
fn C.wl_client_destroy(client &C.wl_client)
fn C.wl_client_flush(client &C.wl_client)
fn C.wl_client_get_credentials(client &C.wl_client, pid &int, uid &u32, gid &u32)
fn C.wl_client_get_fd(client &C.wl_client) int
fn C.wl_client_add_destroy_listener(client &C.wl_client, listener &C.wl_listener)
fn C.wl_client_get_destroy_listener(client &C.wl_client, notify Wl_notify_func_t) &C.wl_listener
fn C.wl_client_add_destroy_late_listener(client &C.wl_client, listener &C.wl_listener)
fn C.wl_client_get_destroy_late_listener(client &C.wl_client, notify Wl_notify_func_t) &C.wl_listener
fn C.wl_client_get_object(client &C.wl_client, id u32) &C.wl_resource
fn C.wl_client_post_no_memory(client &C.wl_client)
fn C.wl_client_post_implementation_error(client &C.wl_client, msg &char, ...voidptr)
fn C.wl_client_add_resource_created_listener(client &C.wl_client, listener &C.wl_listener)

type Wl_client_for_each_iterator_t = fn (resource &C.wl_resource, user_data voidptr) Wl_interator_result

fn C.wl_client_for_each_resource(client &C.wl_client, iterator Wl_client_for_each_iterator_t, user_data voidptr)

type Wl_user_data_destroy_func_t = fn (data voidptr)

fn C.wl_client_set_user_data(client &C.wl_client, data voidptr, dtor Wl_user_data_destroy_func_t)
fn C.wl_client_get_user_data(client &C.wl_client) voidptr
fn C.wl_client_set_max_buffer_size(client &C.wl_client, size usize)

pub struct C.wl_listener {
	link   C.wl_list
	notify Wl_notify_func_t
}

pub struct C.wl_signal {
	listener_list C.wl_list
}

fn C.wl_signal_init(signal &C.wl_signal)
fn C.wl_signal_add(signal &C.wl_signal, listener &C.wl_listener)
fn C.wl_signal_get(signal &C.wl_signal, notify Wl_notify_func_t) &C.wl_listener
fn C.wl_signal_emit(signal &C.wl_signal, data voidptr)
fn C.wl_signal_emit_mutable(signal &C.wl_signal, data voidptr)

type Wl_resource_destroy_func_t = fn (resource &C.wl_resource)

fn C.wl_resource_post_event(resource &C.wl_resource, opcode u32, ...u32)

// fn C.wl_resource_post_event_array(resource &C.wl_resource, opcode u32, args &C.wl_argument)
// ...can't be bothered

fn C.wl_resource_post_no_memory(resource &C.wl_resource)

fn C.wl_client_get_display(client &C.wl_client) &C.wl_display
fn C.wl_resource_create(client &C.wl_client, interface, &C.wl_interface, version int, id u32) &C.wl_resource
fn C.wl_resource_set_implementation(resource &C.wl_resource, implementation voidptr, data voidptr, destroy Wl_resource_destroy_func_t)
fn C.wl_resource_set_dispatcher(resource &C.wl_resource, dispatcher Wl_dispatcher_func_t, data voidptr, destroy Wl_resource_destroy_func_t)
fn C.wl_resource_destroy(resource &C.wl_resource)
fn C.wl_resource_get_id(resource &C.wl_resource) u32
fn C.wl_resource_get_link(resource &C.wl_resource) &C.wl_list
fn C.wl_resource_from_link(link &C.wl_list) &C.wl_resource
fn C.wl_resource_find_for_client(list &C.wl_list, client &C.wl_client) &C.wl_resource
fn C.wl_resource_get_client(resource &C.wl_resource) &C.wl_client
fn C.wl_resource_set_user_data(resource &C.wl_resource, data voidptr)
fn C.wl_resource_get_user_data(resource &C.wl_resource) voidptr
fn C.wl_resource_get_version(resource &C.wl_resource) int
fn C.wl_resource_set_destructor(resource &C.wl_resource, destructor Wl_resource_destroy_func_t)
fn C.wl_resource_instance_of(resource &C.wl_resource, interface, &C.wl_interface, implementation voidptr) int
fn C.wl_resource_get_class(resource &C.wl_resource) &char
fn C.wl_resource_get_interface(resource &C.wl_resource) &C.wl_interface
fn C.wl_resource_add_destroy_listener(resource &C.wl_resource, listener &C.wl_listener)
fn C.wl_resource_get_destroy_listener(resource &C.wl_resource, notify Wl_notify_func_t) &C.wl_listener

// fn C.wl_shm_buffer_get(resource &C.wl_resource) &C.wl_shm_buffer
// n C.wl_shm_buffer_begin_access(buffer &C.wl_shm_buffer)
// n C.wl_shm_buffer_end_access(buffer &C.wl_shm_buffer)
// n C.wl_shm_buffer_get_data(buffer &C.wl_shm_buffer) voidptr
// n C.wl_shm_buffer_get_stride(buffer &C.wl_shm_buffer) i32
// n C.wl_shm_buffer_get_format(buffer &C.wl_shm_buffer) u32
// n C.wl_shm_buffer_get_width(buffer &C.wl_shm_buffer) i32
// n C.wl_shm_buffer_get_height(buffer &C.wl_shm_buffer) i32
// n C.wl_shm_buffer_ref(buffer &C.wl_shm_buffer) &C.wl_shm_buffer
// n C.wl_shm_buffer_unref(buffer &C.wl_shm_buffer)
// n C.wl_shm_buffer_ref_pool(buffer &C.wl_shm_buffer) &C.wl_shm_pool
// n C.wl_shm_pool_unref(pool &C.wl_shm_pool)

fn C.wl_display_init_shm(display &C.wl_display) int
fn C.wl_display_add_shm_format(display &C.wl_display, format u32) &u32

fn C.wl_log_set_handler_server(handler Wl_log_func_t)

pub enum Wl_protocol_logger_type {
	request
	event
}

// pub struct Wl_protocol_logger_message {
// pub:
//	resource        &C.wl_resource
//	message_opcode  int
//	message         &C.wl_message
//	arguments_count int
//	arguments       &C.wl_argument
//}
