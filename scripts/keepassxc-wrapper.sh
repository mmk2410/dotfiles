#!/bin/sh

PASSWORD_FILE=~/dotfiles/dotdotfiles/keepassxc/password.gpg
KEEPASS_FILE=~/cloud/keys/2017-10.kdbx

if [ ! -f "$PASSWORD_FILE" ]; then
    echo "No password file."
    exit 1
fi

if [ ! -f "$KEEPASS_FILE" ]; then
    echo "No KeePass file."
    exit 1
fi

gpg --textmode -d "$PASSWORD_FILE" | keepassxc --pw-stdin "$KEEPASS_FILE"
