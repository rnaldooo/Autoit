#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#Region ### START Koda GUI section ### Form=
Global $Form1_1 = GUICreate("Protensão no modelo", 755, 114, 304, 487)
Global $Input1 = GUICtrlCreateInput("3", 8, 8, 81, 21, BitOR($ES_RIGHT,$ES_AUTOHSCROLL))
Global $Label1 = GUICtrlCreateLabel("Cordoalhas", 96, 16, 57, 17)
Global $Input2 = GUICtrlCreateInput("0.00014", 168, 8, 97, 21, BitOR($ES_RIGHT,$ES_AUTOHSCROLL))
Global $Label2 = GUICtrlCreateLabel("m² a cada", 272, 16, 51, 17)
Global $Input3 = GUICtrlCreateInput("0.9", 328, 8, 81, 21, BitOR($ES_RIGHT,$ES_AUTOHSCROLL))
Global $Label3 = GUICtrlCreateLabel("m  Força de", 416, 16, 60, 17)
Global $Input4 = GUICtrlCreateInput("14", 480, 8, 97, 21, BitOR($ES_RIGHT,$ES_AUTOHSCROLL))
Global $Label4 = GUICtrlCreateLabel("tf", 584, 16, 10, 17)
Global $Input5 = GUICtrlCreateInput("1.5", 40, 40, 65, 21, BitOR($ES_RIGHT,$ES_AUTOHSCROLL))
Global $Label5 = GUICtrlCreateLabel("Para", 8, 48, 26, 17)
Global $Label6 = GUICtrlCreateLabel("m", 112, 48, 12, 17)
Global $Button1 = GUICtrlCreateButton("Calcula", 160, 40, 73, 25, $WS_GROUP)
Global $tbEspaco = GUICtrlCreateInput("tbEspaco", 8, 80, 121, 21)
Global $tbCordoalha = GUICtrlCreateInput("tbCordoalha", 152, 80, 97, 21)
Global $Label7 = GUICtrlCreateLabel("x", 136, 88, 9, 17)
Global $Label8 = GUICtrlCreateLabel("de", 256, 88, 16, 17)
Global $tbArea = GUICtrlCreateInput("tbArea", 296, 80, 129, 21)
Global $Label9 = GUICtrlCreateLabel("com Força de", 440, 88, 69, 17)
Global $tbForca = GUICtrlCreateInput("tbForca", 520, 80, 153, 21)
Global $Label10 = GUICtrlCreateLabel("tf", 696, 88, 10, 17)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###


While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
Case $Button1
			Calc1()

	EndSwitch
WEnd

Func Calc1()
	GUICtrlSetData($tbEspaco, guictrlread($Input5)/guictrlread($Input3))
	GUICtrlSetData($tbCordoalha,guictrlread($Input1))
	GUICtrlSetData($tbArea,guictrlread($tbEspaco)*guictrlread($Input1)*guictrlread($Input2))
	GUICtrlSetData($tbForca,guictrlread($tbArea)*guictrlread($Input4)/0.0001)
	EndFunc