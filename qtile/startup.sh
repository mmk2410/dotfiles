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
exec --no-startup-id /usr/lib/pam_kwallet_initett
nextcloud &
