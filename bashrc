
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

black="$(tput setaf 0)"
red="$(tput setaf 1)"
green="$(tput setaf 2)"
yellow="$(tput setaf 3)"
blue="$(tput setaf 4)"
purple="$(tput setaf 5)"
cyan="$(tput setaf 6)"
white="$(tput setaf 7)"
bold="$(tput bold)"
reset="$(tput sgr0)"

export PS1="$bold$white\u$black@$bold$green\h$black:$bold$blue\w$black> $reset"

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
if [ -f ~/.git-completion.bash ]; then
  source ~/.git-completion.bash
fi



