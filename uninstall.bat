@echo off
setlocal

REM --- Get AUTOBLOOM_PATH ---
set "AB_PATH=%AUTOBLOOM_PATH%"

if "%AB_PATH%"=="" (
    echo AUTOBLOOM_PATH is not set. Exiting.
    pause
    exit /b
)

echo Deleting files in %AB_PATH% ...

REM --- Delete all files and folders inside AUTOBLOOM_PATH ---
rd /s /q "%AB_PATH%"

REM --- Remove run-bloom.vbs from Startup ---
set "STARTUP_PATH=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\run-bloom.vbs"
if exist "%STARTUP_PATH%" (
    del /f /q "%STARTUP_PATH%"
)

REM --- Delete the environment variable ---
reg delete "HKCU\Environment" /v "AUTOBLOOM_PATH" /f

echo Uninstallation complete.

REM --- Delete this uninstall.bat itself ---
set "BAT_PATH=%~f0"
del /f /q "%BAT_PATH%"