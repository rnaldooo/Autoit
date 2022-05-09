$file = FileOpen("C:\Users\Reinaldo\Downloads\SHA1_MD5_RC4_BASE64_CRC32_XXTEA\The quick brown fox jumps over the lazy dog.txt", 0)

; Check if file opened for reading OK
If $file = -1 Then
	MsgBox(0, "Error", "Unable to open file.")
	Exit
EndIf

; Read in 1 character at a time until the EOF is reached
While 1
	$chars = FileRead($file )
	If @error = -1 Then ExitLoop
	MsgBox(0, "Char read:", $chars)
Wend

FileClose($file)


#AutoIt3Wrapper_Au3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6

#include <WinAPI.au3>

Global $sFile, $hFile, $sText, $nBytes, $tBuffer

; 1) create file and write data to it
$sFile = @ScriptDir & '\test.txt'
$sText = 'abcdefghijklmnopqrstuvwxyz'
$tBuffer = DllStructCreate("byte[" & StringLen($sText) & "]")
DllStructSetData($tBuffer, 1, $sText)
$hFile = _WinAPI_CreateFile($sFile, 1)
_WinAPI_WriteFile($hFile, DllStructGetPtr($tBuffer), StringLen($sText), $nBytes)
_WinAPI_CloseHandle($hFile)
ConsoleWrite('1) ' & FileRead($sFile) & @LF)

; 2) read 6 bytes from posision 3
$tBuffer = DllStructCreate("byte[6]")
$hFile = _WinAPI_CreateFile($sFile, 2, 2)
_WinAPI_SetFilePointer($hFile, 3)
_WinAPI_ReadFile($hFile, DllStructGetPtr($tBuffer), 6, $nBytes)
_WinAPI_CloseHandle($hFile)
$sText = BinaryToString(DllStructGetData($tBuffer, 1))
ConsoleWrite('2) ' & $sText & @LF)

; 3) write previously read 6 bytes from posision 3 to the same position but in UpperCase
DllStructSetData($tBuffer, 1, StringUpper($sText))
$hFile = _WinAPI_CreateFile($sFile, 2, 4)
_WinAPI_SetFilePointer($hFile, 3)
_WinAPI_WriteFile($hFile, DllStructGetPtr($tBuffer), 6, $nBytes)
_WinAPI_CloseHandle($hFile)
$tBuffer = 0
ConsoleWrite('3) ' & FileRead($sFile) & @LF)

; 4) truncate file size to 12 bytes
$hFile = _WinAPI_CreateFile($sFile, 2, 4)
_WinAPI_SetFilePointer($hFile, 12)
_WinAPI_SetEndOfFile($hFile)
_WinAPI_CloseHandle($hFile)
ConsoleWrite('4) ' & FileRead($sFile) & @LF)








#include <md5.au3>

Global $iBufferSize = 0x20000
$sFilename = "M:\Program\Au3 Scripts\HashTest.exe"
$iRemaining = FileGetSize($sFilename)
Global $hFileHandle = FileOpen($sFilename, 16)
$iTotal = 0
$MD5CTX = _MD5Init()

For $i = 1 To Ceiling($iRemaining / $iBufferSize)
    If $iRemaining > $iBufferSize Then 
        _MD5Input($MD5CTX, FileRead($hFileHandle, $iBufferSize))
        $iRemaining -= $iBufferSize
        $iTotal += $iBufferSize
    Else
        _MD5Input($MD5CTX, FileRead($hFileHandle, $iRemaining))
        $iTotal += $iRemaining
    EndIf
Next
$vHash = _MD5Result($MD5CTX)

$sOrg_File_Contents = FileRead($sFilename)
FileClose($hFileHandle)

$hFileHandle = FileOpen("M:\Program\Au3 Scripts\HashAdded.exe", 18)
FileWrite($hFileHandle, $sOrg_File_Contents & StringTrimLeft($vHash , 2))
FileClose($hFileHandle)

MsgBox(0,"Hash",$vHash)




Func _CRC32($Data, $CRC32 = -1)
	Local $Opcode = '0xC800040053BA2083B8EDB9000100008D41FF516A0859D1E8730231D0E2F85989848DFCFBFFFFE2E78B5D088B4D0C8B451085DB7416E3148A1330C20FB6D2C1E80833849500FCFFFF43E2ECF7D05BC9C21000'

	Local $CodeBuffer = DllStructCreate("byte[" & BinaryLen($Opcode) & "]")
	DllStructSetData($CodeBuffer, 1, $Opcode)

	Local $Input = DllStructCreate("byte[" & BinaryLen($Data) & "]")
	DllStructSetData($Input, 1, $Data)

	Local $Ret = DllCall("user32.dll", "uint", "CallWindowProc", "ptr", DllStructGetPtr($CodeBuffer), _
													"ptr", DllStructGetPtr($Input), _
													"int", BinaryLen($Data), _
													"uint", $CRC32, _
													"int", 0)

	$Input = 0
	$CodeBuffer = 0

	Return $Ret[0]
EndFunc