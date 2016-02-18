#!/bin/bash
# TODO: sync toggle states

xwininfo -root |sed -n -e "s/^ \+Width: \([0-9]\+\).*/\1/p" -e "s/^ \+Height: \([0-9]\+\).*/\1/p" | xargs | while read width height; do
    width_p=$((${width}*$1/100))
    height_p=$((${height}*$1/100))
    awesome_float_toggle.sh;
    wmctrl -r :ACTIVE: -b toggle,above,sticky;
    wmctrl -r :ACTIVE: -e 0,$((${width}-${width_p})),0,$width_p,$height_p;
done
