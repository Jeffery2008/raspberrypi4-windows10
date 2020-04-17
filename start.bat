@echo off
color 57
echo choose  language 
title choose language 
cls
echo Zh-cn=1
echo En-us=2

set /p choice=Please choose language:

if "%choice%"=="1" goto zh-cn
if "%choice%"=="2" goto en-us

:zh-cn
start zh-cn.bat
exit
exit

:en-us
start en-us.bat
exit
exit
