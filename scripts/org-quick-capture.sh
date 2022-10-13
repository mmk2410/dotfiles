#!/bin/sh
emacsclient -c -F '(quote (name . "capture"))' -e '(activate-capture-frame)' 2&>1 > /dev/null
