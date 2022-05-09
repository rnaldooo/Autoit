#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <GUIListBox.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>

$fi = "3.2|4|5|6.3|8|10|12.5|16|20|22|25|32|40"
$fck = "10|15|20|25|30|35|40"

#region ### START Koda GUI section ### Form=
$Form1 = GUICreate("Calculos1", 432, 300, 192, 114)
$Group1 = GUICtrlCreateGroup("Transpasse / Emendas", 8, 8, 409, 281)
$Input1 = GUICtrlCreateInput("Input1", 16, 208, 129, 21)
GUICtrlSetData(-1, "2440")
$Label1 = GUICtrlCreateLabel("Comprimento[cm]:", 16, 192, 88, 17)
$Label2 = GUICtrlCreateLabel("Ø[mm]", 16, 32, 34, 17)
$List1 = GUICtrlCreateList("", 16, 48, 49, 123)
$List2 = GUICtrlCreateList("", 80, 48, 65, 123)
$Label3 = GUICtrlCreateLabel("fck[MPa]", 80, 32, 47, 17)
$Input2 = GUICtrlCreateInput("Input2", 16, 256, 129, 21)
GUICtrlSetData(-1, "90")
$Label4 = GUICtrlCreateLabel("Transpasse[cm]:", 16, 240, 82, 17)
$Label5 = GUICtrlCreateLabel("Transpasse calculado[cm]:", 160, 48, 131, 17)
$Label6 = GUICtrlCreateLabel("Label6", 160, 72, 236, 17)
;$Button1 = GUICtrlCreateButton("Calc1", 160, 72, 73, 25, $WS_GROUP)
;$Button2 = GUICtrlCreateButton("Calc2", 160, 208, 73, 25, $WS_GROUP)
$Label7 = GUICtrlCreateLabel("Label7", 160, 256, 236, 17)
$Label8 = GUICtrlCreateLabel("Label8", 160, 208, 236, 17)
$Label9 = GUICtrlCreateLabel("fbd=(0.7*0.3)*2.25*.7*1/1.4*fck^(2/3)", 160, 100, 100, 17)
$Label10 = GUICtrlCreateLabel("=", 280, 90,100, 17)
$Label11 = GUICtrlCreateLabel("lb=Ø/4*fyd/fbd", 160, 120, 236, 17)
$Label12 = GUICtrlCreateLabel("", 260, 100, 236, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUISetState(@SW_SHOW)
GUICtrlSetData($List1, $fi)
GUICtrlSetData($List2, $fck)

#endregion ### END Koda GUI section ###



While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg

		Case $List1
			_calc1()
		Case $List2
			_calc1()
		Case $Input1
			_calc2()
		Case $Input2
			_calc2()
		Case $GUI_EVENT_CLOSE
			Exit

	EndSwitch
WEnd

Func _calc1()
	$Sfi = GUICtrlRead($List1)
	$Sfck = GUICtrlRead($List2)
	$tlab6 = Round($Sfi / 4 * (50 / 1.15) / (2.25 * 0.7 * 1 * (0.7 * 0.3) / 1.4 * ($Sfck) ^ (2 / 3)) * 100 / 100, 0)
	If Mod($tlab6, 5) <> 0 Then
		$tlabb6 = (Int($tlab6 / 5) + 1) * 5
	Else
		$tlabb6 = $tlab6
	EndIf
	GUICtrlSetData($Label6, $tlab6 & " ou " & $tlabb6)
	GUICtrlSetData($Input2, $tlabb6)
	GUICtrlSetData($Label10, (0.7 * 0.3) * 2.25 * .7 * 1 / 1.4 * (GUICtrlRead($List2)) ^ (2 / 3))
	_calc2()
EndFunc   ;==>_calc1

Func _calc2()
	$tlab7 = (GUICtrlRead($Input1) - (2400 - GUICtrlRead($Input2))) / (1200 - GUICtrlRead($Input2)) + 1
	GUICtrlSetData($Label8, $tlab7)
	GUICtrlSetData($Label7, GUICtrlRead($Input1) & "+" & Ceiling($tlab7) & "*" & GUICtrlRead($Input2))
EndFunc   ;==>_calc2