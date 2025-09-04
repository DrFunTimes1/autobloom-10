Set objShell = CreateObject("WScript.Shell")
Set objFSO = CreateObject("Scripting.FileSystemObject")

' Try to get AUTOBLOOM_PATH environment variable
autoBloomPath = objShell.ExpandEnvironmentStrings("%AUTOBLOOM_PATH%")

If autoBloomPath = "%AUTOBLOOM_PATH%" Then
    ' Fallback: use the folder where this VBS file is
    autoBloomPath = objFSO.GetParentFolderName(WScript.ScriptFullName)
End If

' Build the full path to run.ps1
psScript = """" & autoBloomPath & "\run.ps1" & """"

' Run PowerShell silently (no window)
objShell.Run "powershell.exe -ExecutionPolicy Bypass -File " & psScript, 0, False