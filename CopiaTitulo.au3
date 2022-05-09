#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Version=beta
#AutoIt3Wrapper_icon=icon.ico
#AutoIt3Wrapper_outfile=CopiaTitulo.exe
#AutoIt3Wrapper_UseAnsi=y
#AutoIt3Wrapper_Res_Comment=reinaldo Rox
#AutoIt3Wrapper_Res_Description=aperte F9 no sap2000
#AutoIt3Wrapper_Res_Fileversion=1.0.0.3
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=y
#AutoIt3Wrapper_Add_Constants=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
; *** Start added by AutoIt3Wrapper ***
#include <GUIConstantsEx.au3>
; *** End added by AutoIt3Wrapper ***
; ## 1 ##. Pacotes
;    '---> 1.1 prog
#include <String.au3>
#include <Array.au3>
#include <WinAPI.au3>
;    '---> 1.2 gui
#include <GuiConstants.au3>

; ## 2 ##. Autoit Opções
;    '---> 2.1 prog
AutoItSetOption("WinTitleMatchMode", 4)
;    '---> 2.2 gui (grafic user interface = a janelinha)
Opt("GUICloseOnESC", 0)
Opt("TrayMenuMode", 1)
Opt("TrayOnEventMode", 1)
Opt("WinTitleMatchMode", 4)


; ## 3 ##. Declara Variaveis
;    '---> 3.1 prog
Dim $var = WinList()
Dim $tamanho = 0
Dim $ii = 0
Dim $Pos = 0
Dim $Text = "SAP2000 v14.2.0"

;    '---> 3.2 gui
Dim $estado = 0
Dim $valorr = 0

; pega o handle


; '---> 3.1 prog
; '---> 3.2 gui

; 4. Define atalhos
;HotKeySet("{F1}", "Sobre_GUI")
HotKeySet("{F9}", "Rei_prog")
;HotKeySet("{ESC}", "Minimize_GUI")


; 5. Cria a GUI
GUICreate("Texto no sap2000", 300, 150, 400, 400)
Opt("GUICoordMode", 2)
$Button_1 = GUICtrlCreateButton("Atualizar agora", -1, -1, 300, 20)
$Button_2 = GUICtrlCreateButton("Minimizar", -1, 5, 300, 20)
$label_2 = GUICtrlCreateLabel("titulo da janela1", -1, 5, 300, 20)
$label_1 = GUICtrlCreateLabel($estado, -1, 5, 300, 20)
$label_3 = GUICtrlCreateLabel("titulo da janela2", -1, 5, 300, 20)
$label_4 = GUICtrlCreateLabel($valorr, -1, 5, 300, 20)
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


; 8. Começa LOOP
While 1
	$msg = GUIGetMsg()
	Select
		Case $msg = $GUI_EVENT_CLOSE
			ExitLoop
		Case $msg = $GUI_EVENT_MINIMIZE
			Minimize_GUI()
		Case $msg = $Button_1
			Rei_prog()
		Case $msg = $Button_2
			Minimize_GUI()

	EndSelect

WEnd

; 9. Funções
; '---> 3.1 prog
Func Visivel($handle)
	If BitAND(WinGetState($handle), 2) Then
		Return 1
	Else
		Return 0
	EndIf
EndFunc   ;==>Visivel

Func Rei_prog()
	$var = WinList()
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
	$valorr = $handle
	$Stitulo = $parte1[$Pos]
	;MsgBox(0, "Details", "handle=" & $handle)
	;MsgBox(0, "Details", "titulo=" & $Stitulo)
	$Sarquivo = StringTrimLeft($Stitulo, 28)
	;MsgBox(0, "Details", "arquivo=" & $Sarquivo)

	$texto = WinGetText($Stitulo, "")
	;MsgBox(0, "Details", "t2=" & $texto)
	$texto = StringTrimRight($texto, StringLen($texto) - StringInStr($texto, ")"))
	;MsgBox(0, "Details", "t2=" & $texto)
	$texto = StringTrimLeft($texto, 1)
	$texto = $Sarquivo & " -" & $texto
	;MsgBox(0, "Details", "titulo=" & $texto)
	ClipPut($texto)
	GUICtrlSetData($label_1, $texto)
	WinActivate($handle, "")
	Send("{LALT}f")
	Send("g")
	WinWait("Save PDF File As", "")
	If Not WinActive("Save PDF File As", "") Then WinActivate("Save PDF File As", "")
	WinWaitActive("Save PDF File As", "")
	;GUICtrlSetData("[CLASS:Edit; INSTANCE:1]",$texto)
	;Send("{TAB}")
	;Send("{TAB}")
	;Send("{TAB}")
	;Send("{TAB}")
	Send($texto)
	;Send("{ENTER}")

	;     **** prog ****
	; titulo da janela ativa
	; $ativa = WinGetTitle("ACTIVE", "")
	; $hfoobar = _WinAPI_GetWindowText($handle)
	; WinSetState($hfoobar , "", @SW_RESTORE )
	; MsgBox(0, "Details", "handle=" & $handle)
	; ControlSend($hfoobar, "", "[CLASS:{4B94B650-C2D8-40de-A0AD-E8FADF62D56C}; INSTANCE:3]", "^d")
	; Sleep (1000)
	; ControlSend("Confirm File Delete", "", "", "!s")
	; ControlSend($hfoobar, "", "[CLASS:{4B94B650-C2D8-40de-A0AD-E8FADF62D56C}; INSTANCE:3]", "v")
	; WinActivate($ativa, "")

	; $estado = 1 + $estado
	; GUICtrlSetData($label_1, $estado)
EndFunc   ;==>Rei_prog

; '---> 3.2 gui
Func Sobre_GUI()
	MsgBox(64, "Sobre...", " texto sap2000 (Reinaldo)")
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