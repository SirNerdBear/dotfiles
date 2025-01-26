########################-> Env Vars for XDG Support <-########################
export PYLINTHOME="$XDG_CACHE_HOME"/pylint
export PYTHONSTARTUP=$XDG_CONFIG_HOME/python/pythonstartup.py
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/config
export NPM_CONFIG_CACHE=$XDG_CACHE_HOME/npm
export NPM_CONFIG_TMP=$XDG_RUNTIME_DIR/npm
export WGETRC="$XDG_CONFIG_HOME"/wget/wgetrc
export MACHINE_STORAGE_PATH="$XDG_DATA_HOME"/docker-machine
export ANSIBLE_HOME="$XDG_DATA_HOME"/ansible
export ASDF_DATA_DIR="$XDG_DATA_HOME"/asdf 
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
export PYENV_ROOT="$XDG_DATA_HOME"/pyenv 
export PYTHONSTARTUP="$XDG_CONFIG_HOME"/python/pythonrc

export HISTFILE="$XDG_STATE_HOME/zsh/history"
export SHELL_SESSION_DIR="$XDG_STATE_HOME/zsh/sessions"
export SHELL_SESSION_FILE="$SHELL_SESSION_DIR/$TERM_SESSION_ID"

export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export INPUTRC="$XDG_CONFIG_HOME"/readline/inputrc
export GEMRC="$XDG_CONFIG_HOME"/rubygems/config
export GEM_SPEC_CACHE="$XDG_CACHE_HOME"/gem
export IRBRC="$XDG_CONFIG_HOME"/irb/irbrc
export PSQLRC="$XDG_CONFIG_HOME"/psql/config
export PRYRC="$XDG_CONFIG_HOME"/pry/pryrc
#TODO .subversion
# https://wiki.archlinux.org/index.php/XDG_Base_Directory
##############################################################################

# ~/.gem and ~/.rbenv left in the home directory because when moved gems
# with bins didn't get shims created. Nether is really within the XDG spec
# anyways as they contain programs, not data, cache, or configuration.
# and minus a little ~ clutter there is no significant advantage.
# /usr/local/var/rbenv and /usr/local/var/gem would make sense for these
# directories but it simply isn't worth the time to find the problem.
# For reference old stuff:
#export RBENV_ROOT=/usr/local/var/rbenv
#export GEM_HOME="$XDG_DATA_HOME"/gem
#export GEM_PATH="$XDG_DATA_HOME"/gem

# Other dotfiles that must remain in ~
# .CFUserTextEncoding (created by macOS)
# .DS_Store (because some sadistic programmer though these up)
# .Trash/ (macOS trash directory)
# .cups (printer driver, special snowflake)
# .local/ (XDG spec)
# .config (Symlink XDG spec)
# .ssh (Could be moved but not worth the hassle)
# .terminfo/ 



export EDITOR='nvim';

# Enable persistent REPL history for `node`.
export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node/history;
# Allow 32³ entries; the default is 1000.
export NODE_REPL_HISTORY_SIZE='32768';
# Use sloppy mode by default, matching web browsers.
export NODE_REPL_MODE='sloppy';

# Make Python use UTF-8 encoding for output to stdin, stdout, and stderr.
export PYTHONIOENCODING='UTF-8';

# Prefer US English and use UTF-8.
export LANG='en_US.UTF-8';
export LC_ALL='en_US.UTF-8';

# Highlight section titles in manual pages.
export LESS_TERMCAP_md="${green}";

# Don’t clear the screen after quitting a manual page.
export MANPAGER='less -X';

# Superuser bin
export PATH="/usr/local/sbin:$PATH"

# Make brew installed Python3 the system default
export PATH="/usr/local/opt/python/libexec/bin:$PATH"

# Make GNU brew installed tools the default
export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"

# Add systemd standard (adopted from XDG standard) bin directory
export PATH="$HOME/.local/bin:$PATH"

# Make RBENV shims work
export PATH="~/.rbenv/bin:$PATH"

# Add python scripts to PATH
export PATH="~/Library/Python/3.10/bin:$PATH"

# NeoVIM True Color Support (because 256 isn't enough for my rainbow!)
export NVIM_TUI_ENABLE_TRUE_COLOR=1

# Set Env for Platform
[ $(uname -s) = "Darwin" ] && export MACOS=1 && export UNIX=1
[ $(uname -s) = "Linux" ] && export LINUX=1 && export UNIX=1
uname -s | grep -q "_NT-" && export WINDOWS=1

