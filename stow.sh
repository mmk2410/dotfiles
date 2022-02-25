#!/bin/bash

set -euo pipefail

PRIMARY="\033[0;35m"
LOG="\033[0;36m"
SUCCESS="\033[0;32m"
NC="\033[0m"
BRAND="[stow]"

function log {
    echo -e "${PRIMARY}${BRAND} ${LOG}$1${NC}"
}

function success {
    echo -e "${PRIMARY}${BRAND} ${SUCCESS}$1${NC}"
}

DEFAULT_STOW_PKGS="alacritty systemd picom bash fish zsh stumpwm qutebrowser redshift neovim dunst x"
STOW_PKGS=${STOW_PKGS:=$DEFAULT_STOW_PKGS}

WORK_DOTFILES="${WORK_DOTFILES:=$HOME/.dotfiles/dot-work}"
DEFAULT_WORK_STOW_PKGS="mbsync msmtp ssh passwords"
WORK_STOW_PKGS="${WORK_STOW_PKGS:=$DEFAULT_WORK_STOW_PKGS}"

PRIVATE_DOTFILES="${PRIVATE_DOTFILES:=$HOME/.dotfiles/dot-private}"
DEFAULT_PRIVATE_STOW_PKGS="mbsync msmtp ssh git"
PRIVATE_STOW_PKGS="${PRIVATE_STOW_PKGS:=$DEFAULT_PRIVATE_STOW_PKGS}"

WORK_MACHINE="knuth"
CURRENT_MACHINE="$(hostname)"

log "Stowing general packages."
for pkg in $STOW_PKGS
do
    log "Stowing $pkg package."
    stow $@ "$pkg"
done
log "Finished stowing general packages."

if [[ "$WORK_MACHINE" == "$CURRENT_MACHINE" ]]
then
    log "Detected work system. Stowing relevant files."
    for pkg in $WORK_STOW_PKGS
    do
        log "Stowing $pkg package."
        stow $@ -d "$WORK_DOTFILES" -t "$HOME" "$pkg"
    done
    log "Finished stowing work packages."
else
    log "Detected personal system. Stowing relevant packages."
    for pkg in $PRIVATE_STOW_PKGS
    do
        log "Stowing $pkg package."
        stow $@ -d "$PRIVATE_DOTFILES" -t "$HOME" "$pkg"
    done
    log "Finished stowing private packages."
fi

success "Finished stowing files."
