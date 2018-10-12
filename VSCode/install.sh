echo "Configuring symlinked portable VSCode install"
mkdir -p /Applications/code-portable-data
rm -rf /Applications/code-portable-data/user-data
rm -rf /Applications/code-portable-data/extensions

mkdir -p /Applications/code-portable-data/extensions

ln -s ~/.config/VSCode /Applications/code-portable-data/user-data

echo "Installing VSC extensions…"

code --install-extension bceskavich.theme-dracula-at-night
code --install-extension fallenwood.vimL
code --install-extension idleberg.applescript
code --install-extension ms-python.python
code --install-extension ms-vscode.cpptools
code --install-extension vsciot-vscode.vscode-arduino
code --install-extension EditorConfig.EditorConfig
