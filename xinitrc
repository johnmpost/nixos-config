#!/bin/sh

picom &

# sets root background color
xsetroot -solid "#222222"

# sets key repeat delay (ms) and rate (repeats/sec)
xset r rate 200 25

# turns off power-saving screen blanking
xset s off
xset -dpms

# enables custom keymaps on session start
xmodmap ~/.Xmodmap

exec i3
