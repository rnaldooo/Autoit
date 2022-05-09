; 1. Includes
#include <GuiConstants.au3>
#include <String.au3>
#include <Array.au3>
#include <WinAPI.au3>


; 2. Autoit Options
Opt("GUICloseOnESC", 0)
Opt("TrayMenuMode", 1)
Opt("TrayOnEventMode", 1)


; 3. Declara Variaveis
Dim $estado = 0


; 4. Define atalhos
HotKeySet("{F1}", "Sobre_GUI")
HotKeySet("{F9}", "liga_desl")
HotKeySet("{ESC}", "Minimize_GUI")


; 5. Cria a GUI
GUICreate("Reinaldo [F9]liga/desliga botão direito", 350, 70)
Opt("GUICoordMode", 2)
$Button_1 = GUICtrlCreateButton("Ativa Botão", 10, 30, 100)
$Button_2 = GUICtrlCreateButton("Desativa Botão", 0, -1)
$Button_3 = GUICtrlCreateButton("Minimizar", 0, -1)
$label_1 = GUICtrlCreateLabel($estado, 0, -1)
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
			ativa_botao()
		Case $msg = $Button_2
			desativa_botao()
		Case $msg = $Button_3
			Minimize_GUI()

	EndSelect

WEnd

; 9. Funções
Func Sobre_GUI()
	MsgBox(64, "Sobre...", " Reinaldo => ativa botão direito ")
EndFunc   ;==>Sobre_GUI

Func Abrir_GUI()
	GUISetState(@SW_SHOW)
	GUISetState(@SW_RESTORE)
EndFunc   ;==>Abrir_GUI

Func Minimize_GUI()
	GUISetState(@SW_HIDE)
	GUISetState(@SW_MINIMIZE)
EndFunc   ;==>Minimize_GUI

Func ativa_botao()
	MouseDown("right")
	$estado = 1
	GUICtrlSetData($label_1, $estado)
EndFunc   ;==>ativa_botao


Func desativa_botao()
	MouseUp("right")
	$estado = 0
	GUICtrlSetData($label_1, $estado)
EndFunc   ;==>desativa_botao

Func Sair_GUI()
	Exit
EndFunc   ;==>Sair_GUI

Func liga_desl()
	If $estado = 0 Then
		MouseDown("right")
		$estado = 1
		GUICtrlSetData($label_1, $estado)
	Else
		MouseUp("right")
		$estado = 0
		GUICtrlSetData($label_1, $estado)
	EndIf

EndFunc   ;==>liga_desl


Func Visivel($handle)
	If BitAND(WinGetState($handle), 2) Then
		Return 1
	Else
		Return 0
	EndIf
EndFunc   ;==>Visivel