set -x ARCHFLAGS -arch_x86_64
set -x GPG_TTY (tty)

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

# Attach the autoscreen screen session  if StumpWM is running
# and it's not already in use.
if test \( -n $DESKTOP_SESSION \) -a \( $DESKTOP_SESSION = "stumpwm" \)
        if screen -list | grep -q "No Sockets"
                screen -dmS autoscreen
                exec screen -r
        else if screen -list | grep -Eq "\.autoscreen.*Detached"
                exec screen -r
        end
end

# Automatically start X at login
# source: https://wiki.archlinux.org/index.php/Fish#Start_X_at_login
if status --is-login
    if test -z "$DISPLAY" -a $XDG_VTNR = 1
        exec startx -- -keeptty
    end
end

