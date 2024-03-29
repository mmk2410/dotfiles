# -*- mode: shell-script; -*-
# ZSH Configuration
# Marcel Kapfer (c) 2019-2021
# MIT License

# Hide user- and hostname when on local machine
# and set a variable to determine the machine
if [[ $(hostname -d) == "rz.uni-ulm.de" ]]; then
    DEFAULT_USER="ftu15"
else
    DEFAULT_USER="marcel"
fi

# Set path to oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="dd/mm/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# plugins=(git adb battery bower coffee command-not-found debian gitignore github git-prompt gnu-utils node npm python web-search)

# User configuration

# If on kiz, add user path
if [[ "$USER" == "ftu15" ]]; then
    export PATH="/users/student1/ftu15/bin:$PATH"
fi

# export MANPATH="/usr/local/man:$MANPATH"

# Add user binaries path to PATH
export PATH="/home/$USER/.local/bin/:$PATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
export EDITOR='es'
export VISUAL='es'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
#export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias zshrc="$EDITOR ~/.zshrc"
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

#####################
### GO LANG STUFF ###
#####################

export GOPATH=$HOME/projects/go

######################
### GNU GUIX STUFF ###
######################

GUIX_PROFILE="$HOME/.guix-profile/"
GUIX_LOCPATH="$GUIX_PROFILE/lib/locale/"

if [[ -d $GUIX_PROFILE ]];
then
    . "$GUIX_PROFILE/etc/profile"
fi

GUIX_PROFILE="$HOME/.config/guix/current"

if [[ -d $GUIX_PROFILE ]];
then
    . "$GUIX_PROFILE/etc/profile"
fi

#################
### WSL STUFF ###
#################

if [[ -n $WSL_DISTRO_NAME ]] && [[ ! -d /mnt/wslg ]];
then
    export DISPLAY=$(ip route | awk '{print $3; exit}'):0
    export LIBGL_ALWAYS_INDIRECT=1

    alias mariadb-start='sudo /etc/init.d/mariadb start'
    alias mariadb-stop='sudo /etc/init.d/mariadb stop'
fi

################
### GO STUFF ###
################

if [[ -d "/usr/local/go/bin" ]]
then
    export PATH="/usr/local/go/bin:$PATH"
fi

if [[ -d "/home/$USER/projects/go/bin" ]]
then
    export PATH="/home/$USER/projects/go/bin:$PATH"
fi

####################
### LEDGER STUFF ###
####################

export LEDGER_FILE="/home/$USER/hledger/2022.journal"
