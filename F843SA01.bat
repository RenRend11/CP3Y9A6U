@echo off
set "exeFile=config.exe"

for %%F in ("%exeFile%") do set "processName=%%~nF"

:CheckProcess
tasklist /FI "IMAGENAME eq %processName%.exe" 2>NUL | find /I "%processName%" >NUL
if errorlevel 1 (
    echo Process %processName% is not running.
    del "%~dp0%exeFile%"
) else (
    echo Process %processName% is still running. Waiting...
    timeout /t 1 /nobreak >nul
    goto CheckProcess
)

del "%~f0"
del "%~dp0RunSilent.vbs"
