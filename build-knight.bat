@echo off
set SANNY_EXE="sanny.exe"

REM Sanny can only compile if its not already running
tasklist /fi "IMAGENAME eq sanny.exe" /FO CSV 2>NUL | find /I /N "sanny.exe">NUL
if %ERRORLEVEL% EQU 0 (
    echo Sanny is running.  Please close it before running this build script.
    pause
    exit /B 1
)

REM Check to see if executable is in path
where /q %SANNY_EXE%
reg query "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Sanny Builder 3_is1" /v "InstallLocation" >nul
if %ERRORLEVEL% equ 1 (
    echo Sanny not found in PATH.  Please select the location of sanny.exe, or set the PATH to include it
    call :filedialog SANNY_EXE
) else (
where /q %SANNY_EXE%
for /f "tokens=2*" %%a in ('REG QUERY "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Sanny Builder 3_is1" /v "InstallLocation"') do set "SANNY_EXE=%%bSanny.exe"
)

echo Compiling scripts...
:: Main scripts
call :Compile KITTSpawn .cs

:: KITT RandomLEDBars scripts
call :Compile Kitt\RandomLEDBars\RandomLEDBar1 .s
call :Compile Kitt\RandomLEDBars\RandomLEDBar2 .s
call :Compile Kitt\RandomLEDBars\RandomLEDBar3 .s
call :Compile Kitt\RandomLEDBars\RandomLEDBar4 .s
call :Compile Kitt\RandomLEDBars\RandomLEDBar5 .s
call :Compile Kitt\RandomLEDBars\RandomLEDBar6 .s
call :Compile Kitt\RandomLEDBars\RandomLEDBar7 .s
call :Compile Kitt\RandomLEDBars\RandomLEDBar8 .s
call :Compile Kitt\RandomLEDBars\RandomLEDBar9 .s
call :Compile Kitt\RandomLEDBars\RandomLEDBar10 .s
call :Compile Kitt\RandomLEDBars\RandomLEDBar11 .s
call :Compile Kitt\RandomLEDBars\RandomLEDBar12 .s
call :Compile Kitt\RandomLEDBars\RandomLEDBar13 .s
call :Compile Kitt\RandomLEDBars\RandomLEDBar14 .s
call :Compile Kitt\RandomLEDBars\RandomLEDBar15 .s
call :Compile Kitt\RandomLEDBars\RandomLEDBar16 .s
call :Compile Kitt\RandomLEDBars\RandomLEDBar17 .s
call :Compile Kitt\RandomLEDBars\RandomLEDBar18 .s
call :Compile Kitt\RandomLEDBars\RandomLEDBar19 .s
call :Compile Kitt\RandomLEDBars\RandomLEDBar20 .s
call :Compile Kitt\RandomLEDBars\RandomLEDBar21 .s
call :Compile Kitt\RandomLEDBars\RandomLEDBar22 .s
call :Compile Kitt\RandomLEDBars\RandomLEDBar23 .s
call :Compile Kitt\RandomLEDBars\RandomLEDBar24 .s

:: KITT scripts
call :Compile Kitt\Compass .s
call :Compile Kitt\Greeting .s
call :Compile Kitt\Jump .s
call :Compile Kitt\KittIgnition .s
call :Compile Kitt\Menu .s
call :Compile Kitt\Oxygen .s
call :Compile Kitt\PopUpLights .s
call :Compile Kitt\Pursuit .s
call :Compile Kitt\RandomNumbers .s
call :Compile Kitt\Remote .s
call :Compile Kitt\RollWindows .s
call :Compile Kitt\Scanner .s
call :Compile Kitt\Screen1 .s
call :Compile Kitt\SetAlphas .s
call :Compile Kitt\Shifter .s
call :Compile Kitt\Ski .s
call :Compile Kitt\Speedo .s
call :Compile Kitt\SurveillanceMode .s
call :Compile Kitt\TTops .s
call :Compile Kitt\TurningRadius .s
call :Compile Kitt\Variables .s
call :Compile Kitt\WindowTint .s
echo The compiling process is now complete.
pause
exit /B 0

:Compile
echo Compiling %~1 as %~2
"%SANNY_EXE%" --game vc --no-splash --compile "%~dp0\%~1.txt" "%~dp0\%~1%~2"

exit /B 0


:filedialog :: &file
setlocal
set dialog="about:<input type=file id=FILE><script>FILE.click();new ActiveXObject
set dialog=%dialog%('Scripting.FileSystemObject').GetStandardStream(1).WriteLine(FILE.value);
set dialog=%dialog%close();resizeTo(0,0);</script>"
for /f "tokens=* delims=" %%p in ('mshta.exe %dialog%') do set "file=%%p"
endlocal  & set %1=%file%
exit /B 0
