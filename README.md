# Personal Dotfiles

NixOS + macOS setup with xmonad, kitty, neovim, zsh, and more.
Managed with [GNU Stow](https://www.gnu.org/software/stow/).

On NixOS, packages, fonts, X and the keyboard layout come from
[nix-config](https://github.com/icaroponce/nix-config) (private); this repo only holds app configs.
The old Arch Linux setup lives on the `arch` branch.

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
│   ├── nvim/         # Neovim
│   ├── picom/        # Compositor (Linux)
│   ├── xmobar/       # Status bar: xmobar.hs (Linux)
│   ├── xmonad/       # Window manager: xmonad.hs (Linux)
│   ├── zathura/      # PDF viewer (Linux)
│   └── zsh/          # Zsh config
├── .local/
│   └── bin/          # Custom scripts
├── wallpapers/       # Desktop wallpapers
├── .xinitrc          # X session entry point (Linux)
├── .Xresources       # X resources (Linux)
└── .zshenv           # Sets ZDOTDIR, sources .config/zsh/.zshenv (zsh bootstrap)
```

---

## Setup

### NixOS

```bash
git clone git@github.com:icaroponce/dotfiles.git ~/dotfiles
cd ~/dotfiles && stow --no-folding -t ~ .

# Kitty font size override (Linux uses smaller size than macOS default)
ln -sf kitty.linux.conf ~/.config/kitty/kitty.local.conf
```

`--no-folding` links files one by one instead of whole directories, so home-manager can put
files next to them (e.g. `~/.config/zsh/plugins/`) and xmonad/xmobar build output never lands
in this repo.

### macOS

```bash
brew install stow
git clone git@github.com:icaroponce/dotfiles.git ~/dotfiles
cd ~/dotfiles && stow -t ~ .

# Kitty font size: macOS default (18) is already set in kitty.conf — nothing to do
```

### After adding or removing files from dotfiles

```bash
cd ~/dotfiles && stow --no-folding -t ~ -R .
```

---

## OS-specific config

Files that differ between Linux and macOS are handled inline — no duplicate files needed.

| File | Mechanism |
|------|-----------|
| `kitty.conf` | `font_size 18` (macOS default) + `include kitty.local.conf` for overrides |
| `kitty.linux.conf` | `font_size 10` — symlinked to `kitty.local.conf` on Linux |
| `zsh/.zshenv` | `if [ "$(uname)" = "Darwin" ]` blocks for brew, BROWSER, QT vars |
| `zsh/aliases.zsh` | `if [ "$(uname)" = "Darwin" ]` for clipboard (`pbcopy` vs `xclip`) and `ls` flags |
| `zsh/.zshrc` | fzf integration: `~/.fzf.zsh` (macOS), `fzf --zsh` (NixOS) |

---

## XMonad + xmobar

Plain Haskell files, no build project:

- `~/.config/xmonad/xmonad.hs`: `xmonad` (NixOS module, with xmonad-contrib) recompiles it itself.
- `~/.config/xmobar/xmobar.hs`: `xmobar` (spawned by xmonad) recompiles it itself with the `ghc`
  on PATH, which nix-config provides with the xmonad, xmonad-contrib and xmobar libraries.

Both only recompile when the source is newer than the binary.

```bash
cd ~/.config/xmonad
just check    # compile xmonad.hs, show errors
just restart  # recompile + restart in place; xmobar restarts and recompiles too
```

See [xmonad/README.md](.config/xmonad/README.md) for keybindings.

---

## Startup Flow

### Linux

1. **Login** on tty1, then **startx** → `.xinitrc` which:
   - Loads `.Xresources`
   - Sets wallpaper via `feh`
   - Executes `xmonad`

### zsh (all platforms)

1. **Every shell** → `.zshenv` (sets `ZDOTDIR`, sources `.config/zsh/.zshenv` for PATH/env)
2. **Interactive shell** → `.config/zsh/.zshrc`

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

On NixOS all of these come from nix-config.

### Cross-platform
- **Terminal**: kitty + Hack / LiterationMono Nerd Font
- **Shell**: zsh
- **Editor**: neovim
- **Dotfiles**: stow
- **Task runner**: just

### Linux only
- **WM**: xmonad, xmonad-contrib, xmobar
- **Launcher**: rofi (+ greenclip)
- **Notifications**: dunst
- **Compositor**: picom
- **PDF**: zathura
- **Browser**: brave
- **Clipboard**: xclip

### macOS only
- **Package manager**: homebrew
- **Fonts**: `brew install --cask font-hack-nerd-font font-liberation-nerd-font`
