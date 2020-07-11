#!/bin/sh

# Startup script for qtile
pulseaudio -D
emacs --daemon &
syncthing &
~/.fehbg &
xmodmap ~/.Xmodmap
picom -b
/usr/lib/kdeconnectd &
redshift &
nextcloud &
