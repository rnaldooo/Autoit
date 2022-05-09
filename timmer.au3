
GUISetState(@SW_SHOW)

Global $TIMER = TimerInit()
Global Const $TIMEOUT = 10000; 10 seconds

While 1
	If TimerDiff($TIMER) >= $TIMEOUT Then
		MsgBox(0, "", "Out of time")
		ExitLoop
	EndIf
	$nMsg = GUIGetMsg()
WEnd
