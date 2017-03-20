#!/bin/sh

if [ "$DESKTOP_SESSION" = "stumpwm" ]; then
    stumpish 'eval (stumpwm::save-es-called-win)' > /dev/null
fi

emacsclient -c --alternate-editor="$ALTERNATE_EDITOR" "$@"
