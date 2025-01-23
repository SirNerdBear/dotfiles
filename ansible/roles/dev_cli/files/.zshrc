#/////////////////////////////////#
#// Config Managed with Ansible //#
#/////////////////////////////////#

##############################################################################
# ZSH Configuration                                                          #
# AUTHOR: Scott D Hall (https://github.com/SirNerdBear)                      #
#                                                                            #
# This fairly simple ZSH configuration avoids the bloat of Oh-My-ZSH and     #
# uses Antibody as a plugin manager.                                         #
#                                                                            #
# Sources shell files for functions, exports, aliases, etc. Which are all    #
# compatable with BASH to keep configuration as DRY as possible.             #
#                                                                            #                                                                            #
# Put ZSH plugins in the line-delimited text file zsh_plugins and then type  #
# plug at the prompt to auto-update _plugins.zsh.                            #
##############################################################################


##############################-> ZSH  Options <-##############################
HISTFILE="$XDG_DATA_HOME"/zsh/history #Glory to XDG
HISTSIZE=100000000              # Much history!
SAVEHIST=100000000              # …
setopt HIST_IGNORE_SPACE        #
setopt extended_history         #
setopt hist_expire_dups_first   # Get rid of dups
setopt hist_ignore_dups         # Ignore duplication command history list
setopt hist_ignore_space        #
setopt hist_verify              #
setopt inc_append_history       #
setopt share_history            # Share command history data
setopt appendhistory            #
setopt extendedglob             #
unsetopt nomatch                # Avoid annoying "no match found" from globs
setopt notify                   #
setopt COMPLETE_ALIASES         #
unsetopt LIST_BEEP              # Bell is annoying during autocompletion
unsetopt banghist               # Avoid "nerd rage" when harmlessly using !
##############################################################################

# TODO Ensure ~/.editorconfig is symlinked to $XDG_CONFIG_HOME/.editorconfig
# ~/.editorconfig -> ~/.config/.editorconfig

# Touch .hushlogin to ensure it exists
# The existance of .hushling surpresses login banners, motd, and other noise
touch ~/.hushlogin

# Delete this yucky file because a bug prevents it from being configured away
if [ -d ~/.oracle_jre_usage ]; then
    rm -r ~/.oracle_jre_usage/
fi

#findutils gnu versions of find, xargs, and locate
PATH="$(brew --prefix)/opt/findutils/libexec/gnubin:$PATH"

##########################-> ZSH Spaceship Prompt <-##########################
SPACESHIP_CHAR_COLOR_SUCCESS="048" # A very mild and light green.
SPACESHIP_CHAR_COLOR_FAILURE="048" # Don't prompt change color on errors.
SPACESHIP_CHAR_SYMBOL=""         # Better than the default.
SPACESHIP_BATTERY_SHOW=false       # Ugly. Battery life shown in tmux status.
#SPACESHIP_VI_MODE_SHOW=true        # Removed to have changing color of prompt character
SPACESHIP_VI_MODE_INSERT="%F{2}❯%f"
SPACESHIP_VI_MODE_NORMAL="%F{176}❯%f"
##############################################################################

# If there is no terminfo file for 256-color and italics then create one
if [ ! -f ~/.terminfo/**/xterm-256color-italic ]; then
    tic $XDG_CONFIG_HOME/init/xterm-256color-italic.terminfo
fi

#TODO detect OS and source scripts accoringly
#https://stackoverflow.com/questions/3466166/how-to-check-if-running-in-cygwin-mac-or-linux

##########################-> Source all ZSH Files <-##########################
# Should proably move these to be more generic and have them be .sh
source ~/.config/zsh/exports.zsh #this has to run first or aliases won't work

for file in ~/.config/zsh/*.zsh; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;
##############################################################################

# If abbrev-alias is installed than intialize it now
if type abbrev-alias > /dev/null && type abbrev-alias | grep -q function; then
  abbrev-alias -i
fi

# This usually triggers on first install but it also ensures that if for any
# reason antibody's home directory is nuked, we replace it and avoid issues.
if [ ! -d $ANTIBODY_HOME ] || [ ! "$(ls -A $ANTIBODY_HOME)" ]; then
  #install plugsin and then (if successful) re-source this file
  plug && source $ZDOTDIR/.zshrc && exit
fi

if [ $MACOS ]
then
  :
elif [ $LINUX ]
then
  :
elif [ $WINDOWS ]
then
  :
fi

#########################-> Proper VI Mode Support <-#########################
setopt VI
bindkey -v
bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward

#zle-line-finish ???

function zle-line-init zle-keymap-select {
   #redraw prompt on vi-mode change and change the cursor in Iterm
       if [ "$TERM" = "xterm-256color-italic" ]; then
        if [ $KEYMAP = vicmd ]; then
            # the command mode for vi
            echo -ne "\e[1 q"
        else
            # the insert mode for vi
            echo -ne "\e[3 q"
        fi
    fi
   zle reset-prompt
}

ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=zle-keymap-select

zle -N zle-line-init
zle -N zle-keymap-select

export KEYTIMEOUT=1 # 10ms timeout for VI key sequences
##############################################################################

# RBENV intitaliztion
eval "$(rbenv init -)"

# Make sure SSH Agent running and all keys added
eval "$(ssh-agent -s)" &> /dev/null
ssh-add -A &> /dev/null

function precmd() {
    # Hook fires before new prompt printed
    # Show an exit code banner if $? != 0
    local err=$?
    if [ $err -ne 0 ]; then
        echo "\e[1;41;160m EXIT CODE: $err \e[0;31;196m\e[0m"
    fi
}

eval $(antibody init)

