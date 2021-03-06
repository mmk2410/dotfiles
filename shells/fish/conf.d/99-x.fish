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

# Automatically start X at login
# source: https://wiki.archlinux.org/index.php/Fish#Start_X_at_login
# This must be at the bottom of this file
#if status --is-login
#    if test -z "$DISPLAY" -a $XDG_VTNR = 1
#	# Unlock GPG keyring befor starting X.
#	# This makes some things easier.
#	echo "gpg unlock" | gpg -se -r me@mmk2410.org > /dev/null
#	pulseaudio -D # start pulseaudio before X is started
#	exec startx -- -keeptty
#    end
#end
