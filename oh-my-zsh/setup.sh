#!/usr/bin/env bash

sh -c `curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh`

#make symlink for spaceship theme
ln -s ~/Projects/dotfiles/oh-my-zsh/custom/themes/spaceship-prompt/spaceship.zsh-theme ~/Projects/dotfiles/oh-my-zsh/custom/themes/spaceship.zsh-theme 2> /dev/null

rm ~/.oh-my-zsh/custom
ln -s ~/Projects/dotfiles/oh-my-zsh/custom ~/.oh-my-zsh/custom
