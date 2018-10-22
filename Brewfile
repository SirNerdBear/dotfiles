tap "homebrew/services"
tap "caskroom/cask"
tap "homebrew/cask-fonts"
tap "heroku/brew"

tap "caskroom/drivers"
#tap "caskroom/fonts"
tap "homebrew/bundle"
tap "homebrew/core"
#tap "homebrew/fuse"
tap "homebrew/science"


# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew "coreutils"

# Install some other useful utilities like `sponge`.
brew "moreutils"

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew "findutils"

# Install GNU `sed`, overwriting the built-in `sed`.
brew "gnu-sed", args: ["with-default-names"]

# Install more recent versions of some macOS tools.
brew "vim", args: ["with-override-system-vi"]
brew "homebrew/dupes/grep"
brew "homebrew/dupes/openssh"

# Install font tools.
tap "bramstein/webfonttools"
brew "sfnt2woff"
brew "sfnt2woff-zopfli"
brew "woff2"
brew "fontforge"

########################################################################################
# ZSH Shell — Bash? We don't need no stickin' Bashes!
########################################################################################
brew "zsh"
sudo cp ~/.config/init/zshrc /etc #set zdot_dir
sudo cp ~/.config/init/xdg_env /etc #sourced by /etc/zshrc sets up XDG envirorment vars
sudo chmod 0444 /etc/zshrc /etc/xdg_env #read only for all
rm -f ~/.bash_profile ~/.bash_history ~/.bashrc 2> /dev/null #bash files bye bye
chsh -s $(which zsh) #set default shell

brew "asciinema" #terminal recording
brew "autoconf"  #create config shell scripts

#games
brew "angband"
brew "nethack"
#zangband??
brew "ninvaders"
brew "moon-buggy"
brew "pacman4console"
brew "myman"
brew "vitetris"
#text based adventures


brew "autojump"
brew "automake"
brew "p7zip"
brew "ssdeep"
brew "colordiff"
brew "libevent"
brew "libyaml"
brew "libgpg-error"
brew "libksba"
brew "pth"
brew "dirmngr"
brew "ettercap"
brew "ffmpeg", args: ["with-sdl2"]
brew "figlet"
brew "fzf"
brew "gettext"
brew "gist"
brew "git-flow"
brew "git-standup"
brew "gnupg"
brew "go"
brew "gx"
brew "gx-go"
brew "hub"
brew "icecast"
brew "icoutils"
brew "libtool"
brew "ipfs"
brew "memcached"
brew "libmemcached"
brew "libusb-compat"
brew "libxml2"
brew "mitmproxy"
brew "mosh"
brew "mtr"
brew "mysql"
brew "nmap"
brew "nvm"
brew "openssl@1.1"
brew "ossp-uuid"
brew "pkg-config"
brew "qemu"
brew "ripgrep"
brew "sdl2"
brew "speedtest-cli"
brew "sshfs"
brew "sslsplit"
brew "tcpflow"
brew "the_silver_searcher"
brew "utf8proc"
brew "yarn"
brew "heroku/brew/heroku"
brew "rcmdnk/file/brew-file" #?????????????????????
cask "docker-toolbox"

# Comand line awesome
brew "cmus" #terminal based music player
brew "htop" #better than top
brew "screenfetch" #show system stats in terminal
brew "lynx" #terminal based browser
brew "curl" #newer curl than macOS system default
brew "wget", args: ["with-iri"] #easier terminal downloads over curl
brew "tree" #visual file tree in terminal
brew "foremost" #data carving/recovery
brew "binutils" #https://www.gnu.org/software/binutils/binutils.html
brew "knock" #port knocking
brew "netpbm" #http://netpbm.sourceforge.net/
brew "nmap" #network diagnostic tool
brew "pngcheck" #validate images
brew "exiv2" #manage image metadata
brew "ssh-copy-id" #easier transfer of ssh key to remote hosts
brew "webkit2png" #Python script that takes screenshots (browsershots) using webkit
brew "cmatrix" #Neo is the one
brew "cowsay" #moo
brew "sl" #train
#aquarium

#colored log tailing
brew "multitail"
brew "grc"
brew "lnav"


# Development
brew "git" #more up to date than the one that comes with xcode command line tools
brew install git-lfs #???????
brew "bfg" #scubing files from a gitrepo, etc.
brew "gpg" #signing git commits and such
brew "pinentry-mac" #GUI interface for GPG passphrases, allows macOS keychain use
brew "socat" #sockets via terminal command (required by tmuxstatus deamon)
brew "reattach-to-user-namespace" #enable pbpaste/pbcopy support in tmux
brew "tmux" #terminal multiplexer
brew "tmux-xpanes" #https://github.com/greymd/tmux-xpanes/blob/master/README.md
cask "java" #needed for arduno and others
cask "arduino" #dev IDE used for compiling within NeoVIM/VSCode
cask "docker" #containers are sexy
cask "virtualbox" #vms

tap "homebrew/completions"
brew "homebrew/completions/docker-completion"
brew "homebrew/completions/docker-compose-completion"
# Coding Font
# Ligatures don't work with font-firacode-nerd-font-mono
# Therefore utilizing the non-acsii font for iTerm to support ligatures AND powerline+ symbols
cask "font-fira-code" #ligature font for development sexyness
cask "font-firacode-nerd-font-mono" # includes powerline and many others


cask "visual-studio-code" #VSCode is a GUI text editor (not used much anymore)
cask "discord" #Chatting sexyness
#cask "scrivener" #Writing prose. Must manually install until I get 3.0 (assholes)

cask "google-chrome"
#opera
cask "firefox"

cask "imageoptim" #Reduce size of images https://imageoptim.com/mac
cask "imagealpha" #PNG24 to PNG8 with alpha channel support https://pngmini.com/

cask "kindle"
#cask "monolingual" #broken
cask "sketch"
cask "sketch-toolbox"
cask "soulver" #Text driven calcuations on-the-fly
cask "transmit" #For the occational FTP need
cask "vlc" #Playing videos and such
cask "karabiner-elements" #key remapping
cask "dropbox"
cask "google-drive"
cask "alfred" #GUI fuzzy finder and more (replaces spotlight interface)
cask "iterm2" #terminal replacement
cask "bettertouchtool" #touchbar, remapping mice, keyboard shortcuts, window snapping


sudo gem install tmuxinator #system wide install <- TODO MOVE TO install.sh for tmuxinator


brew "neovim/neovim/neovim" # Neovim > VIM (for now)


# brew install homebrew/php/php56 --with-gmp
brew "imagemagick", args: ["with-webp"] #programic image manipulation/creation
brew "postgresql", restart_service: true #for local non-docker dbs
brew "redis", restart_service: true #local kvs
brew "python" #python 2.x
brew "python3" #python 3.x
brew "node" #NodeJS
brew "rbenv" #Better than RVM
brew "ruby-build" #Allow rbenv to install Ruby versions

#always install rails and bundler gems
git clone https://github.com/rbenv/rbenv-default-gems.git $(rbenv root)/plugins/rbenv-default-gems
echo -e "rails\nbundler\n" > $(rbenv root)/default-gems
LATEST_RUBY=$(rbenv install -l | grep -v - | tail -1)
rbenv install LATEST_RUBY
rbenv global LATEST_RUBY
eval "$(rbenv init -)"
rbenv rehash
unset LATEST_RUBY

# Python stuff
pip3 install pyobjc-framework-ScriptingBridge
pip3 install -U pyobjc
pip3 install ipython #debugging
pip2 install ipython #debugging

