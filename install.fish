#!/usr/bin/fish
# Script for linking the dotfiles

echo "Creating necessary directories"

for dir in (cat dirs.list)
	echo "Creating directory:" ~/$dir
	mkdir -p ~/$dir
end

echo "Linking the dotfiles"

for link in (cat links.list)
	set link (string split " " $link)
	echo "creating symlink from" ~/dotfiles/$link[1] "to" ~/$link[2]
	ln -s ~/dotfiles/$link[1] ~/$link[2]
end

echo "done"
