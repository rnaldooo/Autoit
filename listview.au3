#AutoIt3Wrapper_au3check_parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#include <WindowsConstants.au3>
#include <GuiConstantsEx.au3>
#include <GuiListView.au3>
#include <GuiImageList.au3>




$Debug_LV = False ; Check ClassName being passed to ListView functions, set to True and use a handle to another control to see it work



; Create GUI
GUICreate("ListView Set Extended Style", 400, 300)
$ListView = GUICtrlCreateListView("", 2, 2, 394, 268);, BitOR($LVS_REPORT, $LVS_SHOWSELALWAYS), BitOR($LVS_EX_HEADERDRAGDROP, $LVS_EX_FULLROWSELECT,$LVS_EX_GRIDLINES,$LVS_EX_DOUBLEBUFFER,$LVS_EX_SUBITEMIMAGES))
$hListView = GUICtrlGetHandle($ListView)
_GUICtrlListView_SetExtendedListViewStyle($hListView, BitOR($LVS_EX_DOUBLEBUFFER, $LVS_EX_SUBITEMIMAGES))
GUIRegisterMsg($WM_NOTIFY, "MY_WM_NOTIFY")
GUISetState()

; Load images
$hImage = _GUIImageList_Create()
_GUIImageList_Add($hImage, _GUICtrlListView_CreateSolidBitMap($ListView, 0xFF0000, 16, 16))
_GUIImageList_Add($hImage, _GUICtrlListView_CreateSolidBitMap($ListView, 0x00FF00, 16, 16))
_GUIImageList_Add($hImage, _GUICtrlListView_CreateSolidBitMap($ListView, 0x0000FF, 16, 16))
_GUICtrlListView_SetImageList($ListView, $hImage, 1)

; Add columns
_GUICtrlListView_InsertColumn($ListView, 0, "Column 1", 100)
_GUICtrlListView_InsertColumn($ListView, 1, "Column 2", 100)
_GUICtrlListView_InsertColumn($ListView, 2, "Column 3", 100)

; Add items
For $i = 0 To 10
    _GUICtrlListView_AddItem($ListView, "Row "&$i&": Col 1", 0)
    _GUICtrlListView_AddSubItem($ListView, $i, "Row "&$i&": Col 2", 1, 1)
    _GUICtrlListView_AddSubItem($ListView, $i, "Row "&$i&": Col 3", 2, 2)
next




; Loop until user exits
Do
Until GUIGetMsg() = $GUI_EVENT_CLOSE

GUIDelete()

 
 
 
 Func MY_WM_NOTIFY($hWnd, $iMsg, $iwParam, $ilParam)
    Local $tNMHDR, $hWndFrom, $iCode
    $tNMHDR = DllStructCreate($tagNMHDR, $ilParam)
    $hWndFrom = DllStructGetData($tNMHDR, "hWndFrom")
    $iCode = DllStructGetData($tNMHDR, "Code")
    
    Switch $hWndFrom
        Case $hListView
            Switch $iCode
                Case $NM_RCLICK
                    
                    $aHit = _GUICtrlListView_SubItemHitTest($hWndFrom)
                    $LVEIP_Item = $aHit[0]
                    $LVEIP_SubItem = $aHit[1]
                    
                    If ($LVEIP_Item <> -1) And ($LVEIP_SubItem = 0) Then
;~                      ConsoleWrite("0 $LVEIP_Item: "&$LVEIP_Item&", $LVEIP_SubItem: "&$LVEIP_SubItem& @CRLF)
                        Local $aPos = _GUICtrlListView_GetItemRect($hWndFrom, $LVEIP_Item, 2)
                    ElseIf ($LVEIP_Item <> -1) And ($LVEIP_SubItem > 0) Then
;~                      ConsoleWrite("1 $LVEIP_Item: "&$LVEIP_Item&", $LVEIP_SubItem: "&$LVEIP_SubItem& @CRLF)
                        Local $aPos = _GUICtrlListView_GetSubItemRect($hWndFrom, $LVEIP_Item, $LVEIP_SubItem) ; does consider dropped items, needs Subitem
                    Else
                        Return $GUI_RUNDEFMSG
                    EndIf


;~                  ConsoleWrite($aPos[0]&","& $aPos[1]&","& $aPos[2] &","& $aPos[3] & @CRLF)
;~                     Local $iX = $aPos[0] + $aRect[0]
;~                     Local $iY = $aPos[1] + $aRect[1] + 1
;~                      $iW = $aPos[0] + $aRect[2] - $iX
;~                      $iH = $aPos[1] + $aRect[3] - $iY
;~                  ConsoleWrite($iX&","& $iY&","& $iW &","& $iH  & @CRLF)
                    $LVEIP_hDC = _WinAPI_GetWindowDC($hWndFrom)
;~                  _WinAPI_SetBkColor($LVEIP_hDC, 0x0000FF)
                    $LVEIP_hBrush = _WinAPI_CreateSolidBrush(0x0000FF)
                    FrameRect($LVEIP_hDC, $aPos[0], $aPos[1],$aPos[2],$aPos[3],$LVEIP_hBrush)
                    _WinAPI_DeleteObject($LVEIP_hBrush)
                    _WinAPI_ReleaseDC($hWndFrom,$LVEIP_hDC)

                Case $NM_CLICK

                    $aHit = _GUICtrlListView_SubItemHitTest($hWndFrom)
                    $LVEIP_Item = $aHit[0]
                    $LVEIP_SubItem = $aHit[1]

                    ConsoleWrite("Leftclick LV: "&$hWndFrom&", $LVEIP_Item: "&$LVEIP_Item&", $LVEIP_SubItem: "&$LVEIP_SubItem& @CRLF)

                    Local $tItem
                    $tItem = DllStructCreate($tagLVITEM)
                    DllStructSetData($tItem, "Mask", $LVIF_STATE)
                    DllStructSetData($tItem, "Item", $LVEIP_Item)
                    DllStructSetData($tItem, "SubItem", $LVEIP_SubItem)
                    DllStructSetData($tItem, "State", $LVIS_SELECTED)
                    DllStructSetData($tItem, "StateMask", $LVIS_SELECTED)
                    _GUICtrlListView_SetItemEx($hWndFrom, $tItem)

                Case $LVN_ITEMCHANGING
                    Return 1 ; prevent LV from selecting through mouseclick

                EndSwitch
    EndSwitch
    Return $GUI_RUNDEFMSG
EndFunc

Func FrameRect($hDC, $nLeft, $nTop, $nRight, $nBottom, $LVEIP_hBrush)
    Local $stRect = DllStructCreate("int;int;int;int")
    DllStructSetData($stRect, 1, $nLeft)
    DllStructSetData($stRect, 2, $nTop)
    DllStructSetData($stRect, 3, $nRight)
    DllStructSetData($stRect, 4, $nBottom)
    DllCall("user32.dll", "int", "FrameRect", "hwnd", $hDC, "ptr", DllStructGetPtr($stRect), "hwnd", $LVEIP_hBrush)
;~  ConsoleWrite("urg:"&$nRight&", "&$nBottom & @CRLF)
EndFunc


