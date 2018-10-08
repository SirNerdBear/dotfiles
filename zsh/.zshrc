export TERM="xterm-256color-italic"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/Library/Caches"
export XDG_RUNTIME_DIR="/private/tmp"

export PYLINTHOME="$XDG_CACHE_HOME"/pylint
export PYTHONSTARTUP=$XDG_CONFIG_HOME/pythonstartup.py

export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/config
export NPM_CONFIG_CACHE=$XDG_CACHE_HOME/npm
export NPM_CONFIG_TMP=$XDG_RUNTIME_DIR/npm


export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"

alias wget='wget --hsts-file "$XDG_CONFIG_HOME/wget/wget-hsts"'
alias curl='curl --config "$XDG_CONFIG_HOME/curl/curlrc"'
alias gdb='gdb -nh -x "$XDG_CONFIG_HOME"/gdb/init'
alias svn='svn --config-dir "$XDG_CONFIG_HOME"/subversion'

export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
export MACHINE_STORAGE_PATH="$XDG_DATA_HOME"/docker-machine
export ANTIBODY_HOME="$XDG_DATA_HOME/antibody"

export RBENV_ROOT=/usr/local/var/rbenv

export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export INPUTRC="$XDG_CONFIG_HOME"/readline/inputrc
export GEMRC="$XDG_CONFIG_HOME"/rubygems/config
export GEM_HOME="$XDG_DATA_HOME"/gem
export GEM_SPEC_CACHE="$XDG_CACHE_HOME"/gem
export LPASS_HOME="$XDG_RUNTIME_DIR"/lpass

export NVIM_TUI_ENABLE_TRUE_COLOR=1

if [ -d ~/.oracle_jre_usage ]
then 
    rm -r ~/.oracle_jre_usage/
fi

setopt appendhistory autocd beep extendedglob nomatch notify
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
SPACESHIP_CHAR_SYMBOL="❯ "
SPACESHIP_BATTERY_SHOW=false
SPACESHIP_VI_MODE_SHOW=false

for file in ~/.config/zsh/*.zsh; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

if [ ! -d $ANTIBODY_HOME ] || [ ! "$(ls -A $ANTIBODY_HOME)" ]; then
  # this won't work becasue aliases.zsh contains abbred-alias calls
  plug
fi

abbrev-alias -i

eval "$(rbenv init -)"

# SSH
eval "$(ssh-agent -s)" &> /dev/null
ssh-add -A &> /dev/null



