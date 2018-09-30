# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh
export ZSH_CUSTOM=~/.config/oh-my-zsh
export TERM="xterm-256color-italic"
export NVIM_TUI_ENABLE_TRUE_COLOR=1
export ZSH_DISABLE_COMPFIX=true

ZSH_THEME='spaceship'
SPACESHIP_CHAR_COLOR_FAILURE="green"
SPACESHIP_CHAR_SYMBOL=" "
SPACESHIP_BATTERY_SHOW=false

DISABLE_AUTO_TITLE="true"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

plugins=(git gpg zsh-autosuggestions history-substring-search)

source $ZSH/oh-my-zsh.sh

eval "$(rbenv init -)"

# SSH
eval "$(ssh-agent -s)" &> /dev/null
ssh-add -A &> /dev/null



