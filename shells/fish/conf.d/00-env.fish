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

set -x ARCHFLAGS -arch_x86_64

set -e LANG
set -e LC_CTYPE
set -Ux LANG "en_DK.UTF-8"
set -Ux LC_TYPE "en_DK.UTF-8"

set -e GPG_TTY
set -Ux GPG_TTY (tty)

set -e EDITOR
set -Ux EDITOR "emacsclient -t"

if test -z "$VISUAL"
    set -Ux VISUAL "emacsclient -t"
end

if test -z "$GIT_EDITOR"
    set -Ux GIT_EDITOR es
end

if test -z "$GOPATH"
    set -Ux GOPATH ~/.go
end

if test -z "$XDG_CURRENT_DESKTOP"
    set -Ux XDG_CURRENT_DESKTOP GNOME
end

if test -z "$QT_STYLE_OVERRIDE"
    set -Ux QT_STYLE_OVERRIDE kvantum
end
