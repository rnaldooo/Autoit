#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.15.0 (Beta)
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
; Press Esc to terminate script

;~ #include <Array.au3>
;~ #include <File.au3>
;~ #include <MsgBoxConstants.au3>



Global $aponto =True
HotKeySet("{NUMPADDOT}", "ponto")
HotKeySet("+{ESC}", "Termina")
$aa=10000

While 1
    Sleep($aa)
;~      ToolTip("c",500,500)
;~ 	TrayTip ( "Message from the future", "Charlie é bobao", 4 ,  2 )
WEnd

Func ponto()
;~     $aponto = NOT $aponto
;~     While $aponto
;~         ToolTip("Sending...",0,0)
		Send("{DEL}")
        Send(".")
;~     WEnd
EndFunc

Func Termina()
    Exit 0
EndFunc