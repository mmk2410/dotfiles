#!/bin/sh

extern_1="HDMI-1"
extern_2="DP-1"
intern="eDP-1"
polybar_top_padding=22

common_adjustments() {
    ~/.fehbg &
    xmodmap ~/.Xmodmap
}

switch_internal() {
    xrandr --output "$extern_2" --off \
	   --output "$extern_1" --off \
	   --output "$intern" --auto --primary
    herbstclient detect_monitors
    herbstclient pad 0 "$polybar_top_padding"
}

switch_external() {
    xrandr --output "$extern_2" --primary --auto \
	   --output "$extern_1" --auto --left-of "$extern_2" \
	   --output "$intern" --auto --right-of "$extern_2"
    herbstclient detect_monitors
    herbstclient pad 0 0
    herbstclient pad 2 0
    herbstclient pad 1 "$polybar_top_padding"
}

case "$1" in
    i* )
	switch_internal
        common_adjustments
	;;
    e* )
	switch_external
        common_adjustments
	;;
    * )
	echo "Specify new output configuration. Possibilities are: 'external' and 'internal'"
	;;
esac
