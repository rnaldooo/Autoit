;salva cad; 1. Includes
#include <GuiConstants.au3>
#include <String.au3>
#include <Array.au3>
#include <WinAPI.au3>





; 2. Autoit Options
Opt("GUICloseOnESC", 0)
Opt("TrayMenuMode", 1)
Opt("TrayOnEventMode", 1)
;Opt("WinTitleMatchMode", 4)

; 3. Declara Variaveis
Global $Tempo = 1 * 60000
Global $handle
Global $htitulo

; 4. Define atalhos
HotKeySet("{F1}", "Sobre_GUI")
;HotKeySet("{ESC}", "Minimize_GUI")

; 5. Cria a GUI
GUICreate("salva autocad", 350, 70)
Opt("GUICoordMode", 2)
GUISetState(@SW_HIDE)
GUISetState(@SW_MINIMIZE)

; 7. Define o tray menu
$Abrir_tray = TrayCreateItem("Abrir")
TrayItemSetOnEvent(-1, "Abrir_GUI")
$Tempo_tray = TrayCreateMenu("Tempo")
$tempo01min = TrayCreateItem("1 minuto", $Tempo_tray)
TrayItemSetOnEvent(-1, "Tempo1")
$tempo05min = TrayCreateItem("3 minutos", $Tempo_tray)
TrayItemSetOnEvent(-1, "Tempo3")
$tempo10min = TrayCreateItem("5 minutos", $Tempo_tray)
TrayItemSetOnEvent(-1, "Tempo5")
$Sobre_tray = TrayCreateItem("Sobre")
TrayItemSetOnEvent(-1, "Sobre_GUI")
TrayCreateItem("")
$Sair_tray = TrayCreateItem("Sair")
TrayItemSetOnEvent(-1, "Sair_GUI")
TraySetState()


; 8. Come�a LOOP
Localiza()
While 1
	Sleep($Tempo)
	Salvar()
	$msg = GUIGetMsg()
	Select
		Case $msg = $GUI_EVENT_CLOSE
			ExitLoop
		Case $msg = $GUI_EVENT_MINIMIZE
			Minimize_GUI()
	EndSelect
WEnd

; 9. Fun��es
Func Sobre_GUI()
	MsgBox(64, "Salva Cad...", "para Daniel")
EndFunc   ;==>Sobre_GUI

Func Abrir_GUI()
	GUISetState(@SW_SHOW)
	GUISetState(@SW_RESTORE)
EndFunc   ;==>Abrir_GUI

Func Minimize_GUI()
	GUISetState(@SW_HIDE)
	GUISetState(@SW_MINIMIZE)
EndFunc   ;==>Minimize_GUI

Func Sair_GUI()
	Exit
EndFunc   ;==>Sair_GUI

Func Visivel($handle)
	If BitAND(WinGetState($handle), 2) Then
		Return 1
	Else
		Return 0
	EndIf
EndFunc   ;==>Visivel

Func Tempo1()
	$Tempo = 1 * 60000
EndFunc   ;==>Tempo1

Func Tempo3()
	$Tempo = 3 * 60000
EndFunc   ;==>Tempo3

Func Tempo5()
	$Tempo = 5 * 60000
EndFunc   ;==>Tempo5

Func Localiza()
	Dim $var = WinList()
	Dim $tamanho = 0
	Dim $ii = 0
	Dim $Pos = 0
	Dim $TCAD = "sssssssssssssssss"

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

	$Pos = _ArraySearch($parte1, $TCAD, 0, 0, 0, True)
	;MsgBox(64, "pos...", $Pos)

If $Pos <> -1 Then
		$handle = $parte2[$Pos]
		$htitulo = _WinAPI_GetWindowText($handle)
	;	MsgBox(64, "pos...", $handle)
	;	MsgBox(64, "pos...", $htitulo)		
	Else
;		MsgBox(64, "pos...", "N�o encontrado")
	EndIf
EndFunc 

Func Salvar()	
	ControlSend($htitulo, "", "[CLASS:Afx:01100000:28:00000000:00000002:00010265; INSTANCE:1]", "^s")
	;MsgBox(64, "Salva Cad1...", "para Daniel")
EndFunc   ;==>Salvar