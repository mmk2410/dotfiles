#
# ~/.bashrc
# v2
#
# Marcel Michael Kapfer
# 12 July 2015
# MIT License
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

## Added Aliases from wiki.archlinux.org ##

## Modified commands ## {{{
alias diff='colordiff'              # requires colordiff package
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
alias ..='cd ..'

if [ $UID -ne 0 ]; then
    alias scat='sudo cat'
    alias svim='sudoedit'
    alias root='sudo -i'
    alias netctl='sudo netctl'
fi

alias l='ls -hF --color=auto'
alias ls='ls -hF --color=auto'
alias lr='ls -Rh'                    # recursive ls
alias ll='ls -lh'
alias la='ll -Ah'
alias lx='ll -BXh'                   # sort by extension
alias lz='ll -rSh'                   # sort by size
alias lt='ll -rth'                   # sort by date
alias lm='la -h | more'
alias rm=' timeout 3 rm -Iv --one-file-system'
alias ln='ln -i'
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'
alias cls=' echo -ne "\033c"'
alias ps='ps aux k%cpu'
alias new='touch'
alias re='reboot'
alias off='poweroff'
alias vol='alsamixer'

# error tolerant
alias q=' exit'
alias Q=' exit'
alias x=' exit'
alias cd..='cd ..'


## Package aliases
alias pkgupdate='yaourt -Syua'
alias pkgsearch='yaourt'
alias pkginstall='yaourt -S'
alias pkgremove='sudo pacman -R'
alias pkginfo='sudo pacman -Si'
alias pkgclean='sudo pacman -Sc'

# make neovim the default
alias vim='nvim'

alias mmk2410='cat /home/mmk/.mmk2410'

# If SSH Client is active, show text "ssh-session"
if [ -n "$SSH_CLIENT" ]; then text=" ssh-session"
fi
export PS1='\[\e[1;32m\]\u@\h:\w${text}$\[\e[m\] '

# PS1='[\u@\h \W]\$ '
PS1='\[\e[1;36m\]\h \[\e[1;31m\]\t \d \[\e[m\]\[\e[1;32m\]\w \[\e[m\]\n   \[\e[1;35m\]\u\[\e[1;33m\] >\[\e[m\] '
#powerline-daemon -q
#POWERLINE_BASH_CONTINUATION=1
#POWERLINE_BASH_SELECT=1
#. /usr/lib/python3.4/site-packages/powerline/bindings/bash/powerline.sh
PATH='$PATH:/bin:/sbin:/home/mmk/.gem/ruby/2.2.0/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/share/java/gradle/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/usr/local/texlive/2015/bin/x86_64-linux'
