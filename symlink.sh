#!/bin/bash
# Symlink all .dotfiles to the home directory

cd ~/Projects/dotfiles

now=$(date +"%Y.%m.%d.%H.%M.%S")

if [[ -d ~/.config && ! -L ~/Projects/dotfiles ]]; then
  #mv -r ~/.config ~/Projects/dotfiles/backup/.config-$now
  #echo "~/.config directory backup saved as ~/Projects/dotfiles/backup/.config-$now"
fi
unlink ~/.config > /dev/null 2>&1
ln -s ~/Projects/dotfiles ~/.config

# Disables: system, copyright notice, last login timestamp, motd,etc.
# See `man login`.
touch ~/.hushlogin

for file in .*; do
  if [[ $file == "." || $file == ".." || $file == ".DS_Store" || $file == ".gitignore" || -d $file ]]; then
    continue
  fi
  echo "Linking ~/$file"
  # if the file exists:
  if [[ -f ~/$file && ! -L ~/$file ]]; then
      mkdir -p ~/Projects/dotfiles/backup/$now
      mv ~/$file ~/Projects/dotfiles/backup/$now/$file
      echo "$file backup saved as ~/Project/dotfiles/backup/$now/$file"
  fi
  # symlink might still exist
  unlink ~/$file > /dev/null 2>&1
  # create the link
  ln -s ~/Projects/dotfiles/$file ~/$file
  echo -e '\tlinked'
done
