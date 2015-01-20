#!/usr/bin/env bash

# only download rbenv once:
if [ -d ~/.rbenv ]; then
  echo "skipped git download. rbenv already exists at ~/.rbenv"
else
  git clone git://github.com/sstephenson/rbenv.git               ~/.rbenv
  git clone git://github.com/sstephenson/ruby-build.git          ~/.rbenv/plugins/ruby-build
fi

# .bashrc
if grep -q rbenv ~/.bashrc 2>/dev/null; then
  echo "skipped .bashrc update. rbenv is already mentioned in ~/.bashrc"
else
  echo 'export PATH="$HOME/.rbenv/bin:$PATH"'                    >> ~/.bashrc
  echo 'eval "$(rbenv init -)"'                                  >> ~/.bashrc
  echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
fi

# .gemrc
if grep -q rdoc ~/.gemrc 2>/dev/null; then
  echo "skipped .gemrc update. rdoc is already mentioned in ~/.gemrc"
else
  echo "gem: --no-ri --no-rdoc"                                   > ~/.gemrc
fi

# exec will replace this process with a new one so we can't do anything else...
if which ruby 2>&1>/dev/null; then
  echo "ruby is already installed."
  ruby -v
else
  echo "# now you need to install ruby. example:"
  echo
  echo rbenv install 2.1.5
  echo rbenv global  2.1.5
  echo ruby -v
fi

exec $SHELL
