#NoTrayIcon
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <WinAPI.au3>
#include <Array.au3> ;arraydisplay
#include <ListviewConstants.au3> ; listview
#include <GUIListBox.au3> ; listview

;=============================================== OPÇÕES DAS JANELAS
Opt("GUICloseOnEsc", 0)
Opt("GUIOnEventMode", 1)
Opt("GUIResizeMode", 802)
Opt("TrayMenuMode", 1)
Opt("TrayOnEventMode", 1)
OnAutoItExitRegister("_EventClose")

HotKeySet("{F9}", "_limpa")

$sIni = @ScriptDir & "\settings.ini"

Global Const $Pi = 4 * ATan(1)
Global $ans = IniRead($sIni, "Startup", "ans", "")

If Not FileExists($sIni) Then
	$hFile = FileOpen($sIni, 2)
	FileWrite($hFile, "[Settings]" & @CRLF & "RoundVal=2" & @CRLF & _
			"x=-1" & @CRLF & "y=-1" & @CRLF & "DefAng=deg" & @CRLF & "HelpTips=1" & @CRLF & "SnapTo=1")
	FileClose($hFile)
EndIf

Global $nRndVal = IniRead($sIni, "Settings", "RoundVal", 2)
Global $sDefAng = IniRead($sIni, "Settings", "DefAng", "deg")
Global $bHelpTips = IniRead($sIni, "Settings", "HelpTips", 1)
Global $bSnapTo = IniRead($sIni, "Settings", "SnapTo", 1)

$sIni = ""
$hFile = ""

Global $aOps = StringSplit("asin|acos|atan|sin|cos|tan|bitand|bitnot|bitor|bitrotate|bitshift|bitxor|round|floor|ceiling|" & _
		"int|abs|exp|log|rand|srand|random|srandom|sqrt|root|fact|rad|deg|tobase|frombase", "|")

Local $hMiniUI

_CreateMini()
GUISetState(@SW_SHOW, $hMiniUI)
If $bSnapTo = 1 Then GUIRegisterMsg(0x0047, "_EventMoved")



Func _CreateMini()
	Global $hMiniUI = GUICreate("MDiesel's Calculator!!", 380, 20, IniRead(@ScriptDir & "\settings.ini", "Settings", "x", -1), _
			IniRead(@ScriptDir & "\settings.ini", "Settings", "y", -1), 0x80000000, 0x00000008 + 0x00000080)
	GUICtrlSetDefBkColor(-2)
	GUISetBkColor(0xB0B0B0)
	GUISetOnEvent(-3, "_EventExit")

	$nGraph = GUICtrlCreateGraphic(0, 0, 380, 20)
	For $i = 0 To 20
		GUICtrlSetGraphic(-1, 8, "0x" & StringFormat("%02X%02X%02X", 255 - 3.95 * $i, 255 - 3.95 * $i, 255 - 3.95 * $i), 0xffffff)
		GUICtrlSetGraphic(-1, 6, 0, $i)
		GUICtrlSetGraphic(-1, 2, 380, $i)
	Next
	GUICtrlSetState($nGraph, 128)

	$hMenu = GUICtrlCreateIcon(@AutoItExe, 0, 2, 2, 16, 16, 0x0100)
	GUICtrlSetCursor(-1, "IDC_HAND")
	GUICtrlSetOnEvent(-1, "_EventContext")
	$hRoot = GUICtrlCreateContextMenu($hMenu)

	GUICtrlCreateMenuItem("&Calcular" & @TAB & "{Enter}", $hRoot)
	GUICtrlSetOnEvent(-1, "_EventMini")
	GUICtrlCreateMenuItem("&Limpar", $hRoot)
	GUICtrlSetOnEvent(-1, "_EventClear")
	GUICtrlCreateMenuItem("", $hRoot)

	$hMenu = GUICtrlCreateMenu("&Variaveis", $hRoot)
	GUICtrlCreateMenuItem("&Pi" & @TAB & "3.141...", $hMenu)
	GUICtrlSetOnEvent(-1, "_EventInsertVar")
	GUICtrlCreateMenuItem("&Ans", $hMenu)
	GUICtrlSetOnEvent(-1, "_EventInsertVar")

	$hMenu = GUICtrlCreateMenu("&Funções", $hRoot)
	$hSub = GUICtrlCreateMenu("&Trigonometria", $hMenu)
	For $i = 1 To 6
		GUICtrlCreateMenuItem($aOps[$i], $hSub)
		GUICtrlSetOnEvent(-1, "_EventInsertFunction")
	Next
	$hSub = GUICtrlCreateMenu("&Bit funções", $hMenu)
	For $i = 7 To 12
		GUICtrlCreateMenuItem($aOps[$i], $hSub)
		GUICtrlSetOnEvent(-1, "_EventInsertFunction")
	Next
	$hSub = GUICtrlCreateMenu("Ar&redondamento", $hMenu)
	For $i = 13 To 17
		GUICtrlCreateMenuItem($aOps[$i], $hSub)
		GUICtrlSetOnEvent(-1, "_EventInsertFunction")
	Next
	$hSub = GUICtrlCreateMenu("&Logarítimos", $hMenu)
	For $i = 18 To 19
		GUICtrlCreateMenuItem($aOps[$i], $hSub)
		GUICtrlSetOnEvent(-1, "_EventInsertFunction")
	Next
	$hSub = GUICtrlCreateMenu("Aleató&rio", $hMenu)
	For $i = 20 To 23
		GUICtrlCreateMenuItem($aOps[$i], $hSub)
		GUICtrlSetOnEvent(-1, "_EventInsertFunction")
	Next
	$hSub = GUICtrlCreateMenu("&Número", $hMenu)
	For $i = 24 To 26
		GUICtrlCreateMenuItem($aOps[$i], $hSub)
		GUICtrlSetOnEvent(-1, "_EventInsertFunction")
	Next
	$hSub = GUICtrlCreateMenu("&Conversões", $hMenu)
	$hMenu = GUICtrlCreateMenu("Ângulos", $hSub)
	For $i = 27 To 28
		GUICtrlCreateMenuItem($aOps[$i], $hMenu)
		GUICtrlSetOnEvent(-1, "_EventInsertFunction")
	Next
	$hMenu = GUICtrlCreateMenu("B&ases", $hSub)
	For $i = 29 To 30
		GUICtrlCreateMenuItem($aOps[$i], $hMenu)
		GUICtrlSetOnEvent(-1, "_EventInsertFunction")
	Next

	$hMenu = GUICtrlCreateMenu("Configuraçõe&s...", $hRoot)
	$hMenu2 = GUICtrlCreateMenu("Medid&a de ângulo", $hMenu)
	GUICtrlCreateMenuItem("&Graus", $hMenu2, 0, 1)
	GUICtrlSetOnEvent(-1, "_EventDefAngle")
	GUICtrlSetState(-1, 1)
	GUICtrlCreateMenuItem("&Radianos", $hMenu2, 1, 1)
	GUICtrlSetOnEvent(-1, "_EventDefAngle")
	If $sDefAng = "rad" Then GUICtrlSetState(-1, 1)
	GUICtrlCreateMenuItem("Show &Help Tips", $hMenu)
	If $bHelpTips = 1 Then GUICtrlSetData(-1, "Esconder &Dicas")
	GUICtrlSetOnEvent(-1, "_EventHelpTips")
	GUICtrlCreateMenuItem("&Arredondamento..." & @TAB & $nRndVal, $hMenu)
	GUICtrlSetOnEvent(-1, "_EventRounding")
	GUICtrlCreateMenuItem("&Imã para as bordas", $hMenu)
	If $bSnapTo = 0 Then GUICtrlSetData(-1, "&Imã ligado")
	GUICtrlSetOnEvent(-1, "_EventSnapTo")
	GUICtrlCreateMenuItem("", $hMenu)
	GUICtrlCreateMenuItem("&Editar direto", $hMenu)
	GUICtrlSetOnEvent(-1, "_EventSettingsEdit")
	GUICtrlCreateMenuItem("", $hRoot)
	GUICtrlCreateMenuItem("&Ajuda" & @TAB & "F1", $hRoot)
	GUICtrlSetOnEvent(-1, "_EventHelp")
	GUICtrlCreateMenuItem("Sai&r" & @TAB & "Alt-F4", $hRoot)
	GUICtrlSetOnEvent(-1, "_EventExit")

	$hRoot = ""
	$aOps = ""
	$hMenu = ""
	$hMenu2 = ""
	$hSub = ""

	Global $qInp = GUICtrlCreateInput(IniRead($sIni, "Startup", "QstInp", ""), 19, 4, 195, 14, 2 + 16 + 128, 0)
	GUICtrlSetBkColor(-1, 0xA6CAF0)
	GUICtrlCreateButton("=", 214, 2, 10, 17, 0x0001)
	GUICtrlSetFont(-1, 12, 700)
	GUICtrlSetOnEvent(-1, "_EventMini")
	Global $aInp = GUICtrlCreateInput(IniRead($sIni, "Startup", "AnsInp", ""), 224, 4, 75, 14, 2048, 0)
	;GUICtrlSetTip(-1, testeeee())
	GUICtrlSetBkColor(-1, 0xC0DCC0)

	Global $2Inp = GUICtrlCreateInput(0, 299, 4, 75, 14, 2048, 0)
	GUICtrlSetBkColor(-1, 0xF0DCC0)
	;GUICtrlSetBkColor(-1, 0xF00FFF)

	GUICtrlCreateLabel("|" & @CRLF & "||" & @CRLF & "|||" & @CRLF & "|||" & @CRLF & "|||" & @CRLF & "|||" & @CRLF & "|||" & _
			@CRLF & "||" & @CRLF & "|", 374, 0, 5, 20, 0x0002, 0x00100000)
	GUICtrlSetFont(-1, 2)
	GUICtrlSetCursor(-1, 9)



EndFunc   ;==>_CreateMini



Local $qInp
Local $aInp
Local $2Inp





Func Listclicado()
	MsgBox(0, "OK Pressed", "ID=" & @GUI_CtrlId & " WinHandle=" & @GUI_WinHandle & " CtrlHandle=" & @GUI_CtrlHandle)
EndFunc   ;==>OKPressed


Func testeeee()
	GUISetState(@SW_DISABLE)
GUICreate("Valores1", 202, 362, 312, 238,0x00000080 + 0x00080000 + 0x00C00000, 0x00000001)
$ListView1 = GUICtrlCreateListView("Posição|Valor|Tipo", 8, 8, 185, 345, $LVS_SINGLESEL , $LVS_EX_FULLROWSELECT)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 0, -1)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 1, -1)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 2, -1)
$liv1 = GUICtrlCreateListViewItem("teste|testst|tetet", $ListView1)
$liv2 = GUICtrlCreateListViewItem("tesrser", $ListView1)
GUISetState()
	Opt("GUIOnEventMode", 1)
	While 1
		$Msg = GUIGetMsg(1)
		Select
			Case $Msg[0] = -3
				If $Msg[1] = $hMiniUI Then
					Exit
				Else
					ExitLoop
				EndIf
			Case $Msg[0] = $hDone
				$nRndVal = GUICtrlRead($inp)
				ExitLoop
			Case $msg = $ListView1
				MsgBox(0, "OK Pressed","teste"); "ID=" & @GUI_CtrlId & " WinHandle=" & @GUI_WinHandle & " CtrlHandle=" & @GUI_CtrlHandle)
		EndSelect
	WEnd
	GUIDelete()
	GUISetState(@SW_ENABLE, $hMiniUI)
	Opt("GUIOnEventMode", 1)
EndFunc   ;==>_EventRounding
#endregion Eventos

While 1
;$CI = GUIGetCursorInfo()
;	If $CI[4] = $aInp Then
;		testeeee()
;	EndIf

	Sleep(1000)
WEnd


#region Eventos
Func _EventMini()

	If StringLen(StringRegExpReplace(GUICtrlRead($qInp), "[^\(]", "")) <> _
			StringLen(StringRegExpReplace(GUICtrlRead($qInp), "[^\)]", "")) Then Return 0
	If GUICtrlRead($qInp) = "" Then
		$aVal = ""
	Else
		If StringLen(GUICtrlRead($qInp)) = 1 Then
			Select
				Case GUICtrlRead($qInp) = "+"
					$aVal = _Calculate("++")
				Case GUICtrlRead($qInp) = "-"
					$aVal = _Calculate("--")
				Case GUICtrlRead($qInp) = "/"
					$aVal = _Calculate("//")
				Case GUICtrlRead($qInp) = "*"
					$aVal = _Calculate("**")
				Case Else
					$aVal = _Calculate(GUICtrlRead($qInp))
			EndSelect
		Else
			$aVal = _Calculate(GUICtrlRead($qInp))
		EndIf
	EndIf
	If @error <> 0 Then
		Return GUICtrlSetData($aInp, "ERR#" & @error)
	ElseIf @extended <> 0 Then
		If Execute($aVal) = 1 Then Return GUICtrlSetData($aInp, "True")
		Return GUICtrlSetData($aInp, "False")
	ElseIf (StringRight($aVal, 4) = "#IND") Then
		$aVal = 0
		Return GUICtrlSetData($aInp, "ERR#IND")
	ElseIf (StringLeft(StringRight($aVal, 4), 1) = "#") Then
		GUICtrlSetData($aInp, "ERR#" & StringRight($aVal, 3))
		$aVal = 0
		Return
	EndIf
	$ans = $aVal
	GUICtrlSetData($2Inp, GUICtrlRead($aInp))
	GUICtrlSetData($aInp, $aVal)
	ClipPut(GUICtrlRead($aInp))
	ControlFocus("MDiesel's Calculator!!", "", "[CLASS:Edit; INSTANCE:1]")
	;Send("^V",0)
	Send("^A", 0)

EndFunc   ;==>_EventMini

Func _EventHelp()
	ShellExecute(@ScriptDir & "\help.chm")
EndFunc   ;==>_EventHelp

Func _EventClear()
	GUICtrlSetData($aInp, "")
	GUICtrlSetData($qInp, "")
	$ans = ""
EndFunc   ;==>_EventClear

Func _EventDefAngle()
	$sDefAng = StringLeft(StringTrimLeft(GUICtrlRead(@GUI_CtrlId, 1), 1), 3)
EndFunc   ;==>_EventDefAngle

Func _EventMoved($hWnd, $msgID, $lParam, $wParam)
	$aPos = WinGetPos($hMiniUI, "")
	If $aPos[0] < 15 Then $aPos[0] = 0
	If $aPos[0] > @DesktopWidth - 220 Then $aPos[0] = @DesktopWidth - 205
	If $aPos[1] < 15 Then $aPos[1] = 0
	If $aPos[1] > @DesktopHeight - 45 - $aPos[3] Then $aPos[1] = @DesktopHeight - 30 - $aPos[3]
	WinMove($hMiniUI, "", $aPos[0], $aPos[1])
EndFunc   ;==>_EventMoved

Func _EventContext()
	DllCall("user32.dll", "ptr", "SendMessage", "hwnd", ControlGetHandle(@GUI_WinHandle, "", @GUI_CtrlId), "int", 0x007B, "int", _
			@GUI_CtrlId, "int", 0)
EndFunc   ;==>_EventContext

Func _EventSettingsEdit()
	$aPos = WinGetPos($hMiniUI, "")
	$sString = "[Settings]" & @CRLF & "RoundVal=" & _
			$nRndVal & @CRLF & "x=" & $aPos[0] & @CRLF & "y=" & $aPos[1] & @CRLF & "DefAng=" & $sDefAng
	$hFile = FileOpen(@ScriptDir & "\settings.ini", 2)
	FileWrite($hFile, $sString)
	FileClose($hFile)

	ShellExecute(@ScriptDir & "\settings.ini")
EndFunc   ;==>_EventSettingsEdit

Func _EventInsertFunction()
	Local $p = DllStructCreate("int;int")

	$Msg = GUICtrlSendMsg($qInp, 0xB0, DllStructGetPtr($p, 1), DllStructGetPtr($p, 2))
	$hData = GUICtrlRead($qInp)
	GUICtrlSendMsg($qInp, 0xC2, True, GUICtrlRead(@GUI_CtrlId, 1) & "(" & _
			StringTrimRight(StringTrimLeft($hData, DllStructGetData($p, 1)), DllStructGetData($p, 2) - StringLen($hData)) & ")")

	$anPos = WinGetPos($hMiniUI, "")
	If Not $bHelpTips Then Return
	ToolTip("A function was just added to the field." & @CR & @CR & _
			"For Example: ""sin(30)"" is calling the sin function with a single parameter of 5." & @CR & _
			"To call multiple parameters, seperate them with a comma - "","" eg. ""ToBase(42,2)""", _
			$anPos[0] + 160, $anPos[1] + 20, "Mini Calculator Help", 1, 7)
	AdlibRegister("_TooltipsOff", 4000)
EndFunc   ;==>_EventInsertFunction

Func _EventInsertVar()
	GUICtrlSetData($qInp, StringRegExpReplace(StringReplace(GUICtrlRead(@GUI_CtrlId, 1), "&", ""), @TAB & ".*", ""), 1)

	If Not $bHelpTips Then Return
	$anPos = WinGetPos($hMiniUI, "")
	ToolTip("A Variable was just added to the field." & @CR & @CR & _
			"For Example: ""pi"" Will be replaced with the value of pi: 3.141....", _
			$anPos[0] + 160, $anPos[1] + 20, "Mini Calculator Help", 1, 7)
	AdlibRegister("_TooltipsOff", 4000)
EndFunc   ;==>_EventInsertVar

Func _EventInsertConv()
	GUICtrlSetData($qInp, StringRegExpReplace(StringReplace(GUICtrlRead(@GUI_CtrlId, 1), "&", ""), ".*" & @TAB, ""), 1)

	If Not $bHelpTips Then Return
	$anPos = WinGetPos($hMiniUI, "")
	ToolTip("A Post unary Operator was just added to the field." & @CR & @CR & _
			"For Example: ""146[cm:m]"" Will convert 146cm to m, giving you 1.46", _
			$anPos[0] + 160, $anPos[1] + 20, "Mini Calculator Help", 1, 7)
	AdlibRegister("_TooltipsOff", 4000)
EndFunc   ;==>_EventInsertConv

Func _EventHelpTips()
	If $bHelpTips = 1 Then
		$bHelpTips = 0
		GUICtrlSetData(@GUI_CtrlId, "Mostras Dicas")
		_TooltipsOff()
	Else
		$bHelpTips = 1
		GUICtrlSetData(@GUI_CtrlId, "Esconder Dicas")
	EndIf
EndFunc   ;==>_EventHelpTips

Func _EventSnapTo()
	If $bSnapTo = 0 Then
		$bSnapTo = 1
		GUIRegisterMsg(0x0047, "_EventMoved")
		GUICtrlSetData(@GUI_CtrlId, "Imã ligado")
	Else
		$bSnapTo = 0
		GUIRegisterMsg(0x0047, "")
		GUICtrlSetData(@GUI_CtrlId, "Imã desligado")
	EndIf
EndFunc   ;==>_EventSnapTo

Func _EventRounding()
	GUISetState(@SW_DISABLE)
	GUICreate("Arredondamento...", 168, 48, -1, -1, 0x00000080 + 0x00080000 + 0x00C00000, 0x00000001)
	GUICtrlCreateLabel("Casas:", 2, 4, 80, 20, 0x0002)
	$inp = GUICtrlCreateInput($nRndVal, 84, 2, 40, 20)
	GUICtrlCreateUpdown($inp)
	GUICtrlSetLimit(-1, 15, -15)
	GUICtrlCreateLabel("Max. 15", 126, 4, 40, 20)
	$hDone = GUICtrlCreateButton("OK", 84, 24, 80, 20)
	$hCanc = GUICtrlCreateButton("Cancelar", 2, 24, 80, 20)
	GUISetState()
	Opt("GUIOnEventMode", 0)
	While 1
		$Msg = GUIGetMsg(1)
		Select
			Case $Msg[0] = $hCanc
				ExitLoop
			Case $Msg[0] = -3
				If $Msg[1] = $hMiniUI Then
					Exit
				Else
					ExitLoop
				EndIf
			Case $Msg[0] = $hDone
				$nRndVal = GUICtrlRead($inp)
				ExitLoop
		EndSelect
	WEnd
	GUIDelete()
	GUISetState(@SW_ENABLE, $hMiniUI)
	Opt("GUIOnEventMode", 1)
EndFunc   ;==>_EventRounding
#endregion Eventos


Func _Calculate($sCalc)

	$sCalc = StringStripWS($sCalc, 8)
	$sCalc = StringReplace($sCalc, ",", ".")
	;$sCalc = StringReplace ($sCalc, "!=", "<>") colliding with factorial... eg: 4!=24 could be true or false
	;$sCalc = StringReplace ($sCalc, "++", "+1")
	;$sCalc = StringReplace ($sCalc, "--", "-1")
	$sCalc = StringReplace($sCalc, "++", GUICtrlRead($aInp) + GUICtrlRead($2Inp))
	$sCalc = StringReplace($sCalc, "--", GUICtrlRead($aInp) - GUICtrlRead($2Inp))
	$sCalc = StringReplace($sCalc, "//", GUICtrlRead($aInp) / GUICtrlRead($2Inp))
	$sCalc = StringReplace($sCalc, "**", GUICtrlRead($aInp) * GUICtrlRead($2Inp))
	$sCalc = StringReplace($sCalc, "==", "=")
	$sCalc = StringReplace($sCalc, "pi", $Pi)
	$sCalc = StringReplace($sCalc, "ans", $ans)
	$sCalc = StringRegExpReplace($sCalc, "sqrt\(([^\)]*)\)", "\(\1\^0\.5\)")
	$sCalc = StringRegExpReplace($sCalc, "([0-9]*)!", "fact\(\1\)")
	$sCalc = StringRegExpReplace($sCalc, "([0-9]*)%([0-9]*)", "\(mod\(\1\,\2\)\)")
	$sCalc = StringRegExpReplace($sCalc, "([0-9]*)b>([0-9]*)", "\(tobase\(\1\,\2\)\)")
	$sCalc = StringRegExpReplace($sCalc, "([0-9]*)b([0-9]*)", "\(tobase\(\1\,\2\)\)")
	$sCalc = StringRegExpReplace($sCalc, "([0-9]*)b<([0-9]*)", "\(frombase\(\1\,\2\)\)")
	$sCalc = StringRegExpReplace($sCalc, "([0-9]*\[.*?\])", "_Conversion\(""\1""\)")
	$sCalc = StringReplace($sCalc, "sin", "_sin")
	$sCalc = StringReplace($sCalc, "asin", "_asin")
	$sCalc = StringReplace($sCalc, "cos", "_cos")
	$sCalc = StringReplace($sCalc, "acos", "_acos")
	$sCalc = StringReplace($sCalc, "tan", "_tan")
	$sCalc = StringReplace($sCalc, "atan", "_atan")
	If StringInStr($sCalc, "=") Or StringRegExp($sCalc, "[^b][<;>]") = 1 Then Return SetExtended(1, $sCalc)
	$sCalc = Execute($sCalc)
	Return SetError(@error, @extended, Round($sCalc, $nRndVal))

EndFunc   ;==>_Calculate

Func _EventExit()
	Global $aPos = WinGetPos($hMiniUI, "")
	Exit
EndFunc   ;==>_EventExit

Local $aPos

Func _EventClose()
	GUISetState($hMiniUI, @SW_HIDE)
	GUIRegisterMsg(0x0111, "")
	$sString = "[Settings]" & @CRLF & "RoundVal=" & _
			$nRndVal & @CRLF & "x=" & $aPos[0] & @CRLF & "y=" & $aPos[1] & @CRLF & "DefAng=" & $sDefAng & @CRLF & _
			"SnapTo=" & $bSnapTo & @CRLF & @CRLF & "[StartUp]" & @CRLF & "ans=" & $ans & @CRLF & "AnsInp=" & _
			GUICtrlRead($aInp) & @CRLF & "QstInp=" & GUICtrlRead($qInp)
	$hFile = FileOpen(@ScriptDir & "\settings.ini", 2)
	FileWrite($hFile, $sString)
	FileClose($hFile)
EndFunc   ;==>_EventClose

Func _TooltipsOff()
	ToolTip("")
EndFunc   ;==>_TooltipsOff

Func fact($iNum)
	$x = 1
	For $i = 1 To $iNum
		$x *= $i
	Next
	Return $x
EndFunc   ;==>fact

Func rad($iDeg)
	Return $iDeg * ($Pi / 180)
EndFunc   ;==>rad

Func deg($iRad)
	Return $iRad / ($Pi / 180)
EndFunc   ;==>deg

Func tobase($iNumber, $iBase, $iPad = 1)
	If $iBase < 2 And $iBase > 36 Then Return 0
	Local $sRet = "", $iDigit
	Do
		$iDigit = Mod($iNumber, $iBase)
		$sRet = Chr(48 + $iDigit + 7 * ($iDigit > 9)) & $sRet
		$iNumber = Int($iNumber / $iBase)
	Until ($iNumber = 0) And (StringLen($sRet) >= $iPad)
	Return $sRet
EndFunc   ;==>tobase

Func frombase($sNumber, $iBase)
	Local $iRet = 0, $sChar
	Do
		$iRet *= $iBase
		$sChar = StringLeft($sNumber, 1)
		$iRet += Asc($sChar) + 7 * (Asc($sChar) < 58) - 55
		$sNumber = StringMid($sNumber, 2)
	Until $sNumber = ""
	Return $iRet
EndFunc   ;==>frombase

Func root($fNum, $nExp = 3)
	Local $bNeg = False, $fRet = 0
	If $nExp < 0 Then Return SetError(1, 0, $fNum)

	If $fNum < 0 Then ; is negative
		If Mod($nExp, 2) Then ; nExp is odd, so negative IS possible.
			$bNeg = True
			$fNum *= -1
		Else
			Return SetError(1, 0, $fNum & "i") ; Imaginary number.
		EndIf
	EndIf

	$fRet = $fNum ^ (1 / $nExp)
	If $bNeg Then $fRet *= -1
	Return $fRet
EndFunc   ;==>root

Func _sin($nIn)
	If $sDefAng = "deg" Then $nIn = rad($nIn)
	$nIn = Sin($nIn)
	If $sDefAng = "rad" Then $nIn = rad($nIn)
	Return $nIn
EndFunc   ;==>_sin

Func _asin($nIn)
	If $sDefAng = "deg" Then $nIn = rad($nIn)
	$nIn = ASin($nIn)
	If $sDefAng = "rad" Then $nIn = rad($nIn)
	Return $nIn
EndFunc   ;==>_asin

Func _cos($nIn)
	If $sDefAng = "deg" Then $nIn = rad($nIn)
	$nIn = Cos($nIn)
	If $sDefAng = "rad" Then $nIn = rad($nIn)
	Return $nIn
EndFunc   ;==>_cos

Func _acos($nIn)
	If $sDefAng = "deg" Then $nIn = rad($nIn)
	$nIn = ACos($nIn)
	If $sDefAng = "rad" Then $nIn = rad($nIn)
	Return $nIn
EndFunc   ;==>_acos

Func _tan($nIn)
	If $sDefAng = "deg" Then $nIn = rad($nIn)
	$nIn = Tan($nIn)
	If $sDefAng = "rad" Then $nIn = rad($nIn)
	Return $nIn
EndFunc   ;==>_tan

Func _atan($nIn)
	If $sDefAng = "deg" Then $nIn = rad($nIn)
	$nIn = ATan($nIn)
	If $sDefAng = "rad" Then $nIn = rad($nIn)
	Return $nIn
EndFunc   ;==>_atan

Func min($nNum1, $nNum2)
	If $nNum1 < $nNum2 Then Return $nNum1
	Return $nNum2
EndFunc   ;==>min

Func max($nNum1, $nNum2)
	If $nNum1 > $nNum2 Then Return $nNum1
	Return $nNum2
EndFunc   ;==>max


Func _limpa()
	ClipPut(GUICtrlRead($aInp))
	_EventClear()
	GUISetState(@SW_SHOW)
	WinActivate("MDiesel's Calculator!!", "")
	ControlFocus("MDiesel's Calculator!!", "", "[CLASS:Edit; INSTANCE:1]")
	Send("^V", 0)
	Send("^A", 0)
	GUISetState(@SW_SHOW)
EndFunc   ;==>_limpa