#!/usr/bin/env bash

defaults write com.runningwithcrayons.Alfred-Preferences-3 syncfolder "${HOME}/.config/alfred"
! $(pgrep -q "Alfred 3") && open /Applications/Alfred\ 3.app

