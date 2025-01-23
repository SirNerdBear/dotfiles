#!/usr/bin/env zsh
if [ -f /tmp/tmuxstatus-ipc-`id -u`.pid ]; then
    if ps -p $(cat /tmp/tmuxstatus-ipc-`id -u`.pid) -o command= | grep -q 'tmuxstatus'; then
        exit 0;
    fi
fi

~/.config/tmuxinator/tmuxstatus
