#!/bin/sh

extern_1="HDMI1"
extern_2="DP1"
intern="eDP1"
polybar_top_padding=22

switch_internal() {
    xrandr --output "$extern_2" --off \
	   --output "$extern_1" --off \
	   --output "$intern" --auto --primary
    herbstclient detect_monitors
    herbstclient pad 0 "$polybar_top_padding"
    ~/.fehbg &
    xmodmap ~/.Xmodmap
}

switch_external() {
    xrandr --output "$extern_2" --primary --auto \
	   --output "$extern_1" --auto --left-of "$extern_2" \
	   --output "$intern" --auto --right-of "$extern_2"
    herbstclient detect_monitors
    herbstclient pad 0 0
    herbstclient pad 2 0
    herbstclient pad 1 "$polybar_top_padding"
    ~/.fehbg &
    xmodmap ~/.Xmodmap
}

case "$1" in
    i* )
	switch_internal
	;;
    e* )
	switch_external
	;;
    * )
	echo "Specify new output configuration. Possibilities are: 'external' and 'internal'"
	;;
esac
