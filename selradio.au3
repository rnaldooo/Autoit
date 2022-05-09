#include <ButtonConstants.au3>
#include <ButtonConstants.au3>
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <StatusBarConstants.au3>
#include <TabConstants.au3>
#include <WindowsConstants.au3>
#include <array.au3>
#include <GuiListView.au3>
#include <file.au3>
#include <GuiTab.au3>
#include <IE.au3>


Func SelectServer()
$TOOLS = GUICreate("UnManaged Servers GUI", 532, 420, -1, -1)

$PL3 = GUICtrlCreateLabel("Expitation Date MM/DD/YYYY", 8, 328, 75, 34)
$CLO = GUICtrlCreateInput("", 8, 368, 75, 21)
GUICtrlSetFont(-1, 6, 400, 0, "MS Sans Serif")

$PL4 = GUICtrlCreateLabel("Your User Name:", 8, 8, 140, 17)
$Usrnm = GUICtrlCreateInput("", 150, 6, 157, 21)
GUICtrlSetFont(-1, 6, 400, 0, "MS Sans Serif")

$PL5 = GUICtrlCreateLabel("Your Password:", 8, 35, 124, 17)
$Pw = GUICtrlCreateInput("", 150, 35, 157, 21, $ES_PASSWORD)
GUICtrlSetFont(-1, 6, 400, 0, "MS Sans Serif")
$USN = '/user:"' & GUICtrlRead($Usrnm)
$PAS = '/password:"' & GUICtrlRead($Pw)

; GROUP WITH RADIO BUTTONS

Local $radio1, $radio2, $radio3, $radio4, $nMsg
GuiCtrlCreateGroup("Servers", 35, 85, 230, 150)
$radio1 = GuiCtrlCreateRadio("Server1", 40, 105, 220)
$radio2 = GuiCtrlCreateRadio("Server2", 40, 130, 220)
$radio3 = GuiCtrlCreateRadio("Server3", 40, 155, 220)
$radio4 = GuiCtrlCreateRadio("Server4", 40, 180, 220)
GUICtrlSetState($radio1, $GUI_CHECKED)
GUISetState()
While 1
$nMsg = GUIGetMsg()
Switch $nMsg
Case $GUI_EVENT_CLOSE
ExitLoop
IF $radio1 And BitAND(GUICtrlRead($radio1), $GUI_CHECKED) = $GUI_CHECKED Then
$SRV = $SRV1
ElseIf $SRV = $radio2 And BitAND(GUICtrlRead($radio2), $GUI_CHECKED) = $GUI_CHECKED
$SRV = $SRV2
ElseIf $SRV = $radio3 And BitAND(GUICtrlRead($radio3), $GUI_CHECKED) = $GUI_CHECKED
$SRV = $SRV3
ElseIf $SRV = $radio4 And BitAND(GUICtrlRead($radio4), $GUI_CHECKED) = $GUI_CHECKED
$SRV = $SRV4
EndIf
WEnd ElseIf

EndFunc ;==>Load
WEnd
EndFunc ;==>Example

;load pc list from text file
Func Load($list1)
$file1 = FileOpen("Users.lst", 0)
If $file1 = -1 Then
MsgBox(0, 'Error', 'Unable To open file')
EndIf
While 2
$FRPCL2 = FileReadLine($file1)
If @error = -1 Then ExitLoop
_GUICtrlListView_AddItem($List1, $FRPCL2)
WEnd
EndFunc ;==>Load

$Load = GUICtrlCreateButton("Load", 476, 54, 41, 25, 0)
$List1 = GUICtrlCreateListView("", 290, 85, 200, 200, BitOR($LVS_SHOWSELALWAYS, $LVS_NOSORTHEADER, $LVS_REPORT, $WS_VSCROLL))
_GUICtrlListView_InsertColumn($List1, 0, "Available Users", 200)
_GUICtrlListView_SetExtendedListViewStyle($List1, BitOR($LVS_EX_GRIDLINES, $LVS_EX_FULLROWSELECT))


$EX = GUICtrlCreateButton("Execute", 445, 328, 75, 25, 0)
GUICtrlSetState(-1, $GUI_DROPACCEPTED)
GUISetState(@SW_SHOW)


$FL = @ComSpec & ' /c wmic /node:' & $SRV & ' "' & $USN & ' (pass is not logged)' & ' process call create ' & ' "' & 'cmd.exe /c net user' & _GUICtrlListView_GetItemText(GUICtrlGetHandle($list), $item)& '/expires:'$CLO '"'
_FileWriteLog(@TempDir & '\wmic.log')
RunWait(@ComSpec & ' /c wmic /node:' & $SRV & ' "' & $USN & ' "' & $PAS & '" ' & ' process call create ' & & ' "' & 'cmd.exe /c net user' & _GUICtrlListView_GetItemText(GUICtrlGetHandle($list), $item)& '/expires:'$CLO '"')
Next
;EndIf
;asks if the user would like to execute
If 6 = MsgBox(4, 'Finished', 'Completed Task, do you want to exit?') Then
Exit
Else

EndIf
WEnd
EndSwitch
WEnd 