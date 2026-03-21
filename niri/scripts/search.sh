#!/usr/bin/env bash

TEXT=$(wl-paste -n -t text/plain 2> /dev/null); [ -n "$TEXT" ] && zen "https://google.com/search?q=$TEXT" && niri msg action focus-window --id $(niri msg -j windows | jq -r '.[] | select(.app_id | test("zen-beta")) | .id')
