# My dotfiles

![Screenshot of my terminal](https://raw.githubusercontent.com/SirNerdBear/dotfiles/master/ss.png)

## Installation

Important pre-steps (manual):
* Login with Apple ID to App Store (needed for `mas` to install some apps)
* It's best to close everything except the terminal window

Most of the configuration happens in Ansible. There  is one bootstrap script which kicks off:
* Prompt for system name
* Prompt for Ansible vault decryption key (can be found in Bitwarden) and store in Keychain
* Sets up passwordless Sudo (undone later by the Ansible run)
* Unattended Homebrew install
* Bitwarden CLI installed
* pyenv and pyenv-virtualenv installed via brew
* python 3.10.6 is installed via pyenv
* virtual envirorment for python activated `pyenv virtualenv 3.10.16 ansible-py3-10-16`
* Ansible module is installed via pip3
* Inventory file generated for provided system name
* Ansible galaxy installations
* Ansible run is started with playbook `pb.macos.yaml` and the tag `provision` 
* System hotkeys (not idenpotent, `hotkeys` or `provision`)

Ansible runs the playbook `pb.macos.yaml` with the tag: 
* macOS defaults are set
* homebrew packages installed
* homebrew casks installed
* App Store apps installed via `mas`
* System name is set to match inventory
* SSH and GPG keys are put into ~/.ssh (uses Ansible vault, using decrypt key from Keychain)
* Sets FISH as shell and ensures configurtion, as well as zsh configuration
* dotfiles in the repo are symlinked into ~/.config using subfolders whenever possible
  - shell rc files set envirorment vars for software that support it, as well as XDG_CONFIG_HOME
* dotfles in the repo that must be in user home are symlinked 
* VSCode extensions are installed via make (not idenpotent, only runs on provision tag or `vscode-exts`)
* ASDF and PyENV have ruby, node, and Python versions installed and globals set
* Gems and python cli tools installed with pip, gem, etc using global ruby/python install e.g. tmuxinator, rails, as well as standard gems nvim, etc.
* Build things from source as needed (simi-idenpotent)
* Copy and install fonts from Dropbox storage


** Many security settings can no longer be automated. **

Post install steps (manual):
* Go to security settings:
  - Set `Allow applications: Anywhere`
  - Set `Allow accessories to connect: Automatically When Unlocked`
  - Enable `Ghostty` and `Terminal` as a developer tool
  - Accessiblity for: `Alfred`, `Ghosttty`, and `SensibleSideButtons`
  - Automation for: `Alfred`
  - Input Monitoring for: `Karabiner_grabber`, `Karabiner-EventViewer`
  - Local network for: `Docker`
  - Contacts for: `Alfred`
  - Files & Folders for: `Alfred`, `Docker`, `Ghostty`, and `Terminal`
  - Full Disk Access for: `Alfred`, `Ghostty`, `Terminal`, and `Visual Studio Code`
  - Media & Apple Music: `Alfred`
  - Developer Tools: `Terminal`, `Visual Studio Code` and `Ghostty`
  - Screen & System Audio Recording: `Zoom` and `Discord`
  - Driverkit for `Karabiner`
* Set desired wallpaper/screensaver (not automated for... reasons!)
* Ghostty startup script (TODO automat adding to login items)
* Login to Firefox and Chrome
* A restart is an excellent idea!

## TODO

* Finish implementing the steps above

* https://ghostty.org/docs/config/reference

* Close apps affected by default changes https://stackoverflow.com/questions/43961903/registering-multiple-variables-in-a-loop

* 

* Add an SSH tmux config to change status BAR for remote sessions (location and styling)

* TMUX persistance
  * https://github.com/tmux-plugins/tmux-resurrect/blob/master/README.md
  * https://github.com/tmux-plugins/tmux-resurrect

* Look at https://www.trankynam.com/xtrafinder/

## Followup Items
- https://github.com/ghostty-org/ghostty/issues/4538
- 