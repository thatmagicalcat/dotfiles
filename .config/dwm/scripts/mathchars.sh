#!/bin/fish

cat /home/wizard/Code/rust/math-chars/symbols.txt | dmenu -l 10 -X 400 -Y 400 -W 1100 -fn "JetBrainsMono:size=20" -p "run" -shf '#ffffff' -nhf '#ffffff' | awk -F' ' '{ print $NF }' | tr -d \n | xclip -selection clipboard
