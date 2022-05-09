#include <GUIComboBox.au3>

Opt('MustDeclareVars', 1)

$Debug_CB = False ; Check ClassName being passed to ComboBox/ComboBoxEx functions, set to True and use a handle to another control to see it work

Global $hCombo

_Main()

Func _Main()
	Local $hGUI

	; Create GUI
	$hGUI = GUICreate("(External) ComboBox Create", 400, 296)
	$hCombo = _GUICtrlComboBox_Create ($hGUI, "", 2, 2, 396, 296)
	GUISetState()

	; Add files
	_GUICtrlComboBox_BeginUpdate ($hCombo)
	_GUICtrlComboBox_AddDir ($hCombo, "", $teste, False)
	_GUICtrlComboBox_EndUpdate ($hCombo)
$teste = "aa"
	; Loop until user exits
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>_Main
