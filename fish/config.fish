set -x PATH $PATH /home/mmk2410/bin /usr/local/bin /usr/bin /bin /usr/local/games /usr/games /home/mmk/.gem/ruby/2.2.0/bin /usr/local/texlive/2015/bin/x86_64-linux /home/mmk/.gem/ruby/2.3.0/bin /home/mmk/.go/bin /opt/nodejs/bin ~/.bin/

set -x ARCHFLAGS -arch_x86_64

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
alias q=' exit'
alias Q=' exit'
alias x=' exit'
alias cd..='cd ..'
alias mmk2410='cat /home/mmk/.mmk2410'
mmk2410

set -Ux EDITOR nvim
set -Ux VISUAL nvim
set -Ux GUIX_LOCPATH $HOME/.guix-profile/lib/locale
set -Ux GOPATH ~/.go
