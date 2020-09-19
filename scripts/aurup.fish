#!/usr/bin/env fish

# Small fish script for updating AUR packages using auracle.
#
# 2020 © Marcel Kapfer <opensource@mmk2410.org>
#
# License: GPLv3 (https://www.gnu.org/licenses/gpl-3.0.en.html)

for pkg in (auracle outdated | cut -d' ' -f1)
    cd ~/aur/
    echo "Updating $pkg"
    cd $pkg
    cat PKGBUILD
    read -P 'PKGBUILD OK? (y/N) > ' pkgbuild_ok
    if test $pkgbuild_ok != "y"
        read -P 'Edit PKGBUKD? (Y/n) > ' pkgbuild_edit
        if test $pkgbuild_edit != "n"
            $EDITOR -nw PKGBUILD
            read -P 'PKGBUILD now OK? (y/N) > ' pkgbuild_edit_ok
            if test $pkgbuild_edit_ok != "y"
                continue
            end
        else
            continue
        end
    end
    makepkg -Ccsir
    cd ..
end
