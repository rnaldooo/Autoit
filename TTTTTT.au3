
		$data = "Linearized 1/E 55591/L 130401/N 10/O 53/T 129354>>"
		MsgBox(4096, Default, "texto depois:" & @CRLF & $data)
		$result1 = StringInStr($data, "/N")+2
		MsgBox(0, "Search result:", $result1)
		$result2 = StringInStr($data, "/O")
		MsgBox(0, "Search result:", $result2)
		$compr1 = stringlen($data)+1
		$data = StringTrimRight($data,$compr1-$result2)
		MsgBox(0, "Search result:", $data)
		$pags = StringMid($data, $result1, $result2)
		MsgBox(0, "Search result:",$pags)

		;ConsoleWrite($data & @CRLF)
		;$dim1 = StringReplace($data, "MediaBox [0 0 ", "")
		;$dim1 = StringReplace($dim1, "MediaBox[0 0 ", "")
		;MsgBox(4096, Default, "textocortado:" & @CRLF & $dim1)
		$posicao = StringInStr($data, "/T")-stringInStr($data, "/O")
	;
	;	$posicao = StringInStr($dim1, " ")
	;	$dim2 = StringMid($dim1, $posicao, StringLen($dim1))
	;	$dim2 = StringReplace($dim2, "]", "")
	;	$dim1 = StringMid($dim1, 1, $posicao)
		;MsgBox(4096, Default, "dimensões:" & @CRLF & $dim1 & "X" & $dim2)