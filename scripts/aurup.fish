#!/usr/bin/env fish

# Small fish script for updating AUR packages using auracle.
#
# 2020 © Marcel Kapfer <opensource@mmk2410.org>
#
# License: GPLv3 (https://www.gnu.org/licenses/gpl-3.0.en.html)

set -l pwd $PWG

set_color -o blue
echo "Listing outdated AUR packages..."
set_color normal
auracle outdated

if test $status -ne 0
    set_color -o blue
    echo "No updates available."
    set_color -o red
    echo "Exiting now..."
    set_color normal
    exit 1
else
    set_color -o blue
    echo "Updating existing repositories..."
    set_color normal
    cd ~/aur/
    auracle update
end

for pkg in (auracle outdated | cut -d' ' -f1)
    set_color -o blue
    echo "Updating $pkg..."
    set_color normal
    cd $pkg
    set_color -o blue
    echo "PKGBUILD for $pkg:"
    set_color normal
    cat PKGBUILD
    read -p 'set_color -o cyan; echo -n "PKGBUILD OK?"; set_color normal; echo -n " (y/N) > "' pkgbuild_ok
    if test $pkgbuild_ok != "y"
        read -p 'set_color -o cyan; echo -n "Edit PKGBUILD?"; set_color normal; echo -n " (Y/n) > "' pkgbuild_edit
        if test $pkgbuild_edit != "n"
            $EDITOR -nw PKGBUILD
            read -p 'set_color -o cyan; echo -n "PKGBUILD OK?"; set_color normal; echo -n " (y/N) > "' pkgbuild_edit_ok
            if test $pkgbuild_edit_ok != "y"
                continue
            end
        else
            continue
        end
    end
    set_color -o blue
    echo "Building and installing $pkg..."
    set_color normal
    makepkg -Ccsir
    set_color -o blue
    echo "Finished installing $pkg."
    set_color normal
    cd ..
end

set_color -o blue
echo "Done updating packages."
set_color normal
cd $pwd
