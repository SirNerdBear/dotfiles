echo "Symlinking VSC config…"
rm -rf ~/Library/Application\ Support/Code/User/snippets 2> /dev/null
rm -f ~/Library/Application\ Support/Code/User/keybindings.json 2> /dev/null
rm -f ~/Library/Application\ Support/Code/User/settings.json 2> /dev/null
ln -s ~/.config/VSCode/snippets ~/Library/Application\ Support/Code/User/snippets
ln -s ~/.config/VSCode/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json
ln -s ~/.config/VSCode/settings.json ~/Library/Application\ Support/Code/User/settings.json

echo "Installing VSC extensions…"

code --install-extension bceskavich.theme-dracula-at-night
code --install-extension fallenwood.vimL
code --install-extension idleberg.applescript

