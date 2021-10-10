#!/bin/sh
userresources=$HOME/.Xresources
wallpaper=~/dotfiles/wallpapers/streets.jpg

xrdb -merge $userresources
[ -f "${wallpaper}" ] && feh --bg-scale "$wallpaper"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/x11/xprofile" ] && . "${XDG_CONFIG_HOME:-$HOME/.config}/x11/xprofile"

if [[ $(xrandr -q | grep "HDMI-1-1 connected") ]]; then
    sudo xrandr --output eDP1 --primary --mode 1920x1080 --rotate normal \
        --output HDMI-1-1 --mode 1920x1080 --rate 60.00 --rotate normal --right-of eDP1
fi

exec bspwm
