#!/usr/bin/env bash
# Install command-line tools using Homebrew.

#Things I code in:
#Rails(Ruby,HAML,SASS,JS,CoffeeScript,IRB)
#React(JS,Reacthingmabob)
#C, C++, C#
#Kotlin(Android Dev)
#Swift(macOS, iOS, and watchOS Dev)
#Ardreno(Pretty much C)
#Python
#NodeJS
#Perl


#Things to play with
#Java
#Elixar
#Rust
#PHP (been awhile good to refresh, YII looks cool)



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

#install zsh shell
brew install zsh

# Install oh-my-zsh
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"


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

LATEST_RUBY=$(rbenv install -l | grep -v - | tail -1)
rbenv install LATEST_RUBY
rbenv global LATEST_RUBY
eval "$(rbenv init -)"
rbenv rehash
unset LATEST_RUBY

#TODO Install other versions of ruby here that we use

#TODO sourse shell
# then gem install rails bundler

# Neovim because I'm one of the cool kids
brew install neovim/neovim/neovim
pip2 install neovim
gem install neovim
#TODO python 3



# Install some CTF tools; see https://github.com/ctfs/write-ups.
# brew install aircrack-ng
# brew install bfg
# brew install binutils
# brew install binwalk
# brew install cifer
# brew install dex2jar
# brew install dns2tcp
# brew install fcrackzip
# brew install foremost
# brew install hashpump
# brew install hydra
# brew install john
# brew install knock
# brew install netpbm
# brew install nmap
# brew install pngcheck
# brew install socat
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
