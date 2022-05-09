#region _Mem()

Func _MemOpen($i_Pid, $i_Access = 0x1F0FFF, $i_Inherit = 0)
    Local $av_Return[2] = [DllOpen('kernel32.dll') ]
    Local $ai_Handle = DllCall($av_Return[0], 'int', 'OpenProcess', 'int', $i_Access, 'int', $i_Inherit, 'int', $i_Pid)
    If @error Then
    DllClose($av_Return[0])
    SetError(1)
    Return 0
    EndIf
    $av_Return[1] = $ai_Handle[0]
    Return $av_Return
EndFunc ;==>_MemOpen

Func _MemRead($ah_Mem, $i_Address, $i_Size = 0)
    If $i_Size = 0 Then
    Local $v_Return = ''
    Local $v_Struct = DllStructCreate('byte[1]')
    Local $v_Ret

    While 1
    $v_Ret = DllCall($ah_Mem[0], 'int', 'ReadProcessMemory', 'int', $ah_Mem[1], 'int', $i_Address, 'ptr', DllStructGetPtr($v_Struct), 'int', 1, 'int', '')
    $v_Ret = DllStructGetData($v_Struct, 1)
    If $v_Ret = 0 Then ExitLoop
    $v_Return &= Chr($v_Ret)
    $i_Address += 1
    WEnd

    Else
    Local $v_Struct = DllStructCreate('byte[' & $i_Size & ']')
    Local $v_Ret = DllCall($ah_Mem[0], 'int', 'ReadProcessMemory', 'int', $ah_Mem[1], 'int', $i_Address, 'ptr', DllStructGetPtr($v_Struct), 'int', $i_Size, 'int', '')
    Local $v_Return[$v_Ret[4]]
    For $i = 0 To $v_Ret[4] - 1
    $v_Return[$i] = DllStructGetData($v_Struct, 1, $i + 1)
    Next
    EndIf
    Return $v_Return
EndFunc ;==>_MemRead

Func _MemWrite($ah_Mem, $i_Address, $v_Inject)
    Local $av_Call = DllCall($ah_Mem[0], 'int', 'WriteProcessMemory', 'int', $ah_Mem[1], 'int', $i_Address, 'ptr', DllStructGetPtr($v_Inject), 'int', DllStructGetSize($v_Inject), 'int', '')
    Return $av_Call[0]
EndFunc ;==>_MemWrite

Func _MemClose($ah_Mem)
    Local $av_Ret = DllCall($ah_Mem[0], 'int', 'CloseHandle', 'int', $ah_Mem[1])
    DllClose($ah_Mem[0])
    Return $av_Ret[0]
EndFunc ;==>_MemClose

Func _MemCreate($1, $2 = 0, $3 = 0, $4 = 0, $5 = 0, $6 = 0, $7 = 0, $8 = 0, $9 = 0, $10 = 0, $11 = 0, $12 = 0, $13 = 0, $14 = 0, $15 = 0, _
    $16 = 0, $17 = 0, $18 = 0, $19 = 0, $20 = 0, $21 = 0, $22 = 0, $23 = 0, $24 = 0, $25 = 0, $26 = 0, $27 = 0, $28 = 0, $29 = 0, _
    $30 = 0, $31 = 0, $32 = 0, $33 = 0, $34 = 0, $35 = 0, $36 = 0, $37 = 0, $38 = 0, $39 = 0, $40 = 0, $41 = 0, $42 = 0, $43 = 0, _
    $44 = 0, $45 = 0, $46 = 0, $47 = 0, $48 = 0, $49 = 0, $50 = 0, $51 = 0, $52 = 0, $53 = 0, $54 = 0, $55 = 0, $56 = 0, $57 = 0, _
    $58 = 0, $59 = 0, $60 = 0, $61 = 0, $62 = 0, $63 = 0, $64 = 0, $65 = 0, $66 = 0, $67 = 0, $68 = 0, $69 = 0, $70 = 0, $71 = 0, _
    $72 = 0, $73 = 0, $74 = 0, $75 = 0, $76 = 0, $77 = 0, $78 = 0, $79 = 0, $80 = 0, $81 = 0, $82 = 0, $83 = 0, $84 = 0, $85 = 0, _
    $86 = 0, $87 = 0, $88 = 0, $89 = 0, $90 = 0, $91 = 0, $92 = 0, $93 = 0, $94 = 0, $95 = 0, $96 = 0, $97 = 0, $98 = 0, $99 = 0)
    If IsString($1) Then
    $1 = StringSplit($1, '')
    Local $v_Helper = DllStructCreate('byte[' & UBound($1) & ']')
    For $i = 1 To UBound($1) - 1
    DllStructSetData($v_Helper, 1, Asc($1[$i]), $i)
    Next
    Else
    Local $v_Helper = DllStructCreate('byte[' & @NumParams & ']')
    For $i = 1 To @NumParams
    DllStructSetData($v_Helper, 1, Eval($i), $i)
    Next
    EndIf
    Return $v_Helper
EndFunc ;==>_MemCreate

Func _MemRev($v_DWORD)
    If UBound($v_DWORD) = 4 Then Return '0x' & Hex($v_DWORD[3], 2) & Hex($v_DWORD[2], 2) & Hex($v_DWORD[1], 2) & Hex($v_DWORD[0], 2)
    Local $v_Ret[4] = ['0x' & StringMid(Hex($v_DWORD, 8), 7, 2), '0x' & StringMid(Hex($v_DWORD, 8), 5, 2), '0x' & StringMid(Hex($v_DWORD, 8), 3, 2), '0x' & StringMid(Hex($v_DWORD, 8), 1, 2) ]
    Return $v_Ret
EndFunc ;==>_MemRev

Func _MemAlloc($ah_Mem, $i_Size, $i_Address = 0, $i_AT = 4096, $i_Protect = 0x40)
    Switch @OSVersion
    Case "WIN_ME", "WIN_98", "WIN_95"
    $av_Alloc = DllCall($ah_Mem[0], 'int', 'VirtualAlloc', 'int', $i_Address, 'int', $i_Size, 'int', BitOR($i_AT, 0x8000000), 'int', $i_Protect)
    Case Else
    $av_Alloc = DllCall($ah_Mem[0], 'int', 'VirtualAllocEx', 'int', $ah_Mem[1], 'int', $i_Address, 'int', $i_Size, 'int', $i_AT, 'int', $i_Protect)
    EndSwitch
    Return $av_Alloc[0]
EndFunc ;==>_MemAlloc

Func _MemFree($ah_Mem, $i_Address)
    Switch @OSVersion
    Case "WIN_ME", "WIN_98", "WIN_95"
    $av_Free = DllCall($ah_Mem[0], 'int', 'VirtualFree', 'int', $i_Address, 'int', 0, 'int', 0x8000)
    Case Else
    $av_Free = DllCall($ah_Mem[0], 'int', 'VirtualFreeEx', 'int', $ah_Mem[1], 'int', $i_Address, 'int', 0, 'int', 0x8000)
    EndSwitch
    Return $av_Free[0]
EndFunc ;==>_MemFree

Func _MemText($ah_Mem, $s_Text)
    Local $i_Size = StringLen($s_Text) + 1
    Local $i_Addr = _MemAlloc($ah_Mem, $i_Size)
    _MemWrite($ah_Mem, $i_Addr, _MemCreate($s_Text))
    Return $i_Addr
EndFunc ;==>_MemText

#endregion