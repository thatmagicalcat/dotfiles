#!/bin/sh

wpctl set-mute @DEFAULT_SINK@ toggle
notify-send --expire-time=500 --replace-id=1 $(wpctl get-volume @DEFAULT_SINK@ | awk '{print $3}' | sed 's/\[//;s/\]//')
