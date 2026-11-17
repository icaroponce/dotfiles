#!/bin/sh
userresources=$HOME/.Xresources
wallpaper=~/dotfiles/wallpapers/solar-system.jpg

# Let systemd/dbus-started apps (blueman-manager...) reach this X display (Arch did this in xinitrc.d).
dbus-update-activation-environment --systemd DISPLAY XAUTHORITY

# No idle lock: xss-lock only locks on suspend (or Super+Shift+q). DPMS still powers the screen off.
xset s off

xrdb -merge $userresources
[ -f "${wallpaper}" ] && feh --bg-scale "$wallpaper"

# xmonad recompiles ~/.config/xmonad/xmonad.hs itself when it changed.
exec xmonad
