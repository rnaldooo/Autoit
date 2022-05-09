#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <ListViewConstants.au3>
#include <TabConstants.au3>
#include <TreeViewConstants.au3>
#include <WindowsConstants.au3>
Opt("GUIOnEventMode", 1)
HotKeySet("{TAB}","focus")
#Region ### START Koda GUI section ### Form=Form1.kxf
$Form1 = GUICreate("Form1", 301, 284, 240, 142)
GUISetOnEvent($GUI_EVENT_CLOSE, "Form1Close")
$Tab1 = GUICtrlCreateTab(24, 24, 249, 225)
GUICtrlSetResizing($Tab1, $GUI_DOCKWIDTH+$GUI_DOCKHEIGHT)
GUICtrlSetState($tab1,$gui_focus)
$TabSheet1 = GUICtrlCreateTabItem("TabSheet1")
$TreeView1 = GUICtrlCreateTreeView(40, 64, 209, 129, -1, $WS_EX_CLIENTEDGE)

GUICtrlCreateTreeViewItem("1", $TreeView1)

GUICtrlCreateTreeViewItem("2", $TreeView1)

$Input1 = GUICtrlCreateInput("Input1", 40, 208, 121, 21)
$Button1 = GUICtrlCreateButton("Button1", 176, 208, 75, 25, $WS_GROUP)
$TabSheet2 = GUICtrlCreateTabItem("TabSheet2")
$ListView1 = GUICtrlCreateListView("a|b|c", 48, 72, 201, 121)
GUICtrlCreateListViewItem("1|2|3", $ListView1)
GUICtrlSetState(-1,$gui_focus)
GUICtrlCreateListViewItem("3|2|1", $ListView1)
$Checkbox1 = GUICtrlCreateCheckbox("Checkbox1", 48, 208, 97, 17)
$Button2 = GUICtrlCreateButton("Button2", 176, 208, 75, 25, $WS_GROUP)
GUICtrlCreateTabItem("")

GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###
While 1
    Sleep(100)
WEnd
Func Form1Close()
Exit
EndFunc
 

 Func focus()
     
     Select 
    Case ControlGetFocus ( "Form1" , "")="SysTabControl321"
         GUICtrlSetState($treeview1,$gui_focus)
    Case ControlGetFocus ( "Form1" , "")="SysTreeview321" 
         GUICtrlSetState($input1,$gui_focus)
    Case ControlGetFocus ( "Form1" , "")="Edit1" 
         GUICtrlSetState($button1,$gui_focus)
     Case ControlGetFocus ( "Form1" , "")="Button1" 
         GUICtrlSetState($tab1,$gui_focus)
     EndSelect
EndFunc  
     
     
 
 