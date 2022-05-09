#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#Region ### START Koda GUI section ### Form=
$Form1 = GUICreate("Altura do Texto", 304, 123, 293, 280)
$Input1 = GUICtrlCreateInput("50", 32, 16, 73, 21)
$Label1 = GUICtrlCreateLabel("Título (0.3)", 120, 24, 56, 17)
$Label2 = GUICtrlCreateLabel("Sub-título(0.25)", 120, 56, 77, 17)
$Label3 = GUICtrlCreateLabel("Texto(0.2)", 120, 88, 52, 17)
$Label4 = GUICtrlCreateLabel("Label4", 208, 24, 36, 17)
$Label5 = GUICtrlCreateLabel("Label5", 208, 56, 36, 17)
$Label6 = GUICtrlCreateLabel("Label6", 208, 88, 36, 17)
$Label7 = GUICtrlCreateLabel("1 /", 8, 24, 18, 17)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###


While 1
	$nMsg = GUIGetMsg()
	Sleep(3000)
	GUICtrlSetData($Label4, GUICtrlRead($Input1) * .3)
	GUICtrlSetData($Label5, GUICtrlRead($Input1) * .25)
	GUICtrlSetData($Label6, GUICtrlRead($Input1) * .2)

	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit

	EndSwitch


WEnd