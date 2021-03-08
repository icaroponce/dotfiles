#!/bin/sh
userresources=$HOME/.Xresources

xrdb -merge $userresources
feh --bg-scale ~/dotfiles/wallpapers/space-earth.jpg
#ibus-daemon -drx

exec i3
