#!/usr/bin/env zsh
if [ -f /tmp/powerline-ipc-`id -u`.pid ]; then
    if ps -p $(cat /tmp/powerline-ipc-`id -u`.pid) -o command= | grep -q 'tmuxstatus'; then
        exit 0;
    fi
fi

~/.config/tmux/tmuxstatus
