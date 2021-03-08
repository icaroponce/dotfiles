#!/bin/sh
player="spotifyd"
player_status=$(playerctl -p "$player" status 2> /dev/null)
artist=$(playerctl -p "$player" metadata artist 2> /dev/null)
title=$(playerctl -p "$player" metadata title 2> /dev/null)
label="$artist - $title"

if [ "$player_status" = "Playing" ]; then
    echo "  $label"
elif [ "$player_status" = "Paused" -o "$player_status" = "Stopped" ]; then
    echo "  $label"
else
    echo ""
fi
