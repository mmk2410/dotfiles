# Copyright © 2019 Marcel Kapfer <opensource@mmk2410.org>
# MIT License

# Permission is hereby granted, free of charge, to any person obtaining a copy of
# this software and associated documentation files (the "Software"), to deal in
# the Software without restriction, including without limitation the rights to
# use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
# the Software, and to permit persons to whom the Software is furnished to do so,
# subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
# FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
# COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
# IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
# CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

# Debian Packaging

# quilt
alias dquilt="quilt --quiltrc=$HOME/.quiltrc-dpkg"

# Variables
set -x DEBUILD_DPKG_BUILDPACKAGE_OPTS "-i -I -us -uc"
set -x DEBUILD_LINTIAN_OPTS "-i -I --show-overrides"
set -x DEBSIGN_KEYID "9FE01C39F74551D434116394CADE6F0C09F21B09"

if test -z $DEBFULLNAME
    set -Ux DEBFULLNAME "Marcel Kapfer"
end

if test -z $DEBEMAIL
    set -Ux DEBEMAIL "opensource@mmk2410.org"
end

# pbuilder customization

set -x PDEBUILD_PBUILDER cowbuild
set -x HOOKDIR /var/cache/pbuilder/hooks
set -x MIRRORSITE http://httpredir.debian.org/debian/
set -x APTCACHE /var/cache/apt/archives
set -x BUILDRESULT ../
set -x EXTRAPACKAGES lintian
set -x DEBBUILDOPTS -j4
