# XMonad Cheatsheet

**Mod Key:** `Super` (Windows key)

---

## Applications

| Keybinding | Action |
|------------|--------|
| `Super + Return` | Open terminal (kitty) |
| `Super + o` | Focus browser if open, spawn otherwise (brave) |
| `Super + d` | Open rofi launcher (window/drun/ssh) |
| `Super + c` | Open clipboard history (greenclip) |
| `Super + Shift + q` | Lock screen (i3lock-fancy-rapid) |

---

## Scratchpads

Floating windows that persist their state when hidden.

| Keybinding | Action |
|------------|--------|
| `Super + s` | Toggle terminal scratchpad (kitty) |
| `Super + v` | Toggle volume mixer (pavucontrol) |

---

## Window Management

| Keybinding | Action |
|------------|--------|
| `Super + Shift + c` | Kill focused window |
| `Super + f` | Toggle fullscreen |
| `Super + Shift + f` | Float / sink toggle |
| `Super + t` | Focus next window |
| `Super + n` | Focus previous window |
| `Super + Shift + t` | Swap with next window |
| `Super + Shift + n` | Swap with previous window |
| `Super + a` | Shrink focused window vertically |
| `Super + z` | Grow focused window vertically |
| `Super + g` | Go to any window (across all workspaces) |
| `Super + Shift + g` | Bring any window to current workspace |

---

## Workspaces

| Keybinding | Action |
|------------|--------|
| `Super + Left` | Go to previous non-empty workspace |
| `Super + Right` | Go to next non-empty workspace |
| `Super + Tab` | Toggle to most recent workspace |

---

## Notifications (Dunst)

| Keybinding | Action |
|------------|--------|
| `Alt + Space` | Close notification |
| `Alt + Shift + Space` | Close all notifications |
| `Alt + Escape` | Show notification history |

---

## Screenshots

Saved to `~/Screenshots/`

| Keybinding | Action |
|------------|--------|
| `Print` | Flameshot GUI |
| `Super + Shift + Print` | Selection screenshot (scrot `-s`) |
| `Super + Print` | Upload screenshot (scrot `-u`) |

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

1. **ResizableTall** — master left, stack right; `Super + a`/`z` resize stack windows vertically
2. **Mirror ResizableTall** — master top, stack bottom
3. **ThreeColMid** — master in center, two columns on sides

`Super + f` toggles borderless fullscreen over any layout.

---

## Default XMonad Keys (not overridden)

| Keybinding | Action |
|------------|--------|
| `Super + Space` | Cycle layouts |
| `Super + Shift + Space` | Reset to default layout |
| `Super + h` / `Super + l` | Shrink/Expand master pane |
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
- Blueman-manager
- Arandr

---

## Startup Apps

Managed by `myStartupHook` via `spawnOnce` (won't re-launch on `Super + q` restart):

- `picom` — compositor
- `dunst` — notification daemon
- `nm-applet` — network manager tray icon
- `blueman-applet` — Bluetooth tray icon
- `unclutter` — hide cursor when idle
- `stalonetray` — system tray
- `greenclip daemon` — clipboard history

`autorandr --change` runs on every restart and on monitor plug/unplug.

---

## Build & Restart

No build step. Edit, then `Super + q` (or `just restart`):

1. xmonad recompiles `xmonad.hs` (binary in `~/.cache/xmonad/`) and restarts in place.
2. The restart also restarts xmobar, which recompiles `~/.config/xmobar/xmobar.hs` if it changed
   (binary next to the source, gitignored).

`just check` compiles `xmonad.hs` without restarting, to see errors.
Compile errors: xmonad shows them in an xmessage window; xmobar's go to `~/.local/share/xmobar/xmobar.errors`.

---

## Configuration Files

| File | Purpose |
|------|---------|
| `xmonad.hs` | Main WM config, keybindings, layouts |
| `~/.config/xmobar/xmobar.hs` | Status bar config |
| `justfile` | check / restart / format / lint / repl |
| `~/.config/dunst/dunstrc` | Notification daemon config |

---

## Xmobar Status Bar

Shows: Haskell icon | workspaces | windows → volume | battery | cpu | memory | weather (EDDB) | date/time
