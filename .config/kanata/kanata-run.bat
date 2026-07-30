@echo off

:: Config
set "KANATA_EXE=%USERPROFILE%\scoop\shims\kanata.exe"
set "KANATA_CFG=%USERPROFILE%\.config\kanata\kanata.kbd"

pwsh -WindowStyle Hidden -Command ^
"Start-Process -FilePath '%KANATA_EXE%' -ArgumentList '--cfg ""%KANATA_CFG%""' -WindowStyle Hidden -Verb RunAs"
