#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_icon=..\_vvv2009\icon.ico
#AutoIt3Wrapper_outfile=delfoobar.exe
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
; ## 1 ##. Pacotes
;    '---> 1.1 prog
#include <String.au3>
#include <Array.au3>
#include <WinAPI.au3>
;    '---> 1.2 gui
#include <GuiConstants.au3>

; ## 2 ##. Autoit Op��es
;    '---> 2.1 prog
AutoItSetOption("WinTitleMatchMode", 4)
;    '---> 2.2 gui (grafic user interface = a janelinha)
Opt("GUICloseOnESC", 0)
Opt("TrayMenuMode", 1)
Opt("TrayOnEventMode", 1)


; ## 3 ##. Declara Variaveis
;    '---> 3.1 prog
Dim $var = WinList()
Dim $tamanho = 0
Dim $ii = 0
Dim $Pos = 0
Dim $Textoo = "aaaa"

;    '---> 3.2 gui
Dim $estado = 0



; '---> 3.1 prog
; '---> 3.2 gui

; 4. Define atalhos
;HotKeySet("{F1}", "Sobre_GUI")
HotKeySet("{F9}", "Rei_prog1")
;HotKeySet("{ESC}", "Minimize_GUI")


; 5. Cria a GUI
GUICreate("Reinaldo [F9] aaa CAD", 350, 70)
Opt("GUICoordMode", 2)
$Button_1 = GUICtrlCreateButton("Apagar agora", 10, 30, 100)
$Button_2 = GUICtrlCreateButton("Minimizar", 0, -1)
$label_1 = GUICtrlCreateLabel($estado, 0, -1)
$label_2 = GUICtrlCreateLabel(" m�sicas apagadas", 0, -1)
GUISetState(@SW_HIDE)
GUISetState(@SW_MINIMIZE)


; 7. Define o tray menu
$Abrir_tray = TrayCreateItem("Abrir")
TrayItemSetOnEvent(-1, "Abrir_GUI")
$Sobre_tray = TrayCreateItem("Sobre")
TrayItemSetOnEvent(-1, "Sobre_GUI")
TrayCreateItem("")
$Sair_tray = TrayCreateItem("Sair")
TrayItemSetOnEvent(-1, "Sair_GUI")
TraySetState()


; 8. Come�a LOOP
While 1
	$msg = GUIGetMsg()
	Select
		Case $msg = $GUI_EVENT_CLOSE
			ExitLoop
		Case $msg = $GUI_EVENT_MINIMIZE
			Minimize_GUI()
		Case $msg = $Button_1
			Rei_prog1()
		Case $msg = $Button_2
			Minimize_GUI()

	EndSelect

WEnd

; 9. Fun��es
; '---> 3.1 prog
Func Visivel($handle)
	If BitAND(WinGetState($handle), 2) Then
		Return 1
	Else
		Return 0
	EndIf
EndFunc   ;==>Visivel

Func Rei_prog1()
$hfoobar = Rei_prog("aaaaaa")
;MsgBox(0, "Details", "handle=" & $hfoobar)
WinActivate($hfoobar, "")
;Send("{LCTRL}G")
;Send("{LALT}F")
;Send("!F")
;Send("{LCTRL}g")
Send("{LALT}f")
Send("g")
sleep (9000)
;Send("{TAB}")
$hfoobar = Rei_prog("Salvar como")
WinWait($hfoobar)
WinActivate($hfoobar, "")
Send("{LALT}l")
MsgBox(0, "Details", "handle=" & $hfoobar)
EndFunc


Func Rei_prog($Text)
	;     **** prog ****
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

	;_ArrayDisplay( $parte1, "parte1" )
	;_ArrayDisplay( $parte2, "parte2" )

	$Pos = _ArraySearch($parte1, $Text, 0, 0, 0, True)
	$handle = $parte2[$Pos]

	;MsgBox(0, "Details", "handle=" & $handle)

	; titulo da janela ativa
	$ativa = WinGetTitle("ACTIVE", "")
	$hfoobar = _WinAPI_GetWindowText($handle)
	Return $hfoobar
	;MsgBox(0, "Details", "handle=" & $hfoobar)
	;ControlSend($hfoobar, "", "[CLASS:{4B94B650-C2D8-40de-A0AD-E8FADF62D56C}; INSTANCE:3]", "^d")
	;Sleep (1000)
	;ControlSend("Confirm File Delete", "", "", "!s")
	;ControlSend($hfoobar, "", "[CLASS:{4B94B650-C2D8-40de-A0AD-E8FADF62D56C}; INSTANCE:3]", "v")
	;WinActivate($ativa, "")
EndFunc   ;==>Rei_prog



; '---> 3.2 gui
Func Sobre_GUI()
	MsgBox(64, "Sobre...", " apaga musica foobar (Reinaldo)")
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
