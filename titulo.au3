#include <WinAPI.au3>
#Include <GuiMenu.au3>
#Include <GuiEdit.au3>
#Include <Constants.au3>
#Include <Array.au3>

Opt("WinTitleMatchMode", 4)
$handle = 0x000D0E34
$texto = WinGetText("[TITLE:"& _WinAPI_GetWindowText($handle) &"; [CLASS:MDIClient; INSTANCE:1]", "") 
MsgBox(0, "Details", "t2=" & $texto)

$Sarquivo = _WinAPI_GetWindowText($handle)
MsgBox(0, "Details", "t2=" & $Sarquivo)
_ArrayDisplay($texto, "df")
$result = StringInStr($texto, ")")
MsgBox(0, "Search result:", $result)
$Tamtexto = StringLen($texto)
$texto = StringTrimRight($texto, $Tamtexto-$result)

$texto = WinGetTitle("Ssffs14","")
MsgBox(0, "Details", "t2=" & $texto)
$texto = WinGetText("SAPsfd4","")
MsgBox(0, "Details", "t2=" & $texto)
MsgBox(0, "Details", "t2=" & $texto)
