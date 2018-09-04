#!/bin/sh
 
#                                                                                              
#
# Most of this is copied from https://github.com/mathiasbynens/dotfiles
#

#Colors for use with cecho function
black='\033[0;30m'
white='\033[0;37m'
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
blue='\033[0;34m'
magenta='\033[0;35m'
cyan='\033[0;36m'
  
#Resets the style
reset=`tput sgr0`
 
#Bold
bold=`tput bold`
  
cecho() {
  echo "${2}${1}${reset}"
  return
}
 
cecho_bold() {
  echo "${2}${bold}${1}${reset}"
  return
}


ls -al /Applications/Xcode.app 2>/dev/null
rc=$?; if [[ $rc != 0 ]]; then
    cecho_bold "Xcode is not installed!" $white
    open "https://itunes.apple.com/us/app/xcode/id497799835#"
    exit $rc
fi
 
# Set continue to false by default
CONTINUE=false
  
echo ""
cecho_bold '  ______        _______.   ___   ___      ______   ______   .__   __.  _______  __    _______ ' $green
cecho_bold ' /  __  \      /       |   \  \ /  /     /      | /  __  \  |  \ |  | |   ____||  |  /  _____|' $green
cecho_bold '|  |  |  |    |   (----     \  V  /     |   ----|   |  |  | |   \|  | |  |__   |  | |  |  __  ' $green
cecho_bold '|  |  |  |     \   \         >   <      |  |     |  |  |  | |  .    | |   __|  |  | |  | |_ | ' $green
cecho_bold '|   --   | .----)   |       /  .  \     |   ----.|   --   | |  |\   | |  |     |  | |  |__| | ' $green
cecho_bold ' \______/  |_______/       /__/ \__\     \______| \______/  |__| \__| |__|     |__|  \______| ' $green
echo ""
 
echo ""
cecho "Run config script and set macOS awesomeness? (y/n)" $cyan
read -r response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
  CONTINUE=true
fi
  
if ! $CONTINUE; then
  exit
fi
 
# Ask for the administrator password upfront
sudo -v
 
# Keep-alive: update existing `sudo` time stamp until script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
 
# ===========================================
# = NVRAM CONFIG (CLEARED WITH PRAM RESET)  =
# ===========================================
#Always boot in verbose mode
sudo nvram boot-args="-v"

# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

# ===============
# = MAIN CONFIG =
# ===============

# Set standby delay to 24 hours (default is 1 hour)
sudo pmset -a standbydelay 86400

# Menu bar: hide the Time Machine and Volume
for domain in ~/Library/Preferences/ByHost/com.apple.systemuiserver.*; do
  defaults write "${domain}" dontAutoLoad -array \
    "/System/Library/CoreServices/Menu Extras/TimeMachine.menu" \
    "/System/Library/CoreServices/Menu Extras/Volume.menu"
 
defaults write com.apple.systemuiserver menuExtras -array \
	"/System/Library/CoreServices/Menu Extras/Bluetooth.menu" \
	"/System/Library/CoreServices/Menu Extras/AirPort.menu" \
	"/System/Library/CoreServices/Menu Extras/Battery.menu" \
	"/System/Library/CoreServices/Menu Extras/Clock.menu"

# Set highlight color to dark gray
defaults write NSGlobalDomain AppleHighlightColor -string "0.447764 0.446023 0.449583"

# Set sidebar icon size to medium
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2

# Always show scrollbars
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"
# Possible values: `WhenScrolling`, `Automatic` and `Always`

# Disable the over-the-top focus ring animation
defaults write NSGlobalDomain NSUseAnimatedFocusRing -bool false

# Increase window resize speed for Cocoa applications
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Remove duplicates in the “Open With” menu (also see `lscleanup` alias)
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user

# Display ASCII control characters using caret notation in standard text views
# Try e.g. `cd /tmp; unidecode "\x{0000}" > cc.txt; open -e cc.txt`
defaults write NSGlobalDomain NSTextShowsControlCharacters -bool true

# Disable Resume system-wide
defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false

# Disable automatic termination of inactive apps
defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true

# Set Help Viewer windows to non-floating mode
defaults write com.apple.helpviewer DevMode -bool true

# Reveal IP address, hostname, OS version, etc. when clicking the clock
# in the login window
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

# Restart automatically if the computer freezes
sudo systemsetup -setrestartfreeze on

# Never go into computer sleep mode
sudo systemsetup -setcomputersleep Off > /dev/null

# Disable Notification Center and remove the menu bar icon
launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist 2> /dev/null

# Disable smart quotes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable smart dashes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Disable “natural” (Lion-style) scrolling
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false
 
# =============
# = Wallpaper =
# =============
# TODO
# Set a custom wallpaper image. `DefaultDesktop.jpg` is already a symlink, and
# all wallpapers are in `/Library/Desktop Pictures/`. The default is `Wave.jpg`.
#rm -rf ~/Library/Application Support/Dock/desktoppicture.db
#sudo rm -rf /System/Library/CoreServices/DefaultDesktop.jpg
#sudo ln -s /path/to/your/image /System/Library/CoreServices/DefaultDesktop.jpg

###############################################################################
# SSD-specific tweaks                                                         #
###############################################################################

# Disable hibernation (speeds up entering sleep mode)
sudo pmset -a hibernatemode 0

# Remove the sleep image file to save disk space
sudo rm /private/var/vm/sleepimage
# Create a zero-byte file instead…
sudo touch /private/var/vm/sleepimage
# …and make sure it can’t be rewritten
sudo chflags uchg /private/var/vm/sleepimage

# Disable the sudden motion sensor as it’s not useful for SSDs
sudo pmset -a sms 0

# ==============================================================
# = GENERAL CONFIG AVAILABLE IN CONTROL PANEL (THIS IS FASTER) =
# ==============================================================
# Change minimize/maximize window effect
defaults write com.apple.dock mineffect -string "scale"
 
# Minimize windows into their application’s icon
defaults write com.apple.dock minimize-to-application -bool true
 
# Don’t animate opening applications from the Dock
defaults write com.apple.dock launchanim -bool false
 
# Speed up Mission Control animations
defaults write com.apple.dock expose-animation-duration -float 0.1
 
# Don’t group windows by application in Mission Control
# (i.e. use the old Exposé behavior instead)
defaults write com.apple.dock expose-group-by-app -bool false
 
# Disable Dashboard
defaults write com.apple.dashboard mcx-disabled -bool true
 
# Don’t show Dashboard as a Space
defaults write com.apple.dock dashboard-in-overlay -bool true
 
# Don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false
 
# Disable the Launchpad gesture (pinch with thumb and three fingers)
defaults write com.apple.dock showLaunchpadGestureEnabled -int 0

#Keyboard backlight turn off after 5 minutes to save battery
defaults write com.apple.BezelServices kDimTime -int 300
 
 
echo ""
echo "Would you like to set your computer name (as done via System Preferences >> Sharing)?  (y/n)"
read -r response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
  echo "What would you like it to be?"
  read COMPUTER_NAME
  sudo scutil --set ComputerName $COMPUTER_NAME
  sudo scutil --set HostName $COMPUTER_NAME
  sudo scutil --set LocalHostName $COMPUTER_NAME
  sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string $COMPUTER_NAME
fi
 
#hide spotlight icon
sudo chmod 600 /System/Library/CoreServices/Search.bundle/Contents/MacOS/Search
 
#dark mode switching via Control+Option+Command+T
# http://www.reddit.com/r/apple/comments/2jr6s2/1010_i_found_a_way_to_dynamically_switch_between/
sudo defaults write /Library/Preferences/.GlobalPreferences.plist _HIEnableThemeSwitchHotKey -bool true
 
# ================
# = Disable Dock =
# ================

#Wipe all (default) app icons from the Dock
defaults write com.apple.dock persistent-apps -array
 
 
#Hide the Dock and Set a Very Long Delay AKA Remove the Dock for Good
defaults write com.apple.dock autohide-delay -float 1000
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-time-modifier -float 20000000000; killall Dock
defaults write com.apple.dock tilesize -int 1 #tiny size
defaults write com.apple.dock magnification -boolean false
defaults write com.apple.dock contents-immutable -boolean true
defaults write com.apple.dock static-only -bool TRUE #only show open apps
defaults write com.apple.dock size-immutable -boolean true
defaults write com.apple.dock magnify-immutable -boolean true
defaults write com.apple.dock autohide-immutable -boolean true
defaults write com.apple.dock position-immutable -boolean true
defaults write com.apple.dock min-effect-immutable -boolean true
defaults write com.apple.dock min-in-place-immutable -boolean true
defaults write com.apple.dock no-bouncing -boolean-neg true
 
#iTerm2 Settings
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "/Users/scott/Dropbox/Apps/iTerm2"
 
# ==================
# = KEYBOARD INPUT =
# ==================
 
#Unicode Input
defaults write com.apple.HIToolbox AppleEnabledInputSources -array-add '<dict><key>InputSourceKind</key><string>Keyboard Layout</string><key>KeyboardLayout ID</key><integer>-1</integer><key>KeyboardLayout Name</key><string>Unicode Hex Input</string></dict>'
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 60 '<dict><key>enabled</key><false/><key>value</key><dict><key>parameters</key><array><integer>32</integer><integer>49</integer><integer>786432</integer></array><key>type</key><string>standard</string></dict></dict>'
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 61 '<dict><key>enabled</key><true/><key>value</key><dict><key>parameters</key><array><integer>32</integer><integer>49</integer><integer>917504</integer></array><key>type</key><string>standard</string></dict></dict>'
 
# ==========
# = CHROME =
# ==========
# Bring up Chrome Extensions via ⌘E (Window → Extensions)
defaults write com.google.Chrome NSUserKeyEquivalents '{ Extensions = "@$e"; }'
 
 
###############################################################################
# Kill affected applications                                                  #
###############################################################################
 
for app in "Activity Monitor" "cfprefsd" \
    "Dock" "Finder" "Chrome" "Safari" "SystemUIServer" \
    "Terminal" "iTerm"; do
    killall "${app}" > /dev/null 2>&1
done

