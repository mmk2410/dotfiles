#!/bin/sh
TERMINAL=urxvt
userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    echo "Found a user modmap at $usermodpad"
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# run predefined screen layout with xrandr
screenlayout=$HOME/.screenlayout/default.sh
if [ -f $screenlayout ]; then
    /bin/bash /home/marcel/.screenlayout/default.sh
fi

# Here StumpWM is kept as default
session=${1:-stumpwm}

case $session in
    awesome           ) exec awesome;;
    bspwm             ) exec bspwm;;
    i3|i3wm           ) exec i3;;
    kde               ) exec startkde;;
    lxqt              ) exec startlxqt;;
    openbox           ) exec openbox-session;;
    qtile             ) exec qtile;;
    ratpoison         ) exec ratpoison;;
    stumpwm           ) exec stumpwm;;
    xfce|xfce4        ) exec startxfce4;;
    xmonad            ) exec xmonad;;
    # No known session, try to run it as command
    *) exec "$1";;
esac
