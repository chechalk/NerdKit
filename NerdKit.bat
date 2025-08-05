@echo off
:: ================================================
:: NerdKit.bat - All-in-One CyberSec Swiss Army Knife
:: No AI garbage. No bloat. Just paranoid DOS stuff.
::
:: Credits:
::   Author: Cchalk (3xploitSec)
::   GitHub: https://github.com/chechalk
:: ================================================
title NerdKit - CyberSec Multitool
color 0a
setlocal enabledelayedexpansion

:MAIN_MENU
cls
echo.
echo   ╔════════════════════════════════════════╗
echo   ║                                        ║
echo   ║           -= N E R D K I T =-          ║
echo   ║       Paranoid CyberSec Toolkit        ║
echo   ║        (By Cchalk / 3xploitSec)        ║
echo   ║                                        ║
echo   ╠════════════════════════════════════════╣
echo   ║                                        ║
echo   ║  1. Scan ALL Files (Tamper Detection)  ║
echo   ║  2. Nuke Windows Logs (OpSec)          ║
echo   ║  3. Anonymity Tools (Basic OPSEC)      ║
echo   ║  4. USB Ninja Scanner (BadUSB Check)   ║
echo   ║  5. Exit                               ║
echo   ║                                        ║
echo   ╚════════════════════════════════════════╝
echo.
set /p choice="[?] Choose (1-5): "

if "%choice%"=="1" goto SCAN_ALL
if "%choice%"=="2" goto NUKE_LOGS
if "%choice%"=="3" goto ANONYMITY_MENU
if "%choice%"=="4" goto USB_SCAN
if "%choice%"=="5" exit
goto MAIN_MENU

:: ================================================
:: SCAN ALL FILES - Tamper detection + hashes
:: ================================================
:SCAN_ALL
cls
echo.
echo   ╔════════════════════════════════════════╗
echo   ║          FILE TAMPER SCANNER           ║
echo   ╚════════════════════════════════════════╝
echo.
echo [!] This will scan EVERY file recursively.
echo [!] Will take ages on large folders.
echo.
set /p target="[+] Enter folder to scan (e.g., C:\): "
if not exist "%target%" (
  echo [X] Folder doesn't exist!
  pause
  goto MAIN_MENU
)

echo [*] Scanning all files (size + dates + hashes)...
echo. > scan_report.txt
echo === FILE TAMPER REPORT === >> scan_report.txt
echo Scan of: %target% >> scan_report.txt
echo Date: %date% %time% >> scan_report.txt
echo ========================= >> scan_report.txt

for /r "%target%" %%F in (*) do (
  echo Processing: %%F
  echo. >> scan_report.txt
  echo [FILE] %%F >> scan_report.txt
  echo   Size: %%~zF bytes >> scan_report.txt
  echo   Modified: %%~tF >> scan_report.txt
  certutil -hashfile "%%F" MD5 | find /v "hash" >> scan_report.txt
)
echo [✓] Done! Saved to scan_report.txt
pause
goto MAIN_MENU

:: ================================================
:: NUKE WINDOWS LOGS - OpSec cleanup
:: ================================================
:NUKE_LOGS
cls
echo.
echo   ╔════════════════════════════════════════╗
echo   ║          WINDOWS LOG NUKE TOOL         ║
echo   ╚════════════════════════════════════════╝
echo.
echo [!] This will delete common Windows logs (MAY DAMAGE MACHINE)
echo [!] Run as Admin for full effect (MAY DAMAGE MACHINE)
echo.
set /p confirm="[?] Are you sure? (y/n): " 
if /i "%confirm%" neq "y" goto MAIN_MENU

echo [*] Terminating logs...
del /q /f /s %windir%\*.log >nul 2>&1
del /q /f /s %windir%\system32\LogFiles\*.* >nul 2>&1
del /q /f /s %windir%\system32\winevt\Logs\*.* >nul 2>&1
wevtutil cl Application >nul 2>&1
wevtutil cl System >nul 2>&1
wevtutil cl Security >nul 2>&1
echo [✓] Logs obliterated. Watch your six.
pause
goto MAIN_MENU

:: ================================================
:: ANONYMITY TOOLS MENU
:: ================================================
:ANONYMITY_MENU
cls
echo.
echo   ╔════════════════════════════════════════╗
echo   ║          ANONYMITY TOOLKIT             ║
echo   ╚════════════════════════════════════════╝
echo.
echo  1. Flush DNS Cache
echo  2. Disable Telemetry (Requires Admin) (Dangerous Can Damage)
echo  3. Clear Recent Files History
echo  4. Back to Main Menu
echo.
set /p opsec="[?] Choose (1-4): "

if "%opsec%"=="1" (
  ipconfig /flushdns
  echo [✓] DNS cache annihilated
  pause
  goto ANONYMITY_MENU
)
if "%opsec%"=="2" (
  reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f
  echo [✓] Telemetry "disabled" (lol Microsoft)
  pause
  goto ANONYMITY_MENU
)
if "%opsec%"=="3" (
  del /q /f /s "%appdata%\Microsoft\Windows\Recent\*.*" >nul 2>&1
  echo [✓] Recent files history purged
  pause
  goto ANONYMITY_MENU
)
if "%opsec%"=="4" goto MAIN_MENU
goto ANONYMITY_MENU

:: ================================================
:: USB NINJA SCANNER - BadUSB detection
:: ================================================
:USB_SCAN
cls
echo.
echo   ╔════════════════════════════════════════╗
echo   ║          USB NINJA SCANNER             ║
echo   ╚════════════════════════════════════════╝
echo.
echo [!] Plug in the suspicious USB first!
pause

echo [*] Scanning USB for sketchy behavior...
echo === USB SCAN REPORT === > usb_scan.txt
echo Date: %date% %time% >> usb_scan.txt
echo ===================== >> usb_scan.txt

wmic logicaldisk where "drivetype=2" get deviceid,size,freespace >> usb_scan.txt

echo. >> usb_scan.txt
echo [*] Checking for autorun exploits...
dir /a /s /b *.inf *.vbs *.bat *.cmd >> usb_scan.txt

echo. >> usb_scan.txt
echo [*] Checking file structure anomalies...
tree /f >> usb_scan.txt

echo [✓] Scan complete. Check usb_scan.txt
echo [!] If you see .inf/.vbs files, eject that USB NOW
pause
goto MAIN_MENU

:: ================================================
:: END OF FILE
:: ================================================
