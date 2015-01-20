
# update the values of LINES and COLUMNS after each command:
shopt -s checkwinsize

# console title:
case "$TERM" in
xterm*|rxvt*)
  PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
  ;;
*)
  ;;
esac

# colored prompt (red if root):
if [[ $UID -eq 0 ]]; then
    export PS1="\[\e[31;1m\]\u\[\e[30;1m\]@\[\e[31;1m\]\H\[\e[30;1m\]:\[\e[34;1m\]\w\[\e[30;1m\]> \[\e[0m\]"
else
    export PS1="\[\e[30;0m\]\u\[\e[30;1m\]@\[\e[30;0m\]\H\[\e[30;1m\]:\[\e[34;1m\]\w\[\e[30;1m\]> \[\e[0m\]"
fi

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

# for vi like commands
set -o vi

# general aliases:
alias ls='ls --color=auto'
alias ll='ls -l'
alias clera='clear'

# rbenv:
if [ -d ~/.rbenv ]; then 
  export PATH="$HOME/.rbenv/bin:$HOME/.rbenv/plugins/ruby-build/bin:$PATH"
  eval "$(rbenv init -)"
fi

# git:
source ~/.git-completion.bash
alias gst='git status'



