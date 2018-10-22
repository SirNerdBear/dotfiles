#!/usr/bin/env bash

#always install rails and bundler gems
git clone https://github.com/rbenv/rbenv-default-gems.git $(rbenv root)/plugins/rbenv-default-gems
#TODO test for file here
ln -s $XDG_CONFIG_HOME/rbenv/default-gems $(rbenv root)/default-gems
LATEST_RUBY=$(rbenv install -l | grep -v - | tail -1)
rbenv install LATEST_RUBY
rbenv global LATEST_RUBY
eval "$(rbenv init -)"
rbenv rehash
unset LATEST_RUBY

