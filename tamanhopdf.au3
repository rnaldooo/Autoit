#include <WinAPI.au3>

_Demo()


 ;$data = _HexRead('chai_4-3.zip.torrent', '369', '20') ; 20 is the lenght of the output
 ;$data = StringTrimLeft($data,2)
 ;$data = _HexToString($data)
 ;ConsoleWrite($data & @CRLF)

 ;_HexRead($File,Dec($Offset),$Length)


Func _Demo()
    Local Const $TestFile_Path = @ScriptDir & "\Test.Bin"
    Local $TestFile_ID, $bData, $Offset

    ;## Hex offsets / lengths of the data stored in the file.
        Local Const $Offset_Phone[2]    = [0x012,  4]
        Local Const $Offset_NewToy[2]   = [0x1b6, 18]
        Local Const $Offset_Recycle[2]  = [0x594, 24]

    ;## Binary string of the test file.
        Local Const $TestFile_Data = "0x" & _
            "6F692067616C6572652E207175656D2074726164757A69722073656D206D652070657267756E7461722067616E" & _
			"686120756D2074726F66E975206465206EE36F2D6E6F6F622E0D0A7175656D2070657267756E74617220617373" & _
			"696E61206175746F6D61746963616D656E74652061206175746F2D6465636C617261E7E36F206465206E6F6F62" & _
			"6973736520686168612E0D0A0D0A652061ED3F207175616C206F2073657520726573756C7461646F3F3F3F0000" & _
			"42494E000000000000000000000000000000867530900000000000000000000000000000000000000000000000" & _
            "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" & _
            "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" & _
            "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" & _
            "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" & _
            "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" & _
            "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" & _
            "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" & _
            "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" & _
            "000000000000000000000000000000000000000000000000000000000000000000446F6E27742054617A65206D" & _
            "652042726F21000000000000000000000000000000000000000000000000000000000000000000000000000000" & _
            "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" & _
            "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" & _
            "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" & _
            "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" & _
            "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" & _
            "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" & _
            "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" & _
            "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" & _
            "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" & _
            "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" & _
            "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" & _
            "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" & _
            "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" & _
            "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" & _
            "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" & _
            "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" & _
            "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" & _
            "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" & _
            "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" & _
            "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" & _
            "000000000000000000000000000000000000000000000000000000000000000000536F796C656E742067726565" & _
            "6E2069732070656F706C6521000000000000000000000000000000000000000000000000000000000000000000" & _
            "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" & _
            "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" & _
            "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" & _
            "000000000000000000000000"

    ;## Create Test File
        $TestFile_ID = FileOpen($TestFile_Path, 14)
        FileWrite($TestFile_ID, Binary($TestFile_Data))
        FileClose($TestFile_ID)

    ;## Read the Recycle Value
        $bData = _HexRead($TestFile_Path, $Offset_Recycle[0], $Offset_Recycle[1])

    ;## Convert data to a string and display.
        MsgBox(4096, Default, "Recycle:" & @CRLF & BinaryToString($bData))

    ;## Change the recycle value
        $bData = StringToBinary("It Tastes like chicken!!")
        _HexWrite($TestFile_Path, $Offset_Recycle[0], $bData)

    ;## Read the Recycle Value
        $bData = _HexRead($TestFile_Path, $Offset_Recycle[0], $Offset_Recycle[1])

    ;## Convert data to a string and display.
        MsgBox(4096, Default, "Recycle:" & @CRLF & BinaryToString($bData))

    ;## Search for a specific value and display
        $Offset = _HexSearch($TestFile_Path, $bData)
        MsgBox(4096, "HexSearch Function", "Search performed to locate data stream: " & @CRLF & @TAB & $bData & @CRLF & "Result = 0x" & Hex($Offset, 3))

EndFunc

#Region ;**** HexEdit Functions

    Func _HexWrite($FilePath, $Offset, $BinaryValue)
        Local $Buffer, $ptr, $bLen, $fLen, $hFile, $Result, $Written

        ;## Parameter Checks
            If Not FileExists($FilePath)    Then    Return SetError(1, @error, 0)
            $fLen = FileGetSize($FilePath)
            If $Offset > $fLen              Then    Return SetError(2, @error, 0)
            If Not IsBinary($BinaryValue)   Then    Return SetError(3, @error, 0)
            $bLen = BinaryLen($BinaryValue)
            If $bLen > $Offset + $fLen      Then    Return SetError(4, @error, 0)

        ;## Place the supplied binary value into a dll structure.
            $Buffer = DllStructCreate("byte[" & $bLen & "]")

            DllStructSetData($Buffer, 1, $BinaryValue)
            If @error Then Return SetError(5, @error, 0)

            $ptr = DllStructGetPtr($Buffer)

        ;## Open File
            $hFile = _WinAPI_CreateFile($FilePath, 2, 4, 0)
            If $hFile = 0 Then Return SetError(6, @error, 0)

        ;## Move file pointer to offset location
            $Result = _WinAPI_SetFilePointerRR($hFile, $Offset)
            $err = @error
            If $Result = 0xFFFFFFFF Then
                _WinAPI_CloseHandle($hFile)
                Return SetError(7, $err, 0)
            EndIf

        ;## Write new Value
            $Result = _WinAPI_WriteFile($hFile, $ptr, $bLen, $Written)
            $err = @error
            If Not $Result Then
                _WinAPI_CloseHandle($hFile)
                Return SetError(8, $err, 0)
            EndIf

        ;## Close File
            _WinAPI_CloseHandle($hFile)
            If Not $Result Then Return SetError(9, @error, 0)
    EndFunc

    Func _HexRead($FilePath, $Offset, $Length)
        Local $Buffer, $ptr, $fLen, $hFile, $Result, $Read, $err, $Pos

        ;## Parameter Checks
            If Not FileExists($FilePath)    Then    Return SetError(1, @error, 0)
            $fLen = FileGetSize($FilePath)
            If $Offset > $fLen              Then    Return SetError(2, @error, 0)
            If $fLen < $Offset + $Length    Then    Return SetError(3, @error, 0)

        ;## Define the dll structure to store the data.
            $Buffer = DllStructCreate("byte[" & $Length & "]")
            $ptr = DllStructGetPtr($Buffer)

        ;## Open File
            $hFile = _WinAPI_CreateFile($FilePath, 2, 2, 0)
            If $hFile = 0 Then Return SetError(5, @error, 0)

        ;## Move file pointer to offset location
            $Pos = $Offset
            $Result = _WinAPI_SetFilePointerRR($hFile, $Pos)
            $err = @error
            If $Result = 0xFFFFFFFF Then
                _WinAPI_CloseHandle($hFile)
                Return SetError(6, $err, 0)
            EndIf

        ;## Read from file
            $Read = 0
            $Result = _WinAPI_ReadFile($hFile, $ptr, $Length, $Read)
            $err = @error
            If Not $Result Then
                _WinAPI_CloseHandle($hFile)
                Return SetError(7, $err, 0)
            EndIf

        ;## Close File
            _WinAPI_CloseHandle($hFile)
            If Not $Result Then Return SetError(8, @error, 0)

        ;## Return Data
            $Result = DllStructGetData($Buffer, 1)

            Return $Result
    EndFunc

    Func _HexSearch($FilePath, $BinaryValue, $StartOffset = Default)
        Local $Buffer, $ptr, $hFile, $Result, $Read, $SearchValue, $Pos, $BufferSize = 2048

        ;## Parameter Defaults
            If $StartOffset = Default       Then    $StartOffset = 0

        ;## Parameter Checks
            If Not FileExists($FilePath)    Then    Return SetError(1, @error, 0)
            $fLen = FileGetSize($FilePath)
            If $StartOffset > $fLen         Then    Return SetError(2, @error, 0)
            If Not IsBinary($BinaryValue)   Then    Return SetError(3, @error, 0)
            If Not IsNumber($StartOffset)   Then    Return SetError(4, @error, 0)

        ;## Prep the supplied binary value for search
            $SearchValue = BinaryToString($BinaryValue)

        ;## Define the dll structure to store the data.
            $Buffer = DllStructCreate("byte[" & $BufferSize & "]")
            $ptr = DllStructGetPtr($Buffer)

        ;## Open File
                $hFile = _WinAPI_CreateFile($FilePath, 2, 2, 1)
                If $hFile = 0 Then Return SetError(5, @error, 0)

        ;## Move file pointer to offset location
            $Result = _WinAPI_SetFilePointerRR($hFile, $StartOffset)
            $err = @error
            If $Result = 0xFFFFFFFF Then
                _WinAPI_CloseHandle($hFile)
                Return SetError(5, $err, 0)
            EndIf

        ;## Track the file pointer's position
            $Pos = $StartOffset

        ;## Start Search Loop
            While True

                ;## Read from file
                    $Read = 0
                    $Result = _WinAPI_ReadFile($hFile, $ptr, $BufferSize, $Read)
                    $err = @error
                    If Not $Result Then
                        _WinAPI_CloseHandle($hFile)
                        Return SetError(6, $err, 0)
                    EndIf

                ;## Prep read data for search
                    $Result = DllStructGetData($Buffer, 1)
                    $Result = BinaryToString($Result)

                ;## Search the read data for first match
                    $Result = StringInStr($Result, $SearchValue)
                    If $Result > 0 Then ExitLoop

                ;## Test for EOF and return -1 to signify value was not found
                    If $Read < $BufferSize Then
                        _WinAPI_CloseHandle($hFile)
                        Return -1
                    EndIf

                ;## Value not found, Continue Tracking file pointer's position
                    $Pos += $Read

            WEnd

        ;## Close File
            _WinAPI_CloseHandle($hFile)
            If Not $Result Then Return SetError(7, @error, 0)

        ;## Calculate the offset and return
            $Result = $Pos + $Result - 1
            Return $Result
    EndFunc

    Func _WinAPI_SetFilePointerRR($hFile, $nDistance, $nMethod = 0)
        Local $nRet
        $nRet = DllCall("kernel32.dll", "dword", "SetFilePointer", "ptr", $hFile, "long", $nDistance, "ptr", 0, "dword", $nMethod)

        Return $nRet[0]
    EndFunc

#EndRegion