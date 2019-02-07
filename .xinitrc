#!/bin/sh
userresources=$HOME/.Xresources
#usermodmap=$HOME/.Xmodmap

xrdb -merge $userresources
feh --bg-scale ~/dotfiles/wallpapers/firewatcher.jpg

exec i3
