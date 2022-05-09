
#region --- AutoIt Macro Generator V 0.21 beta ---
Opt("WinTitleMatchMode", 4)
WinWait("MDownloader","Dowload")
ControlClick("MDownloader","Dowload","WindowsForms10.SysListView32.app.0.2e0c6812")
ControlClick("MDownloader","Dowload","WindowsForms10.SysListView32.app.0.2e0c6812","Right")
WinWait("classname=WindowsForms10.Window.20808.app.0.2e0c681","")
ControlClick("classname=WindowsForms10.Window.20808.app.0.2e0c681","","WindowsForms10.Window.20808.app.0.2e0c6810")
WinWait("MDownloader","Dowload")
ControlClick("MDownloader","Dowload","WindowsForms10.SysListView32.app.0.2e0c6812")
ControlClick("MDownloader","Dowload","WindowsForms10.SysListView32.app.0.2e0c6812","Right")
WinWait("classname=WindowsForms10.Window.20808.app.0.2e0c681","")
ControlClick("classname=WindowsForms10.Window.20808.app.0.2e0c681","","WindowsForms10.Window.20808.app.0.2e0c6810")
ControlClick("classname=WindowsForms10.Window.20808.app.0.2e0c681","","WindowsForms10.Window.20808.app.0.2e0c6810")
WinWait("Iniciar","")
ControlClick("Iniciar","","Button0")
WinWait("Menu Iniciar","Controle da Árvore de Namespac")
$CLVItem = ControlListView("Menu Iniciar","Controle da Árvore de Namespac","SysListView321","FindItem","Bloco de Notas")
ControlListView("Menu Iniciar","Controle da Árvore de Namespac","SysListView321","SelectClear")
ControlListView("Menu Iniciar","Controle da Árvore de Namespac","SysListView321","Select",$CLVItem)
WinWait("Sem título - Bloco de notas","")
ControlClick("Sem título - Bloco de notas","","Edit1","Right")
ControlClick("Sem título - Bloco de notas","","Edit1","Right")
ControlClick("Sem título - Bloco de notas","","Edit1")
ControlClick("Sem título - Bloco de notas","","Edit1")
#endregion --- End ---

;packages
#include <GuiConstants.au3>
#include <Array.au3>
#Include <WinAPI.au3>
#Include <GuiToolBar.au3>

;Winlist generat a 2 dimensions array  title = array[n][0]     handle = array[n][1]
;var 1
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
Dim $Text = "MDownloader"

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

;sendind commands to foobar window
; + is shift
; ! is alt
;see in second line i know the title of the window will be show
;when we delete file, i can made a code if he let a empty
;folder and show another windows with title "Notice"
;but a dont makeit, if you want send code to especific
;point use the autoit window info and input value like
;this => ControlSend($hfoobar, "", value, "+D")
;the autoit is very easy to learn just press F1
;else you can find in google autoit_1_2_3
;is a good tutorial
; ControlSend($hfoobar, "", "", "+D")
; ControlSend("Confirm File Delete", "", "", "!s")
; WinActivate($ativa, "")
WinActivate($hfoobar, "")
ControlSend($hfoobar, "", "", "{UP}")
;MsgBox(0, "Details", "handle="  & $handle)
;MsgBox(0, "Details", "hfoobar=" & $hfoobar)

Dim $hok = 0
Dim $tok = 0
Dim $tcancel = 0
ControlGetText ( "title", "text", controlID )

$hok = ControlGetHandle ( $hfoobar , "" , "[CLASSNN:ThunderRT6CommandButton1]")
While $tok = 0
	Sleep ( 1000 )
    $tok = ControlCommand( $hfoobar , "" , "[CLASSNN:ThunderRT6CommandButton1]","IsEnabled", "")
	$texto1 = ControlGetText ( $hfoobar , "", "[CLASSNN:WindowsForms10.SysListView32.app.0.2e0c6812]" )

$file = FileOpen("test11.txt", 1)

; Check if file opened for writing OK
If $file = -1 Then
    MsgBox(0, "Error", "Unable to open file.")
    Exit
EndIf

FileWrite($file, "Line1")
FileWrite($file, "Still Line1" & @CRLF)
FileWrite($file, "Line2")

FileClose($file)



WEnd

SoundSetWaveVolume(50)
SoundPlay( "C:\BACKUP\reinaldo\Brasil_sil_sil.mp3",1)

Exit



