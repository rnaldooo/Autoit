$strFolderName = "Netwerkverbindingen" 
; Virtual folder containing icons for the Control Panel applications. (value = 3)    
Const $ssfCONTROLS = 3    
$ShellApp = ObjCreate("Shell.Application") 
$oControlPanel = $ShellApp.Namespace($ssfCONTROLS) 
; Find 'Network connections' control panel item    
$oNetConnections = ""    
For $FolderItem In $oControlPanel.Items     
    If $FolderItem.Name = $strFolderName Then    
	$oNetConnections = $FolderItem.GetFolder      
	ExitLoop    
EndIf  
Next      
local $i = 0   
local $adaper[100]   
For $oNetConnections In $oNetConnections.Items      
	$i = $i + 1    
	$adaper[$i] = $oNetConnections.name   
Next       
MsgBox(0, "", $adaper[1] & @cr & $adaper[2] & @cr & $adaper[3])