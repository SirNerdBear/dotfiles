#!/usr/bin/env bash

defaults write com.runningwithcrayons.Alfred-Preferences syncfolder "${HOME}/dotfiles/alfred"
! $(pgrep -q "Alfred 5") && open /Applications/Alfred\ 5.app

