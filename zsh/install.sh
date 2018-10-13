#!/usr/bin/env bash

########################################################################################
# ZSH Shell — Bash? We don't need no stickin' Bashes!
########################################################################################
sudo cp ~/.config/init/zshrc /etc #set zdot_dir
sudo cp ~/.config/init/xdg_env /etc #sourced by /etc/zshrc sets up XDG envirorment vars
sudo chmod 0444 /etc/zshrc /etc/xdg_env #read only for all
rm -f ~/.bash_profile ~/.bash_history ~/.bashrc 2> /dev/null #bash files bye bye
chsh -s $(which zsh) #set default shell
