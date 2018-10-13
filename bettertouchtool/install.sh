#!/usr/bin/env bash

#TODO copy license file

if [ ! $(pgrep -q "BetterTouchTool") ]; then
	ln -s ~/.config/bettertouchtool/Default.bttpreset ~/.btt_autoload_preset.json
	open /Applications/BetterTouchTool.app
	sleep 4
	rm ~/.btt_autoload_preset.json
	#open license_goes_here (pulled from lpass)
fi

