#!/bin/sh
status=$(playerctl status 2>/dev/null)

if [ "$status" = "Playing" ] || [ "$status" = "Paused" ]; then
    icon=$([ "$status" = "Playing" ] && echo "⏸" || echo "▶")
    full_title=$(playerctl metadata --format '{{title}} - {{artist}}')

    max_len=25
    if [ ${#full_title} -gt $max_len ]; then
        display_title="${full_title:0:$max_len}..."
    else
        display_title="$full_title"
    fi

    printf '%s' "$icon $display_title" | jq -McRs \
        --arg tooltip "$full_title" \
        --arg class "${status,,}" \
        '{ text: ., tooltip: $tooltip, class: $class }'
else
    jq -Mc -n '{ text: "", tooltip: "", class: "stopped" }'
fi
