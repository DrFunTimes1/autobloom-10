@echo off
echo Installing AutoBloom...

:: --- Prompt user for INSTALL_PATH ---
set /p INSTALL_PATH=Enter installation path [default: C:\Autobloom]: 
if "%INSTALL_PATH%"=="" set INSTALL_PATH=C:\Autobloom

:: --- Ensure INSTALL_PATH exists ---
if not exist "%INSTALL_PATH%" mkdir "%INSTALL_PATH%"
if not exist "%INSTALL_PATH%\src" mkdir "%INSTALL_PATH%\src"

:: --- Save install path in environment variable ---
setx AUTOBLOOM_PATH "%INSTALL_PATH%"

:: --- Download MPV ---
echo Downloading MPV...
curl -L -o "%INSTALL_PATH%\mpv.7z" "https://github.com/shinchiro/mpv-winbuild-cmake/releases/download/20250827/mpv-x86_64-20250827-git-9f153e2.7z"

:: --- Ensure 7z folder exists ---
if not exist "%INSTALL_PATH%\7z" mkdir "%INSTALL_PATH%\7z"

:: --- Download minimalist 7-Zip portable ---
curl -L -o "%INSTALL_PATH%\7z\7z.exe" "https://www.7-zip.org/a/7z1900-x64.exe" 

:: --- Extract MPV ---
"%INSTALL_PATH%\7z\7z.exe" x "%INSTALL_PATH%\mpv.7z" -o"%INSTALL_PATH%\mpv" -y

:: --- Remove 7z folder and mpv.7z after extraction ---
rmdir /s /q "%INSTALL_PATH%\7z"
del "%INSTALL_PATH%\mpv.7z"

:: --- Download AutoBloom files ---
echo Downloading AutoBloom files...
curl -L -o "%INSTALL_PATH%\src\bloom-light.mp4" "https://github.com/DrFunTimes831/autobloom-win10/raw/main/src/bloom-light.mp4"
curl -L -o "%INSTALL_PATH%\src\bloom-dark.mp4"  "https://github.com/DrFunTimes831/autobloom-win10/raw/main/src/bloom-dark.mp4"
curl -L -o "%INSTALL_PATH%\src\bloom-light.png" "https://github.com/DrFunTimes831/autobloom-win10/raw/main/src/bloom-light.png"
curl -L -o "%INSTALL_PATH%\src\bloom-dark.png"  "https://github.com/DrFunTimes831/autobloom-win10/raw/main/src/bloom-dark.png"
curl -L -o "%INSTALL_PATH%\uninstall.bat"       "https://github.com/DrFunTimes831/autobloom-win10/raw/main/uninstall.bat"
curl -L -o "%INSTALL_PATH%\run.ps1"            "https://github.com/DrFunTimes831/autobloom-win10/raw/main/run.ps1"
curl -L -o "%INSTALL_PATH%\wallpaper.exe" "https://github.com/DrFunTimes831/autobloom-win10/raw/main/wallpaper.exe"
curl -L -o "%INSTALL_PATH%\run-bloom.vbs"      "https://github.com/DrFunTimes831/autobloom-win10/raw/main/run_bloom.vbs"

:: --- Prompt user for mode ---
set /p MODE=Select bloom mode (light/dark) [default: light]: 
if /i not "%MODE%"=="dark" set MODE=light

:: --- Save mode to file ---
echo %MODE% > "%INSTALL_PATH%\bloom-mode.txt"

:: --- Copy README to desktop if exists ---
if exist "%INSTALL_PATH%\README.md" (
    xcopy /E /I "%INSTALL_PATH%\README.md" "%USERPROFILE%\Desktop" >nul
)

:: --- Add run_bloom.vbs to startup ---
if exist "%INSTALL_PATH%\run_bloom.vbs" (
    xcopy /Y /I "%INSTALL_PATH%\run_bloom.vbs" "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup" >nul
)

:: --- Execute Run.ps1 immediately ---
echo Launching AutoBloom...
powershell -ExecutionPolicy Bypass -File "%INSTALL_PATH%\Run.ps1"

echo.
echo AutoBloom installed successfully! It will run automatically at startup.
pause
exit