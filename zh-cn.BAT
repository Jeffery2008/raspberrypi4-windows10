@echo off
color 57
setlocal EnableExtensions
setlocal EnableDelayedExpansion
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )
title ��ݮ��4 windows10arm64��װһ����
echo ******************************************************************************************************************
echo *windows10arm64 for Pi4 һ������
echo *3B��+�����޷�����������һ��                                                    
echo *USB�޷�ʹ�ã���Ѽ�����뵽����ӿڣ������޷�ʹ�ã���������������������������       
echo *UEFI BOIS���Ѿ�����������IO����ʱ���Դ���Ͷ��޷�ʹ�ã�                                          
echo *�ڴ����Ѿ�������Ϊ1G��                                                                                               
echo *��лʹ��  
echo ******************************************************************************************************************                                                                                                                   
set /p W=������windows�����̷�:
set /p E=������UEFI�����̷���
cd /d %~dp0 
:menu
title ��ݮ��4 windows10arm64��װһ����
cls
echo -����S���в���
echo -����H�鿴����
echo -����E�˳�

set /p choice=������Ҫѡ�����Ŀ:
if "%choice%"=="S" goto START
if "%choice%"=="E" goto EXIT
if "%choice%"=="s" goto START
if "%choice%"=="e" goto EXIT

if "%choice%"=="H" goto help
if "%choice%"=="h" goto help

:START
cls
echo ׼������
title ���ڽ���wim10armӳ����......
dism /apply-image /imagefile:windows10arm64.wim /index:1 /applydir:%W%: 
echo ���ڽ�������
title ���ڽ�����������
bcdboot "%W%":\Windows /s "%E%": /f UEFI /l en-us
bcdedit /store "%E%":\efi\microsoft\boot\bcd /set {Default} nointegritychecks on
bcdedit /store "%E%":\efi\microsoft\boot\bcd /set {Default} testsigning on
bcdedit /store "%E%":\EFI\Microsoft\Boot\bcd /set {default} truncatememory 0x40000000
echo ���ڹر�RECOVERY
title ���ڹر�RECOVERY
bcdedit /store "%E%":\efi\microsoft\boot\bcd /set {Default} recoveryenabled off
echo ����ˢдUEFI
title ����ˢдUEFI
XCOPY UEFI\ "%E%":\ /s /f /h
echo ���س����ص��˵���
pause>nul
goto menu

:EXIT
exit

:help
echo step1 �½�������128mb����ʽ��Ϊfat32

echo step2 �½�������ʣ���С����ʽ��ΪNTFS

echo step3 ���أ��Ҽ��Թ���Ա��������

echo step4 ѡ���½���NTFS�����̷�

echo step5 ѡ���½���FAT32�����̷�

echo step6 ����S������

echo step7 ��������ɺ�����E�˳�

echo ���س����ص��˵���
pause>nul
goto menu