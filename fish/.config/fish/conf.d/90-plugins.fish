#!/usr/bin/env fish

set -l emacs_vterm_plugin_path "~/.config/fish/plugins/emacs-vterm"

if test -d "$emacs_vterm_plugin_path"
   source "$emacs_vterm_plugin_path/init.fish"
end
