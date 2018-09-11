#!/usr/bin/env bash


#AppStore
#mas signin --dialog #NEED EMAIL#
mas install 409203825 #Numbers
mas install 409203825 #XCoode
mas install 497799835 #Pages
mas install 409201541 #The Archive Browser
mas install 409183694 #Keynote
mas install 425424353 #The Unarchiver

# Install apps

# Chrome & Canary
# Photoshop
# Alfred
# BetterTouchTool
# Discord
# iTerm2
# Docker
# Arduino,

# #https://github.com/mas-cli/mas
# CLI App: Xcode, Pages, Numbers, Keynote, The Archive Browser

#For the most part I should switch to Docker instead of dealing with DB
#instances on my local machine, etc. 

# Install main applications
brew cask install iterm2
brew cask install alfred
brew cask install dropbox
brew cask install bettertouchtool #NOT WORKING
brew cask install visual-studio-code
brew cask install discord
#brew cask install scrivener #Must manually install until I get 3.0 (assholes)


brew cask install imageoptim #Reduce size of images https://imageoptim.com/mac
brew cask install imagealpha #PNG24 to PNG8 with alpha channel support https://pngmini.com/ 


brew tap homebrew/completions
brew install homebrew/completions/docker-completion
brew install homebrew/completions/docker-compose-completion

brew tap caskroom/cask
#brew cask install atom
brew cask install dashlane
brew cask install docker
brew cask install dropbox
brew cask install firefox
brew cask install google-chrome
brew cask install google-drive
brew cask install iterm2
#brew cask install kindle
brew cask install monolingual
brew cask install sequel-pro
brew cask install sketch
brew cask install sketch-toolbox
brew cask install sky-fonts
brew cask install skype
brew cask install soulver
brew cask install transmit
brew cask install vlc
brew cask install wifi-explorer

#tap caskroom/fonts
#cask font-inconsolata
#cask font-fira-mono
cask font-abeezee
cask font-abel
cask font-aboriginal-sans
cask font-aboriginal-serif

#TODO add more fonts 
brew cask install \
  font-anonymous-pro \
  font-dejavu-sans-mono-for-powerline \
  font-droid-sans \
  font-droid-sans-mono font-droid-sans-mono-for-powerline \
  font-meslo-lg font-input \
  font-inconsolata font-inconsolata-for-powerline \
  font-liberation-mono font-liberation-mono-for-powerline \
  font-liberation-sans \
  font-meslo-lg \
  font-nixie-one \
  font-office-code-pro \
  font-pt-mono \
  font-raleway font-roboto \
  font-source-code-pro font-source-code-pro-for-powerline \
  font-source-sans-pro \
  font-ubuntu font-ubuntu-mono-powerline