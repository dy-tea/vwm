module main

import os
import flag

import src { Server }
import wlr.util

fn main() {
	C.wlr_log_init(.debug, unsafe { nil })

	mut fp := flag.new_flag_parser(os.args)
	fp.application('vwm')
	fp.version('0.0.0')
	fp.limit_free_args(0, 0)!
	fp.description('v wayland window manager')
	fp.skip_executable()

	startup_cmd := fp.string('startup', `s`, '', 'startup command')
	fp.finalize() or {
		eprintln(err)
		println(fp.usage())
		return
	}

	server := Server.new()
	code := server.run(startup_cmd)
	if code != 0 {
		exit(code)
	}
	server.destroy()
}
