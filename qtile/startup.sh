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
/usr/lib/pam_kwallet_init &
# wait for kwallet to unlock before launching nextcloud
sleep 60 && nextcloud &
