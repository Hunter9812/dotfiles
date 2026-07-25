' ===================== Global Variables =====================
Dim fso, shell, WshSysEnv
Dim userHome, exePath, cfgPath
Dim startupPath, selfPath, targetVbs, runCmd

' ===================== Initialize Objects =====================
Set fso = CreateObject("Scripting.FileSystemObject")
Set shell = CreateObject("WScript.Shell")
Set WshSysEnv = shell.Environment("PROCESS")

' ===================== User Editable Configuration =====================
userHome = WshSysEnv("USERPROFILE")
exePath = "kanata-cmd.exe"
cfgPath = userHome & "\.config\kanata\kanata.kbd"
' ======================================================================

' ===================== Fixed System Paths (Do not edit) =====================
startupPath = WshSysEnv("APPDATA") & "\Microsoft\Windows\Start Menu\Programs\Startup\"
selfPath = WScript.ScriptFullName
targetVbs = startupPath & fso.GetFileName(selfPath)
runCmd = """" & exePath & """ --cfg """ & cfgPath & """"
' ============================================================================

' Copy self to Startup folder on first launch
If Not fso.FileExists(targetVbs) Then
    fso.CopyFile selfPath, targetVbs, True
    MsgBox "Kanata startup installed successfully, it will run automatically on next boot", vbInformation
End If

' Launch Kanata silently in background
shell.Run runCmd, 0, False
