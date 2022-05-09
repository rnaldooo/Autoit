#AutoIt3Wrapper_au3check_parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#include <GUIConstantsEx.au3>
#include <GuiButton.au3>
#include <WindowsConstants.au3>

dim $tt = "d"

 _GUICtrlButton_Enable("[CLASS:WindowsForms10.BUTTON.app67; INSTANCE:2]" , True)

; _GUICtrlToolbar_SetButtonInfo (0x00040482, $idSave, $STD_PRINT, BitOR($TBSTATE_PRESSED, $TBSTATE_ENABLED), -1, 100, 1234)
;$tt = _GUICtrlButton_GetState("[CLASS:WindowsForms10.BUTTON.app67; INSTANCE:2]")
;MsgBox(0, "Details", "é=" & $tt)