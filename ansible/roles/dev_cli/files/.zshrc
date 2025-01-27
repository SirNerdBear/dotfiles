#/////////////////////////////////#
#// Config Managed with Ansible //#
#/////////////////////////////////#

##############################################################################
# ZSH Configuration                                                          #
# AUTHOR: Scott D Hall (https://github.com/SirNerdBear)                      #
#                                                                            #
# This fairly simple ZSH configuration avoids the bloat of Oh-My-ZSH and     #
# uses Antidote as a plugin manager.                                         #
#                                                                            #
# Sources shell files for functions, exports, aliases, etc. Which are all    #
# compatable with BASH to keep configuration as DRY as possible.             #
#                                                                            #                                                                            #
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

# Delete this yucky file because a bug prevents it from being configured away
if [ -d ~/.oracle_jre_usage ]; then
    rm -r ~/.oracle_jre_usage/
fi

eval "$(/opt/homebrew/bin/brew shellenv)"

source ~/.config/zsh/exports.zsh #this has to run early


export TERMINFO="$XDG_DATA_HOME"/terminfo                                     
export TERMINFO_DIRS="$XDG_DATA_HOME"/terminfo:/usr/share/terminfo:/Applications/Ghostty.app/Contents/Resources/terminfo

# If there is no terminfo file for 256-color and italics then create one
if [ ! -f "$TERMINFO"/.terminfo/**/xterm-256color-italic ]; then
    tic $XDG_CONFIG_HOME/term/xterm-256color-italic.terminfo
fi
# Support italics

export TERM="xterm-256color-italic"

#findutils gnu versions of find, xargs, and locate
PATH="$(brew --prefix)/opt/findutils/libexec/gnubin:$PATH"

#Python Virtual ENV
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"
eval "$(pyenv virtualenv-init -)"

#Starship.rs
eval "$(starship init zsh)"

# If abbrev-alias is installed than intialize it now
if type abbrev-alias > /dev/null && type abbrev-alias | grep -q function; then
  abbrev-alias -i
fi

source ~/.config/zsh/functions.zsh
source ~/.config/zsh/aliases.zsh

# Plugin manager 
source $(brew --prefix)/opt/antidote/share/antidote/antidote.zsh
antidote load $ZDOTDIR/zsh_plugins

source ~/.local/share/cargo/env

. "$XDG_DATA_HOME/asdf/asdf.sh"


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

bindkey -e #emacs key shortcuts

#zle-line-finish ???

function zle-line-init zle-keymap-select {
  #block cursor
  if [ "$TERM" = "xterm-256color-italic" ]; then
    echo -ne "\e[1 q"
  fi
  zle reset-prompt
}

ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=zle-keymap-select

zle -N zle-line-init
zle -N zle-keymap-select

export KEYTIMEOUT=1 # 10ms timeout for VI key sequences
##############################################################################

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

if [ $GHOSTTY_QUICK_WINDOW ]
then
  tmux attach -d -t quake
fi