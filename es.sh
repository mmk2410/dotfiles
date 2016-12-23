#!/bin/sh

stumpish 'eval (stumpwm::save-es-called-win)' > /dev/null
emacsclient -c --alternate-editor=$ALTERNATE_EDITOR "$@"
