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
~/dotfiles/scripts/nextcloud-kwallet.sh &
