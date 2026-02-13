#!/bin/sh

# Get the first temp line from sensors output matching "Core 0"
TEMP=$(sensors | grep -m 1 'Core 0' | awk '{print $3}' | tr -d '+°C')

# Fallback if Core 0 not found
if [ -z "$TEMP" ]; then
  TEMP=$(sensors | grep -m 1 -E 'temp1' | awk '{print $2}' | tr -d '+°C')
fi

# Cut off any decimal part
TEMP_INT=${TEMP%.*}

# Emoji thermometer + color
if [ "$TEMP_INT" -ge 80 ]; then
  ICON=""
elif [ "$TEMP_INT" -ge 65 ]; then
  ICON=""
elif [ "$TEMP_INT" -ge 50 ]; then
  ICON=""
else
  ICON=""
fi

echo "${ICON} ${TEMP_INT}°C"
