#Include <WinAPI.au3>
AutoItSetOption("WinTitleMatchMode", 4)

;rode o outro para pegar o handlee
$handle = "0x00080102"
; titulo da janela ativa
$ativa = WinGetTitle("ACTIVE", "")
$hfoobar = _WinAPI_GetWindowText($handle)

ControlSend($hfoobar, "", 124, "+D")
ControlSend("Confirm File Delete", "", "", "!s")
ControlSend($hfoobar, "", "", "v")
WinActivate($ativa, "")

Exit
