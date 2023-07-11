#!/usr/bin/env bash

set -euo pipefail

PRIMARY="\033[0;35m"
LOG="\033[0;36m"
SUCCESS="\033[0;32m"
NC="\033[0m"
BRAND="[nix-stow]"

function log {
    echo -e "${PRIMARY}${BRAND} ${LOG}$1${NC}"
}

function success {
    echo -e "${PRIMARY}${BRAND} ${SUCCESS}$1${NC}"
}

NIX_DOTFILES="${NIX_DOTFILES:=$(pwd)/nix}"
NIX_WORK_DOTFILES="${NIX_WORK_DOTFILES:=$(pwd)/dot-work/nix}"
NIX_PRIVATE_DOTFILES="${NIX_PRIVATE_DOTFILES:=$(pwd)/dot-private/nix}"

WORK_MACHINE="knuth"
CURRENT_MACHINE="$(hostname)"

log "Stowing common home-manager config."
stow $@ -d "$NIX_DOTFILES" -t "$HOME" home-manager

if [[ "$WORK_MACHINE" == "$CURRENT_MACHINE" ]]
then
    log "Detected work system. Stowing work-specific home-manager config."
    stow $@ -d "$NIX_WORK_DOTFILES" -t "$HOME" home-manager
else
    log "Detected personal system. Stowing private home-manager config."
    stow $@ -d "$NIX_PRIVATE_DOTFILES" -t "$HOME" home-manager
fi

success "Finished stowing Nix files."
