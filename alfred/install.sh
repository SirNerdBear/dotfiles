#!/usr/bin/env bash

defaults write com.runningwithcrayons.Alfred-Preferences syncfolder "${HOME}/.config/alfred"
! $(pgrep -q "Alfred 4") && open /Applications/Alfred\ 4.app

