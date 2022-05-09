#NoTrayIcon

;calculator = 35745 & 31639 & 26426

#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=32Calc.ico
#AutoIt3Wrapper_Outfile=Calc.exe
#AutoIt3Wrapper_Res_Comment=Isaac Flaum
#AutoIt3Wrapper_Res_Description=Calculator: by Isaac Flaum
#AutoIt3Wrapper_Res_LegalCopyright=Isaac Flaum
#AutoIt3Wrapper_Res_Language=1033
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <guiconstants.au3>
#include <EditConstants.au3>
#include <ButtonConstants.au3>
#include <WindowsConstants.au3>
;calculator created by isaac flaum

Opt("GUIResizeMode", $GUI_DOCKALL)
$calc = GUICreate("Calc", 105, 130)
GUICtrlSetResizing($calc, $GUI_DOCKMENUBAR)
WinMove("Calc", "", Default, Default, 150, 220)

Dim $i = 0
Dim $j = 0

$menu = GUICtrlCreateMenu("Menu")
$copy = GUICtrlCreateMenuItem("Copy", $menu)
$paste = GUICtrlCreateMenuItem("Paste", $menu)
$exit = GUICtrlCreateMenuItem("Exit", $menu)
$about = GUICtrlCreateMenuItem("About", $menu)
$edit = GUICtrlCreateMenu("Edit")
$advanced = GUICtrlCreateMenuItem("Advanced", $edit)
$simple = GUICtrlCreateMenuItem("Simple", $edit)
$language = GUICtrlCreateMenu("Language")
$english = GUICtrlCreateMenuItem("English", $language)
$mandarin = GUICtrlCreateMenuItem("Mandarin", $language)
$input = GUICtrlCreateInput("", 5, 5, 135, 20, $ES_READONLY)

Global $button[10]
$button[7] = GUICtrlCreateButton("7", 5, 30, 30, 30, $BS_FLAT)
$button[8] = GUICtrlCreateButton("8", 40, 30, 30, 30, $BS_FLAT)
$button[9] = GUICtrlCreateButton("9", 75, 30, 30, 30, $BS_FLAT)
$button[4] = GUICtrlCreateButton("4", 5, 65, 30, 30, $BS_FLAT)
$button[5] = GUICtrlCreateButton("5", 40, 65, 30, 30, $BS_FLAT)
$button[6] = GUICtrlCreateButton("6", 75, 65, 30, 30, $BS_FLAT)
$button[1] = GUICtrlCreateButton("1", 5, 100, 30, 30, $BS_FLAT)
$button[2] = GUICtrlCreateButton("2", 40, 100, 30, 30, $BS_FLAT)
$button[3] = GUICtrlCreateButton("3", 75, 100, 30, 30, $BS_FLAT)
$button[0] = GUICtrlCreateButton("0", 40, 135, 30, 30, $BS_FLAT)
$equals = GUICtrlCreateButton("=", 5, 135, 30, 30, $BS_FLAT)

$clear = GUICtrlCreateButton("C", 75, 135, 30, 30, $BS_FLAT)
$divide = GUICtrlCreateButton("/", 110, 30, 30, 30, $BS_FLAT)
$multiply = GUICtrlCreateButton("x", 110, 65, 30, 30, $BS_FLAT)
$plus = GUICtrlCreateButton("+", 110, 100, 30, 30, $BS_FLAT)
$minus = GUICtrlCreateButton("-", 110, 135, 30, 30, $BS_FLAT)
$operation = -1 ;0 = plus, 1 = minus, 2 = times, 3 = divide, 4 = nothing

;set the background button color!
GUICtrlSetBkColor($input, 0xFFF8DC)
GUICtrlSetBkColor($button[9], 0x5a6a50)
GUICtrlSetBkColor($button[8], 0x5a6a50)
GUICtrlSetBkColor($button[7], 0x5a6a50)
GUICtrlSetBkColor($button[6], 0x5a6a50)
GUICtrlSetBkColor($button[5], 0x5a6a50)
GUICtrlSetBkColor($button[4], 0x5a6a50)
GUICtrlSetBkColor($button[3], 0x5a6a50)
GUICtrlSetBkColor($button[2], 0x5a6a50)
GUICtrlSetBkColor($button[1], 0x5a6a50)
GUICtrlSetBkColor($button[0], 0x5a6a50)
GUICtrlSetBkColor($equals, 0x5a6a50)
GUICtrlSetBkColor($clear, 0x5a6a50)
GUICtrlSetBkColor($divide, 0x5a6a50)
GUICtrlSetBkColor($multiply, 0x5a6a50)
GUICtrlSetBkColor($plus, 0x5a6a50)
GUICtrlSetBkColor($minus, 0x5a6a50)


;creating the advanced buttons



GUICtrlSetBkColor($sin, 0x5a6a50)
GUICtrlSetBkColor($cos, 0x5a6a50)
GUICtrlSetBkColor($tan, 0x5a6a50)
GUICtrlSetBkColor($sqrt, 0x5a6a50)
GUICtrlSetState($sin, $GUI_HIDE)
GUICtrlSetState($cos, $GUI_HIDE)
GUICtrlSetState($tan, $GUI_HIDE)
GUICtrlSetState($sqrt, $GUI_HIDE)

GUISetBkColor(0x494e48)

GUISetState(@SW_SHOW)
GUICtrlSetState($simple, $GUI_CHECKED)
GUICtrlSetState($english, $GUI_CHECKED)

Do
    Local $msg = GUIGetMsg()
    If ($msg = -3) Then
        $i = 1
    EndIf
    Select
        Case ($msg = $button[0])
            If $j = 1 Then
                GUICtrlSetData($input, "")
            EndIf
            $pnum = GUICtrlRead($input)
            GUICtrlSetData($input, $pnum & "0")
            $j = 0
        Case ($msg = $copy)
            $pnum = GUICtrlRead($input)
            ClipPut($pnum)
        Case ($msg = $paste)
            $data = ClipGet()
            GUICtrlSetData($input, $data)
        Case ($msg = $button[1])
            If $j = 1 Then
                GUICtrlSetData($input, "")
            EndIf
            $pnum = GUICtrlRead($input)
            GUICtrlSetData($input, $pnum & "1")
            $j = 0
        Case ($msg = $button[2])
            If $j = 1 Then
                GUICtrlSetData($input, "")
            EndIf
            $pnum = GUICtrlRead($input)
            GUICtrlSetData($input, $pnum & "2")
            $j = 0
        Case ($msg = $button[3])
            If $j = 1 Then
                GUICtrlSetData($input, "")
            EndIf
            $pnum = GUICtrlRead($input)
            GUICtrlSetData($input, $pnum & "3")
            $j = 0
        Case ($msg = $button[4])
            If $j = 1 Then
                GUICtrlSetData($input, "")
            EndIf
            $pnum = GUICtrlRead($input)
            GUICtrlSetData($input, $pnum & "4")
            $j = 0
        Case ($msg = $button[5])
            If $j = 1 Then
                GUICtrlSetData($input, "")
            EndIf
            $pnum = GUICtrlRead($input)
            GUICtrlSetData($input, $pnum & "5")
            $j = 0
        Case ($msg = $button[6])
            If $j = 1 Then
                GUICtrlSetData($input, "")
            EndIf
            $pnum = GUICtrlRead($input)
            GUICtrlSetData($input, $pnum & "6")
            $j = 0
        Case ($msg = $button[7])
            If $j = 1 Then
                GUICtrlSetData($input, "")
            EndIf
            $pnum = GUICtrlRead($input)
            GUICtrlSetData($input, $pnum & "7")
            $j = 0
        Case ($msg = $button[8])
            If $j = 1 Then
                GUICtrlSetData($input, "")
            EndIf
            $pnum = GUICtrlRead($input)
            GUICtrlSetData($input, $pnum & "8")
            $j = 0
        Case ($msg = $button[9])
            If $j = 1 Then
                GUICtrlSetData($input, "")
            EndIf
            $pnum = GUICtrlRead($input)
            GUICtrlSetData($input, $pnum & "9")
            $j = 0
        Case ($msg = $plus)
            $num1 = GUICtrlRead($input)
            $operation = 0
            $j = 1
        Case ($msg = $minus)
            $num1 = GUICtrlRead($input)
            $operation = 1
            $j = 1
        Case ($msg = $multiply)
            $num1 = GUICtrlRead($input)
            $operation = 2
            $j = 1
        Case ($msg = $divide)
            $num1 = GUICtrlRead($input)
            $operation = 3
            $j = 1
        Case ($msg = $equals)
            $j = 0
            If $operation = 0 Then
                _add()
            ElseIf $operation = 1 Then
                _subtract()
            ElseIf $operation = 2 Then
                _multiply()
            ElseIf $operation = 3 Then
                _divide()
            Else
                MsgBox(0, "Error", "No Operation Was Selected", 5)
            EndIf
        Case ($msg = $clear)
            $num1 = 0
            $num2 = 0
            GUICtrlSetData($input, "")
        Case ($msg = $exit)
            $i = 1
        Case ($msg = $about)
            MsgBox(0, "Calc", "This calculator was created by Isaac Flaum using Autoit as an efficent, good looking calculator.", 10)
        Case ($msg = $advanced)
            GUICtrlSetState($advanced, $GUI_CHECKED)
            GUICtrlSetState($simple, $GUI_UNCHECKED)
            $num1 = GUICtrlRead($input)
            GUICtrlDelete($input)
            WinMove("Calc", "", Default, Default, 185, 220)
            Dim $input = GUICtrlCreateInput($num1, 5, 5, 168, 20)
            GUICtrlSetState($sin, $GUI_SHOW)
            GUICtrlSetState($cos, $GUI_SHOW)
            GUICtrlSetState($tan, $GUI_SHOW)
            GUICtrlSetState($sqrt, $GUI_SHOW)
        Case ($msg = $simple)
            GUICtrlSetState($simple, $GUI_CHECKED)
            GUICtrlSetState($advanced, $GUI_UNCHECKED)
            $num1 = GUICtrlRead($input)
            WinMove("Calc", "", Default, Default, 150, 220)
            GUICtrlDelete($input)
            GUICtrlSetState($sin, $GUI_HIDE)
            GUICtrlSetState($cos, $GUI_HIDE)
            GUICtrlSetState($tan, $GUI_HIDE)
            GUICtrlSetState($sqrt, $GUI_HIDE)
            Dim $input = GUICtrlCreateInput($num1, 5, 5, 135, 20, $ES_READONLY)
        Case ($msg = $mandarin)
            GUICtrlSetState($english, $GUI_UNCHECKED)
            GUICtrlSetState($mandarin, $GUI_CHECKED)
            GUICtrlSetData($button[0], ChrW(38646))
            GUICtrlSetData($button[1], ChrW(19968))
            GUICtrlSetData($button[2], ChrW(20108))
            GUICtrlSetData($button[3], ChrW(19977))
            GUICtrlSetData($button[4], ChrW(22235))
            GUICtrlSetData($button[5], ChrW(20116))
            GUICtrlSetData($button[6], ChrW(20845))
            GUICtrlSetData($button[7], ChrW(19971))
            GUICtrlSetData($button[8], ChrW(20843))
            GUICtrlSetData($button[9], ChrW(20061))
        Case ($msg = $english)
            GUICtrlSetState($english, $GUI_CHECKED)
            GUICtrlSetState($mandarin, $GUI_UNCHECKED)
            GUICtrlSetData($button[0], "0")
            GUICtrlSetData($button[1], "1")
            GUICtrlSetData($button[2], "2")
            GUICtrlSetData($button[3], "3")
            GUICtrlSetData($button[4], "4")
            GUICtrlSetData($button[5], "5")
            GUICtrlSetData($button[6], "6")
            GUICtrlSetData($button[7], "7")
            GUICtrlSetData($button[8], "8")
            GUICtrlSetData($button[9], "9")
        Case ($msg = $sin)
            $num1 = GUICtrlRead($input)
            _sine()
        Case ($msg = $cos)
            $num1 = GUICtrlRead($input)
            _cosine()
        Case ($msg = $tan)
            $num1 = GUICtrlRead($input)
            _tangent()
        Case ($msg = $sqrt)
            $num1 = GUICtrlRead($input)
            _sqrt()
    EndSelect

Until $i = 1

Func _add()
    $num2 = GUICtrlRead($input)
    $final = $num1 + $num2
    GUICtrlSetData($input, $final)
EndFunc   ;==>_add

Func _subtract()
    $num2 = GUICtrlRead($input)
    $final = $num1 - $num2
    GUICtrlSetData($input, $final)
EndFunc   ;==>_subtract

Func _multiply()
    $num2 = GUICtrlRead($input)
    $final = ($num1 * $num2)
    GUICtrlSetData($input, $final)
EndFunc   ;==>_multiply

Func _divide()
    $num2 = GUICtrlRead($input)
    $final = ($num1 / $num2)
    GUICtrlSetData($input, $final)
EndFunc   ;==>_divide

Func _sine()
    $final = Sin($num1)
    GUICtrlSetData($input, $final)
EndFunc   ;==>_sine

Func _cosine()
    $final = Cos($num1)
    GUICtrlSetData($input, $final)
EndFunc   ;==>_cosine

Func _tangent()
    $final = Tan($num1)
    GUICtrlSetData($input, $final)
EndFunc   ;==>_tangent

Func _sqrt()
    $final = Sqrt($num1)
    GUICtrlSetData($input, $final)
EndFunc   ;==>_sqrt

