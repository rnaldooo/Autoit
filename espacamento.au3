#include <GUIConstantsEx.au3>
#include <GUIListBox.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#region ### START Koda GUI section ### Form=C:\Users\Reinaldo\Documents\Reinaldo\autoit\espaca.kxf
$Form1 = GUICreate("Form1", 384, 153, 192, 114)
$List1 = GUICtrlCreateList("", 8, 8, 25, 136)
GUICtrlSetData(-1, "0|1|2|3|4|5|6|7|8|9")
$List2 = GUICtrlCreateList("", 32, 8, 25, 136)
GUICtrlSetData(-1, "0|1|2|3|4|5|6|7|8|9")
$List3 = GUICtrlCreateList("", 56, 8, 25, 136)
GUICtrlSetData(-1, "0|1|2|3|4|5|6|7|8|9")
$List4 = GUICtrlCreateList("", 80, 8, 25, 136)
GUICtrlSetData(-1, "0|1|2|3|4|5|6|7|8|9")
$List5 = GUICtrlCreateList("", 128, 8, 25, 136)
GUICtrlSetData(-1, "0|1|2|3|4|5|6|7|8|9")
$List6 = GUICtrlCreateList("", 152, 8, 25, 136)
GUICtrlSetData(-1, "0|1|2|3|4|5|6|7|8|9")
$Label1 = GUICtrlCreateLabel("Label1", 192, 8, 180, 17)
$Label2 = GUICtrlCreateLabel("Label2", 192, 40, 180, 17)
$Label3 = GUICtrlCreateLabel("Label3", 192, 72, 180, 17)
$Button1 = GUICtrlCreateButton("Button1", 192, 112, 177, 25, $WS_GROUP)

GUISetState(@SW_SHOW)
#endregion ### END Koda GUI section ###

While 1
	$nMsg = GUIGetMsg()
	Sleep(3000)
	GUICtrlSetData($Label1, (GUICtrlRead($List1) * 1000 + GUICtrlRead($List2) * 100 + GUICtrlRead($List3) * 10 + GUICtrlRead($List4) * 1) / (GUICtrlRead($List5) * 10 + GUICtrlRead($List6) * 1))
	If StringIsInt(GUICtrlRead($Label1)) Then
		GUICtrlSetData($Label2, (GUICtrlRead($Label1) + 1) & " barras")
	Else
		GUICtrlSetData($Label2, "não inteiro")
	EndIf

	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit

	EndSwitch


WEnd