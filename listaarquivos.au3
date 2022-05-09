#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <ListViewConstants.au3>
#include <TreeViewConstants.au3>
#include <WindowsConstants.au3>
#include <File.au3>
#include <Array.au3>
#include <GUIListBox.au3>
#include <Constants.au3>
#include <StaticConstants.au3>
#Include <GuiStatusBar.au3>


;Opt('MustDeclareVars', 1)
;$Debug_LB = False ; Check ClassName being passed to ListBox functions, set to True and use a handle to another control to see it work

$Pasta = ""
Local $aText[2] = ["Diretório", $Pasta]
Local $aParts[2] = [50, -1]
$ligtextos = chr(10)
$selecao = 1


#Region ### START Koda GUI section ### Form=
$Form1 = GUICreate("Copia lista para clipboard", 625, 445, 193, 125)
;$TreeView1 = GUICtrlCreateTreeView(16, 24, 161, 377)
;$generalitem = GUICtrlCreateTreeView(32, 16, 137, 209)
;$ListView1 = GUICtrlCreateListView("", 200, 24, 137, 385)
$Edit1 = GUICtrlCreateList("", 16, 24, 193, 345)
$StatusBar1 = _GUICtrlStatusBar_Create ($Form1, $aParts, $aText)
GUICtrlSetData(-1, "")
$Button1 = GUICtrlCreateButton("Pasta", 16, 384, 97, 33, 0)
$Button2 = GUICtrlCreateButton("Limpa", 384, 384, 97, 33, 0)

$Input1 = GUICtrlCreateInput($ligtextos, 432, 88, 121, 21)
$Label1 = GUICtrlCreateLabel("separador", 300, 88, 100, 17)
$Button3 = GUICtrlCreateButton("chr(13)", 448, 152, 81, 25, 0)
$Button4 = GUICtrlCreateButton("chr(10)", 448, 192, 81, 25, 0)
$Button5 = GUICtrlCreateButton("usar meu", 448, 232, 81, 25, 0)
$Label2 = GUICtrlCreateLabel( GUICtrlRead($Input1), 448, 270, 100, 25)

GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

While 1
	$nMsg = GUIGetMsg()
	Select
		Case $nMsg = $Button1
			_listar()
		Case $nMsg = $Button2
			_limpa()
		Case $nMsg = $Button3
			$selecao = 1
		Case $nMsg = $Button4
			$selecao = 2
		Case $nMsg = $Button5
			$selecao = 3
			GUICtrlSetData($Label2, GUICtrlRead($Input1))
		Case $nMsg = $GUI_EVENT_CLOSE
			ExitLoop

	EndSelect
WEnd



Func _listar()
	; escolhe pasta
	$Pasta = FileSelectFolder("Selecione a pasta...", "")

	; lista arquivos para matriz
	$ListaArquivos = _FileListToArray($Pasta)
	If @error = 1 Then
		MsgBox(0, "", "Nenhuma Pasta encontrada.")
		Exit
	EndIf
	;_ArrayDisplay($ListaArquivos, "$ListaArquivos")

	; matriz para string

	$listatexto1 = _ArrayToString($ListaArquivos, "|")
	Select
		Case $selecao = 1
			$listatexto2 = _ArrayToString($ListaArquivos, chr(10))
		Case $selecao = 2
			$listatexto2 = _ArrayToString($ListaArquivos, chr(13))
		Case $selecao = 3
			$listatexto2 = _ArrayToString($ListaArquivos, GUICtrlRead($Input1))
	EndSelect
	ClipPut($listatexto2)

	;MsgBox(0, "_ArrayToString() getting $avArray items 1 to 7", _ArrayToString($ListaArquivos, "|"))
	GUICtrlSetData($Edit1, $listatexto1)
	_GUICtrlStatusBar_SetText($StatusBar1, $Pasta,1)


EndFunc   ;==>_listar

Func _limpa()
	$Pasta = ""
	$ListaArquivos = ""
	$listatexto1 = ""
	$listatexto2 = ""
	GUICtrlSetData($Edit1, $listatexto1)
	_GUICtrlStatusBar_SetText($StatusBar1, $Pasta,1)
EndFunc

