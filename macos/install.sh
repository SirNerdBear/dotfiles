#!/bin/sh

[ $(uname -s) != "Darwin" ] && exit

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

if [ ! -f /Library/Keychains/FileVaultMaster.keychain ]; then
  sudo mv ~/Projects/dotfiles/init/FileVaultMaster.keychain \
          /Library/Keychains/FileVaultMaster.keychain
fi
if sudo fdesetup status | \
   grep -q 'FileVault is Off' && sudo fdesetup showdeferralinfo | \
   grep -q 'Not found'
then
  sudo fdesetup enable -defer /dev/null -keychain –norecoverykey -forceatlogin 0 –dontaskatlogout
fi

#get the fonts from dropbox
#dbxcli get my-font-backup.zip && unzip -o my-font-backup.zip -d ~/Library/Fonts && rm my-font-backup.zip
#chmod 0600 ~/Library/Fonts/*

##################################################################################
# General UI/UX
##################################################################################

#Always boot in verbose mode
sudo nvram boot-args="-v"

# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

# Set standby delay to 24 hours (default is 1 hour)
sudo pmset -a standbydelay 86400

# Menu bar: hide the Time Machine, Volume, and User icons
for domain in ~/Library/Preferences/ByHost/com.apple.systemuiserver.*; do
	defaults write "${domain}" dontAutoLoad -array \
		"/System/Library/CoreServices/Menu Extras/TimeMachine.menu" \
		"/System/Library/CoreServices/Menu Extras/Volume.menu" \
		"/System/Library/CoreServices/Menu Extras/User.menu"
done

defaults write com.apple.systemuiserver menuExtras -array \
	"/System/Library/CoreServices/Menu Extras/Bluetooth.menu" \
	"/System/Library/CoreServices/Menu Extras/AirPort.menu" \
	"/System/Library/CoreServices/Menu Extras/Battery.menu" \
	"/System/Library/CoreServices/Menu Extras/Clock.menu"

# Disable the guest account
sudo /usr/bin/defaults write /Library/Preferences/com.apple.loginwindow GuestEnabled -bool NO;
sudo defaults write /Library/Preferences/com.apple.AppleFileServer guestAccess -bool NO
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server AllowGuestAccess -bool NO

# Disabling OS X Gate Keeper
# Install any app, not just Mac App Store apps
sudo spctl --master-disable
sudo defaults write /var/db/SystemPolicy-prefs.plist enabled -string no
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Set highlight color to dark gray
defaults write NSGlobalDomain AppleHighlightColor -string "0.447764 0.446023 0.449583"

# Set sidebar icon size to medium
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2

# Always show scrollbars
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"
# Possible values: `WhenScrolling`, `Automatic` and `Always`

# Disable the over-the-top focus ring animation
defaults write NSGlobalDomain NSUseAnimatedFocusRing -bool false

# Disable smooth scrolling
#defaults write NSGlobalDomain NSScrollAnimationEnabled -bool false

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

# Display ASCII control characters using caret notation in standard text views
# Try e.g. `cd /tmp; unidecode "\x{0000}" > cc.txt; open -e cc.txt`
defaults write NSGlobalDomain NSTextShowsControlCharacters -bool true

# Disable Resume system-wide
defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false

# Disable automatic termination of inactive apps
defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true

# Saving to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Remove duplicates in the “Open With” menu (also see `lscleanup` alias)
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user

# Disable the crash reporter
#defaults write com.apple.CrashReporter DialogType -string "none"

# Set Help Viewer windows to non-floating mode
defaults write com.apple.helpviewer DevMode -bool true

# Reveal IP address, hostname, OS version, etc. when clicking the clock
# in the login window
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

# Restart automatically if the computer freezes
sudo systemsetup -setrestartfreeze on

# Never go into computer sleep mode
sudo systemsetup -setcomputersleep Off > /dev/null

# Disable smart quotes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable smart dashes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Dark mode
defaults write -g AppleInterfaceStyle "Dark"
defaults write -g AppleAquaColorVariant -int 6

# Reudce motion enable to change space switching to a fade and not a swipe
defaults write com.apple.universalaccess reduceMotion -bool true
defaults write com.apple.dock expose-animation-duration -float 0.1 #doesn't work in 10.12+

osascript -e 'tell application "Finder" to set desktop picture to POSIX file "'"${XDG_CONFIG_HOME}/init/Minimal Forest [FIXED].heic"'"'


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

###############################################################################
# Trackpad, mouse, keyboard, Bluetooth accessories, and input                 #
###############################################################################

#Make function keys work like function keys by default
defaults write -g com.apple.keyboard.fnState -bool true

# cnt=`/usr/libexec/PlistBuddy -c "print AppleEnabledInputSources" ~/Library/Preferences/com.apple.HIToolbox.plist | grep "Dict" | wc -l | tr -d '[:space:]'`
# cnt=`expr "$cnt" '-' '1'`
# US=0
# UNICODE=0
# REMOVE=()
# foreach idx (`seq 0 $cnt`)
#     val=`/usr/libexec/PlistBuddy -c "print AppleEnabledInputSources:${idx}:InputSourceKind" ~/Library/Preferences/com.apple.HIToolbox.plist`
#     if [ "$val" = "Keyboard Layout" ]; then
#         input=`/usr/libexec/PlistBuddy -c "print AppleEnabledInputSources:${idx}:KeyboardLayout\ Name" ~/Library/Preferences/com.apple.HIToolbox.plist`
#         if [ "$input" = "U.S." ]; then
#             if [ "$US" -gt 0 ]; then
#                 REMOVE+=($idx)
#             fi
#             US=1;
#         elif [ "$input" = "Unicode Hex Input" ]; then
#             if [ "$UNICODE" -gt 0 ]; then
#                 REMOVE+=($idx)
#             fi
#             UNICODE=1;
#         else
#             REMOVE+=(idx)
#             echo "${input}"
#         fi
#     fi
# end
# if [ "$US" -lt 1 ]; then
#     #add US standard keyboard input
#     defaults write com.apple.HIToolbox AppleEnabledInputSources -array-add '<dict><key>InputSourceKind</key><string>Keyboard Layout</string><key>KeyboardLayout ID</key><integer>0</integer><key>KeyboardLayout Name</key><string>U.S.</string></dict>'
# fi
# if [ "$UNICODE" -lt 1 ]; then
#     #add Unicode keyboard input allowing easy input of unicode characters (Option+unicode)
#     defaults write com.apple.HIToolbox AppleEnabledInputSources -array-add '<dict><key>InputSourceKind</key><string>Keyboard Layout</string><key>KeyboardLayout ID</key><integer>-1</integer><key>KeyboardLayout Name</key><string>Unicode Hex Input</string></dict>'
# fi
# foreach idx ($REMOVE)
#     #remove inputs that are dups or not U.S. / Unicode
#     /usr/libexec/PlistBuddy -c "delete AppleEnabledInputSources:${idx}" ~/Library/Preferences/com.apple.HIToolbox.plist
# end

# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Trackpad: map bottom right corner to right-click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
defaults -currentHost write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 1
defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true

# Disable “natural” (Lion-style) scrolling
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Increase sound quality for Bluetooth headphones/headsets
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

# Enable full keyboard access for all controls
# (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Use scroll gesture with the Ctrl (^) modifier key to zoom
defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144

# Follow the keyboard focus while zoomed in
defaults write com.apple.universalaccess closeViewZoomFollowsFocus -bool true

# Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 40

# Set language and text formats
# Note: if you’re in the US, replace `EUR` with `USD`, `Centimeters` with
# `Inches`, `en_GB` with `en_US`, and `true` with `false`.
defaults write NSGlobalDomain AppleLanguages -array "us" "en"
defaults write NSGlobalDomain AppleLocale -string "en_US@currency=USD"
defaults write NSGlobalDomain AppleMeasurementUnits -string "Inches"
defaults write NSGlobalDomain AppleMetricUnits -bool false

# Set the timezone; see `sudo systemsetup -listtimezones` for other values
sudo systemsetup -settimezone "America/Los_Angeles" > /dev/null

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Turn off keyboard illumination when computer is not used for 2 minutes
defaults write com.apple.BezelServices kDimTime -int 120

# Setting trackpad & mouse speed to a reasonable number
defaults write -g com.apple.trackpad.scaling 2
defaults write -g com.apple.mouse.scaling 2.5

# Turn on right click support for mice
defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseButtonMode -string TwoButton
defaults write com.apple.AppleMultitouchMouse MouseButtonMode -string TwoButton
defaults write com.apple.driver.AppleHIDMouse Button2 -int 2

##################################################################################
# System Shortcuts
##################################################################################

#12 - kSHKTurnKeyboardAccessOnOrOff - Ctrl, F1
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 12 '<dict><key>enabled</key><false/><key>value</key><dict><key>parameters</key><array><integer>65535</integer><integer>122</integer><integer>8650752</integer></array><key>type</key><string>standard</string></dict></dict>'

#21 - kSHKInvertColors - Ctrl, Opt, Cmd, 8
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 21 '<dict><key>enabled</key><false/><key>value</key><dict><key>parameters</key><array><integer>56</integer><integer>28</integer><integer>1835008</integer></array><key>type</key><string>standard</string></dict></dict>'

#30 - kSHKSavePictureOfSelectedAreaAsAFile - Shift, Cmd, 4
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 30 '<dict><key>enabled</key><true/><key>value</key><dict><key>parameters</key><array><integer>52</integer><integer>21</integer><integer>1179648</integer></array><key>type</key><string>standard</string></dict></dict>'

#13 - kSHKChangeTheWayTabMovesFocus - Ctrl, F7
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 13 '<dict><key>enabled</key><true/><key>value</key><dict><key>parameters</key><array><integer>65535</integer><integer>98</integer><integer>8650752</integer></array><key>type</key><string>standard</string></dict></dict>'

#79 - kSHKMoveLeftASpace - Ctrl, Arrow Left
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 79 '<dict><key>enabled</key><true/><key>value</key><dict><key>parameters</key><array><integer>65535</integer><integer>123</integer><integer>8650752</integer></array><key>type</key><string>standard</string></dict></dict>'

#31 - kSHKCopyPictureOfSelectedAreaToTheClipboard - Ctrl, Shift, Cmd, 4
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 31 '<dict><key>enabled</key><true/><key>value</key><dict><key>parameters</key><array><integer>52</integer><integer>21</integer><integer>1441792</integer></array><key>type</key><string>standard</string></dict></dict>'

#7 - kSHKMoveFocusToTheMenuBar - Ctrl, F2
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 7 '<dict><key>enabled</key><true/><key>value</key><dict><key>parameters</key><array><integer>65535</integer><integer>120</integer><integer>8650752</integer></array><key>type</key><string>standard</string></dict></dict>'

#23 - kSHKTurnImageSmoothingOnOrOff - Opt, Cmd, Backslash "\"
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 23 '<dict><key>enabled</key><false/><key>value</key><dict><key>parameters</key><array><integer>92</integer><integer>42</integer><integer>1572864</integer></array><key>type</key><string>standard</string></dict></dict>'

#160 - kSHKShowLaunchpad -
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 160 '<dict><key>enabled</key><false/><key>value</key><dict><key>parameters</key><array><integer>65535</integer><integer>65535</integer><integer>0</integer></array><key>type</key><string>standard</string></dict></dict>'

#32 - kSHKMissionControl - Ctrl, Arrow Up
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 32 '<dict><key>enabled</key><false/><key>value</key><dict><key>parameters</key><array><integer>65535</integer><integer>126</integer><integer>8650752</integer></array><key>type</key><string>standard</string></dict></dict>'

#15 - kSHKTurnZoomOnOrOff - Opt, Cmd, 8
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 15 '<dict><key>enabled</key><false/><key>value</key><dict><key>parameters</key><array><integer>56</integer><integer>28</integer><integer>1572864</integer></array><key>type</key><string>standard</string></dict></dict>'

#8 - kSHKMoveFocusToTheDock - Ctrl, F3
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 8 '<dict><key>enabled</key><false/><key>value</key><dict><key>parameters</key><array><integer>65535</integer><integer>99</integer><integer>8650752</integer></array><key>type</key><string>standard</string></dict></dict>'

#9 - kSHKMoveFocusToActiveOrNextWindow - Ctrl, F4
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 9 '<dict><key>enabled</key><true/><key>value</key><dict><key>parameters</key><array><integer>65535</integer><integer>118</integer><integer>8650752</integer></array><key>type</key><string>standard</string></dict></dict>'

#33 - kSHKApplicationWindows - Ctrl, Arrow Down
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 33 '<dict><key>enabled</key><false/><key>value</key><dict><key>parameters</key><array><integer>65535</integer><integer>125</integer><integer>8650752</integer></array><key>type</key><string>standard</string></dict></dict>'

#118 - kSHKSwitchToDesktop1 - Ctrl, 1
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 118 '<dict><key>enabled</key><false/><key>value</key><dict><key>parameters</key><array><integer>65535</integer><integer>18</integer><integer>262144</integer></array><key>type</key><string>standard</string></dict></dict>'

#119 - kSHKSwitchToDesktop2 - Ctrl, 2
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 119 '<dict><key>enabled</key><false/><key>value</key><dict><key>parameters</key><array><integer>65535</integer><integer>19</integer><integer>262144</integer></array><key>type</key><string>standard</string></dict></dict>'

#120 - kSHKSwitchToDesktop3 - Ctrl, 3
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 120 '<dict><key>enabled</key><false/><key>value</key><dict><key>parameters</key><array><integer>65535</integer><integer>20</integer><integer>262144</integer></array><key>type</key><string>standard</string></dict></dict>'

#121 - kSHKSwitchToDesktop5 - Ctrl, 4
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 121 '<dict><key>enabled</key><false/><key>value</key><dict><key>parameters</key><array><integer>65535</integer><integer>21</integer><integer>262144</integer></array><key>type</key><string>standard</string></dict></dict>'

#25 - kSHKIncreaseContrast - Ctrl, Opt, Cmd, .
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 25 '<dict><key>enabled</key><false/><key>value</key><dict><key>parameters</key><array><integer>46</integer><integer>47</integer><integer>1835008</integer></array><key>type</key><string>standard</string></dict></dict>'

#51 - kSHKMoveFocusToTheWindowDrawer - Opt, Cmd, `
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 51 '<dict><key>enabled</key><true/><key>value</key><dict><key>parameters</key><array><integer>39</integer><integer>50</integer><integer>1572864</integer></array><key>type</key><string>standard</string></dict></dict>'

#60 - kSHKSelectThePreviousInputSource - Ctrl, Opt, Space bar
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 60 '<dict><key>enabled</key><true/><key>value</key><dict><key>parameters</key><array><integer>32</integer><integer>49</integer><integer>786432</integer></array><key>type</key><string>standard</string></dict></dict>'

#17 - kSHKZoomIn - Opt, Cmd, =
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 17 '<dict><key>enabled</key><false/><key>value</key><dict><key>parameters</key><array><integer>61</integer><integer>24</integer><integer>1572864</integer></array><key>type</key><string>standard</string></dict></dict>'

#26 - kSHKDecreaseContrast - Ctrl, Opt, Cmd, ,
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 26 '<dict><key>enabled</key><false/><key>value</key><dict><key>parameters</key><array><integer>44</integer><integer>43</integer><integer>1835008</integer></array><key>type</key><string>standard</string></dict></dict>'

#175 - kSHKTurnDoNotDisturbOnOrOff -
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 175 '<dict><key>enabled</key><false/><key>value</key><dict><key>parameters</key><array><integer>65535</integer><integer>65535</integer><integer>0</integer></array><key>type</key><string>standard</string></dict></dict>'

#52 - kSHKTurnDockHidingOnOrOff - Opt, Cmd, D
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 52 '<dict><key>enabled</key><false/><key>value</key><dict><key>parameters</key><array><integer>100</integer><integer>2</integer><integer>1572864</integer></array><key>type</key><string>standard</string></dict></dict>'

#61 - kSHKSelectNextSourceInInputMenu - Ctrl, Opt, Shift, Space bar
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 61 '<dict><key>enabled</key><false/><key>value</key><dict><key>parameters</key><array><integer>32</integer><integer>49</integer><integer>917504</integer></array><key>type</key><string>standard</string></dict></dict>'

#27 - kSHKMoveFocusToNextWindow - Cmd, `
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 27 '<dict><key>enabled</key><true/><key>value</key><dict><key>parameters</key><array><integer>96</integer><integer>50</integer><integer>1048576</integer></array><key>type</key><string>standard</string></dict></dict>'

#36 - kSHKShowDesktop - F11
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 36 '<dict><key>enabled</key><true/><key>value</key><dict><key>parameters</key><array><integer>65535</integer><integer>103</integer><integer>8388608</integer></array><key>type</key><string>standard</string></dict></dict>'

#62 - kSHKShowDashboard - F12
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 62 '<dict><key>enabled</key><false/><key>value</key><dict><key>parameters</key><array><integer>65535</integer><integer>111</integer><integer>8388608</integer></array><key>type</key><string>standard</string></dict></dict>'

#19 - kSHKZoomOut - Opt, Cmd, -
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 19 '<dict><key>enabled</key><false/><key>value</key><dict><key>parameters</key><array><integer>45</integer><integer>27</integer><integer>1572864</integer></array><key>type</key><string>standard</string></dict></dict>'

#28 - kSHKSavePictureOfScreenAsAFile - Shift, Cmd, 3
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 28 '<dict><key>enabled</key><true/><key>value</key><dict><key>parameters</key><array><integer>51</integer><integer>20</integer><integer>1179648</integer></array><key>type</key><string>standard</string></dict></dict>'

#162 - kSHKShowAccessibilityControls - Opt, Cmd, F5
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 162 '<dict><key>enabled</key><false/><key>value</key><dict><key>parameters</key><array><integer>65535</integer><integer>96</integer><integer>9961472</integer></array><key>type</key><string>standard</string></dict></dict>'

#163 - kSHKShowNotificationCenter -
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 163 '<dict><key>enabled</key><false/><key>value</key><dict><key>parameters</key><array><integer>65535</integer><integer>65535</integer><integer>0</integer></array><key>type</key><string>standard</string></dict></dict>'

#29 - kSHKCopyPictureOfScreenToTheClipboard - Ctrl, Shift, Cmd, 3
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 29 '<dict><key>enabled</key><true/><key>value</key><dict><key>parameters</key><array><integer>51</integer><integer>20</integer><integer>1441792</integer></array><key>type</key><string>standard</string></dict></dict>'

#81 - kSHKMoveRightASpace - Ctrl, Arrow Right
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 81 '<dict><key>enabled</key><true/><key>value</key><dict><key>parameters</key><array><integer>65535</integer><integer>124</integer><integer>8650752</integer></array><key>type</key><string>standard</string></dict></dict>'

#64 - kSHKShowSpotlightSearch - Cmd, Space bar
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 64 '<dict><key>enabled</key><false/><key>value</key><dict><key>parameters</key><array><integer>32</integer><integer>49</integer><integer>1048576</integer></array><key>type</key><string>standard</string></dict></dict>'

#98 - kSHKShowHelpMenu - Shift, Cmd, /
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 98 '<dict><key>enabled</key><false/><key>value</key><dict><key>parameters</key><array><integer>47</integer><integer>44</integer><integer>1179648</integer></array><key>type</key><string>standard</string></dict></dict>'

#65 - kSHKShowFinderSearchWindow - Opt, Cmd, Space bar
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 65 '<dict><key>enabled</key><true/><key>value</key><dict><key>parameters</key><array><integer>32</integer><integer>49</integer><integer>1572864</integer></array><key>type</key><string>standard</string></dict></dict>'

#57 - kSHKMoveFocusToStatusMenus - Ctrl, F8
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 57 '<dict><key>enabled</key><true/><key>value</key><dict><key>parameters</key><array><integer>65535</integer><integer>100</integer><integer>8650752</integer></array><key>type</key><string>standard</string></dict></dict>'

#10 - kSHKMoveFocusToTheWindowToolbar - Ctrl, F5
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 10 '<dict><key>enabled</key><true/><key>value</key><dict><key>parameters</key><array><integer>65535</integer><integer>96</integer><integer>8650752</integer></array><key>type</key><string>standard</string></dict></dict>'

#179 - kSHKTurnFocusFollowingOnOrOff -
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 179 '<dict><key>enabled</key><false/><key>value</key><dict><key>parameters</key><array><integer>65535</integer><integer>65535</integer><integer>0</integer></array><key>type</key><string>standard</string></dict></dict>'

#59 - kSHKTurnVoiceOverOnOrOff - Cmd, F5
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 59 '<dict><key>enabled</key><false/><key>value</key><dict><key>parameters</key><array><integer>65535</integer><integer>96</integer><integer>9437184</integer></array><key>type</key><string>standard</string></dict></dict>'

#11 - kSHKMoveFocusToTheFloatingWindow - Ctrl, F6
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 11 '<dict><key>enabled</key><true/><key>value</key><dict><key>parameters</key><array><integer>65535</integer><integer>97</integer><integer>8650752</integer></array><key>type</key><string>standard</string></dict></dict>'

##################################################################################
# Screen
##################################################################################

# Rquire password 5 seconds after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 5

# Save screenshots to the desktop
defaults write com.apple.screencapture location -string "${HOME}/Desktop"

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"

# Disable shadow in screenshots
defaults write com.apple.screencapture disable-shadow -bool true

# Enable subpixel font rendering on non-Apple LCDs
defaults write NSGlobalDomain AppleFontSmoothing -int 2

# Enable HiDPI display modes (requires restart)
sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true

##################################################################################
# Finder
##################################################################################

# Finder: allow quitting via ⌘ + Q; doing so will also hide desktop icons
#defaults write com.apple.finder QuitMenuItem -bool true

# Finder: disable window animations and Get Info animations
defaults write com.apple.finder DisableAllAnimations -bool true

# Set ~/Projects as the default directory for new Finder windows
mkdir -p ~/Projects
defaults write com.apple.finder NewWindowTarget -string "PfDe"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Projects/"

# Remove icons for hard drives, servers, and removable media on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowMountedServersOnDesktop -bool false
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false

# Finder: hide hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool false

# Allowing text selection in Quick Look/Preview in Finder by default
defaults write com.apple.finder QLEnableTextSelection -bool true

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Enable spring loading for directories
defaults write NSGlobalDomain com.apple.springing.enabled -bool true

# Remove the spring loading delay for directories
defaults write NSGlobalDomain com.apple.springing.delay -float 0

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Disable disk image verification
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

# Automatically open a new Finder window when a volume is mounted
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

# Show item info near icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist

# Show item info to the right of the icons on the desktop
/usr/libexec/PlistBuddy -c "Set DesktopViewSettings:IconViewSettings:labelOnBottom false" ~/Library/Preferences/com.apple.finder.plist

# Enable snap-to-grid for icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

# Increase grid spacing for icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist

# Increase the size of icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist

# Use list view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Disable the warning before emptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Enable AirDrop over Ethernet and on unsupported Macs running Lion
defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

# Show the ~/Library folder
chflags nohidden ~/Library

#Remove Dropbox’s green checkmark icons in Finder
file=/Applications/Dropbox.app/Contents/Resources/emblem-dropbox-uptodate.icns
[ -e "${file}" ] && mv -f "${file}" "${file}.bak"

# Expand the following File Info panes:
# “General”, “Open with”, and “Sharing & Permissions”
defaults write com.apple.finder FXInfoPanesExpanded -dict \
	General -bool true \
	OpenWith -bool true \
	Privileges -bool true


##################################################################################
# Dock, Dashboard, and hot corners
##################################################################################

# Change minimize/maximize window effect
defaults write com.apple.dock mineffect -string "scale"

# Minimize windows into their application’s icon
defaults write com.apple.dock minimize-to-application -bool true

# Don’t animate opening applications from the Dock
defaults write com.apple.dock launchanim -bool false

# Wipe all (default) app icons from the Dock
defaults write com.apple.dock persistent-apps -array

# Speed up Mission Control animations
defaults write com.apple.dock expose-animation-duration -float 0.1

# Group windows by application in Mission Control
# (i.e. use the old Exposé behavior instead)
defaults write com.apple.dock expose-group-by-app -bool true

# Disable Dashboard
defaults write com.apple.dashboard mcx-disabled -bool true

# Don’t show Dashboard as a Space
defaults write com.apple.dock dashboard-in-overlay -bool true

# Don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# Disable the Launchpad gesture (pinch with thumb and three fingers)
defaults write com.apple.dock showLaunchpadGestureEnabled -int 0

# Reset Launchpad, but keep the desktop wallpaper intact
find "${HOME}/Library/Application Support/Dock" -name "*-*.db" -maxdepth 1 -delete

# Add iOS & Watch Simulator to Launchpad
# sudo ln -sf "/Applications/Xcode.app/Contents/Developer/Applications/Simulator.app" "/Applications/Simulator.app"
# sudo ln -sf "/Applications/Xcode.app/Contents/Developer/Applications/Simulator (Watch).app" "/Applications/Simulator (Watch).app"

# Hot corners
# Possible values:
#  0: no-op
#  2: Mission Control
#  3: Show application windows
#  4: Desktop
#  5: Start screen saver
#  6: Disable screen saver
#  7: Dashboard
# 10: Put display to sleep
# 11: Launchpad
# 12: Notification Center
# Top left screen corner → no-op
defaults write com.apple.dock wvous-tl-corner -int 0
defaults write com.apple.dock wvous-tl-modifier -int 0
# Top right screen corner → no-op
defaults write com.apple.dock wvous-tr-corner -int 0
defaults write com.apple.dock wvous-tr-modifier -int 0
# Bottom left screen corner → Put display to sleep
defaults write com.apple.dock wvous-bl-corner -int 10
defaults write com.apple.dock wvous-bl-modifier -int 0
# Bottom right screen corner → no-op
defaults write com.apple.dock wvous-br-corner -int 0
defaults write com.apple.dock wvous-br-modifier -int 0

#Hide the Dock and Set a Very Long Delay AKA Remove the Dock for Good
defaults write com.apple.dock autohide-delay -float 1000
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-time-modifier -float 20000000000
defaults write com.apple.dock tilesize -int 1 #tiny size
defaults write com.apple.dock magnification -boolean false
defaults write com.apple.dock contents-immutable -boolean true
defaults write com.apple.dock static-only -bool true #only show open apps
defaults write com.apple.dock size-immutable -boolean true
defaults write com.apple.dock magnify-immutable -boolean true
defaults write com.apple.dock autohide-immutable -boolean true
defaults write com.apple.dock position-immutable -boolean true
defaults write com.apple.dock min-effect-immutable -boolean true
defaults write com.apple.dock min-in-place-immutable -boolean true
defaults write com.apple.dock no-bouncing -boolean true

##################################################################################
# Safari & WebKit
##################################################################################

# Get rid of keybinds to email page
defaults write com.apple.Safari NSUserKeyEquivalents -dict-add 'Email Link to This Page' '\0' 'Email This Page' '\0'

# Privacy: don’t send search queries to Apple
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true

# Press Tab to highlight each item on a web page
defaults write com.apple.Safari WebKitTabToLinksPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks -bool true

# Show the full URL in the address bar (note: this still hides the scheme)
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

# Set Safari’s home page to `about:blank` for faster loading
defaults write com.apple.Safari HomePage -string "about:blank"

# Prevent Safari from opening ‘safe’ files automatically after downloading
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

# Allow hitting the Backspace key to go to the previous page in history
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool true

# Hide Safari’s bookmarks bar by default
defaults write com.apple.Safari ShowFavoritesBar -bool false

# Hide Safari’s sidebar in Top Sites
defaults write com.apple.Safari ShowSidebarInTopSites -bool false

# Disable Safari’s thumbnail cache for History and Top Sites
defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2

# Enable Safari’s debug menu
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

# Make Safari’s search banners default to Contains instead of Starts With
defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false

# Remove useless icons from Safari’s bookmarks bar
defaults write com.apple.Safari ProxiesInBookmarksBar "()"

# Enable the Develop menu and the Web Inspector in Safari
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

# Add a context menu item for showing the Web Inspector in web views
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

# Enable continuous spellchecking
defaults write com.apple.Safari WebContinuousSpellCheckingEnabled -bool true

# Disable auto-correct
defaults write com.apple.Safari WebAutomaticSpellingCorrectionEnabled -bool false

# Disable AutoFill
defaults write com.apple.Safari AutoFillFromAddressBook -bool false
defaults write com.apple.Safari AutoFillPasswords -bool false
defaults write com.apple.Safari AutoFillCreditCardData -bool false
defaults write com.apple.Safari AutoFillMiscellaneousForms -bool false

# Warn about fraudulent websites
defaults write com.apple.Safari WarnAboutFraudulentWebsites -bool true

# Disable plug-ins
defaults write com.apple.Safari WebKitPluginsEnabled -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2PluginsEnabled -bool false

# Disable Java
defaults write com.apple.Safari WebKitJavaEnabled -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabled -bool false

# Block pop-up windows
defaults write com.apple.Safari WebKitJavaScriptCanOpenWindowsAutomatically -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaScriptCanOpenWindowsAutomatically -bool false

# Enable “Do Not Track”
defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true

# Update extensions automatically
defaults write com.apple.Safari InstallExtensionUpdatesAutomatically -bool true

##################################################################################
# Spotlight
##################################################################################

# Disable Spotlight indexing for any volume that gets mounted and has not yet been indexed before.
sudo defaults write /.Spotlight-V100/VolumeConfiguration Exclusions -array "/Volumes"

# Change indexing order and disable some search results
defaults write com.apple.spotlight orderedItems -array \
	'{"enabled" = 1;"name" = "APPLICATIONS";}' \
	'{"enabled" = 1;"name" = "SYSTEM_PREFS";}' \
	'{"enabled" = 1;"name" = "DIRECTORIES";}' \
	'{"enabled" = 1;"name" = "PDF";}' \
	'{"enabled" = 1;"name" = "FONTS";}' \
	'{"enabled" = 0;"name" = "DOCUMENTS";}' \
	'{"enabled" = 0;"name" = "MESSAGES";}' \
	'{"enabled" = 1;"name" = "CONTACT";}' \
	'{"enabled" = 0;"name" = "EVENT_TODO";}' \
	'{"enabled" = 0;"name" = "IMAGES";}' \
	'{"enabled" = 0;"name" = "BOOKMARKS";}' \
	'{"enabled" = 0;"name" = "MUSIC";}' \
	'{"enabled" = 0;"name" = "MOVIES";}' \
	'{"enabled" = 0;"name" = "PRESENTATIONS";}' \
	'{"enabled" = 0;"name" = "SPREADSHEETS";}' \
	'{"enabled" = 0;"name" = "SOURCE";}' \
	'{"enabled" = 0;"name" = "MENU_DEFINITION";}' \
	'{"enabled" = 0;"name" = "MENU_OTHER";}' \
	'{"enabled" = 0;"name" = "MENU_CONVERSION";}' \
	'{"enabled" = 0;"name" = "MENU_EXPRESSION";}' \
	'{"enabled" = 0;"name" = "MENU_WEBSEARCH";}' \
	'{"enabled" = 0;"name" = "MENU_SPOTLIGHT_SUGGESTIONS";}'

# Load new settings before rebuilding the index
killall mds > /dev/null 2>&1

# Make sure indexing is enabled for the main volume
sudo mdutil -i on / > /dev/null

# Rebuild the index from scratch
sudo mdutil -E / > /dev/null

##################################################################################
# Terminal
##################################################################################

#Support 256 colors and italics
tic ~/Projects/dotfiles/init/xterm-256color-italic.terminfo

# Only use UTF-8 in Terminal.app
defaults write com.apple.terminal StringEncodings -array 4

# Use a modified version of the Solarized Dark theme by default in Terminal.app
osascript <<EOD
tell application "Terminal"
	local allOpenedWindows
	local initialOpenedWindows
	local windowID
	set themeName to "Dracula"
	(* Store the IDs of all the open terminal windows. *)
	set initialOpenedWindows to id of every window
	(* Open the custom theme so that it gets added to the list
	   of available terminal themes (note: this will open two
	   additional terminal windows). *)
	do shell script "open '$HOME/Projects/dotfiles/init/" & themeName & ".terminal'"
	(* Wait a little bit to ensure that the custom theme is added. *)
	delay 1
	(* Set the custom theme as the default terminal theme. *)
	set default settings to settings set themeName
	(* Get the IDs of all the currently opened terminal windows. *)
	set allOpenedWindows to id of every window
	repeat with windowID in allOpenedWindows
		(* Close the additional windows that were opened in order
		   to add the custom theme to the list of terminal themes. *)
		if initialOpenedWindows does not contain windowID then
			close (every window whose id is windowID)
		(* Change the theme for the initial opened terminal windows
		   to remove the need to close them in order for the custom
		   theme to be applied. *)
		else
			set current settings of tabs of (every window whose id is windowID) to settings set themeName
		end if
	end repeat
end tell
EOD

# Enable “focus follows mouse” for Terminal.app and all X11 apps
# i.e. hover over a window and start typing in it without clicking first
#defaults write com.apple.terminal FocusFollowsMouse -bool true
#defaults write org.x.X11 wm_ffm -bool true

# Enable Secure Keyboard Entry in Terminal.app
# See: https://security.stackexchange.com/a/47786/8918
defaults write com.apple.terminal SecureKeyboardEntry -bool true

# Disable the annoying line marks
defaults write com.apple.Terminal ShowLineMarks -int 0

# Install the Solarized Dark theme for iTerm
open "${HOME}/.config/init/Dracula.itermcolors"

##################################################################################
# Chrome
##################################################################################
# Bring up Chrome Extensions via Shift + ⌘E (Window → Extensions)
defaults write com.google.Chrome NSUserKeyEquivalents '{ Extensions = "@$e"; }'

# Get rid of binds to email
defaults write com.google.Chrome NSUserKeyEquivalents -dict-add 'Email Page Location' '\0'
defaults write com.google.Chrome.canary NSUserKeyEquivalents -dict-add 'Email Page Location' '\0'

# Remap Developer Tools to Command + Shift + I as that is more natural and it avoids the stupid email
# BetterTouchTool redirects Command + Option + I to this new shortcut
defaults write com.google.Chrome NSUserKeyEquivalents -dict-add 'Developer Tools' '@$i'

# Disable the all too sensitive backswipe on trackpads
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false
defaults write com.google.Chrome.canary AppleEnableSwipeNavigateWithScrolls -bool false

# Disable the all too sensitive backswipe on Magic Mouse
defaults write com.google.Chrome AppleEnableMouseSwipeNavigateWithScrolls -bool false
defaults write com.google.Chrome.canary AppleEnableMouseSwipeNavigateWithScrolls -bool false

# Use the system-native print preview dialog
defaults write com.google.Chrome DisablePrintPreview -bool true
defaults write com.google.Chrome.canary DisablePrintPreview -bool true

# Expand the print dialog by default
defaults write com.google.Chrome PMPrintingExpandedStateForPrint2 -bool true
defaults write com.google.Chrome.canary PMPrintingExpandedStateForPrint2 -bool true

###############################################################################
# Photos                                                                      #
###############################################################################

# Prevent Photos from opening automatically when devices are plugged in
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

###############################################################################
# Messages                                                                    #
###############################################################################

# Disable automatic emoji substitution (i.e. use plain text smileys)
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticEmojiSubstitutionEnablediMessage" -bool false

# Disable smart quotes as it’s annoying for messages that contain code
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticQuoteSubstitutionEnabled" -bool false

# Disable continuous spell checking
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "continuousSpellCheckingEnabled" -bool f

####################################################################################
# XCode
####################################################################################
mkdir -p ~/Library/Developer/Xcode/UserData/FontAndColorThemes
ln -s ~/.config/init/Dracula.xccolortheme ~/Library/Developer/Xcode/UserData/FontAndColorThemes/Dracula.xccolortheme 2> /dev/null

#set theme to Dracula
defaults write com.apple.dt.Xcode XCFontAndColorCurrentTheme -string Dracula.xccolortheme

#show line numbers
defaults write com.apple.dt.Xcode DVTTextShowLineNumbers -bool true

#multi core CPU
defaults write com.apple.dt.Xcode IDEBuildOperationMaxNumberOfConcurrentCompileTasks `sysctl -n hw.ncpu`

#fuzzy complete
defaults write com.apple.dt.Xcode IDECodeCompletionFuzzyMode 3
defaults write com.apple.dt.Xcode IDEWorkaroundForRadar6288283 3

#show built time
defaults write com.apple.dt.Xcode ShowBuildOperationDuration YES

###############################################################################
# Time Machine                                                                #
###############################################################################

# Prevent Time Machine from prompting to use new hard drives as backup volume
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# Disable local Time Machine backups
hash tmutil &> /dev/null && sudo tmutil disablelocal

###############################################################################
# Activity Monitor                                                            #
###############################################################################

# Show the main window when launching Activity Monitor
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

# Show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# Sort Activity Monitor results by CPU usage
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

###############################################################################
# TextEdit and Disk Utility
###############################################################################

# Use plain text mode for new TextEdit documents
defaults write com.apple.TextEdit RichText -int 0

# Open and save files as UTF-8 in TextEdit
defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

# Enable the debug menu in Disk Utility
defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true
defaults write com.apple.DiskUtility advanced-image-options -bool true


for app in "Activity Monitor" "Address Book" "Calendar" "Contacts" "cfprefsd" \
	"Dock" "Finder" "Google Chrome" "Google Chrome Canary" "Mail" "Messages" \
	"Opera" "Photos" "Safari" "SizeUp" "Spectacle" "SystemUIServer" \
	"Transmission" "Tweetbot" "Twitter" "iCal"; do
	killall "${app}" &> /dev/null
done

echo "Done. Note that some of these changes require a restart to take effect."
