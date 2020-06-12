export ANTIBODY_HOME="$(antibody home)"
#ZSH="$ANTIBODY_HOME/antibody"/https-COLON--SLASH--SLASH-github.com-SLASH-robbyrussell-SLASH-oh-my-zsh
# tell omz where it lives
export ZSH="$ANTIBODY_HOME"/https-COLON--SLASH--SLASH-github.com-SLASH-robbyrussell-SLASH-oh-my-zsh



# quit bugging me!
DISABLE_AUTO_UPDATE="true"


#.editorconfig
#.tmux.conf=tmux/tmux.conf
#cmus?
#.curlrc=curl/curlrc
#.wgetrc=/wget/wgetrc
#.docker=/docker
#gdb
#.htoprc=htop/htoprc
#.karabiner=karabiner
#multitail?
#npm
#nvim
#readline
#rubygems
#sampler.yml
#tmuxinator
#wget
#zshrc
#oh-my-zsh



export TERM="xterm-256color-italic"

#export PYLINTHOME="$XDG_CACHE_HOME"/pylint
#export PYTHONSTARTUP=$XDG_CONFIG_HOME/pythonstartup.py

#export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/config
#export NPM_CONFIG_CACHE=$XDG_CACHE_HOME/npm
#export NPM_CONFIG_TMP=$XDG_RUNTIME_DIR/npm


#export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"

alias wget='wget --hsts-file "$XDG_CONFIG_HOME/wget/wget-hsts"'
alias curl='curl --config "$XDG_CONFIG_HOME/curl/curlrc"'
alias gdb='gdb -nh -x "$XDG_CONFIG_HOME"/gdb/init'
alias svn='svn --config-dir "$XDG_CONFIG_HOME"/subversion'

#export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
#export MACHINE_STORAGE_PATH="$XDG_DATA_HOME"/docker-machine
#export ANTIBODY_HOME="$XDG_DATA_HOME/antibody"

#export RBENV_ROOT=/usr/local/var/rbenv

#export GNUPGHOME="$XDG_DATA_HOME"/gnupg
#export INPUTRC="$XDG_CONFIG_HOME"/readline/inputrc
#export GEMRC="$XDG_CONFIG_HOME"/rubygems/config
#export GEM_HOME="$XDG_DATA_HOME"/gem
#export GEM_SPEC_CACHE="$XDG_CACHE_HOME"/gem
#export LPASS_HOME="$XDG_RUNTIME_DIR"/lpass

export NVIM_TUI_ENABLE_TRUE_COLOR=1

if [ -d ~/.oracle_jre_usage ]
then 
    rm -r ~/.oracle_jre_usage/
fi

setopt appendhistory extendedglob nomatch notify
#history
HISTFILE="$XDG_DATA_HOME"/zsh/history
HISTSIZE=100000000
SAVEHIST=100000000
setopt HIST_IGNORE_SPACE
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups # ignore duplication command history list
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history # share command history data
setopt COMPLETE_ALIASES
unsetopt LIST_BEEP
setopt VI
#stop pissing me off when using ! in line
unsetopt banghist 

#TODO detect OS and source scripts accoringly
#https://stackoverflow.com/questions/3466166/how-to-check-if-running-in-cygwin-mac-or-linux



#https://stackoverflow.com/questions/21162988/how-to-make-zsh-search-configuration-in-xdg-config-home
#zsh_history
#zsh/bash


#https://wiki.archlinux.org/index.php/XDG_Base_Directory
#.tmux / .tmux.config
#.zsh_history, .zshrc
#.tmux -> XDG_DATA_HOME
#.tmux.conf
#.bash_prompt .bashrc .bash_history


SPACESHIP_CHAR_COLOR_SUCCESS="048"
SPACESHIP_CHAR_COLOR_FAILURE="208"
SPACESHIP_CHAR_SYMBOL="" #❯ removed normal prompt for a VI status prompt
SPACESHIP_BATTERY_SHOW=false
#SPACESHIP_VI_MODE_INSERT="%F{237}%K{2}I%F{2}%k%f"
#SPACESHIP_VI_MODE_NORMAL="%F{237}%K{176}N%F{176}%k%f"
SPACESHIP_VI_MODE_INSERT="%F{2}❯%f"
SPACESHIP_VI_MODE_NORMAL="%F{176}❯%f"


for file in ~/.config/zsh/*.zsh; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

if [ ! -d $ANTIBODY_HOME ] || [ ! "$(ls -A $ANTIBODY_HOME)" ]; then
  #install plugsins
  plug && source <(antibody init)
  #source <(antibody init)
fi


if type abbrev-alias > /dev/null && type abbrev-alias | grep -q function; then
  abbrev-alias -i
fi

export PATH="/usr/local/var/rbenv/bin:$PATH"
eval "$(rbenv init -)"

# SSH
eval "$(ssh-agent -s)" &> /dev/null
ssh-add -A &> /dev/null


bindkey -v

bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward

function zle-line-init zle-keymap-select {
   #redraw prompt on vi-mode change
   zle reset-prompt
}

ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=zle-keymap-select


zle -N zle-line-init
zle -N zle-keymap-select

export KEYTIMEOUT=1


#source SSH if currently in SSH mode
#https://www.freecodecamp.org/news/tmux-in-practice-local-and-nested-remote-tmux-sessions-4f7ba5db8795/

#LOOK HERE FOR IDEAS
#https://github.com/samoshkin/tmux-config

