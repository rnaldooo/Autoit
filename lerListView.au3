#include <WinAPIHObj.au3>
#include <GuiListBox.au3>
#include <Array.au3>
#include <GuiListView.au3>

#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <ListViewConstants.au3>
#include <WindowsConstants.au3>

#include <GuiConstantsEx.au3>



#Region opts
Opt("TrayOnEventMode", 1)
Opt("TrayMenuMode", 1)
Opt("TrayAutoPause", 0)
Opt("TrayIconHide", 1)
AutoItSetOption("WinTitleMatchMode", 4)
AutoItSetOption('WinDetectHiddenText', 1)
AutoItSetOption('MouseCoordMode', 0)
AutoItSetOption("SendKeyDownDelay", 50)
OnAutoItExitRegister("_EventClose")
#EndRegion opts



Global $hGUI, $ctrlButton, $ctrlLB


#Region ### START Koda GUI section ### Form=
$Form1_1 = GUICreate("Form1", 826, 438, 192, 124)
$Button1 = GUICtrlCreateButton("Button1", 8, 8, 75, 25)
$List1 = GUICtrlCreateList("", 8, 48, 177, 240)
GUICtrlSetData(-1, "")
$ListView1 = GUICtrlCreateListView("", 200, 48, 274, 158)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 0, 50)
$Button2 = GUICtrlCreateButton("Button2", 96, 8, 75, 25)
$Button3 = GUICtrlCreateButton("Button3", 184, 8, 75, 25)
$Button4 = GUICtrlCreateButton("Button4", 272, 8, 75, 25)
$Input1 = GUICtrlCreateInput("Input1", 480, 8, 193, 21)
$Input2 = GUICtrlCreateInput("Input2", 480, 32, 193, 21)
$Input3 = GUICtrlCreateInput("Input3", 480, 56, 193, 21)
$Input4 = GUICtrlCreateInput("Input4", 480, 80, 193, 21)
$Input5 = GUICtrlCreateInput("Input5", 480, 104, 193, 21)
$Input6 = GUICtrlCreateInput("Input6", 480, 128, 193, 21)
$Input7 = GUICtrlCreateInput("Input7", 480, 152, 193, 21)
$Input8 = GUICtrlCreateInput("Input8", 480, 176, 193, 21)
$Input9 = GUICtrlCreateInput("Input9", 480, 200, 193, 21)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

For $n = 1 To 19
	GUICtrlSetData($List1, "Item " & $n)
Next

GUICtrlSetData($Input1, "Quadros de Desenho")


While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $Button1
			_lehandle2()
		Case $Button2
			_ler()

		Case $GUI_EVENT_CLOSE
			Exit

	EndSwitch
WEnd



Func _lehandle()
	$BuscarTitle = GUICtrlRead($Input1)
	Local $aWindows = _WinAPI_EnumWindows()
	Local $aResult[$aWindows[0][0]][6]
	For $i = 1 To $aWindows[0][0]
		$aResult[$i - 1][0] = $aWindows[$i][0]
		$aResult[$i - 1][1] = $aWindows[$i][1]
		$aResult[$i - 1][2] = WinGetTitle($aWindows[$i][0])
		$aResult[$i - 1][3] = WinGetText($aWindows[$i][0])
		$aResult[$i - 1][4] = WinGetProcess($aWindows[$i][0])
		$aResult[$i - 1][5] = _IsVisible($aWindows[$i][0])
	Next
	;_ArrayDisplay($aResult, "_WinAPI_EnumWindows", Default, Default, 50, Default, "#|Handle|Class|Title|Text|Process")
	$iIndex2 = _ArraySearch($aResult, $BuscarTitle, 0, 0, 0, 1, 0, 2)
	GUICtrlSetData($Input6, $iIndex2)
	GUICtrlSetData($Input7, $aWindows[$iIndex2 + 1][0])
	GUICtrlSetData($Input8, $aWindows[$iIndex2 + 1][1])
EndFunc   ;==>_lehandle


Func _lehandle2()
	;Dim $tatocando = _vesetatocando()
	;If GUICtrlRead($Input10) = "Input10" Then
		;If $tatocando Then
		;	_play()
		;	Sleep(GUICtrlRead($Input7))
		;Else
		;EndIf
		;Send("{MEDIA_PLAY_PAUSE}")
		;Sleep(500)
		$alista2 = WinList()
		$tamanho = 0
		;_ArrayDisplay($alista2, "parte2")


		;Dim $Pos3 = 0
		;$Pos3 = _ArraySearch($alista2[][0], "001F0DB8", 0, 0, 0, True)
		;MsgBox($MB_SYSTEMMODAL, "", $Pos3)

		For $i = 1 To $alista2[0][0]
			If $alista2[$i][0] <> "" And _IsVisible($alista2[$i][1]) Then
				$tamanho = $tamanho + 1
			EndIf
		Next

		Dim $ii = 0
		Dim $parte1[$tamanho]
		Dim $parte2[$tamanho]

		For $i = 1 To $alista2[0][0]
			If $alista2[$i][0] <> "" And _IsVisible($alista2[$i][1]) Then
				$parte1[$ii] = $alista2[$i][0]
				$parte2[$ii] = $alista2[$i][1]
				$ii = $ii + 1
			EndIf
		Next

		;_ArrayDisplay($parte1, "parte1")
		;_ArrayDisplay($parte2, "parte2")

		Dim $Pos = 0
		Dim $Text = GUICtrlRead($Input1)
		;dim $sclassnn = "WindowsForms10.Window.8.app.0.1bb715_r14_ad11"

		;MsgBox($MB_SYSTEMMODAL, "", $Text)
		;$Pos = _ArraySearch($parte1, $Text, 0, 0, 0, True)
		;$iIndex2 = _ArraySearch($aResult, $BuscarTitle, 0, 0, 0, 1, 0, 2)
		;_ArraySearch ( Const ByRef $aArray,
		;						$vValue [,
		;						$iStart = 0 [,
		;						$iEnd = 0 [,
		;						$iCase = 0 [,
		;						$iCompare = 0 [,
		;						$iForward = 1 [,
		;						$iSubItem = -1 [,
		;						$bRow = False]]]]]]] )
		;$Pos = _ArraySearch($parte1, $Text)
		;MsgBox($MB_SYSTEMMODAL, "", $Pos)
	;		$Pos = _ArraySearch($parte1, $Text, 0, 0, 1, 1, 0,0, True)
		;MsgBox($MB_SYSTEMMODAL, "", $Pos)
	;		$Pos = _ArraySearch($parte1, $Text, 0, 0, 1, 1, 0,1, True)
		;MsgBox($MB_SYSTEMMODAL, "", $Pos)
		;	$Pos = _ArraySearch($parte1, $Text, 0, 0, 1, 1, 0,0, False)
		;MsgBox($MB_SYSTEMMODAL, "", $Pos)
		;	$Pos = _ArraySearch($parte1, $Text, 0, 0, 1, 1, 0,1, False)
		;MsgBox($MB_SYSTEMMODAL, "", $Pos)
			$Pos = _ArraySearch($parte1, $Text, 0, 0, 0, True)
		;MsgBox($MB_SYSTEMMODAL, "", $Pos)
		$handle2 = $parte2[$Pos]

		;$Pos = _ArraySearch($parte1, $Text, 0, 0, 0, True)
		;$handle2 = $parte2[$Pos]

	;	$ativa = WinGetTitle("ACTIVE", "")
	;	$hfoobar = _WinAPI_GetWindowText($handle2)
		GUICtrlSetData($Input7, $handle2)
	;	GUICtrlSetData($Input9, $hfoobar)

		;If $tatocando Then
		;	_play()
			;Sleep(100)
		;Else
		;EndIf
		;_play()
	;Else
	;EndIf
	;Send("{MEDIA_PLAY_PAUSE}")
EndFunc   ;==>_lehandle2



Func _IsVisible($handle)
	If BitAND(WinGetState($handle), 2) Then
		Return 1
	Else
		Return 0
	EndIf
EndFunc   ;==>_IsVisible


Func _ler()

	;Local $hLB = ControlGetHandle(GUICtrlRead($Input7), "", 13967)
	;_ArrayDisplay($hLB, "parte1")

	;Local $iCnt = _GUICtrlListBox_GetCount($hLB)
	;Local $sMsg = ""
	;For $n = 0 To $iCnt - 1
	;	$sMsg &= $n & ":  " & _GUICtrlListBox_GetText($hLB, $n) & @CRLF
	;Next
	;MsgBox(64, "Result", $sMsg)


	;MsgBox($MB_SYSTEMMODAL, "", ControlListView(GUICtrlRead($Input1), "", "SysListView321",	"FindItem", "82-2918J"))
	;MsgBox($MB_SYSTEMMODAL, "", ControlListView(GUICtrlRead($Input7), "", "SysListView321",	"FindItem", "82-2918J"))
	;MsgBox($MB_SYSTEMMODAL, "", _GUICtrlListView_GetItemText(GUICtrlRead($Input7), 1,1))
	;MsgBox($MB_SYSTEMMODAL, "", ControlListView(GUICtrlRead($Input1), "", "SysListView321", "GetText",1,1))
	;MsgBox($MB_SYSTEMMODAL, "", ControlListView(GUICtrlRead($Input7), "", "SysListView321", "GetText",0,0))
	;MsgBox($MB_SYSTEMMODAL, "", ControlListView(GUICtrlRead($Input7), "", "SysListView321", "GetText",1,0))
;	MsgBox($MB_SYSTEMMODAL, "", ControlListView(GUICtrlRead($Input7), "", "SysListView321", "GetText",2,0))
	;MsgBox($MB_SYSTEMMODAL, "", ControlListView(GUICtrlRead($Input7), "", "SysListView321", "GetText",3,0))
	;MsgBox($MB_SYSTEMMODAL, "", ControlListView(GUICtrlRead($Input7), "", "SysListView321", "GetText",4,0))

	;MsgBox($MB_SYSTEMMODAL, "", ControlListView(GUICtrlRead($Input7), "", "Button2", "GetText",1,0))
	;MsgBox($MB_SYSTEMMODAL, "", ControlListView(GUICtrlRead($Input1), "", 13967, "GetText",1,1))
;SysListView321
	;MsgBox($MB_SYSTEMMODAL, "", ControlListView(GUICtrlRead($Input7), "", "[CLASS:Button; INSTANCE:2]", "GetText", 9, 0))
;[CLASS:SysHeader32; INSTANCE:1]
	;MsgBox($MB_SYSTEMMODAL, "", _GUICtrlListView_GetItemText(GUICtrlRead($Input7), 1))
;	MsgBox($MB_SYSTEMMODAL, "", _GUICtrlListView_GetItemText(GUICtrlRead($Input7), 0))
;	MsgBox($MB_SYSTEMMODAL, "", _GUICtrlListView_GetItemText(GUICtrlRead($Input7), 1, 0))
;	MsgBox($MB_SYSTEMMODAL, "", _GUICtrlListView_GetItemText(GUICtrlRead($Input7), 1, 1))
;	MsgBox($MB_SYSTEMMODAL, "", _GUICtrlListView_GetItemText(GUICtrlRead($Input7), 1, 2))

	;I don't know why, I' m sure it's not a owner-drawn listview since:

	;ControlListView($hWnd, "", "SysListView321", "GetText", $idx, 1) can get the correct text!!


	;	_WinAPI_GetObject ( $hObject, $iSize, $pObject )
	;$alista =
	;_ArrayDisplay($alista, "parte1")


EndFunc   ;==>_ler



Func _EventClose()
	GUISetState($Form1_1, @SW_HIDE)
	GUIRegisterMsg(0x0111, "")
	;_FileWriteFromArray($sArqu, $alista, 0)
EndFunc   ;==>_EventClose
