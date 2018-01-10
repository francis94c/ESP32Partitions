' Author: Francis Ilechukwu
Option Explicit

Dim wshshell, FSO, destination, documents

Set wshshell = CreateObject("WScript.Shell")

documents = wshshell.SpecialFolders("MyDocuments")

Set FSO = CreateObject("Scripting.FileSystemObject")

destination = documents + "\Arduino\tools\ESP32Partitions\"

If FSO.FolderExists(destination) Then
	wscript.echo "Folder " + destination + " Exists Already"
Else
	FSO.CreateFolder(destination)
End If

destination = destination + "tool\"

wscript.echo "Installing..."

If FSO.FolderExists(destination) Then
	wscript.echo "Folder " + destination + " Exists Already"
Else
	FSO.CreateFolder(destination)
End If

FSO.CopyFile "tool\ESP32Partitions.jar", destination + "ESP32Partitions.jar"
FSO.CopyFile "tool\esp-partition.py", destination + "esp-partition.py"

wscript.echo "Installation Complete."
