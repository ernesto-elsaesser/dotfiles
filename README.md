# Files

- [bashrc](bashrc) should be sourced from `~/.bashrc`
- [vimrc](vimrc) is loaded via the `vim` alias in bashrc
  - [gitsigns.vim](gitsigns.vim) contains code to show git diffs via vim signs
- [RULES.md](RULES.md) contains general instructions for coding agents
- [keymap/](keymap/) contains scripts to remap keyboard and mouse buttons

The `vimrc` contains mappings for German umlaut keys, and thus works best with German keyboards.

## Bash Hook

```bash
echo "source $HOME/dotfiles/bashrc" >> $HOME/.bashrc
```

## Python

Install `uv`:

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

To install a GPU wheel of `PyTorch`:

```bash
uv pip install torch --torch-backend=auto
```

See [Using uv with PyTorch](https://docs.astral.sh/uv/guides/integration/pytorch/)

## Coding Agent

Install Antigravity CLI:

```bash
curl -fsSL https://antigravity.google/cli/install.sh | bash
```

Then run `agy` once and login.

Link `RULES.md`:

```bash
ln -s $HOME/dotfiles/RULES.md $HOME/.gemini/GEMINI.md
```

The scrollback buffer works as expected (Ctrl+W N).

## Key Mapping

### Caps Lock As Ctrl

Configuration files to map CapsLock to Control

#### Linux

In KDE Plasma 6:

1. Go to Settings > Keyboard > Key Bindings
2. Enable "Configure keyboard options"
3. Under "Ctrl position" enable "Caps Lock as Ctrl"
4. Click "Apply"

Otherwise copy [caps-to-ctrl.conf](keymap/caps-to-ctrl.conf) into `/etc/X11/xorg.conf.d/`:

```bash
sudo cp keymap/caps-to-ctrl.conf /etc/X11/xorg.conf.d/99-caps-to-ctrl.conf
```

When working in the console (TTY), load [caps-to-ctrl.map](keymap/caps-to-ctrl.map)
via `loadkeys` to patch the current keymap:

```bash
loadkeys keymap/caps-to-ctrl.map
```

#### Windows

Install [caps-to-ctrl.reg](keymap/caps-to-ctrl.reg) to remap scancodes via Registry.

### Mouse Buttons

[mouse-buttons.hwdb](keymap/mouse-buttons.hwdb) is a HWDB entry that maps:

- Side Button 1 (Mouse 4): Enter
- Side Button 2 (Mouse 5): Backspace

It should be copied into `/etc/udev/hwdb.d/` (e.g. as `90-mouse-btns.conf`).

[mouse-buttons.ahk](keymap/mouse-buttons.ahk) is an AutoHotkey script that performs that same mapping (usable on Windows).
