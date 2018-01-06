Dim wshshell
Set wshshell = CreateObject("WScript.Shell")
Documents = wshshell.SpecialFolders("MyDocuments")
Dim FSO
Set FSO = CreateObject("Scripting.FileSystemObject")
Dim destination
destination = Documents + "\Arduino\tools\ESP32Partitions\"
If FSO.FolderExists(destination) Then
	wscript.echo "Folder " + destination + " Exists Already"
Else
	FSO.CreateFolder(destination)
End If
destination = destination + "tool\"
If FSO.FolderExists(destination) Then
	wscript.echo "Folder " + destination + " Exists Already"
Else
	FSO.CreateFolder(destination)
End If

FSO.CopyFile "tool\ESP32Partitions.jar", destination + "ESP32Partitions.jar"
FSO.CopyFile "tool\esp-partition.py", destination + "esp-partition.py"

wscript.echo "Installation Complete"
