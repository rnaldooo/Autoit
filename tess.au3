; AutoIt 3.0.103 example
; 17 Jan 2005 - CyberSlug
; demonstration version - Valuater
; This script shows manual positioning of all controls;
;   there are much better methods of positioning...
#include <GuiConstants.au3>

; Create the GUI.
GuiCreate("Sample GUI", 400, 400) 
GuiSetIcon(@SystemDir & "\mspaint.exe", 0) ; set the icon for the GUI from the microsoft paint program.


; Create a MENU Control. 
GuiCtrlCreateMenu("Menu&One") ; create a menu at the upper portion of the GUI.
GuiCtrlCreateMenu("Menu&Two") ; this type of menu may have a drop-down list.
GuiCtrlCreateMenu("MenuTh&ree")
GuiCtrlCreateMenu("Menu&Four")

; Create a CONTEXT MENU Control.
$contextMenu = GuiCtrlCreateContextMenu() ; this is a Right Click menu.
GuiCtrlCreateMenuItem("Context Menu", $contextMenu) ; create a sub-catagory.
GuiCtrlCreateMenuItem("", $contextMenu) ;separator for the sub-catagories.
GuiCtrlCreateMenuItem("&Properties", $contextMenu)

; Create a MESSAGE BOX.
; MsgBox(262208,"*NOTE*","Be sure to *Right Click* the GUI to see the pop-up context Menu.    ", 10)


; Create a COMBO or COMBOBOX Control.
GuiCtrlCreatecombo("Sample Combo", 250, 80, 120, 100) ; set the default as "Sample Combo".

; Create an EDIT Control.
GuiCtrlCreateEdit(@CRLF & "  Sample Edit Control", 10, 110, 150, 70) ; CRLF means, Carrage Return & Line Feed.

; Create a LIST Control.
GuiCtrlCreateList("", 5, 190, 100, 90)
GuiCtrlSetData(-1, "a.Sample|b.List|c.Control|d.Here", "b.List") ; set the data in the list with "b.List" as the default.

; Create a LIST VIEW Control.
$listView = GuiCtrlCreateListView("Sample|ListView|", 110, 190, 110, 80)
GuiCtrlCreateListViewItem("A|One", $listView) ; sets the list view items.
GuiCtrlCreateListViewItem("B|Two", $listView)
GuiCtrlCreateListViewItem("C|Three", $listView)

; Create a LABEL Control.
GuiCtrlCreateLabel("Green" & @CRLF & "Label", 350, 165, 40, 40)
GuiCtrlSetBkColor(-1, 0x00FF00) ; sets the controls back-ground color.

; Create an INPUT Control.
GuiCtrlCreateInput("Sample Input Box", 235, 255, 130, 20)

; Creates a BUTTON Control.
GuiCtrlCreateButton("Sample Button", 10, 330, 100, 30)

; set the GUI as visible.
GuiSetState()
While GuiGetMsg() <> $GUI_EVENT_CLOSE ; loop until the message recieved is equal to event close.
WEnd