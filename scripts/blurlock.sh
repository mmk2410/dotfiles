#!/bin/sh
scrot /tmp/lock.png
convert /tmp/lock.png -modulate 70,20 -blur 0x8 /tmp/lock.png
i3lock -i /tmp/lock.png
