; 1. Includes
#include <GuiConstants.au3>
#include <String.au3>
#include <Array.au3>
#Include <WinAPI.au3>


; 2. Autoit Options
Opt("GUICloseOnESC", 0)
Opt("TrayMenuMode", 1)
Opt("TrayOnEventMode", 1)


; 3. Declara Variaveis
Dim $Tempo	= 5*60000


; 4. Define atalhos
HotKeySet("{F1}", "Sobre_GUI")
HotKeySet("{ESC}", "Minimize_GUI")


; 5. Cria a GUI
GUICreate("gServer ]IvI![^ @ 201.12.99.177", 350, 70)
Opt("GUICoordMode", 2)
$Button_1 = GUICtrlCreateButton("Iniciar Servidor", 10, 30, 100)
$Button_2 = GUICtrlCreateButton("Re-Iniciar Servidor", 0, -1)
$Button_3 = GUICtrlCreateButton("Parar Servidor", 0, -1)
GUISetState(@SW_HIDE)
GUISetState(@SW_MINIMIZE)


; 7. Define o tray menu
$Abrir_tray = 	TrayCreateItem("Abrir")
				TrayItemSetOnEvent(-1, "Abrir_GUI")
$Tempo_tray	= 	TrayCreateMenu("Tempo")
	$tempo01min	= 	TrayCreateItem("5 minuto",   $Tempo_tray)
					TrayItemSetOnEvent(-1, "Tempo5")
	$tempo05min	= 	TrayCreateItem("10 minutos",  $Tempo_tray)
					TrayItemSetOnEvent(-1, "Tempo10")
	$tempo10min	= 	TrayCreateItem("20 minutos", $Tempo_tray)
					TrayItemSetOnEvent(-1, "Tempo20")
$Sobre_tray = 	TrayCreateItem("Sobre")
				TrayItemSetOnEvent(-1, "Sobre_GUI")
TrayCreateItem("")
$Sair_tray = 	TrayCreateItem("Sair")
				TrayItemSetOnEvent(-1, "Sair_GUI")
TraySetState()


; 8. Começa LOOP
Inicio()
While 1
	Sleep($Tempo)			
	Verificar()
	$msg = GUIGetMsg()
	Select
		Case $msg = $GUI_EVENT_CLOSE
			ExitLoop
		Case $msg = $GUI_EVENT_MINIMIZE
			Minimize_GUI()
		Case $msg = $Button_1
			Iniciar_server()
		Case $msg = $Button_2
			Reiniciar_server()
		Case $msg = $Button_3
			Parar_server()
			
	EndSelect
	
WEnd

; 9. Funções
Func Sobre_GUI()
	MsgBox(64, "Sobre...", " Chacal Script ")
EndFunc   ;==>Sobre_GUI

Func Abrir_GUI()
	GUISetState(@SW_SHOW)
	GUISetState(@SW_RESTORE)
EndFunc   ;==>Abrir_GUI

Func Minimize_GUI()
	GUISetState(@SW_HIDE)
	GUISetState(@SW_MINIMIZE)
EndFunc   ;==>Minimize_GUI

Func Iniciar_server()
	Run('D:\jogos\aa283\System\runserver.bat')
	
	ProgressOn("Inicializando Servidor...201.12.99.177", "]IvIacacos !nsanos[^", "0 %")
	For $Button_1 = 1 To 100 Step 5
		Sleep(1000) ; wait time.
		ProgressSet($Button_1, $Button_2 & " %") ; set the progress meter to the variable $i.
	Next
	ProgressSet(100, "100%", "Completo") ; when the loop is complete, set the progress meter to 100 percent.
	Sleep(500) ; wait a half of a second.
	ProgressOff() ; close the progress meter.
EndFunc   ;==>Iniciar_server


Func Reiniciar_server()
	WinClose("d:\jogos\aa283\System\Server.exe")
	
	ProgressOn("Re-Iniciando Servidor...201.12.99.177", "]IvIacacos !nsanos[^", "0 %")
	For $Button_2 = 1 To 100 Step 5
		Sleep(1000) ; wait time.
		ProgressSet($Button_2, $Button_2 & " %") ; set the progress meter to the variable $i.
	Next
	ProgressSet(100, "100%", "Completo") ; when the loop is complete, set the progress meter to 100 percent.
	Sleep(500) ; wait a half of a second.
	ProgressOff() ; close the progress meter.
EndFunc   ;==>Reiniciar_server


Func Parar_server()
	WinClose("C:\WINDOWS\system32\cmd.exe")
	WinClose("d:\jogos\aa283\System\Server.exe")
	
	ProgressOn("Parando Servidor... 201.12.99.177", "]IvIacacos !nsanos[^", "0 %")
	For $Button_1 = 1 To 100 Step 20
		Sleep(1000) ; wait time.
		ProgressSet($Button_3, $Button_3 & " %") ; set the progress meter to the variable $i.
	Next
	ProgressSet(100, "100%", "Completo") ; when the loop is complete, set the progress meter to 100 percent.
	Sleep(500) ; wait a half of a second.
	ProgressOff() ; close the progress meter.
EndFunc   ;==>Parar_server


Func Sair_GUI()
	Exit
EndFunc   

Func Visivel($handle)
	If BitAND(WinGetState($handle), 2) Then
		Return 1
	Else
		Return 0
	EndIf
EndFunc   

Func Tempo5()
	$Tempo = 5*60000
EndFunc

Func Tempo10()
	$Tempo = 10*60000
EndFunc

Func Tempo20()
	$Tempo = 20*60000
EndFunc

Func Verificar()
	
	Dim $var = WinList()
	Dim $tamanho = 0
	Dim $ii = 0
	Dim $Pos = 0
	Dim $Tpara = "PARA - Microsoft Internet Explorer"
	Dim $Treinicia = "REINICIA - Microsoft Internet Explorer"
	Dim $Tinicia = "INICIA - Microsoft Internet Explorer"

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


	$Pos = _ArraySearch($parte1, $Tpara, 0, 0, 0, False)
  	If $Pos <> -1 Then
		$handle = $parte2[$Pos]
		$hie = _WinAPI_GetWindowText($handle)
		ControlSend($hie,"", "[CLASSNN:Internet Explorer_Server1]" , "{F5}" )
		Parar_server()
	Else
		
		$Pos = _ArraySearch($parte1, $Treinicia, 0, 0, 0, False)
		If $Pos <> -1 Then
			$handle = $parte2[$Pos]
			$hie = _WinAPI_GetWindowText($handle)
			ControlSend($hie,"", "[CLASSNN:Internet Explorer_Server1]" , "{F5}" )
			Reiniciar_server()
		Else

			$Pos = _ArraySearch($parte1, $Tinicia, 0, 0, 0, False)
			If $Pos <> -1 Then
				$handle = $parte2[$Pos]
				$hie = _WinAPI_GetWindowText($handle)
				ControlSend($hie,"", "[CLASSNN:Internet Explorer_Server1]" , "{F5}" )
				Iniciar_server()
			Else
				Inicio()
EndIf
EndIf
EndIf
EndFunc   

Func Inicio()
Run("C:\Arquivo de Programas\Internet Explorer\IEXPLORE.EXE")

	Dim $var = WinList()
	Dim $tamanho = 0
	Dim $ii = 0
	Dim $Pos = 0
	Dim $Tie = "Microsoft Internet"

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

	$Pos = _ArraySearch($parte1, $Tie, 0, 0, 0, True)

	If $Pos <> -1 Then
		$handle = $parte2[$Pos]
		$hfoobar = _WinAPI_GetWindowText($handle)
		WinWait($Tie)
		ControlSetText($hfoobar, "","Edit2", "http://www.macacosinsanos.com/gServer/" )
		ControlSend($hfoobar,"","Edit2", @CR )
		WinSetState( "","", @SW_MINIMIZE )
		Else
	EndIf
EndFunc


