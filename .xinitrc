#!/bin/sh
userresources=$HOME/.Xresources
wallpaper=~/dotfiles/wallpapers/solar-system.jpg

xrdb -merge $userresources
[ -f "${wallpaper}" ] && feh --bg-scale "$wallpaper"
exec xmonad-x86_64-linux
