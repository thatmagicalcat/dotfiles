#!/bin/bash

DEVICE_NAME="ELAN1300:00 04F3:3087 Touchpad"
STATE=$(xinput list-props "$DEVICE_NAME" | grep "Device Enabled (" | awk '{print $NF}')

if [ "$STATE" -eq 1 ]; then
  xinput set-prop "$DEVICE_NAME" "Device Enabled" 0
else
  xinput set-prop "$DEVICE_NAME" "Device Enabled" 1
fi
