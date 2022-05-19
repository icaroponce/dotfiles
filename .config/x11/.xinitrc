#!/bin/sh
userresources=$HOME/.Xresources
wallpaper=~/dotfiles/wallpapers/solar-system.jpg

xrdb -merge $userresources
[ -f "${wallpaper}" ] && feh --bg-scale "$wallpaper"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/x11/xprofile" ] && . "${XDG_CONFIG_HOME:-$HOME/.config}/x11/xprofile"

exec xmonad-x86_64-linux
