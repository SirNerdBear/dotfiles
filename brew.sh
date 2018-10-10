#!/usr/bin/env bash

mkdir -p ~Library/Python

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils

# Install some other useful utilities like `sponge`.
brew install moreutils

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils

# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed --with-default-names

#CLI for AppStore https://github.com/mas-cli/mas
brew install mas

# Install `wget` with IRI support.
brew install wget --with-iri

# Install more recent versions of some macOS tools.
brew install vim --with-override-system-vi
brew install homebrew/dupes/grep
brew install homebrew/dupes/openssh
# brew install homebrew/php/php56 --with-gmp

# Install font tools.
brew tap bramstein/webfonttools
brew install sfnt2woff
brew install sfnt2woff-zopfli
brew install woff2

# Install essentual development tools
brew install lynx wget git
brew install postgresql
brew install rbenv ruby-build node
brew install cmatrix sl cowsay pinentry-mac gpg
brew install python python3 curl fontforge reattach-to-user-namespace htop screenfetch tmux
brew install tmux-xpanes #https://github.com/greymd/tmux-xpanes/blob/master/README.md
brew install vitetris #time wasting

brew install zsh #better shell
sudo cp ~/.config/init/zshrc /etc
sudo cp ~/.config/init/xdg_env /etc
sudo chmod 0444 /etc/zshrc /etc/xdg_env
rm -f ~/.bash_profile ~/.bash_history ~/.bashrc 2> /dev/null #ugly bash files bye bye


brew install cmus

brew install multitail grc

#needed for tmux status line connecing to python deamon
brew install socat #used to connect to sockets via terminal command

#always install rails and bundler gems
git clone https://github.com/rbenv/rbenv-default-gems.git $(rbenv root)/plugins/rbenv-default-gems
echo -e "rails\nbundler\n" > $(rbenv root)/default-gems

LATEST_RUBY=$(rbenv install -l | grep -v - | tail -1)
rbenv install LATEST_RUBY
rbenv global LATEST_RUBY
eval "$(rbenv init -)"
rbenv rehash
unset LATEST_RUBY

# Neovim
brew install neovim/neovim/neovim
pip2 install neovim
gem install neovim
sudo gem install tmuxinator #system wide install

export PATH="/usr/local/opt/python/libexec/bin:$PATH"
#pip will now be python 3
#pip2 will be the system python /usr/local/bin

#or be explict and use pip3
pip3 install pyobjc-framework-ScriptingBridge
pip3 install -U pyobjc
pip3 install neovim

#npm support for neovim
npm install -g neovim

brew install foremost #data carving/recovery

# Install some CTF tools; see https://github.com/ctfs/write-ups.
# brew install aircrack-ng
brew install bfg #scubing files from a gitrepo, etc.
# brew install binutils
# brew install binwalk
# brew install cifer
# brew install dex2jar
# brew install dns2tcp
# brew install fcrackzip
# brew install hashpump
# brew install hydra
# brew install john
brew install knock #port knocking
# brew install netpbm
# brew install nmap
# brew install pngcheck
# brew install sqlmap
# brew install tcpflow
# brew install tcpreplay
# brew install tcptrace
# brew install ucspi-tcp # `tcpserver` etc.
# brew install xpdf
# brew install xz

brew tap homebrew/services

# Install other useful binaries.
#brew install exiv2
brew install git
brew install git-lfs
brew install imagemagick --with-webp
brew install ssh-copy-id
brew install tree
brew install webkit2png
brew install wget

# Remove outdated versions from the cellar.
brew cleanup
