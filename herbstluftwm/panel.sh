#!/usr/bin/bash

# Inspired by the herbstluftwm panel configuration of DistroTube
# See: https://gitlab.com/dwt1/dotfiles/-/blob/master/.config/herbstluftwm/panel.sh

# If there is already a polybar, kill it and wait for it to shutdow
killall -q polybar
while pgrep -u $UID -x polybar > /dev/null; do sleep 1; done

if type "xrandr"; then
    for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
	MONITOR=$m polybar --reload main &
    done
else
    polybar --reload main &
fi
