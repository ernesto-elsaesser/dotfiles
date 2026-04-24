# Files

- [bashrc](bashrc) should be sourced from `~/.bashrc`
- [vimrc](vimrc) is loaded via the aliases in bashrc
- [git-diag.lua](git-diag.lua) is sourced by vimrc (if using neovim)
- [gitconfig](gitconfig) should be copied to `~/.gitconfig`
- [RULES.md](RULES.md) should be used as global context for coding agents
- [key-mapping](key-mapping) contains scripts to remap keyboard and mouse buttons

## Vim / Neovim

The `vimrc` contains mappings for German umlaut keys, intended for German keyboard layouts.

The `git-diag.lua` script defines a custom command to show the git diff for
the current file as signs and diagnostics items.

## Key Mapping

### CapsLock > Control

Configuration files to map CapsLock to Control under Linux and Windows:

- [caps-to-ctrl.map](key-mapping/caps-to-ctrl.map) should be loaded via `loadkeys`
  - Parital patch to currently loaded console (TTY) keymap
- [caps-to-ctrl.conf](key-mapping/caps-to-ctrl.conf) should be copied into `/etc/X11/xorg.conf.d/`
  - Sets `XkbOptions` for any X11 keyboard device
- [caps-to-ctrl.reg](key-mapping/caps-to-ctrl.reg) should be executed under Windows
  - Maps scancodes via Registry entry

### Mouse Buttons

[mouse-buttons.hwdb](key-mapping/mouse-buttons.hwdb) is a HWDB entry that maps:

- Side Button 1 (Mouse 4): Enter
- Side Button 2 (Mouse 5): Backspace

It should be copied into `/etc/udev/hwdb.d/` (e.g. as `90-mouse-btns.conf`).

