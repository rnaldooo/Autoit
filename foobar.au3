;packages
#include <GuiConstants.au3>
#include <Array.au3>
#Include <WinAPI.au3>
#Include <GuiToolBar.au3>


#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>





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

;WinActivate($hfoobar, "")

;MsgBox(0, "Details", "handle="  & $handle)
;MsgBox(0, "Details", "hfoobar=" & $hfoobar)

Dim $hok = 0
Dim $tok = 0
Dim $tcancel = 0

#Region ### START Koda GUI section ### Form=
$Form1 = GUICreate("Form1", 223, 141, 192, 124)
;  $bwo = GUICtrlCreateButton("wo", 88, 16, 33, 17)
;$bwf = GUICtrlCreateButton("wf", 88, 40, 33, 17)
;  $bao = GUICtrlCreateButton("ao", 24, 72, 33, 17)
;$baf = GUICtrlCreateButton("af", 24, 96, 33, 17)
;$bdo = GUICtrlCreateButton("do", 160, 72, 41, 17)
;$bdf = GUICtrlCreateButton("df", 160, 96, 41, 17)
;$bso = GUICtrlCreateButton("so", 88, 72, 33, 17)
;$bsf = GUICtrlCreateButton("sf", 88, 96, 33, 17)
$bsair = GUICtrlCreateButton("sair", 176, 16, 33, 17)
;  $brando = GUICtrlCreateButton("ron", 176, 40, 33, 17)
;$brandf = GUICtrlCreateButton("roff", 176, 60, 33, 17)
$Checkbox1 = GUICtrlCreateCheckbox("andar", 150, 72, 81, 25)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###
$alea = 0

;$hok = ControlGetHandle ( $hfoobar , "" , "[CLASSNN:ThunderRT6CommandButton1]")
While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $bsair
			Exit
		;Case $bwo
       ;            ControlSend($handle , "", $sclassnn, "{w 6}")
		;		   MsgBox(0, "Details", GUICtrlRead($Checkbox1) )
				  ; MsgBox(0, "Details", "w")
		;Case $bwf
         ;          ControlSend($handle, "", "", "{w up}")
		;Case $bao
     ;              ControlSend($Text, "", $sclassnn, "{a 6}")
		;Case $baf
        ;           ControlSend($handle, "", "", "{a up}")
		;Case $bdo
        ;           ControlSend($handle, "", "", "{d down}")
		;Case $bdf
        ;           ControlSend($hfoobar, "", "", "{d up}")
		;Case $bso
        ;           ControlSend($hfoobar, "", "", "{s down}")
	    ;Case $bsf
        ;           ControlSend($hfoobar, "", "", "{s up}")
	;	Case $brando
				 $alea = 1
				; MsgBox(0, "Details", GUICtrlRead($Checkbox1) )
	;			 GUICtrlSetState($Checkbox1, 1)
		;Case $brandf
		;		 $alea = 0
		;		 GUICtrlSetState($Checkbox1, 4)
				; MsgBox(0, "Details", GUICtrlRead($Checkbox1) )
	EndSwitch

	$ichar = Random(1, 4, 1)
	Switch $ichar
		Case $ichar =1
		$schar = "w"
		Case $ichar =2
		$schar = "a"
		Case $ichar =3
		$schar = "d"
		Case $ichar =4
		$schar = "s"
	EndSwitch

	$temp = 0
	$ipassos = Random(1, 10, 1)

	if GUICtrlRead($Checkbox1) = 1 Then
		;ControlSend("BlueStacks App Player" , "", "[CLASSNN:WindowsForms10.Window.8.app.0.3296db7_r14_ad11]", "{"& $schar &" " & $ipassos&"}")
		for $tt=1 to 6
		;GUICtrlSetData($Checkbox1, GUICtrlRead($Checkbox1))
		if (GUICtrlRead($Checkbox1) = 4) then	ExitLoop
		ControlSend($Text, "", $sclassnn, "{w 6}")
		Sleep(3000)
		if (GUICtrlRead($Checkbox1) = 4) then	ExitLoop
		Next

		for $tt=1 to 6
		GUICtrlSetData($Checkbox1, GUICtrlRead($Checkbox1))
		if (GUICtrlRead($Checkbox1) = 4) then	ExitLoop
		ControlSend($Text, "", $sclassnn, "{s 6}")
		Sleep(3000)
		GUICtrlSetData($Checkbox1, GUICtrlRead($Checkbox1))
		if (GUICtrlRead($Checkbox1) = 4) then	ExitLoop
		Next
	Else
		EndIf

WEnd

;SoundSetWaveVolume(50)
;SoundPlay( "C:\BACKUP\reinaldo\Brasil_sil_sil.mp3",1)

Exit








