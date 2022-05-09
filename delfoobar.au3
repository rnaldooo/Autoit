#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=icon.ico
#AutoIt3Wrapper_Outfile=delfoobar.exe
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
; ## 1 ##. Pacotes
;    '---> 1.1 prog
#include <String.au3>
#include <Array.au3>
#include <WinAPI.au3>
;    '---> 1.2 gui
#include <GuiConstants.au3>
#Include <GuiToolBar.au3>
#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>


; ## 2 ##. Autoit Opções
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


;function
Func IsVisible($handle)
  If BitAnd( WinGetState($handle), 2 ) Then
    Return 1
  Else
    Return 0
  EndIf
EndFunc
;for define dimension of array (dimension=tamanho in portuguese)
;only the windows open is gona be count
;code 1
For $i = 1 to $var[0][0]
  If $var[$i][0] <> "" AND IsVisible($var[$i][1]) Then
$tamanho = $tamanho + 1
  EndIf
Next

;now we gonna create 2 array with dimension found up here
;var 2
Dim $ii = 0
Dim $parte1[$tamanho]
Dim $parte2[$tamanho]

;we gona split the 2dimension array in 2 array with 1 dimension
;code 2
For $i = 1 to $var[0][0]
  If $var[$i][0] <> "" AND IsVisible($var[$i][1]) Then
 $parte1[$ii] = $var[$i][0]
 $parte2[$ii] = $var[$i][1]
 $ii= $ii+1
  EndIf
Next

;if you wanna see the array remove the point comma
;_ArrayDisplay( $parte1, "parte1" )
;_ArrayDisplay( $parte2, "parte2" )

;var 3
Dim $Pos = 0
Dim $Text = "BlueStacks App Player"
dim $sclassnn = "WindowsForms10.Window.8.app.0.1bb715_r14_ad11"

;now we gona search te word foobar2000 in titles array and will
;be give the respective position in matriz, and we pick the handle
;code 3
$Pos = _ArraySearch ($parte1, $Text, 0, 0, 0, True)
$handle = $parte2[$Pos]
;to see handle remove point comma
;MsgBox(0, "Details", "handle=" & $handle)

;is need toh run wingettitle with ACTIVE option
AutoItSetOption("WinTitleMatchMode", 4)
;active windows
$ativa = WinGetTitle("ACTIVE", "")
$hfoobar = _WinAPI_GetWindowText($handle)
;MsgBox(0, "Details", "handle=" & $hfoobar)


$handle = $hfoobar
$valorr = $handle
;MsgBox(0, "Details", "handle=" & $handle)


; '---> 3.1 prog
; '---> 3.2 gui

; 4. Define atalhos
;HotKeySet("{F1}", "Sobre_GUI")
HotKeySet("{F9}", "Rei_prog")
;HotKeySet("{ESC}", "Minimize_GUI")


; 5. Cria a GUI
GUICreate("Reinaldo [F9] apaga musica foobar", 100, 150, 400, 400)
Opt("GUICoordMode", 2)
$Button_1 = GUICtrlCreateButton("Apagar agora", -1, -1, 100, 20)
$Button_2 = GUICtrlCreateButton("Minimizar", -1, 5, 100, 20)
$label_2 = GUICtrlCreateLabel(" músicas apagadas", -1, 5, 100, 20)
$label_1 = GUICtrlCreateLabel($estado, -1, 5, 100, 20)
$label_3 = GUICtrlCreateLabel(" handle", -1, 5, 100, 20)
$label_4 = GUICtrlCreateLabel($valorr, -1, 5, 100, 20)
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
	;     **** prog ****
	; titulo da janela ativa
	$ativa = WinGetTitle("ACTIVE", "")
	$hfoobar = _WinAPI_GetWindowText($handle)
	WinSetState($hfoobar, "", @SW_RESTORE)
	;MsgBox(0, "Details", "handle=" & $handle)
	ControlSend($hfoobar, "", "[CLASS:{4B94B650-C2D8-40de-A0AD-E8FADF62D56C}; INSTANCE:1]", "^d")
	Sleep(1000)
	ControlSend("Confirm File Delete", "", "", "!s")
	ControlSend($hfoobar, "", "[CLASS:{4B94B650-C2D8-40de-A0AD-E8FADF62D56C}; INSTANCE:1]", "v")
	WinActivate($ativa, "")

	$estado = 1 + $estado
	GUICtrlSetData($label_1, $estado)
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