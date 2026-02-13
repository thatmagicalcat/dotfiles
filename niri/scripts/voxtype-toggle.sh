#!/bin/sh

STATE_FILE="/tmp/voxtype_recording_state"

if [ -f "$STATE_FILE" ]; then
    voxtype record stop
    rm "$STATE_FILE"
    notify-send -t 1000 "VoxType" "Recording Stopped"
else
    voxtype record start
    touch "$STATE_FILE"
    notify-send -t 1000 "VoxType" "Recording Started"
fi