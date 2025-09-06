#!/bin/bash

. "${HOME}/.cache/wal/colors.sh"
CONFIG="${HOME}/.config/mako/config"

cat > "$CONFIG" << EOF
max-visible=3
sort=-time
output=HDMI-A-1
layer=top
anchor=top-right

font=JetbrainsMono Nerd Font 12
background-color=$color0
text-color=$color7
text-alignment=center
width=400
margin=10
padding=10
outer-margin=10
border-size=2
border-color=$color2
border-radius=0
progress-color=over $color3
icons=1
max-icon-size=64
icon-path=""
actions=1
default-timeout=4000
ignore-timeout=0
group-by=none
EOF

pkill mako || (mako & disown) && (mako & disown)
