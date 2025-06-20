#!/bin/bash

pactl set-sink-mute @DEFAULT_SINK@ toggle
notify-send --expire-time=500 --replace-id=1 $(pactl get-sink-mute @DEFAULT_SINK@)
kill -44 $(pidof dwmblocks)
