#!/bin/sh

# Startup script for qtile
pulseaudio -D
emacs --daemon &
syncthing &
~/.fehbg &
xmodmap ~/.Xmodmap
picom -b
/usr/lib/kdeconnectd &
/usr/bin/kdeconnect-indicator &
redshift-gtk &
nm-applet &
gnome-keyring-daemon --start
~/dotfiles/scripts/nextcloud-kwallet.sh &
keepassxc &
