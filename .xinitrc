#!/bin/sh
userresources=$HOME/.Xresources
wallpaper=~/dotfiles/wallpapers/solar-system.jpg

# Let systemd/dbus-started apps (blueman-manager...) reach this X display (Arch did this in xinitrc.d).
dbus-update-activation-environment --systemd DISPLAY XAUTHORITY
# startx has no display manager to start graphical-session.target (needed by xdg-desktop-portal).
systemctl --user start nixos-fake-graphical-session.target

# Idle: lock after 15 min (screensaver timer -> xss-lock -> i3lock), screen off after 16 min (DPMS).
# Note: DPMS turning the screen off also forces the screensaver, so it always locks too.
# xss-lock also locks before suspend; Super+Shift+q locks manually.
xset s 900 0
xset dpms 960 960 960

xrdb -merge $userresources
[ -f "${wallpaper}" ] && feh --no-fehbg --bg-fill "$wallpaper"

# xmonad recompiles ~/.config/xmonad/xmonad.hs itself when it changed.
xmonad
systemctl --user stop nixos-fake-graphical-session.target
