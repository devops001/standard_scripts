
# update the values of LINES and COLUMNS after each command:
shopt -s checkwinsize

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
  PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
  ;;
*)
  ;;
esac

# enable bash completion in interactive shells
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# if the command-not-found package is installed, use it
if [ -x /usr/bin/command-not-found ]; then
	function command_not_found_handle {
    /usr/bin/command-not-found $1
    return $?
	}
fi

# put local bin dirs at the front of PATH:
export PATH=$HOME/bin:$PATH

# for vi like commands
set -o vi

# general aliases:
alias ls='ls --color=auto'
alias ll='ls -l'
alias clera='clear'

# git aliases:
alias gst='git status'
alias gb='git branch'
alias gba='git branch -a'
alias gco='git checkout'
alias gg="git log --pretty=format:'%h : %s' --graph"

# colored prompt (red if root):
if [[ $UID -eq 0 ]]; then
    export PS1="\[\e[31;1m\]\u\[\e[30;1m\]@\[\e[31;1m\]\H\[\e[30;1m\]:\[\e[34;1m\]\w\[\e[30;1m\]> \[\e[0m\]"
else
    export PS1="\[\e[30;0m\]\u\[\e[30;1m\]@\[\e[30;0m\]\H\[\e[30;1m\]:\[\e[34;1m\]\w\[\e[30;1m\]> \[\e[0m\]"
fi

