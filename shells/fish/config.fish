set -x ARCHFLAGS -arch_x86_64

set -e GPG_TTY
set -Ux GPG_TTY (tty)

eval (thefuck --alias | tr '\n' ';')
alias l="ls"
alias diff='colordiff'
alias grep='grep --color=auto'
alias more='less'
alias df='df -h'
alias du='du -c -h'
alias mkdir='mkdir -p -v'
alias nano='nano -w'
alias ping='ping -c 3'
alias pingtest='ping -c 3 marcel-kapfer.de'
alias dmesg='dmesg -HL'
alias da='date "+%A, %B %d, %Y [%T]"'
alias du1='du --max-depth=1'
alias hist='history | grep'         # requires an argument
alias openports='ss --all --numeric --processes --ipv4 --ipv6'
alias pgg='ps -Af | grep'           # requires an argument
alias ln='ln -i'
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'
alias cls=' echo -ne "\033c"'
alias ps='ps aux k%cpu'
alias new='touch'
alias re='/sbin/reboot'
alias off='/sbin/poweroff'
alias vol='alsamixer'
alias q=' exit'
alias Q=' exit'
alias x=' exit'
alias cd..='cd ..'
alias sbcl='rlwrap sbcl'
alias o='xdg-open'
alias nemo='nemo --no-desktop'
alias dquilt="quilt --quiltrc=$HOME/.quiltrc-dpkg"
alias mmk2410='~/.mmk2410'

# if [ -z $SSH_CLIENT ]
#   ~/.mmk2410
# end

if [ -z $EDITOR ]
	set -Ux EDITOR es
end

if [ -z $VISUAL ]
	set -Ux VISUAL es
end

if [ -z $GIT_EDITOR ]
	set -Ux GIT_EDITOR es
end

if [ -z $GOPATH ]
	set -Ux GOPATH ~/.go
end

if test -z $DEBFULLNAME
	set -Ux DEBFULLNAME "Marcel Kapfer"
end

if test -z $DEBEMAIL
	set -Ux DEBEMAIL "opensource@mmk2410.org"
end

# Attach the autoscreen screen session  if StumpWM is running
# and it's not already in use.
# if test \( -n $DESKTOP_SESSION \) -a \( $DESKTOP_SESSION = "stumpwm" \)
#         if screen -list | grep -q "No Sockets"
#                 screen -dmS autoscreen
#                 exec screen -r
#         else if screen -list | grep -Eq "\.autoscreen.*Detached"
#                 exec screen -r
#         end
# end

# gpg-agent as SSH agent
set -e SSH_AGENT_PID
set -e SSH_AUTH_SOCK
if test -z $gnupg_SSH_AUTH_SOCK_by
    set gnupg_SSH_AUTH_SOCK_by 0
end
if test $gnupg_SSH_AUTH_SOCK_by -ne %self
    set UID (id -u)
    set -Ux SSH_AUTH_SOCK "/run/user/$UID/gnupg/S.gpg-agent.ssh"
end
gpg-connect-agent updatestartuptty /bye > /dev/null

# Automatically start X at login
# source: https://wiki.archlinux.org/index.php/Fish#Start_X_at_login
# This must be at the bottom of this file
if status --is-login
	if test -z "$DISPLAY" -a $XDG_VTNR = 1
		# Unlock GPG keyring befor starting X.
		# This makes some things easier.
		echo "gpg unlock" | gpg -se -r me@mmk2410.org > /dev/null
		exec startx -- -keeptty
	end
end
