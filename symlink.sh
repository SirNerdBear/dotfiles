#!/bin/bash
# Symlink all .dotfiles to the home directory

cd ~/.dotfiles

now=$(date +"%Y.%m.%d.%H.%M.%S")

for file in .*; do
  if [[ $file == "." || $file == ".." || $file == ".gitignore" || -d $file ]]; then
    continue
  fi
  echo "Linking ~/$file"
  # if the file exists:
  if [[ -f ~/$file && ! -L ~/$file ]]; then
      mkdir -p ~/.dotfiles/backup/$now
      mv ~/$file ~/.dotfiles/backup/$now/$file
      echo "backup saved as ~/.dotfiles_backup/$now/$file"
  fi
  # symlink might still exist
  unlink ~/$file > /dev/null 2>&1
  # create the link
  ln -s ~/.dotfiles/$file ~/$file
  echo -e '\tlinked'
done