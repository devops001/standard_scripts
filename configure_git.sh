#!/usr/bin/env bash

NAME=""
EMAIL=""

# identity:
git config --global user.name "$NAME"
git config --global user.email "$EMAIL"

# aliases:
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status
git config --global alias.unstage 'reset HEAD --'
git config --global alias.last 'log -1 HEAD'

# other:
git config --global core.editor vi
git config --global color.ui true
git config --global push.default simple

git config --global --list
