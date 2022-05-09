#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.15.0 (Beta)
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here


#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#Region ### START Koda GUI section ### Form=
$Form1 = GUICreate("Form1", 615, 438, 192, 124)
$Button1 = GUICtrlCreateButton("|<", 128, 56, 75, 25)
$Button2 = GUICtrlCreateButton(">", 136, 96, 75, 25)
$Button3 = GUICtrlCreateButton(">|", 136, 144, 75, 25)
$Button4 = GUICtrlCreateButton("||", 152, 192, 75, 25)
$Button5 = GUICtrlCreateButton("st", 160, 248, 75, 25)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		case $Button1
		Send("{MEDIA_PREV}")
			case $Button2
		Send("{MEDIA_PLAY_PAUSE}")
			case $Button3
		Send("{MEDIA_NEXT}")
			case $Button4
		Send("{MEDIA_NEXT}")
		case $Button5
		Send("{MEDIA_STOP}")
		Case $GUI_EVENT_CLOSE
			Exit

	EndSwitch
WEnd


;{VOLUME_MUTE} Mute the volume
;{VOLUME_DOWN} Reduce the volume
;{VOLUME_UP} Increase the volume
;{MEDIA_NEXT} Select next track in media player
;{MEDIA_PREV} Select previous track in media player
;{MEDIA_STOP} Stop media player
;{MEDIA_PLAY_PAUSE}

