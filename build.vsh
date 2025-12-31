#!/usr/bin/env -S v

import term

fn sh(cmd string) string {
	println('❯ ${cmd}')
	return execute_or_exit(cmd).output
}

fn err(msg string) {
	println(term.fail_message(msg))
	exit(1)
}

fn program_installed(name string) {
	if sh('which ${name}') == '' {
		err('program `${name}` not found')
	}
}

program_installed('pkg-config')
program_installed('wayland-scanner')

sh('wayland-scanner client-header protocols/wlr-layer-shell-unstable-v1.xml protocols/wlr-layer-shell-unstable-v1-protocol.h')
sh('v .')
