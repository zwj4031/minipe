@echo off
if exist X:\runok exit
echo .>X:\runok
mode con cols=16 lines=1
cd /d %systemroot%\system32
::::��ʼ
set root=X:\windows\system32
set wait=pecmd wait 1000 
if not exist "X:\Program Files\WinXShell.exe" (
set say=%root%\pecmd.exe TEAM TEXT "
set font="L300 T300 R768 B768 $30^|wait 800 
set wait=echo ...
set xsay=echo ...
set show=echo ...
set xshow=echo ...
) else (
set say=start "" "X:\Program Files\WinXShell.exe" -ui -jcfg wxsUI\UI_led.zip -text
:::set say=start "" "X:\Program Files\WinXShell.exe" -ui -jcfg wxsUI\UI_led.zip -wait 5 -scroll -top -text
set show=start "" "X:\Program Files\WinXShell.exe" -ui -jcfg wxsUI\UI_show.zip -text
set xsay=start "" "X:\Program Files\WinXShell.exe" -code "QuitWindow(nil,'UI_LED')"
set xshow=start "" "X:\Program Files\WinXShell.exe" -code "QuitWindow(nil,'UI_show')"
set wait=%root%\pecmd.exe wait 800
)
if not "%2" == "" set args1=%1&&set args2=%2&&goto startjob
::���ýű�1����

regedit /s pe.reg
%say% "���ڰ�װ����..." %font%
echo ��ѹ��������
if exist %systemroot%\system32\drivers.7z  (
:::::7z x drivers.7z -o%temp%\pe-driver\drivers
DriverIndexer.exe load-driver drivers.7z 
)
%xsay%

%say% "�������繲����ط���..." %font%
net start lanmanserver>nul
net start lanmanworkstation>nul
%xsay%

%say% "��������..." %font%
if exist %systemroot%\pecmd.ini  (
pecmd load %systemroot%\pecmd.ini
)
%xsay%
%say% "���! ��ʼ����..." %font%
%xsay%
wpeinit
if exist %systemroot%\system32\startup.bat start "" %systemroot%\system32\startup.bat
exit

