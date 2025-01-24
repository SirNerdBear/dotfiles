# My dotfiles

![Screenshot of my terminal](https://raw.githubusercontent.com/SirNerdBear/dotfiles/master/ss.png)

## Provisioning New Computer (or Restore)

Important pre-steps (manual):
* Login with Apple ID to App Store (needed for `mas` to install some apps)
* It's best to close everything except the terminal window
* For a new system. Configure DHCP for Mac and add to inventory (the hostname will be set on the system during provision)

Ansible should be run to setup a fresh installed Mac from another system. In the event a minimal Ansible setup is needed in order to run Ansilbe on the localhost, addtional manual steps are required.  

For a first run use the provision tag
`pb devsystem --tags provision --limit inventory-name-here`

Althought the playbook is idenpotent, some tasks have limited support. The above can therefore be re-ran, but shouldn't need to be.

`pb devsystem --tags macos_defaults,packages,apps,sysconfig,netconfig,hotkeys`

There are a few addtional playbooks which are called by devsystem, but can also be called independently.

`pb ssh` will ensure ssh keys are in the ~/.ssh/ directory, permissions set, etc. 
`pb gpg --tags restore,renew,revoke`

Bootstrapping if no Ansible computer configured: 
* Pull the dotfiles docker imagwe, which has pyenv, pyenv-virtualenv and python 3.10.6 as well as Ansible and all depencies is available.
* The inventory file should be mapped to a volume mount on the host system. 
* Install docker, [macOS](https://docs.docker.com/desktop/setup/install/mac-install/)
* Run `docker run dotfiles -v....`
* This will run a minimal playbook and prepare the system to run the ansible automation directly
* Will be prompted for Ansible Vault key for secets

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
* Bitwarden added to Chrome and Safari
* Licenses for Scriviner, Royal TSX, and Alfred
* A restart is an excellent idea!