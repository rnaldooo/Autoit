#include <GUIConstants.au3>

;cria as estruturas que guardam o estado dos joysticks
local $JOYID1 = 0 , $JOYID2 = 1
local $JOYINFO1, $JOYINFO2
local $s1, $s2, $s3, $s4, $ss1, $ss2, $ss3, $ss4, $x1, $x2, $y1, $y2
local $bt_joy1, $bt_joy2

$str = "int x;int y;int z;int buttons"
$JOYINFO1 = DllStructCreate($str)

$JOYINFO2 = DllStructCreate($str)

While 1
$retjoy1=DllCall("winmm.dll", "int", "joyGetPos", "int", $JOYID1, "ptr", DllStructGetPtr($JOYINFO1))
$retjoy2=DllCall("winmm.dll", "int", "joyGetPos", "int", $JOYID2, "ptr", DllStructGetPtr($JOYINFO2))

;pega os valores preenchidos pela função JoyGetPos
$bt_joy1=DllStructGetData($JOYINFO1,"buttons")
$bt_joy2=DllStructGetData($JOYINFO2,"buttons")
$x1=DllStructGetData($JOYINFO1,"x")
$x2=DllStructGetData($JOYINFO2,"x")
$y1=DllStructGetData($JOYINFO1,"y")
$y2=DllStructGetData($JOYINFO2,"y")
$JOYNOERROR=" "

if $retjoy1[0] = $JOYNOERROR Then ExitLoop

;testa o estado dos botoes joy1
If BitAND($bt_joy1, 1) Then send(" teste1 ");botão 1
If BitAND($bt_joy1, 2) Then send(" ");botão 2
If BitAND($bt_joy1, 4) Then send(" ");botão 3
If BitAND($bt_joy1, 8) Then send(" ");botão 4
If BitAND($bt_joy1, 16) Then send(" ");botão 5
If BitAND($bt_joy1, 32) Then send(" ");botão 6
If BitAND($bt_joy1, 64) Then send(" ");botão 7
If BitAND($bt_joy1,128) Then send(" ");botão 8
If BitAND($bt_joy1,256) Then send(" ");botão 9
If BitAND($bt_joy1,512) Then send(" ");botão 10
;If BitAND($bt_joy1,1024) Then send(" ");botão 11
;If BitAND($bt_joy1,2048) Then send(" ");botão 12

if $retjoy2[0] = $JOYNOERROR Then ExitLoop
;açiona os botoes joy2
If BitAND($bt_joy2, 1) Then send(" teste2 ");botão 1
If BitAND($bt_joy2, 2) Then send(" ");botão 2
If BitAND($bt_joy2, 4) Then send(" ");botão 3
If BitAND($bt_joy2, 8) Then send(" ");botão 4
If BitAND($bt_joy2, 16) Then send(" ");botão 5
If BitAND($bt_joy2, 32) Then send(" ");botão 6
If BitAND($bt_joy2, 64) Then send(" ");botão 7
If BitAND($bt_joy2,128) Then send(" ");botão 8
If BitAND($bt_joy2,256) Then send(" ");botão 9
If BitAND($bt_joy2,512) Then send(" ");botão 10
;If BitAND($bt_joy2,1024) Then send(" ");botão 11
;If BitAND($bt_joy2,2048) Then send(" ");botão 12
EndIf
;sai se o botão1 + botão1 forem pressionados juntos, se tirar o exiloop pode colocar o que quiser tipo send("5").
If BitAND($bt_joy1, 1) And BitAND($bt_joy2, 1) Then ExitLoop

;Aqui define o tempo entre um pulso e outro
$msg = GUIGetMsg()
If $msg = $GUI_EVENT_CLOSE Then ExitLoop
Sleep(100); se tirar esta linha o pulso fica mais rápido
Wend

;libera a memoria alocada pelas estruturas
$JOYINFO1 =0
$JOYINFO2 =0
Exit(0) 