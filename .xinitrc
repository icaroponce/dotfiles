#!/bin/sh
userresources=$HOME/.Xresources
wallpaper=~/dotfiles/wallpapers/solar-system.jpg

xrdb -merge $userresources
[ -f "${wallpaper}" ] && feh --bg-scale "$wallpaper"

# xmonad recompiles ~/.config/xmonad/xmonad.hs itself when it changed.
exec xmonad
