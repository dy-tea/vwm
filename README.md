# wlroots compositor written in V (WIP)

Currently implementing a basic compositor based off [tinywl](https://gitlab.freedesktop.org/wlroots/wlroots/-/blob/master/tinywl/tinywl.c?ref_type=heads).

Contributions are welcome, as well as suggestions on how to improve the [wlroots bindings](src/wlr).

# Building
This project depends on the following packages:
- `wlroots` **0.19** (on arch this is `wlroots-git`)
- `wayland`
- `wayland-protocols`
- `libdrm`
- `xkbcommon`
- `udev`
- `xkbcommon`
- `pixman`
- `libseat`

X dependencies:
- `xwayland`
- `libxcb`
- `libxcb-render-util`
- `libxcb-wm`
- `libxcb-errors`

**NOTE: The project does not currently build due to various isses with cgen in V.**

If you want to try diagnosing issues, you can generate the necessary protocol file by running `v run build.vsh`, which will also attempt to compile and run the compositor.
