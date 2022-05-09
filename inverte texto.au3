Dim $texto = ClipGet()
Dim $texto2 = ""
$len = StringLen($texto)
For $i = $len To 1 Step -1
	$texto2 = $texto2 & StringMid($texto, $i, 1)
Next

; MsgBox(0, "texto", "link=" & $texto2)
ClipPut($texto2)