@echo off & cd /d %~dp0 & title BIOS Updater
 >NUL 2>&1 REG.exe query "HKU\S-1-5-19" || (
 ECHO SET UAC = CreateObject^("Shell.Application"^) > "%TEMP%\Getadmin.vbs"
 ECHO UAC.ShellExecute "%~f0", "%1", "", "runas", 1 >> "%TEMP%\Getadmin.vbs"
 "%TEMP%\Getadmin.vbs"
 DEL /f /q "%TEMP%\Getadmin.vbs" 2>NUL
 Exit /b
 )
 
 echo Administrative permissions required. Detecting permissions...
 echo.
 net session >nul 2>&1
 
 if %errorLevel% == 0 (
 echo Success: Administrative permissions confirmed.
 echo.
 ) else (
 echo Failure: Current permissions inadequate. This script requires administrator privileges.
 echo.
 echo To do this, right-click this script, and then select 'Run as administrator'.
 echo.
 echo Press any key to Exit.
 pause >nul
 goto :eof
 )
@echo off
 @cls
 @echo WARNING: This utility will reprogram the whole SPI Flash chip which
 @echo WARNING: includes system BIOS, TXE or ME firmware!!!
 @echo WARNING: DO NOT continue unless you are 100% sure you want to do this.
 @echo WARNING: To stop, turn off your computer and remove the update media,
 @echo WARNING: or do not run THIS SCRIPT.
 @pause
 @cls
@AFUWINx64.EXE PHxAQFxN105GRU05.ROM /p /b /n /r /x /l /k /reboot

