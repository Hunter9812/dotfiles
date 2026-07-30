@echo off

set "TASK_NAME=App\Kanata"

:: [schtasks](https://learn.microsoft.com/zh-cn/windows-server/administration/windows-commands/schtasks#syntax)
schtasks /create ^
/tn "%TASK_NAME%" ^
/tr "C:\Windows\System32\conhost.exe --headless %USERPROFILE%\scoop\shims\kanata.exe --cfg %USERPROFILE%\.config\kanata\kanata.kbd" ^
/sc onlogon ^
/ru "%USERNAME%" ^
/rl highest ^
/f

echo.
echo ========== Task Information Check ==========
schtasks /query /tn "%TASK_NAME%"

echo.
echo Process finished. Press any key to close window.
pause >nul
