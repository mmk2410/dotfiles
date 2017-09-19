#!/bin/bash
level="$(upower -d | grep "percentage" | cut -d' ' -f15- | head -n 1)"
state="$(upower -d | grep "state" | cut -d' ' -f20- | head -n 1)"

case "$state" in
    charging) statesym="↑" ;;
    discharging) statesym="↓" ;;
    * ) statesym="$state" ;;
esac

echo "$level $statesym"
    
