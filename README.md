# Personal Dotfiles

Arch Linux setup with xmonad, kitty, neovim, zsh, and more.

---

## Directory Structure

```
~/dotfiles/
├── .config/
│   ├── dunst/        # Notification daemon
│   ├── fontconfig/   # Font configuration
│   ├── kitty/        # Terminal emulator
│   ├── newsboat/     # RSS reader
│   ├── nix/          # Nix config
│   ├── nixpkgs/      # Nix packages
│   ├── nvim/         # Neovim
│   ├── picom/        # Compositor
│   ├── shell/        # Shell profile & aliases
│   ├── x11/          # X11 config (.xinitrc, xprofile)
│   ├── xmonad/       # Window manager
│   ├── zathura/      # PDF viewer
│   └── zsh/          # Zsh config
├── .local/
│   └── bin/          # Custom scripts
├── etc/              # System config references
├── wallpapers/       # Desktop wallpapers
├── .Xresources       # X resources
├── .xserverrc        # X server config
├── .profile          # -> .config/shell/profile
├── .zprofile         # -> .config/shell/profile
└── .nix-channels     # Nix channels
```

---

## Symlink Setup

### Home Directory Symlinks (~/)

These files need to be symlinked directly in your home directory:

```bash
# Profile files
ln -sf ~/dotfiles/.profile ~/.profile
ln -sf ~/dotfiles/.zprofile ~/.zprofile

# X11 files
ln -sf ~/dotfiles/.Xresources ~/.Xresources
ln -sf ~/dotfiles/.xserverrc ~/.xserverrc
ln -sf ~/dotfiles/.config/x11/.xinitrc ~/.xinitrc

# Nix
ln -sf ~/dotfiles/.nix-channels ~/.nix-channels
```

### Config Directory Symlinks (~/.config/)

These directories are symlinked into `~/.config/`:

```bash
# Create symlinks for all config directories
ln -sf ~/dotfiles/.config/dunst ~/.config/dunst
ln -sf ~/dotfiles/.config/fontconfig ~/.config/fontconfig
ln -sf ~/dotfiles/.config/kitty ~/.config/kitty
ln -sf ~/dotfiles/.config/newsboat ~/.config/newsboat
ln -sf ~/dotfiles/.config/nix ~/.config/nix
ln -sf ~/dotfiles/.config/nixpkgs ~/.config/nixpkgs
ln -sf ~/dotfiles/.config/nvim ~/.config/nvim
ln -sf ~/dotfiles/.config/picom ~/.config/picom
ln -sf ~/dotfiles/.config/shell ~/.config/shell
ln -sf ~/dotfiles/.config/x11 ~/.config/x11
ln -sf ~/dotfiles/.config/xmonad ~/.config/xmonad
ln -sf ~/dotfiles/.config/zathura ~/.config/zathura
ln -sf ~/dotfiles/.config/zsh ~/.config/zsh
```

### Quick Setup Script

Run all symlinks at once:

```bash
#!/bin/bash

DOTFILES=~/dotfiles

# Home directory
ln -sf $DOTFILES/.profile ~/.profile
ln -sf $DOTFILES/.zprofile ~/.zprofile
ln -sf $DOTFILES/.Xresources ~/.Xresources
ln -sf $DOTFILES/.xserverrc ~/.xserverrc
ln -sf $DOTFILES/.config/x11/.xinitrc ~/.xinitrc
ln -sf $DOTFILES/.nix-channels ~/.nix-channels

# .config directory
mkdir -p ~/.config
for dir in dunst fontconfig kitty newsboat nix nixpkgs nvim picom shell x11 xmonad zathura zsh; do
    ln -sf $DOTFILES/.config/$dir ~/.config/$dir
done

echo "Symlinks created!"
```

---

## XMonad Setup

After creating symlinks, build xmonad:

```bash
cd ~/.config/xmonad
./build ~/.local/bin/xmonad-x86_64-linux
```

Make sure `~/.local/bin` is in your PATH.

See [xmonad/README.md](.config/xmonad/README.md) for keybindings and usage.

---

## Startup Flow

1. **Login** loads `.zprofile` -> `.config/shell/profile`
2. **startx** runs `.xinitrc` which:
   - Loads `.Xresources`
   - Sets wallpaper via `feh`
   - Sources `.config/x11/xprofile`
   - Executes `xmonad-x86_64-linux`

---

## Environment Variables (from shell/profile)

| Variable | Value |
|----------|-------|
| `EDITOR` | nvim |
| `TERMINAL` | kitty |
| `BROWSER` | brave |
| `READER` | zathura |
| `XDG_CONFIG_HOME` | ~/.config |
| `XDG_DATA_HOME` | ~/.local/share |
| `XDG_CACHE_HOME` | ~/.cache |
| `ZDOTDIR` | ~/.config/zsh |

---

## Dependencies

Core packages needed:

- **WM**: xmonad, xmonad-contrib, xmobar
- **Terminal**: kitty
- **Shell**: zsh
- **Editor**: neovim
- **Launcher**: rofi
- **Notifications**: dunst
- **Compositor**: picom
- **PDF**: zathura
- **Browser**: brave
- **Build**: stack (for xmonad), pyenv, nix

---

## Notes

- The `.profile` and `.zprofile` in dotfiles root are symlinks to `.config/shell/profile`
- xmonad binary must be at `~/.local/bin/xmonad-x86_64-linux` for `.xinitrc` to find it
- Wallpaper is set from `~/dotfiles/wallpapers/solar-system.jpg`
