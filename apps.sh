
# =========================
# = Install Google Chrome =
# =========================
temp=$TMPDIR$(uuidgen)
mkdir -p $temp/mount
curl https://dl.google.com/chrome/mac/stable/GGRO/googlechrome.dmg > $temp/1.dmg
yes | hdiutil attach -noverify -nobrowse -mountpoint $temp/mount $temp/1.dmg
cp -r $temp/mount/*.app /Applications
hdiutil detach $temp/mount
rm -r $temp
#LastPass
open -a "Google Chrome" "https://chrome.google.com/webstore/detail/lastpass-free-password-ma/hdokiejnpimakedhajhdlcegeplioahd?hl=en-US"
 
exit;

#https://github.com/mas-cli/mas


#configure ruby GEM manager to avoid documentation (speeds up gem install)
echo "gem: --no-ri --no-rdoc" > $HOME/.gemrc
 
#Install Homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew doctor
 
brew install lynx wget git
brew install postgresql
brew install rbenv ruby-build node
 
# Xcode
# Chrome & Canary
# Photoshop
# Alfred (Set clipboard history)
# BetterTouchTool
# Discord
# iTerm2 (Need 3.1 or nightly build for margin settinge 
 
#brew install macvim --override-system-vim
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

brew install rbenv ruby-build cmatrix sl cowsay

#TODO sourse shell and set rbenv global
# then
# gem install highline rails bundler

brew install python python3 curl fontforge

#brew install neovim/neovim/neovim

#pip2 install neovim
#gem install neovim
#TODO python 3

#install XCODE command line tools
#make sure XCODE is installed or this wonâ€™t work
xcode-select --install
