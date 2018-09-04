require 'plist'

current = Plist.parse_xml('/Users/scott/Desktop/symbolichotkeys.plist')

noteMap = {
    7 => ['kSHKMoveFocusToTheMenuBar','Ctrl, F2'],
    8 => ['kSHKMoveFocusToTheDock','Ctrl, F3'],
    9 => ['kSHKMoveFocusToActiveOrNextWindow','Ctrl, F4'],
    10 => ['kSHKMoveFocusToTheWindowToolbar','Ctrl, F5'],
    11 => ['kSHKMoveFocusToTheFloatingWindow','Ctrl, F6'],
    12 => ['kSHKTurnKeyboardAccessOnOrOff','Ctrl, F1'],
    13 => ['kSHKChangeTheWayTabMovesFocus','Ctrl, F7'],
    15 => ['kSHKTurnZoomOnOrOff','Opt, Cmd, 8'],
    17 => ['kSHKZoomIn','Opt, Cmd, ='],
    19 => ['kSHKZoomOut','Opt, Cmd, -'],
    21 => ['kSHKInvertColors','Ctrl, Opt, Cmd, 8'],
    23 => ['kSHKTurnImageSmoothingOnOrOff','Opt, Cmd, Backslash "\"'],
    25 => ['kSHKIncreaseContrast','Ctrl, Opt, Cmd, .'],
    26 => ['kSHKDecreaseContrast','Ctrl, Opt, Cmd, ,'],
    27 => ['kSHKMoveFocusToNextWindow','Cmd, `'],
    28 => ['kSHKSavePictureOfScreenAsAFile','Shift, Cmd, 3'],
    29 => ['kSHKCopyPictureOfScreenToTheClipboard','Ctrl, Shift, Cmd, 3'],
    30 => ['kSHKSavePictureOfSelectedAreaAsAFile','Shift, Cmd, 4'],
    31 => ['kSHKCopyPictureOfSelectedAreaToTheClipboard','Ctrl, Shift, Cmd, 4'],
    32 => ['kSHKMissionControl','Ctrl, Arrow Up'],
    33 => ['kSHKApplicationWindows','Ctrl, Arrow Down'],
    36 => ['kSHKShowDesktop','F11'],
    51 => ['kSHKMoveFocusToTheWindowDrawer','Opt, Cmd, `'],
    52 => ['kSHKTurnDockHidingOnOrOff','Opt, Cmd, D'],
    57 => ['kSHKMoveFocusToStatusMenus','Ctrl, F8'],
    59 => ['kSHKTurnVoiceOverOnOrOff','Cmd, F5'],
    60 => ['kSHKSelectThePreviousInputSource','Ctrl, Space bar'],
    61 => ['kSHKSelectNextSourceInInputMenu','Ctrl, Opt, Space bar'],
    62 => ['kSHKShowDashboard','F12'],
    64 => ['kSHKShowSpotlightSearch','Cmd, Space bar'],
    65 => ['kSHKShowFinderSearchWindow','Opt, Cmd, Space bar'],
    70 => ['kSHKLookUpInDictionary','Shift, Cmd, E'],
    73 => ['kSHKHideAndShowFrontRow','Cmd, Esc'],
    75 => ['kSHKActivateSpaces','F8'],
    79 => ['kSHKMoveLeftASpace','Ctrl, Arrow Left'],
    81 => ['kSHKMoveRightASpace','Ctrl, Arrow Right'],
    98 => ['kSHKShowHelpMenu','Shift, Cmd, /'],
    118 => ['kSHKSwitchToDesktop1','Ctrl, 1'],
    119 => ['kSHKSwitchToDesktop2','Ctrl, 2'],
    120 => ['kSHKSwitchToDesktop3','Ctrl, 3'],
    121 => ['kSHKSwitchToDesktop4','Ctrl, 4'],
    160 => ['kSHKShowLaunchpad',''],
    162 => ['kSHKShowAccessibilityControls','Opt, Cmd, F5'],
    163 => ['kSHKShowNotificationCenter',''],
    175 => ['kSHKTurnDoNotDisturbOnOrOff',''],
    179 => ['kSHKTurnFocusFollowingOnOrOff','']
}

File.open('out.txt', 'w') do |file|

    current['AppleSymbolicHotKeys'].each do |key,obj|
        #puts obj.to_plist(false).gsub(/>\s+?</, "><")
        file.write("##{key} - #{noteMap.fetch(key.to_i,[])[0] || '?'} - #{noteMap.fetch(key.to_i,[])[1] || 'None'}\n")
        file.write("defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add #{key} '" + obj.to_plist(false).gsub(/>\s+?</, "><").gsub(/\n/,"") + "'\n\n")
        #puts obj.to_plist(false)
    end
end