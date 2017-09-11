# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
# Colors
GREEN='\[\033[01;32m\]'
BLUE='\[\033[01;34m\]'
RED='\[\033[01;31m\]'
NO_COLOR='\[\033[00m\]'

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+:}ignoredups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# cd with typing a directory name
shopt -s autocd

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    tmux|urxvt|xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    # PS1="${debian_chroot:+($debian_chroot)}╭─${GREEN}\u@\h${NO_COLOR}:${BLUE}\w ${NO_COLOR}\n╰─➤"
    PS1="${debian_chroot:+($debian_chroot)}╭─${GREEN}\u@\h${NO_COLOR}:${BLUE}\w ${RED}\$(git branch 2>/dev/null | grep '^*'| colrm 1 2)${NO_COLOR}\n╰─➤"
else
    PS1="${debian_chroot:+($debian_chroot)}\u@\h:\w\$ "
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

#enable 256 colors in terminal
export TERM=xterm-256color
export TERMINAL=urxvt
export PATH=$PATH:/sbin
export EDITOR=/usr/bin/vim
# history for all sessions
export PROMPT_COMMAND='history -a'

#virtual environment
# export WORKON_HOME=$HOME/.virtualenvs
# export PROJECT_HOME=$HOME/Devel
# source /usr/local/bin/virtualenvwrapper.sh

# If not running interactively, do not do anything
# [[ $- != *i* ]] && return
# [[ -z "$TMUX" ]] && exec tmux

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --group-directories-first --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

#colored man
alias man='env LESS_TERMCAP_md=$(echo -e "\e[0;36m") env LESS_TERMCAP_us=$(echo -e "\e[0;32m") env LESS_TERMCAP_me=$(echo -e "\e[0m") man -L ru'
# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias aptuu='sudo apt-get update && sudo apt-get -y upgrade'

#colored some utilities
alias ping='grc --colour=auto ping'
alias diff='grc --colour=auto diff'
alias netstat='grc --colour=auto netstat'
alias last='grc --colour=auto last'
alias ifconfig='grc --colour=auto ifconfig'
alias mount='grc --colour=auto mount'
alias ps='grc --colour=auto ps'
alias df='grc --colour=auto df'


# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# for cheat.sh completion
source ~/.bash.d/cheat.sh

# History search
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\C-p": history-search-backward'
bind '"\C-n": history-search-forward'
# source /home/algvozdev/.oh-my-git/prompt.sh
