#!/usr/bin/env -S v

import term

fn info(msg string) {
	println(term.yellow(term.underline('INFO') + ': ${msg}'))
}

fn sh(cmd string) {
	info('Running \'${cmd}\'')
	print(execute_or_exit(cmd).output)
}

name := 'vompositor'
protocol := 'xdg-shell_protocol.h'

// Generate xdg-shell-protocol.h if required
if ls('.')!.contains(protocol) {
	info('${protocol} already exists, skipping')
} else {
	info('Generating ${protocol}')
	sh('wayland-scanner server-header $(pkg-config --variable=pkgdatadir wayland-protocols)/stable/xdg-shell/xdg-shell.xml ${protocol}')
}

// Build
sh('v -cg -show-c-output crun .')
