
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
alias gst='git status'

# color prompt:
PS1='${debian_chroot:+($debian_chroot)}\[\033[00;34m\]\u\[\033[00m\]@\[\033[01;30m\]\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

