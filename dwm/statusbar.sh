#/bin/bash

echo "$@" | socat - UNIX-CONNECT:/tmp/dwm-statusbar.sock
