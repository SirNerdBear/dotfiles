#!/usr/bin/env bash

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

brew tap homebrew/services

# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils

# Install some other useful utilities like `sponge`.
brew install moreutils

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils

# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed --with-default-names

# Install `wget` with IRI support.
brew install wget --with-iri

# Install more recent versions of some macOS tools.
brew install vim --with-override-system-vi
brew install homebrew/dupes/grep
brew install homebrew/dupes/openssh

# Install font tools.
brew tap bramstein/webfonttools
brew install sfnt2woff
brew install sfnt2woff-zopfli
brew install woff2
brew install fontforge 

########################################################################################
# ZSH Shell — Bash? We don't need no stickin' Bashes!
########################################################################################
brew install zsh
sudo cp ~/.config/init/zshrc /etc #set zdot_dir
sudo cp ~/.config/init/xdg_env /etc #sourced by /etc/zshrc sets up XDG envirorment vars
sudo chmod 0444 /etc/zshrc /etc/xdg_env #read only for all
rm -f ~/.bash_profile ~/.bash_history ~/.bashrc 2> /dev/null #bash files bye bye
chsh -s $(which zsh) #set default shell

# Comand line awesome
brew install cmus #terminal based music player
brew install htop #better than top
brew install screenfetch #show system stats in terminal
brew install lynx #terminal based browser
brew install curl #newer curl than macOS system default
brew install wget #easier terminal downloads over curl
brew install git #more up to date than the one that comes with xcode command line tools
brew install git-lfs #???????
brew install bfg #scubing files from a gitrepo, etc.

brew install pinentry-mac gpg #signing git commits and such
#gpg --import ~/Dropbox/gpgkey.asc

brew install multitail grc lnav #colores log tools
brew install tree #visual file tree in terminal
brew install foremost #data carving/recovery
brew install binutils #https://www.gnu.org/software/binutils/binutils.html
brew install knock #port knocking
brew install netpbm #http://netpbm.sourceforge.net/
brew install nmap
brew install pngcheck
brew install exiv2 #manage image metadata
brew install ssh-copy-id
brew install webkit2png #Python script that takes screenshots (browsershots) using webkit

# Development
brew install socat #sockets via terminal command (required by tmuxstatus deamon)
brew install reattach-to-user-namespace #enable pbpaste/pbcopy support in tmux
brew install tmux
brew install tmux-xpanes #https://github.com/greymd/tmux-xpanes/blob/master/README.md
sudo gem install tmuxinator #system wide install

# Neovim
brew install neovim/neovim/neovim
pip3 install neovim
pip2 install neovim
npm install -g neovim
gem install neovim

# brew install homebrew/php/php56 --with-gmp
brew install imagemagick --with-webp
brew install postgresql #local dbs (though mostly use docker instances for dbs)
brew install python python3 #python 2 and python 3
brew install node #NodeJS
brew install rbenv ruby-build
#always install rails and bundler gems
git clone https://github.com/rbenv/rbenv-default-gems.git $(rbenv root)/plugins/rbenv-default-gems
echo -e "rails\nbundler\n" > $(rbenv root)/default-gems
LATEST_RUBY=$(rbenv install -l | grep -v - | tail -1)
rbenv install LATEST_RUBY
rbenv global LATEST_RUBY
eval "$(rbenv init -)"
rbenv rehash
unset LATEST_RUBY

# Silly fun things for the terminal
brew install cmatrix #Neo is the one
brew install cowsay #moo
brew install sl #train
brew install vitetris 
#text based adventure games like Adventure
#neocat

# Python stuff
pip3 install pyobjc-framework-ScriptingBridge
pip3 install -U pyobjc

# Remove outdated versions from the cellar.
brew cleanup