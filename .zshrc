export TERM="xterm-256color-italic"
export NVIM_TUI_ENABLE_TRUE_COLOR=1

SPACESHIP_CHAR_COLOR_SUCCESS="048"
SPACESHIP_CHAR_COLOR_FAILURE="208"
SPACESHIP_CHAR_SYMBOL="❯ "
SPACESHIP_BATTERY_SHOW=false

for file in ~/.config/zsh/*.zsh; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

abbrev-alias -i

eval "$(rbenv init -)"

# SSH
eval "$(ssh-agent -s)" &> /dev/null
ssh-add -A &> /dev/null



