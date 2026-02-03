# XMonad Cheatsheet

**Mod Key:** `Super` (Windows key)

---

## Applications

| Keybinding | Action |
|------------|--------|
| `Super + Return` | Open terminal (kitty) |
| `Super + o` | Open browser (brave) |
| `Super + d` | Open rofi launcher (window/drun/ssh) |
| `Super + Shift + q` | Lock screen (i3lock-fancy-rapid) |

---

## Screenshots

Saved to `~/Screenshots/`

| Keybinding | Action |
|------------|--------|
| `Print` | Full screenshot |
| `Super + Shift + Print` | Selection screenshot (`-s`) |
| `Super + Print` | Upload screenshot (`-u`) |

---

## Window Management

| Keybinding | Action |
|------------|--------|
| `Super + Shift + c` | Kill focused window |
| `Super + f` | Toggle fullscreen |
| `Super + t` | Focus next window |
| `Super + n` | Focus previous window |
| `Super + Shift + t` | Swap with next window |
| `Super + Shift + n` | Swap with previous window |

---

## Workspaces

| Keybinding | Action |
|------------|--------|
| `Super + Left` | Go to previous non-empty workspace |
| `Super + Right` | Go to next non-empty workspace |
| `Super + Shift + Tab` | Toggle to most recent workspace |

---

## Notifications (Dunst)

| Keybinding | Action |
|------------|--------|
| `Alt + Space` | Close notification |
| `Alt + Shift + Space` | Close all notifications |
| `Alt + Escape` | Show notification history |

---

## Media Keys

| Key | Action |
|-----|--------|
| `XF86AudioRaiseVolume` | Volume +5% |
| `XF86AudioLowerVolume` | Volume -5% |
| `XF86AudioMute` | Toggle mute |
| `XF86AudioPrev` | Previous track (spotify) |
| `XF86AudioNext` | Next track (spotify) |
| `XF86AudioPlay/Pause` | Play/Pause (spotify) |

---

## Layouts

Cycle layouts with `Super + Space` (default xmonad):

1. **Tall** - Master left, stack right (default)
2. **Mirror Tall** - Master top, stack bottom
3. **Full** - Single window fullscreen
4. **ThreeColMid** - Master in center, two columns on sides

---

## Default XMonad Keys (not overridden)

| Keybinding | Action |
|------------|--------|
| `Super + Space` | Cycle layouts |
| `Super + Shift + Space` | Reset to default layout |
| `Super + h/l` | Shrink/Expand master |
| `Super + ,` / `Super + .` | Inc/Dec master windows |
| `Super + [1-9]` | Switch to workspace |
| `Super + Shift + [1-9]` | Move window to workspace |
| `Super + Shift + Return` | Swap focused with master |
| `Super + m` | Focus master window |
| `Super + b` | Toggle xmobar struts |

---

## Floating Windows (auto-float)

- Galculator
- Gimp
- Lxappearance
- Pavucontrol

---

## Build & Restart

```bash
# Build xmonad and link the binary to your PATH
cd ~/.config/xmonad
./build ~/.local/bin/xmonad-x86_64-linux
```

The `build` script does the following:
1. Runs `stack build --reconfigure` in the xmonad config directory
2. Creates a hard link from the compiled `xmonadrc` binary to the specified path

After building, restart xmonad with `Super + q` (default binding).

---

## Configuration Files

| File | Purpose |
|------|---------|
| `xmonad.hs` | Main WM config, keybindings, layouts |
| `xmobar.hs` | Status bar config |
| `build` | Build script for Arch Linux (uses Stack) |

---

## Xmobar Status Bar

Shows: Haskell icon | workspaces | windows -> volume | battery | cpu | memory | weather (EDDB) | date/time
