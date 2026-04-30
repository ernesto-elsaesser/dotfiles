# Files

- [bashrc](bashrc) should be sourced from `~/.bashrc`
- [vimrc](vimrc) is loaded via the aliases in bashrc
- [keymap](keymap) contains scripts to remap keyboard and mouse buttons
- [nvim](nvim) contains neovim Lua scripts
- [RULES.md](RULES.md) should be used as global context for coding agents

## Vim / Neovim

The `vimrc` contains mappings for German umlaut keys, intended for German keyboard layouts.

Lua scripts automatically loaded from `vimrc` by Neovim:

- [term.lua](nvim/term.lua) - send commands to a link terminal buffer
- [git.lua](nvim/git.lua) - show git diff via signs and diagnostics items
- [lsp.lua](nvim/lsp.lua) - LSP client configuration
- [ollama.lua](nvim/ollama.lua) - code completions via local LLM

## Key Mapping

### CapsLock > Control

Configuration files to map CapsLock to Control under Linux and Windows:

- [caps-to-ctrl.map](keymap/caps-to-ctrl.map) should be loaded via `loadkeys`
  - Parital patch to currently loaded console (TTY) keymap
- [caps-to-ctrl.conf](keymap/caps-to-ctrl.conf) should be copied into `/etc/X11/xorg.conf.d/`
  - Sets `XkbOptions` for any X11 keyboard device
- [caps-to-ctrl.reg](keymap/caps-to-ctrl.reg) should be executed under Windows
  - Maps scancodes via Registry entry

### Mouse Buttons

[mouse-buttons.hwdb](keymap/mouse-buttons.hwdb) is a HWDB entry that maps:

- Side Button 1 (Mouse 4): Enter
- Side Button 2 (Mouse 5): Backspace

It should be copied into `/etc/udev/hwdb.d/` (e.g. as `90-mouse-btns.conf`).

