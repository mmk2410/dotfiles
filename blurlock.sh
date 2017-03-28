#!/bin/sh
scrot /tmp/lock.png
convert /tmp/lock.png -modulate 70,20 -blur 0x4 /tmp/lock.png
i3lock -i /tmp/lock.png
