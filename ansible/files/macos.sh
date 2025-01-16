#!/bin/bash

set -x -e

# Close System Preferences to prevent interference
osascript -e 'tell application "System Preferences" to quit'

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


##################################################################################
# System Shortcuts
##################################################################################
# Sadly setting a dict is not possible in ansible https://github.com/ansible-collections/community.general/issues/238
# The main issue being idempotence is hard to achive with the nature of nested dictionary comparisons
# As such these will need to run as commands, and idempotence will be broken, as such maybe it should be a tag like set-shortcuts

#http://krypted.com/mac-os-x/defaults-symbolichotkeys/


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

#Lock screen it Cmd+L
defaults write com.apple.finder NSUserKeyEquivalents -dict 'Lock Screen' '@l'
#TODO move this to All Applications

    # # Expand the following File Info panes:
    # # “General”, “Open with”, and “Sharing & Permissions”
    # defaults write com.apple.finder FXInfoPanesExpanded -dict \
    # 	General -bool true \
    # 	OpenWith -bool true \
    # 	Privileges -bool true


#     - domain: com.apple.Safari
#   key: NSUserKeyEquivalents
#   type: dict-add
#   value: 'Email Link to This Page' '\0' 'Email This Page' '\0'
#   name: Get rid of keybinds to email page

# Bring up Chrome Extensions via Shift + ⌘E (Window → Extensions)
defaults write com.google.Chrome NSUserKeyEquivalents '{ Extensions = "@$e"; }'
defaults write com.google.Chrome.canary NSUserKeyEquivalents -dict-add 'Email Page Location' '\0'


# - domain: com.google.Chrome
#   key: NSUserKeyEquivalents
#   type: dict-add
#   value: 'Email Page Location' '\0'
#   name: Get rid of binds to email


# # Remap Developer Tools to Command + Shift + I as that is more natural and it avoids the stupid email
# - domain: com.google.Chrome
#   key: NSUserKeyEquivalents
#   type: dict-add
#   value: 'Developer Tools' '@$i'
#   name: BetterTouchTool redirects Command + Option + I to this new shortcut

#active settings from above
/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u

