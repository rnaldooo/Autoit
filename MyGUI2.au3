;pacotes
#include <GuiConstants.au3>
#include <Array.au3>

;variáveis
Dim $var = WinList()
dim $tamanho = 0

;funções
Func IsVisible($handle)
  If BitAnd( WinGetState($handle), 2 ) Then 
    Return 1
  Else
    Return 0
  EndIf

EndFunc

;código
For $i = 1 to $var[0][0]
  If $var[$i][0] <> "" AND IsVisible($var[$i][1]) Then
$tamanho = $tamanho + 1 
  EndIf
Next
;MsgBox(0, "Details", "Tamanho=" & $tamanho)

Dim $ii = 0
Dim $parte1[$tamanho]
Dim $parte2[$tamanho]

For $i = 1 to $var[0][0]
  If $var[$i][0] <> "" AND IsVisible($var[$i][1]) Then
 $parte1[$ii] = $var[$i][0]
 $parte2[$ii] = $var[$i][1]
 $ii= $ii+1
  EndIf
Next

;_ArrayDisplay( $parte1, "parte1" )
;_ArrayDisplay( $parte2, "parte2" )


; 2. Autoit Options
Opt("GUICloseOnESC", 1)         
;1 = ESC  closes script, 0 = ESC won't close.
opt("TrayMenuMode", 1)   
; Default tray menu items (Script Paused/Exit) will not be shown.
opt("TrayOnEventMode", 1)
;TraySetClick (16); right click




Dim $sArrayString = _ArrayToString( $parte1,",", 1, 7 )
GuiCreate("MyGUI", 392, 316,(@DesktopWidth-392)/2, (@DesktopHeight-316)/2 , $WS_OVERLAPPEDWINDOW + $WS_VISIBLE + $WS_CLIPSIBLINGS)


$Combo_1 = GuiCtrlCreateCombo($parte1[0], 20, 30, 270, 21)
$Label_2 = GuiCtrlCreateLabel("", 30, 130, 200, 20)
$Button_3 = GuiCtrlCreateButton("pegar handle", 20, 70, 160, 30)
$Input_4 = GuiCtrlCreateInput("", 30, 200, 200, 20)


Dim $x = 0
Dim $Pos = 0
For $x = 1 to $tamanho - 1
	GUICtrlSetData( $Combo_1, $parte1[$x])
Next



GuiSetState()

While 1
	$message = GUIGetMsg()
	
	If $message = $GUI_EVENT_CLOSE Then Set_Exit()
	
	If $message = $Button_3 Then
		$Text = GUICtrlRead( $Combo_1 )
		GUICtrlSetData( $Label_2 , $Text)
		$Pos = _ArraySearch ($parte1, $Text, 0, 0, 0, True)
		GUICtrlSetData( $Input_4 , $parte2[$Pos])
		ClipPut ( $parte2[$Pos] )
	EndIf

WEnd

; 8. Set the tray menu
	$About_tray = TrayCreateItem ("About Weather")
	TrayItemSetOnEvent (-1, "About_GUI")
	TrayCreateItem ("")
	$exit_tray = TrayCreateItem ("Exit Weather")
	TrayItemSetOnEvent (-1, "Set_Exit")
	
	TraySetState ()



Func About_GUI()
	MsgBox(64, "Welcome!", " this is your Weather Service      ")
EndFunc	

Func Set_Exit()
	;MsgBox(0,"","Good-Bye!",1)
	Exit
EndFunc

; 4. Set Hot Keys
HotKeySet("{F1}", "About_GUI")
; when F1 is pressed, goto function "About_GUI".




 ;   MsgBox(0, "Details", "Title=" & $var[$i][0] & @LF & "Handle=" & $var[$i][1])

;Dim $sArrayString = _ArrayToString( $avArray,@TAB, 1, 7 )
;MsgBox( 4096, "_ArrayToString() Test", $sArrayString )
;Exit

; Ex. #2:
;#include <Array.au3>
;_ArrayDisplay($avArray, "_ArrayDisplay() 2D Test", 1, 1) ; [2D, transposed]


;Dim $sArrayString2 = _ArrayToString( $avArray[0][0],",", 1, 7 )

;
;While 1
;	$msg = GuiGetMsg()
;	Select
;	Case $msg = $GUI_EVENT_CLOSE
;		ExitLoop
;	Case Else
;		;;;
;	EndSelect
;WEnd



;Dim $avArray = Winlist()
;Dim $I = 0
;Dim $tam = UBound( $avArray )
;Dim $parte1[$tam]
;Dim $parte2[$tam]

;_ArrayDisplay( $avArray, "inicio" )

; Populate test array.
;For $I = 0 to UBound( $avArray ) - 1
;	$parte1[$I] = $avArray[$I][0] 
;Next

; Populate test array.
;For $I = 0 to UBound( $avArray ) - 1
;	$parte2[$I] = $avArray[$I][1] 
; Next

; _ArrayDisplay( $parte1, "parte1" )
; _ArrayDisplay( $parte2, "parte2" )

;MsgBox( 4096, "" , $sArrayString2 )


; 



Exit