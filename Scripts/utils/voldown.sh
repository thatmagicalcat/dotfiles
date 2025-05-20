#!/bin/bash
vol="$(pactl get-sink-volume @DEFAULT_SINK@ | awk -F' ' '{ print $5 }')"
if [ "$vol" != "0%" ]; then
    pactl set-sink-volume 0 -5%
    notify-send --expire-time=500 --replace-id=1 "Volume: $(pactl get-sink-volume 0 | awk -F' ' '{ print $5 }')"
fi
kill -44 $(pidof dwmblocks)
