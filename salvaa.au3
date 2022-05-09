#include <GuiConstants.au3>
#include <String.au3>
#include <Array.au3>
#include <WinAPI.au3>

;Opt("WinTitleMatchMode", 4)

Salvar()

Func Salvar()
	Dim $var = WinList()
	Dim $tamanho = 0
	Dim $ii = 0
	Dim $Pos = 0
	Dim $TCAD = "AutoCAD 2010"

	For $i = 1 To $var[0][0]
		If $var[$i][0] <> "" And Visivel($var[$i][1]) Then
			$tamanho = $tamanho + 1
		EndIf
	Next

	Dim $parte1[$tamanho]
	Dim $parte2[$tamanho]

	For $i = 1 To $var[0][0]
		If $var[$i][0] <> "" And Visivel($var[$i][1]) Then
			$parte1[$ii] = $var[$i][0]
			$parte2[$ii] = $var[$i][1]
			$ii = $ii + 1
		EndIf
	Next

	;_ArrayDisplay($parte1, "parte1")
	;_ArrayDisplay($parte2, "parte2")

	;$Pos = _ArraySearch($parte1, $TCAD, 0, 0, 0, True)
	;MsgBox(64, "pos...", $Pos)
	
	If $Pos <> -1 Then
		$handle = $parte2[$Pos]
		$htitulo = _WinAPI_GetWindowText($handle)
		;MsgBox(64, "pos...", $handle)
		;MsgBox(64, "pos...", $htitulo)
		ControlSend($htitulo, "", "[CLASS:Afx:01100000:8:00010005:00000000:00000000; INSTANCE:2]", "^s")
		;MsgBox(64, "Salva Cad1...", "para Daniel")
	Else
	EndIf
EndFunc   ;==>Salvar

Func Visivel($handle)
	If BitAND(WinGetState($handle), 2) Then
		Return 1
	Else
		Return 0
	EndIf
EndFunc   ;==>Visivel