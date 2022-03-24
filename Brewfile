# https://github.com/Homebrew/homebrew-bundle

tap "homebrew/services"    # Integrates brews with macOS' launchctl manager
#tap "homebrew/cask-fonts"  # https://github.com/Homebrew/homebrew-cask-fonts
tap "homebrew/bundle"      # https://github.com/Homebrew/homebrew-bundle
tap "homebrew/core"        # Majority of brews are in the core
tap "idleberg/dbxcli"      # Dropbox dbxcli

################################## LIBRARYS ##################################
# Development dependencies used mostly in C projects.                        #
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#
brew "libevent"            # Lib for callback functions and events
brew "libyaml"             # YAML 1.1 parser and emitter written in C
brew "libgpg-error"        # Lib that defines common err values for all GnuPG
brew "libksba"             # Library for working with X.509 certificates
brew "pth"                 # Library for Unix platforms Pthreads
brew "libtool"             # Hides the complexity of using shared libraries
brew "libmemcached"        # C/C++ client library and tools for memcached
brew "libusb-compat"       # Library for USB device access
brew "libxml2"             # XML C parser and toolkit
brew "sdl2"                # Lib. Low-level access to audio, keyboard,
                           # mouse, joystick, and graphics.
brew "utf8proc"            # C library for processing UTF-8 Unicode data
brew "imagemagick"         # Programic image manipulation and creation
brew "webp"                # Format providing lossless and lossy compression
##############################  </END LIBRARYS>  #############################


################################# CLI  TOOLS #################################
# Tools to get the most out of the command-line. A lot of use-case utilties. #
# Some are for fun. That is, unless, ASCII fish are critical to workflow.    #
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#
brew "dbxcli"              # Dropbox CLI
brew "automake"            # Tool to automatically generate Makefile.in
brew "p7zip"               # A port of 7za.exe for POSIX systems
brew "colordiff"           # CLI diff… Now in COLOR!
brew "figlet"              # Text to ASCII art converter
brew "icoutils"            # Extract & convert images in windows ico/cur files
brew "speedtest-cli"       # CLI for https://speedtest.net bandwidth tests
brew "tcpflow"             # TCP/IP packet demultiplexer
brew "fontforge"           # Makes sexy fonts
brew "asciinema"           # CLI Recording
brew "cmus"                # CLI music player. Because iTunes is bloat-wear.
brew "htop"                # Better and sexier than top by 9001%
brew "screenfetch"         # Show system stats in terminal to be a 'cool kid.'
brew "lynx"                # CLI browser, for "reasons."
brew "curl"                # Newer curl than macOS system default
brew "wget"                # Easier terminal downloads over curl
brew "tree"                # Visual file tree CLI
brew "foremost"            # Data carving/recovery
brew "binutils"            # https://www.gnu.org/software/binutils/binutils.html
brew "knock"               # Port knocking (knock-knock. Who's there? Port 23)
brew "netpbm"              # http://netpbm.sourceforge.net/
brew "nmap"                # Network diagnostic tool
brew "pngcheck"            # Validate images
brew "exiv2"               # Manage image metadata
brew "ssh-copy-id"         # Easier transfer of ssh key to remote hosts
brew "cmatrix"             # Neo is the one
brew "cowsay"              # Obligatory. Moo.
brew "sl"                  # Ride the train
brew "asciiquarium"        # Fishys. Nuff said.
brew "multitail"           # Tail one or more logs with colors
brew "grc"                 # Genetic colorizor for logs or other things
brew "lnav"                # A different tailing log tool than multitail
brew "fzf"                 # CLI fuzzy finder.
brew "socat"               # Sockets via CLI
brew "zsh"                 # Bash replacement
brew "antibody"            # ZSH plugin manager
brew "reattach-to-user-namespace" # Enable pbpaste/pbcopy in tmux
brew "tmux"                # Terminal multiplexer
brew "tmux-xpanes"         # https://github.com/greymd/tmux-xpanes

brew "lastpass-cli",       # CLI interface for LastPass. Used to restore SSH
  args: ['with-pinentry']  # keys & other sensative data, keeping repo clean.
# TODO https://github.com/lastpass/lastpass-cli/issues/427

# Install more recent versions of some macOS tools.
brew "coreutils"           # GNU core utilities
brew "moreutils"           # Useful stuff like `vipe`, `vidir`, `chronic`.
                           # https://joeyh.name/code/moreutils/
brew "findutils"           # GNU `find`, `locate`, `updatedb`, and `xargs`.
brew "gnu-sed"             # GNU `sed`
brew "grep"                # GNU `grep`
brew "openssh"             # Remote login with the SSH protocol. Key gen.
brew "vim"                 # Prefer NeoVim but a fallback is a good idea.

# Install font tools.
tap "bramstein/webfonttools" # adds cask for font tools below
brew "sfnt2woff"           # TrueType and OpenType fonts -> WOFF
brew "sfnt2woff-zopfli"    # sfnt2woff with Zopfli compression (2-5% smaller)
brew "woff2"               # WOFF2 (de)compression utilities by Google
#############################  </END CLI TOOLS>  #############################


#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ BEGIN GAMES! @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#
# Why? Because: https://xkcd.com/303/                                        #
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#
brew "angband"             # http://www.roguebasin.com/index.php?title=Angband
brew "nethack"             #
#zangband??                # Anabang clone not in the tolken universe.
brew "ninvaders"           # Space invaders is a classic yo!
brew "moon-buggy"          # Oddly soothing during fits of debug rage.
brew "myman"               # Pacman with proper Vi movement keys.
brew "vitetris"            # DA DA DA DA DUM DUM DUM DA DA DA DO DO DO DA DA…
###############################  </END GAMES>  ###############################


#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ macOS APPS @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#
# General use applications not directly tied to development                  #
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#
cask "discord"             # Chatting sexyness
cask "scrivener"           # Writing prose.
cask "kindle"              # I was elected to lead, not to read
cask "vlc"                 # Playing videos and such
cask "karabiner-elements"  # Key remapping
cask "alfred"              # GUI fuzzy finder and more (replaces spotlight)
cask "iterm2"              # Terminal replacement

cask "firefox"             # Best
cask "google-chrome"       # Ok
cask "thunderbird"         # For Email

cask "sensiblesidebuttons" # Make back/forward on mouse work
cask "zoom"              # For remote meetings and such
cask "slack"               # Work chat
cask "microsoft-teams"     # Gross. Sick!
cask "webtorrent"          # Yo ho!
cask "scrivener"           # For penning the next epic novel
cask "grammarly"           # Write words the good
cask "calibre"             # For making eBooks
cask "dbeaver-community"   # Database GUI tool

cask "fontforge"           # Edit/convert fonts
cask "adobe-creative-cloud"# These jerks get $$$ every month

#Adobe apps must be installed manually from the CC app

#############################  </END macOS APPS>  ############################


############################### DEV ENVIRONMENT ##############################
# Install a whole bunch of non-restrictive license fonts. Licenced fonts are #
# added elsewhere (via custom finder extention) and synced with Dropbox.     #
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#
#cask "java"                # Needed for arduno and others
cask "arduino"             # Used for compiling/uploading arduino
cask "blisk"               # Browser for testing mobile, etc.
brew "go"                  # Twice as good as stop… j/k… https://golang.org/
brew "gx"                  # Package manager (used by Go projects)
brew "gx-go"               # Tool to use with the gx package manager in go
brew "python"              # Python 2.x
brew "python3"             # Python 3.x
brew "node"                # NodeJS
brew "rbenv"               # Usually prefer containers but this allows
                           # allows for not using the system gem folder
                           # and can run non-dockorized RoR apps.
brew "ruby-build"          # Allow rbenv to install Ruby versions
brew "yarn"                # Mostly used in React projects. And for cats.
brew "nvm"                 # Multiple versions of node and iojs (rbenv for js)

cask "visual-studio-code"  # GUI text editor that I setup like VIM
cask "imageoptim"          # Reduce size of images https://imageoptim.com/mac
cask "imagealpha"          # PNG24->PNG8 /w alpha channel https://pngmini.com/

cask "docker"              # Containers are HOT!
cask "virtualbox"          # Oracle's VirtualBox (VMs)
brew "qemu"                # CLI VMs

brew "postgresql"          # For local non-docker dbs
brew "redis"               # Local object storage (key value store)
brew "mysql"               # local mySQL db support (not auto started)
brew "memcached"           # An in-memory key-value store for small chunks
                           # of arbitrary data (strings, objects) from results
                           # of database calls, API calls, or page rendering.

brew "git"                 # More up to date than XCode installed default
brew "git-flow"            # https://github.com/nvie/gitflow
brew "git-standup"         # Get quick git commit history
brew "gist"                # CLI for uploading Gists
brew "hub"                 # Githubs wrapper for git https://hub.github.com/
brew "git-lfs"             # GIT large file storage https://git-lfs.github.com
brew "bfg"                 # Scubing files from a gitrepo, etc.
brew "ripgrep"             # grep but respects .gitignore
#https://stackoverflow.com/questions/39494631/gpg-failed-to-sign-the-data-fatal-failed-to-write-commit-object-git-2-10-0
brew "gpg"                 # Signing git commits and such
brew "pinentry-mac"        # GUI interface for GPG passphrase (macOS keychain)

brew "autoconf"            # Create config shell scripts
brew "mitmproxy"           # https://mitmproxy.org/
brew "ossp-uuid"           # ISO-C API and CLI for generating UUIDs
brew "pkg-config"          # helper tool used in compiling
brew "webkit2png"          # Python script that takes screenshots using webkit

# Add CLI completions for docker
brew "docker-completion"
#brew "docker-compose-completion"

# CODING FONT
# Ligatures don't work with font-firacode-nerd-font
# Therefore utilizing the non-acsii font for iTerm to support both.
#cask "font-fira-code"      # Ligature font for development sexyness
#cask "font-firacode-nerd-font" # Includes powerline symbols and much more

brew "neovim"              # Neovim > VIM (for now)
brew "the_silver_searcher" # Runs searches real fast. Get it? Ahahaha! NEEERD!
                           # Used in vim with Ag (replaces <Ctrl-P>).
###########################  </END DEV ENVIRONMENT>  #########################
