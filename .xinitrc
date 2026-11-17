#!/bin/sh
userresources=$HOME/.Xresources
wallpaper=~/dotfiles/wallpapers/solar-system.jpg

# Let systemd/dbus-started apps (blueman-manager...) reach this X display (Arch did this in xinitrc.d).
dbus-update-activation-environment --systemd DISPLAY XAUTHORITY

# Idle: lock after 15 min (screensaver timer -> xss-lock -> i3lock), screen off after 16 min (DPMS).
# Note: DPMS turning the screen off also forces the screensaver, so it always locks too.
# xss-lock also locks before suspend; Super+Shift+q locks manually.
xset s 900 0
xset dpms 960 960 960

xrdb -merge $userresources
[ -f "${wallpaper}" ] && feh --bg-scale "$wallpaper"

# xmonad recompiles ~/.config/xmonad/xmonad.hs itself when it changed.
exec xmonad
