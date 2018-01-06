Set wshshell = CreateObject("WScript.Shell")
Documents = wshshell.SpecialFolders("MyDocuments")
MsgBox(Documents)
