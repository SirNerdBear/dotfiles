export TERM="xterm-256color-italic"
export NVIM_TUI_ENABLE_TRUE_COLOR=1
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/Library"
export XDG_CACHE_HOME="$HOME/Library/Caches"
export PYLINTHOME="$XDG_CACHE_HOME"/pylint
export PYTHONSTARTUP=$XDG_CONFIG_HOME/pythonstartup.py
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
alias wget="wget --hsts-file ~/.config/wget/wget-hsts"
alias curl='curl --config "$XDG_CONFIG_HOME/curl/curlrc"'
alias gdb='gdb -nh -x "$XDG_CONFIG_HOME"/gdb/init'
alias svn='svn --config-dir "$XDG_CONFIG_HOME"/subversion'
#need to move these
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
export MACHINE_STORAGE_PATH="$XDG_DATA_HOME"/docker-machine
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export INPUTRC="$XDG_CONFIG_HOME"/readline/inputrc
export GEMRC="$XDG_CONFIG_HOME"/rubygems/config
export GEM_HOME="$XDG_DATA_HOME"/gem
export GEM_SPEC_CACHE="$XDG_CACHE_HOME"/gem
#ANTIBODY_HOME="$XDG_DATA_HOME/antibody"
#need to make the dir above, move from the cache, del the ignore in CleanMyMac, and set installer to make dir

#TODO detect OS and source scripts accoringly
#https://stackoverflow.com/questions/3466166/how-to-check-if-running-in-cygwin-mac-or-linux



#https://stackoverflow.com/questions/21162988/how-to-make-zsh-search-configuration-in-xdg-config-home
#zsh_history
#zsh/bash


#https://wiki.archlinux.org/index.php/XDG_Base_Directory
#.gem and .gemrc
#.tmux / .tmux.config

#wont move/touch
#.cups
#.CFUserTextEncoding
#.DS_Store
#.dropbox
#.editorconfig


SPACESHIP_CHAR_COLOR_SUCCESS="048"
SPACESHIP_CHAR_COLOR_FAILURE="208"
SPACESHIP_CHAR_SYMBOL="❯ "
SPACESHIP_BATTERY_SHOW=false
SPACESHIP_VI_MODE_SHOW=false

for file in ~/.config/zsh/*.zsh; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

abbrev-alias -i

eval "$(rbenv init -)"

# SSH
eval "$(ssh-agent -s)" &> /dev/null
ssh-add -A &> /dev/null



