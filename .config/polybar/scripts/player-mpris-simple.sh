#!/bin/sh

player_status=$(playerctl -p spotify status 2> /dev/null)
artist=$(playerctl -p spotify metadata artist 2> /dev/null)
title=$(playerctl -p spotify metadata title 2> /dev/null)
label="$artist - $title"

if [ "$player_status" = "Playing" ]; then
    echo "  $label"
elif [ "$player_status" = "Paused" ]; then
    echo "  $label"
else
    echo ""
fi
