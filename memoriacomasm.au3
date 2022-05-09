#include <Asm.au3>
#include <Misc.au3>
#include <Array.au3>
#include <Memory.au3>
#include <_Distorm.au3>
#include <NomadMemory.au3>

; dont remove that noob or we cant write to wow process memory
#requireadmin

;
; WOW 3.1.3 MEMORY OFFSET CONSTANTS
;
Global Const $PLAYER_BASE  = 0x010BD5F4
Global Const $PLAYER_BPTR1 = 0x34
Global Const $PLAYER_BPTR2 = 0x24

Global Const $Lua_Dostring = 0x0049AAB0
Global Const $GetLocalizedText = 0x005A82F0

; Setting privilege
SetPrivilege( "SeDebugPrivilege", 1 )

; Open wow process to hook endscene
$wow = _MemoryOpen(WinGetProcess("aaaa"))

; Makes sure WoW is open
If @error == 1 then
  MsgBox( 0x1010, "Error", "Process not found!")
  Exit
EndIf

; Gets player base address
$base = _MemoryRead("0x" & hex($PLAYER_BASE), $wow, "dword")
$base_2 = _MemoryRead("0x" & hex($base + $PLAYER_BPTR1), $wow, "dword")
$base_3 = _MemoryRead("0x" & hex($base_2 + $PLAYER_BPTR2), $wow, "dword")

if $base_3 = 0 Then
  MsgBox( 0x1010, "Error", "Login to your account first!")
  Exit
endif

; get address of EndScene
$pDevice = _MemoryRead("0x" & hex(0x0113C290), $wow, "dword")
$pEnd = _MemoryRead("0x" & hex($pDevice + 0x38A8), $wow, "dword")
$pScene = _MemoryRead("0x" & hex($pEnd), $wow, "dword")
$pEndScene = _MemoryRead("0x" & hex($pScene + 0xA8), $wow, "dword")

; injected code
Global $injected_code

; check if already hooked
$orig = _MemoryRead( "0x" & hex($pEndScene), $wow, "byte[64]" )

; autoit is garbage
$orig_ptr = DllStructCreate("byte[64]")
DllStructSetData( $orig_ptr, 1, $orig )

; check for push xxxxxxxx/ret/nop
; 0x68, 0xC3, 0x90
if DllStructGetData( $orig_ptr, 1, 1 ) == 104 and _
   DllStructGetData( $orig_ptr, 1, 6 ) == -61 and DllStructGetData( $orig_ptr, 1, 7 ) == -112 Then

  $injected_code = _MemoryRead( "0x" & hex($pEndScene + 1), $wow, "dword" )
else
  ; allocate memory to store injected code
  $injected_code = _MemVirtualAllocEx( $wow[1], 0, 2048, $MEM_COMMIT, $PAGE_EXECUTE_READWRITE )

  ; Generate the STUB to be injected
  $Asm = AsmInit()
  AsmReset($Asm)
  ; save regs
  AsmAdd($Asm, "pushad")
  AsmAdd($Asm, "pushfd")
  ; check if theres something to be run
  AsmAdd($Asm, "mov esi, " & hex( $injected_code + 256 ) & "h")
  AsmAdd($Asm, "cmp dword [esi], 0" )
  AsmAdd($Asm, "jz $+73" ) ; label exit:
  ; UpdateCurMgr
  AsmAdd($Asm, "mov edx, [" & hex(0x01139f80) & "h]")
  AsmAdd($Asm, "mov edx, [ edx + " & hex( 0x2C34 ) & "h]")
  AsmAdd($Asm, "mov eax, fs:[2Ch]")
  AsmAdd($Asm, "mov eax, [eax]")
  AsmAdd($Asm, "add eax, 0x10")
  AsmAdd($Asm, "mov [eax], edx")
  ; DoString
  AsmAdd($Asm, "mov esi, " & hex( $injected_code + 1024 ) & "h")
  AsmAdd($Asm, "push 0" )
  AsmAdd($Asm, "push esi" )
  AsmAdd($Asm, "push esi" )
  AsmAdd($Asm, "mov eax, " & hex( $Lua_Dostring ) & "h" )
  AsmAdd($Asm, "call eax" )
  AsmAdd($Asm, "add esp, 0Ch" )
  ; check if theres something to be returned on
  AsmAdd($Asm, "mov esi, " & hex( $injected_code + 512 ) & "h")
  AsmAdd($Asm, "cmp dword [esi], 0" )
  AsmAdd($Asm, "jz $+2D" ) ; label exit:
  ; GetLocalizedText
  AsmAdd($Asm, "mov ecx, " & hex( $base_3 ) & "h") ; must be made dynamic
  AsmAdd($Asm, "push -1")
  AsmAdd($Asm, "push esi")
  AsmAdd($Asm, "mov eax, " & hex( $GetLocalizedText ) & "h" )
  AsmAdd($Asm, "call eax")
  AsmAdd($Asm, "cmp eax, 0" )
  AsmAdd($Asm, "jz $+11" ) ; label exit:
  ; copy return string
  AsmAdd($Asm, "mov esi, eax")
  AsmAdd($Asm, "mov edi, " & hex( $injected_code + 768 ) & "h")
  AsmAdd($Asm, "copy:")
  AsmAdd($Asm, "lodsb")
  AsmAdd($Asm, "stosb")
  AsmAdd($Asm, "cmp al, 0")
  AsmAdd($Asm, "jnz @copy")
  ; clean state busy flag
  AsmAdd($Asm, "exit:")
  AsmAdd($Asm, "xor eax, eax")
  AsmAdd($Asm, "mov edi, " & hex( $injected_code + 256 ) & "h")
  AsmAdd($Asm, "stosd")
  AsmAdd($Asm, "mov edi, " & hex( $injected_code + 512 ) & "h")
  AsmAdd($Asm, "stosd")
  ; restore regs
  AsmAdd($Asm, "popfd")
  AsmAdd($Asm, "popad")

  ; copy injected code
  _MemoryWrite( "0x" & hex( $injected_code ), $wow, AsmGetBinary($Asm), "byte[" & $Asm[2] & "]" )

  ; create hook jump
  $jmpto = AsmInit()
  AsmReset( $jmpto )
  AsmAdd( $jmpto, "push " & hex( $injected_code ) & "h" )
  AsmAdd( $jmpto, "ret")
  AsmAdd( $jmpto, "nop")

  ; save original instructions
  _MemoryWrite( "0x" & hex($injected_code + $Asm[2]), $wow, $orig, "byte[64]" )

  ; disasm original bytes
  $DecodeArray = DllStructCreate("byte[" & $sizeofDecodedInst * 64 & "]")
  $ret = distorm_decode(0,  DllStructGetPtr($orig_ptr), 64, $Decode32Bits, DllStructGetPtr($DecodeArray), 64)

  ; parse until we can jump back
  $sumsize = 0
  If $ret[0] == $DECRES_SUCCESS Then
    For $i = 0 To $ret[1] ; number of decoded instructions
      ; get size of 1 instruction
      $instr = DllStructCreate($tagDecodedInst, DllStructGetPtr($DecodeArray) + ($i * $sizeofDecodedInst))
      $sumsize += DllStructGetData($instr, "size")

      ; check if we copied enough instructions
      if $sumsize >= $jmpto[2] Then

        ; create jump back stub
        $jmpback = AsmInit()
        AsmReset( $jmpback )
        AsmAdd( $jmpback, "push " & hex($pEndScene + $sumsize) & "h" )
        AsmAdd( $jmpback, "ret")
        AsmAdd( $jmpback, "nop")

        ; write jump back
        _MemoryWrite( "0x" & hex($injected_code + $Asm[2] + $sumsize), $wow, AsmGetBinary($jmpback), "byte[" & $jmpback[2] & "]" )
        ExitLoop
      Endif
    Next
  Endif

  ; write jump hook
  _MemoryWrite( "0x" & hex($pEndScene), $wow, AsmGetBinary($jmpto), "byte[" & $jmpto[2] & "]" )
EndIf

;
; Samples
;

; simple DoString()
WowLuaDoString( $wow, "", "DEFAULT_CHAT_FRAME:AddMessage(""DoString() from AutoIt !!!"", 1, 0, 0);" );

; doString() and GetLocalizedText()
$s_text = WowLuaDoString( $wow, "s_text", "s_text = GetMinimapZoneText();" );

; show
MsgBox( 0, $s_text, $s_text )

; doString() and GetLocalizedText()
$i_int = WowLuaDoString( $wow, "i_int", "i_int = GetContainerNumSlots(0);" );

; show
MsgBox( 0, $i_int, $i_int )

; close wow memory
_MemoryClose( $wow )

Exit

;
; Execute Lua code in WOW main thread
;
Func WowLuaDoString( $wow, $desc, $cmd )

  ; write ret var
  _MemoryWrite( "0x" & hex($injected_code + 512), $wow, $desc, "char[" & StringLen( $desc )+1 & "]" )

  ; write lua command
  _MemoryWrite( "0x" & hex($injected_code + 1024), $wow, $cmd, "char[" & StringLen( $cmd )+1 & "]" )

  ; change status
  $stat = 1
  _MemoryWrite( "0x" & hex($injected_code + 256), $wow, $stat, "dword" )

  ; wait execution
  do
    $stat = _MemoryRead( "0x" & hex($injected_code + 256), $wow, "dword" )
  Until $stat = 0

  ; read answer
  $ret = _MemoryRead( "0x" & hex($injected_code + 768), $wow, "char[256]" )

  Return $ret

EndFunc
