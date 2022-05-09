#include <WinApi.au3>
#include <GuiConstants.au3>

$gMain = GUICreate("FileReadTail", 625, 482, 193, 125)
GUICtrlCreateLabel("Filename:", 8, 12, 49, 17)
$inFilename = GUICtrlCreateInput("", 64, 10, 281, 21)
$btBrowse = GUICtrlCreateButton("Browse...", 360, 8, 75, 25, 0)
$cbOffset = GUICtrlCreateCombo("6", 480, 10, 137, 25)
GUICtrlSetData(-1, "128|256|512|1024|2048", "512")
GUICtrlCreateLabel("Offset:", 440, 12, 35, 17)
$edResults = GUICtrlCreateEdit("", 16, 56, 593, 377)
GUICtrlSetFont(-1, 8.5, Default, Default, "Courier New")
$btRead = GUICtrlCreateButton("Read", 264, 448, 75, 25, 0)
GUICtrlSetState(-1, $GUI_DISABLE)
$bRead = False
GUISetState(@SW_SHOW)

While 1
	$nMsg = GUIGetMsg()
	Select
		Case $nMsg = $GUI_EVENT_CLOSE
			ExitLoop
		Case $nMsg = $btBrowse
			$sFilename = FileOpenDialog("Select file to read...", "", "All (*.*)")
			If @error <> 1 Then GUICtrlSetData($inFilename, $sFilename)
		Case $nMsg = $btRead
			_ReadFileTail(GUICtrlRead($inFilename), GUICtrlRead($cbOffset))
	EndSelect
	If FileExists(GUICtrlRead($inFilename)) Then
		If Not $bRead Then
			GUICtrlSetState($btRead, $GUI_ENABLE)
			$bRead = True
		EndIf
	Else
		If $bRead Then
			GUICtrlSetState($btRead, $GUI_DISABLE)
			$bRead = False
		EndIf
	EndIf
WEnd

Func _ReadFileTail($sInFilename, $nBytes)
	Local $hInFile, $aResult, $hBuffer, $nRead

	; Open file for reading
	$hInFile = _WinAPI_CreateFile($sInFilename, 2, 2, 2)
	If $hInFile = 0 Then
		GUICtrlSetData($edResults, "!> [" & _WinAPI_GetLastError() & "] " & _WinAPI_GetLastErrorMessage() & @CRLF)
		Return
	EndIf

	; Move file pointer to desired position
	$aResult = DllCall("Kernel32.dll", "dword", "SetFilePointer", "hwnd", $hInFile, "int", Int("-" & $nBytes), "long_ptr", 0, "dword", 2)
	$nPosition = $aResult[0]
	$nOffset = Int("0x" & StringRight(Hex($nPosition), 1))
	$nPosition -= $nOffset
	
	;_WinAPI_SetFilePointer($hBuffer, -"ubyte buffer[3]", 2)
	;_WinAPI_SetEndOfFile($hBuffer)
	;_WinAPI_CloseHandle($hBuffer)
	
	; Create file read buffer
	$hBuffer = DllStructCreate("ubyte buffer[" & $nBytes & "]")


	$pBuffer = DllStructGetPtr($hBuffer)

	If _WinAPI_ReadFile($hInFile, $pBuffer, $nBytes, $nRead) Then
		GUICtrlSetData($edResults, StringFormat("%17s: %s\r\n", "Filename", $sInFilename))
		GUICtrlSetData($edResults, StringFormat("%17s: %s\r\n", "Pointer position", Hex($nPosition)), 1)
		GUICtrlSetData($edResults, StringFormat("%17s: %s\r\n", "Pointer offset", $nOffset), 1)
		GUICtrlSetData($edResults, StringFormat("%17s: %s\r\n\r\n", "Bytes read", $nRead), 1)
		$sBuffer = StringTrimLeft(DllStructGetData($hBuffer, "buffer"), 2)
		For $i = 0 To ($nRead / 16) + 1
			$sHex = ""
			$sWord = ""
			If $sBuffer = "" Then ExitLoop
			$sTemp = StringLeft($sBuffer, 32 - ($nOffset * 2))
			$sBuffer = StringTrimLeft($sBuffer, 32 - ($nOffset * 2))
			For $j = $nOffset To 15
				$sHex &= StringLeft($sTemp, 2)
				If Mod($j, 2) = 1 Then $sHex &= " "
				$nCode = Int("0x" & StringLeft($sTemp, 2))
				If $nCode > 31 And $nCode < 127 Then
					$sWord &= Chr($nCode)
				Else
					$sWord &= "."
				EndIf
				$sTemp = StringTrimLeft($sTemp, 2)
				If $sTemp = "" Then ExitLoop
			Next
			If $i = 0 Then
				GUICtrlSetData($edResults, StringFormat(" %s: %40s  %16s\r\n", Hex($nPosition), $sHex, $sWord), 1)
				$nOffset = 0
			Else
				GUICtrlSetData($edResults, StringFormat(" %s: %-40s  %-16s\r\n", Hex($nPosition), $sHex, $sWord), 1)
			EndIf
			$nPosition += 32
		Next
		_WinAPI_CloseHandle($hInFile)
		Return StringTrimLeft(DllStructGetData($hBuffer, "buffer"), 2)
	Else
		GUICtrlSetData($edResults, "!> [" & _WinAPI_GetLastError() & "] " & _WinAPI_GetLastErrorMessage() & @CRLF)
		_WinAPI_CloseHandle($hInFile)
	EndIf
EndFunc   ;==>_ReadFileTail