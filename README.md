# Personal Dotfiles

Arch Linux + macOS setup with xmonad, kitty, neovim, zsh, and more.
Managed with [GNU Stow](https://www.gnu.org/software/stow/).

---

## Directory Structure

```
~/dotfiles/
├── .config/
│   ├── dunst/        # Notification daemon (Linux)
│   ├── fontconfig/   # Font configuration (Linux)
│   ├── haskell/      # Haskell tools (fourmolu.yaml, justfile template)
│   ├── kitty/        # Terminal emulator
│   ├── newsboat/     # RSS reader
│   ├── nix/          # Nix config
│   ├── nixpkgs/      # Nix packages
│   ├── nvim/         # Neovim
│   ├── picom/        # Compositor (Linux)
│   ├── shell/        # Shell profile & aliases (cross-platform)
│   ├── xmonad/       # Window manager (Linux)
│   ├── zathura/      # PDF viewer (Linux)
│   └── zsh/          # Zsh config
├── .local/
│   └── bin/          # Custom scripts
├── .stack/
│   └── config.yaml   # Stack global config
├── wallpapers/       # Desktop wallpapers
├── .xinitrc          # X session entry point (Linux)
├── .Xresources       # X resources (Linux)
├── .xserverrc        # X server config (Linux)
├── .profile          # -> .config/shell/profile
├── .zprofile         # -> .config/shell/profile
├── .nix-channels     # Nix channels
└── etc/              # System config references (manual, see below)
```

---

## Setup

### Linux (Arch)

```bash
yay -S stow
git clone git@github.com:you/dotfiles.git ~/dotfiles
cd ~/dotfiles && stow .

# Kitty font size override (Linux uses smaller size than macOS default)
ln -sf kitty.linux.conf ~/.config/kitty/kitty.local.conf

# Build xmonad
cd ~/.config/xmonad && just build
```

### macOS

```bash
brew install stow
git clone git@github.com:you/dotfiles.git ~/dotfiles
cd ~/dotfiles && stow .

# Kitty font size: macOS default (18) is already set in kitty.conf — nothing to do
```

### After adding or removing files from dotfiles

```bash
cd ~/dotfiles && stow -R .
```

---

## OS-specific config

Files that differ between Linux and macOS are handled inline — no duplicate files needed.

| File | Mechanism |
|------|-----------|
| `kitty.conf` | `font_size 18` (macOS default) + `include kitty.local.conf` for overrides |
| `kitty.linux.conf` | `font_size 10` — symlinked to `kitty.local.conf` on Linux |
| `shell/profile` | `if [ "$(uname)" = "Darwin" ]` blocks for brew, BROWSER, QT vars |
| `shell/aliasrc` | `if [ "$(uname)" = "Darwin" ]` for clipboard (`pbcopy` vs `xclip`) and `ls` flags |

---

## XMonad

```bash
cd ~/.config/xmonad
just build    # builds xmonad + xmobar, symlinks binaries
just restart  # restart xmonad in-place (no logout)
```

Binary must be at `~/.local/bin/xmonad-x86_64-linux`. See [xmonad/README.md](.config/xmonad/README.md) for keybindings.

---

## Startup Flow (Linux)

1. **Login** → `.zprofile` → `.config/shell/profile`
2. **startx** → `.xinitrc` which:
   - Loads `.Xresources`
   - Sets wallpaper via `feh`
   - Executes `xmonad-x86_64-linux`

---

## Environment Variables

| Variable | Linux | macOS |
|----------|-------|-------|
| `EDITOR` | nvim | nvim |
| `TERMINAL` | kitty | kitty |
| `BROWSER` | brave | open |
| `READER` | zathura | — |
| `XDG_CONFIG_HOME` | ~/.config | ~/.config |
| `ZDOTDIR` | ~/.config/zsh | ~/.config/zsh |

---

## Dependencies

### Cross-platform
- **Terminal**: kitty + Hack / LiterationMono Nerd Font
- **Shell**: zsh
- **Editor**: neovim
- **Dotfiles**: stow
- **Task runner**: just
- **Haskell**: ghcup (GHC/HLS/stack), fourmolu (static binary in ~/.local/bin)

### Linux only
- **WM**: xmonad, xmonad-contrib, xmobar
- **Launcher**: rofi
- **Notifications**: dunst
- **Compositor**: picom
- **PDF**: zathura
- **Browser**: brave
- **Clipboard**: xclip
- **Font packages**: `ttf-hack-nerd`, `ttf-liberation-mono-nerd`

### macOS only
- **Package manager**: homebrew
- **Font**: `brew install --cask font-hack-nerd-font`

---

## System config (manual, one-time)

These files target `/etc/` and are not managed by stow. Apply once per machine with sudo.

**`/etc/vconsole.conf`**
```
KEYMAP=ANSI-dvorak
FONT=ter-v24n
```

**`/etc/X11/xorg.conf.d/00-keyboard.conf`**
```
Section "InputClass"
    Identifier "system-keyboard"
    MatchIsKeyboard "on"
    Option "XkbLayout" "us"
    Option "XkbVariant" "altgr-intl"
EndSection
```
