; IMPORTANT INFO ABOUT GETTING STARTED: Lines that start with a
; semicolon, such as this one, are comments.  They are not executed.

; This script has a special filename and path because it is automatically
; launched when you run the program directly.  Also, any text file whose
; name ends in .ahk is associated with the program, which means that it
; can be launched simply by double-clicking it.  You can have as many .ahk
; files as you want, located in any folder.  You can also run more than
; one .ahk file simultaneously and each will get its own tray icon.

; SAMPLE HOTKEYS: Below are two sample hotkeys.  The first is Win+Z and it
; launches a web site in the default browser.  The second is Control+Alt+N
; and it launches a new Notepad window (or activates an existing one).  To
; try out these hotkeys, run AutoHotkey again, which will load this file.
SetCapsLockState Off


#NoTrayIcon
#h::Run winHide
^!n::
IfWinExist Untitled - Notepad
	WinActivate
else
	Run Notepad
return

; TODO Need to do the CAPSLOCK stuff instead of this

^!#r::Reload
^!r::Run notepad D:\My Documents\AutoHotkey.ahk


#;::Send  {ASC 00133}
+#-::Send  {ASC 00151}
#-::Send  {ASC 00150}

; You have to disable the CapsLock key in MS Keyboard Layout Creator. or a RegEdit of Scancode?
; https://www.autohotkey.com/board/topic/104173-capslock-to-control-and-escape/
CapsLock::
	key=
	Input, key, B C L1 T1, {Esc}
	if (ErrorLevel = "Max")
		Send {Ctrl Down}%key%
	KeyWait, CapsLock
	Return
CapsLock up::
	If key
		Send {Ctrl Up}
	else
		Send, {Esc 2}
	Return
; https://github.com/oueta/putty-quake-terminal


^!p::
IfWinExist Adobe Photoshop CS5 Extended
	WinActivate
else
	Run photoshop
return

^#v::                            ; Text�only paste from ClipBoard
   Clip0 = %ClipBoardAll%
   ClipBoard = %ClipBoard%       ; Convert to text
   Send ^v                       ; For best compatibility: SendPlay
   Sleep 50                      ; Don't change clipboard while it is pasted! (Sleep > 0)
   ClipBoard = %Clip0%           ; Restore original ClipBoard
   VarSetCapacity(Clip0, 0)      ; Free memory
Return



::wsig::Best Regards,{enter}{enter}Scott Hall{enter}President{enter}My Privacy Tools, Inc.{enter}scott@myprivacytools.com

^!Left::Send   {Media_Prev}
^!Down::Send   {Media_Play_Pause}
^!Right::Send  {Media_Next}
+^!Left::Send  {Volume_Down}
+^!Down::Send  {Volume_Mute}
+^!Right::Send {Volume_Up}