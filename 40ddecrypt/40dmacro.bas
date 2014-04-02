Sub Decrypt()
Rootpath = "C:\40D Hack\Decrypt\"
Dim HexArray1(512) As String
Dim HexArray2(513) As String

Dim DecArray1(512) As Byte
Dim DecArray2(513) As Byte

Open Rootpath + "Generic_40D_table.txt" For Input As #1


For teller = 1 To 512
  Input #1, HexArray1(teller)
  DecArray1(teller) = CByte(HexArray1(teller))
Next
Line Input #1, Inline    ' Read empty line of data.
For teller = 1 To 513
  Input #1, HexArray2(teller)
   DecArray2(teller) = CByte(HexArray2(teller))
Next
Close #1

Dim MyChar As Byte
Dim OutChar As Byte
Dim XorVal As Byte

Open Rootpath + "40d00111.fir" For Binary Access Read As #1     ' Open file for input.
Open Rootpath + "40d00111.bin.txt" For Binary Access Write As #2    ' Open file for output.

'FW 1.0.5
' Key1 offset = 0x92
' Key2 offset = 0x1B0
'
'FW 1.0.8
' Key1 offset = 0x100
' Key2 offset = 0x1A7
'
'FW 1.1.0
' Key1 offset = 0xAC
' Key2 offset = 0x1E8
'
'FW 1.1.1
' Key1 offset = 0x27
' Key2 offset = 0x191
'
Offset_Key1 = &H27
Offset_Key2 = &H191

ArrayTeller1 = 1 + Offset_Key1
ArrayTeller2 = 1 + Offset_Key2


current = 0
Do While current < LOF(1)

  Get #1, , MyChar  ' Read 1 byte of data from input file
  If current >= &H120 Then
    XorVal = DecArray1(ArrayTeller1) Xor DecArray2(ArrayTeller2) Xor 55
    OutChar = MyChar Xor XorVal
    ArrayTeller1 = ArrayTeller1 + 1
    If ArrayTeller1 > 512 Then ArrayTeller1 = 1
    ArrayTeller2 = ArrayTeller2 + 1
    If ArrayTeller2 > 513 Then ArrayTeller2 = 1
  Else
    OutChar = MyChar
  End If
    Put #2, , OutChar  ' Write 1 byte to output file
current = Loc(1)
Loop

Close #2    ' Close file.
Close #1    ' Close file.
Result = MsgBox("Ready", vbOKOnly, "Finished")
End Sub

