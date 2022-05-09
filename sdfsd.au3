
; Script Format Demonstration.

; 1. Place required include files.
; 2. Set Autoit options, as needed.
; 3. Declare Variables.
; 4. Set Desired Hot Keys.
; 5. Create the GUI.
; 6. Display the GUI.
; 7. Set/Update control information.
; 8. Set the Tray Menu
; 9. Start the Loop, and "Listen" for a message.
; 10. Create the Functions.


; here is an Example


; 1. Includes
#include <GuiConstants.au3>
#include <String.au3>

; 2. Autoit Options
Opt("GUICloseOnESC", 1)         
;1 = ESC  closes script, 0 = ESC won't close.
opt("TrayMenuMode", 1)   
; Default tray menu items (Script Paused/Exit) will not be shown.
opt("TrayOnEventMode", 1)
;TraySetClick (16); right click

; 3. Declare Variables use, Dim, Global or Local.
Dim $Text, $Cloudy = 1
; see help for more info.

; 4. Set Hot Keys
HotKeySet("{F1}", "About_GUI")
; when F1 is pressed, goto function "About_GUI".

; 5. Create the GUI
$Window = GUICreate("My Weather Program")
$combo = GUICtrlCreateCombo("", 120, 50, 150, 20)
$button = GUICtrlCreateButton("Press here for Daily Weather Report", 100, 300, 200, 40)

; 6. Display the GUI
GUISetState()

; 7. Set the control information

; this will split the string called $days, by each comma.
$days = StringSplit("Sunday,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday", ",")
; the return is an array $days[0] is 7, the total
; $days[1] contains "Sunday" ... $days[7] contains "Saturday"

; this will use a for/next loop to set the $combo information with the $days.
For $x = 1 to $days[0]
	GUICtrlSetData( $combo, $days[$x])
Next

; 8. Set the tray menu
	$About_tray = TrayCreateItem ("About Weather")
	TrayItemSetOnEvent (-1, "About_GUI")
	TrayCreateItem ("")
	$exit_tray = TrayCreateItem ("Exit Weather")
	TrayItemSetOnEvent (-1, "Set_Exit")
	
	TraySetState ()

; 9. Start the loop
While 1
	; "Listen" for the message
	$message = GUIGetMsg()
	
	If $message = $GUI_EVENT_CLOSE Then Set_Exit()
	
	If $message = $button Then
		; read the selected day in the combo
		$Text = GUICtrlRead( $combo )
		; call the function with the info
		Day_Function($Text)
	EndIf

WEnd

; 10. Create the Functions 

Func Day_Function($Text)
	If $Text = "" Then Return
	; randomly choose amount of rain
	$rain = Random(5, 100, 1)
	; call another function for clouds
	Cloud_Function()
	If $Cloudy = 1 Then
		$Clouds = "Cloudy"
	Else
		$Clouds = "Clear"
	EndIf
	; show the weather information.
	MsgBox(64, "Your Weather","On " & $Text & " You can expect,   " & @CRLF & $Clouds & " skies in the afternoon and evening   " & @CRLF & _
	"The chance of rain is approximately " & $rain & " percent   ")
EndFunc

Func Cloud_Function()
	If $Cloudy = 1 Then
		$Cloudy = 2
		; leave this function now
		Return
	EndIf
	If $Cloudy = 2 Then
		$Cloudy = 1
		Return
	EndIf
EndFunc

Func About_GUI()
	MsgBox(64, "Welcome!", " this is your Weather Service      ")
EndFunc	

Func Set_Exit()
	MsgBox(0,"","Good-Bye!",1)
	Exit
EndFunc
	
; All of these functions are UDF's, User Defined Functions

; When you have completed a Script use Tidy under "Tools" above to "clean" it up.
; Then make a comment at the top, like this

#cs ===============================================================================
	*AutoIt 1-2-3 	ver 1.0.1 - 02.01.2006
	Autor: 			Valuater
	E-mail:			XPCleanMenu@aol.com
	Language:   	English
	OSystem: 		Windows Xp
	Requirements: 	Legal copy of Microsoft Windows Xp
	Construction: 	AutoIt 3.1.1+, SciTE 1.64
	Features: 		Automated Program, Reads Text, Runs Scripts, etc
	- Use = Tutorials, Help Files, Installers, Presentations, etc
	- ...
	
	Thanks to all, Enjoy...
#ce ===============================================================================