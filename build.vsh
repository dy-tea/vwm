#!/usr/bin/env -S v

fn sh(cmd string) {
  println('INFO: Running \'${cmd}\'')
  print(execute_or_exit(cmd).output)
}

name := 'vompositor'
protocol := 'xdg-shell_protocol.h'

// Generate xdg-shell-protocol.h if required
if ls('.')!.contains(protocol) {
  println("INFO: ${protocol} already exists, skipping")
} else {
  println("INFO: Generating ${protocol}")
  sh('wayland-scanner server-header $(pkg-config --variable=pkgdatadir wayland-protocols)/stable/xdg-shell/xdg-shell.xml ${protocol}')
}

// Build
sh('v -cg -show-c-output crun .')
