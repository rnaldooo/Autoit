#include <String.au3>
#include <Array.au3>
#include <WinAPI.au3>
#include <GuiConstants.au3>

$handle = 0x00020338
$titulo = _WinAPI_GetWindowText($handle)
$ttt = BitAND(WinGetState($titulo), 2)
MsgBox(0, "Detalhes", "ttt=" & $ttt)
WinSetState($titulo, "", @SW_RESTORE)
$ttt = BitAND(WinGetState($titulo), 2)
MsgBox(0, "Detalhes", "ttt=" & $ttt)


#include <WindowsConstants.au3>

#Region ### START Koda GUI section ### Form=
$Form1 = GUICreate("Form1", 412, 223, 193, 125)
$Button1 = GUICtrlCreateButton("Button1", 24, 16, 81, 25, 0)
$Button2 = GUICtrlCreateButton("Button2", 24, 56, 81, 25, 0)
$Label1 = GUICtrlCreateLabel("Label1", 32, 112, 36, 17)
$Label2 = GUICtrlCreateLabel("Label2", 32, 152, 36, 17)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit

	EndSwitch
WEnd