@echo off
color 57
setlocal EnableExtensions
setlocal EnableDelayedExpansion
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )
title Windows 10 On Raspberrypi 4
echo ******************************************************************************************************************
echo *Windows10 On Raspberry Pi 4 
echo ******************************************************************************************************************                                                                                                                   
set /p W=Please enter the partition to install Windows£º
set /p E=Please enter the Boot partition£º
cd /d %~dp0 
:menu
title Windows On Raspberry Pi 4
cls
echo -S to add the image
echo -H to help
echo -E to exit

set /p choice=Please enter the command you want to execute:
if "%choice%"=="S" goto START
if "%choice%"=="E" goto EXIT
if "%choice%"=="s" goto START
if "%choice%"=="e" goto EXIT
if "%choice%"=="H" goto help
if "%choice%"=="h" goto help

:START
cls
title Windows 10 image is being deployed
dism /apply-image /imagefile:windows10arm64.wim /index:1 /applydir:%W%: 
title Building boot¡­¡­
bcdboot "%W%":\Windows /s "%E%": /f UEFI /l en-us
bcdedit /store "%E%":\efi\microsoft\boot\bcd /set {Default} nointegritychecks on
bcdedit /store "%E%":\efi\microsoft\boot\bcd /set {Default} testsigning on
bcdedit /store "%E%":\EFI\Microsoft\Boot\bcd /set {default} truncatememory 0x40000000
bcdedit /store "%E%":\efi\microsoft\boot\bcd /set {Default} recoveryenabled off
title Writing UEFI file¡­¡­
XCOPY UEFI\ "%E%":\ /s /f /h
echo Press any key to continue
pause>nul
goto menu

:EXIT
exit

:help
echo Step 1, create a new 128MB file system partition with FAT32

echo Step 2, create a new NTFS partition with the remaining space

echo step3 Download the Windows image, right-click to run as an administrator

echo step4 Enter the NTFS partition 

echo step5 Enter the FAT32 partition 

echo step6 Enter S to deploy the image

echo step7 Press E to exit after mirror deployment is complete
echo Press any key to continue¡­¡­
pause>nul
goto menu