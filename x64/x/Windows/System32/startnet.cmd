@echo off
if exist X:\runok exit
echo .>X:\runok
mode con cols=16 lines=1
cd /d %systemroot%\system32

regedit /s pe.reg
echo ��ѹ��������
if exist %systemroot%\system32\drivers.7z  (
:::::7z x drivers.7z -o%temp%\pe-driver\drivers
DriverIndexer.exe load-driver drivers.7z 
)
::echo ��װ��������
::for /f %%i in ('dir /b %temp%\pe-driver\drivers') do (
::dpinst.exe /S /Path "%temp%\pe-driver\drivers\%%i"
::)
wpeinit
if exist %systemroot%\system32\startup.bat start "" %systemroot%\system32\startup.bat
exit

