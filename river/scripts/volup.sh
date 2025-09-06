#!/bin/bash

current_volume=$(wpctl get-volume @DEFAULT_SINK@ | awk '{print $2}' | sed 's/\[//;s/\]//')
if [ "$current_volume" != "1.0" ] && [ -z "$muted" ]; then
    wpctl set-volume @DEFAULT_SINK@ 5%+
    new_volume=$(wpctl get-volume @DEFAULT_SINK@ | awk '{print $2}' | sed 's/\[//;s/\]//')

	notify_text="Volume: $(printf "%.0f\n" $(echo "$new_volume * 100" | bc))%"
    makoctl dismiss && notify-send --expire-time=500 --replace-id=1 "$notify_text"
fi
