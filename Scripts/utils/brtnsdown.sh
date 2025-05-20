#!/bin/bash

brightnessctl set 5%-
notify-send --expire-time=500 --replace-id=1 "Brightness: $(echo $(brightnessctl i | awk -F '(' '{ print $2 }' | awk -F ')' '{ print $1 }'))"
kill -47 $(pidof dwmblocks)
