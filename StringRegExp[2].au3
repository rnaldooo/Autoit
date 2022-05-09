#include <MsgBoxConstants.au3>
#include <StringConstants.au3>

Local $aArray = StringRegExp('{asf{bbbb} dfer dsf{re{er}}fds {htr{tr{hgfdh}}}}', '(?=(\{([^{}]+| (?<n>\{)| (?<-n>\}))+(?(n)(?!))\}))', $STR_REGEXPARRAYMATCH)
ConsoleWrite($aArray)
;_ArrayDisplay($aArray, "alertas")
;ConsoleWrite($aArray[0])
For $i = 0 To UBound($aArray) - 1
	MsgBox($MB_SYSTEMMODAL, "RegExp Test with Option 2 - " & $i, $aArray[$i])
Next
