@echo off & pushd "%~dp0"
if exist winre.wim (
echo ����winre.wim��׼��������
set wimfile=winre.wim & goto :start
)

if exist boot.wim goto :boot_wim

for %%i in (*.iso) do (
echo û�з���winre.wim��boot.wim�����ڳ��Դ�iso�н�ѹ��boot.wim ......
bin\7z.exe e -o"%~dp0" -aoa "%%i" sources/boot.wim>NUL
if exist boot.wim goto :boot_wim
)
echo. & echo �Ҳ���winre.wim��boot.wim��ϵͳiso�κ�һ������������˳� ......
pause>nul & EXIT

:boot_wim
echo ����boot.wim��ֱ��������׼��ɾ����1 ......
bin\wimlib delete boot.wim 1 --check>NUL
set wimfile=boot.wim

:start

echo. & echo ��ʼʱ�䣺%time% & set startT=%time%
echo. & echo �Ժ򡭡���������
if exist excel.txt del excel.txt /f /q
for /f "delims=" %%i in (bin\Win10x86_64.txt) do (
        echo %%i | find ".exe" >NUL && (
        for /f "delims=" %%a in ('bin\wimlib dir %wimfile% 1 ^| find "." ^| findstr /vil "%%i"') do echo delete --force --recursive "%%a">>excel.txt
        ) || (
        for /f "delims=" %%a in ('bin\wimlib dir %wimfile% 1 --path=windows\winsxs ^| find "." ^| findstr /vi "%%i"') do echo delete --force --recursive "%%a">>excel.txt
        )
)

:::||::�����޸�ע���������
:::||echo. & echo ׼���ͷ�ע���...... & echo.
:::||if not exist %~dp0build md %~dp0build
:::||bin\7z.exe e -o%~dp0build -aoa %wimfile% Windows/System32/config/system>NUL
:::||if "%Processor_Architecture%%Processor_Architew6432%" equ "x86" (
:::||set "NSudo=%~dp0x86\NSudo32.exe"
:::||) else (
:::||set "NSudo=%~dp0x64\NSudo64.exe"
:::||) 
:::||start "" /w /min %NSudo% -U:S -P:E -M:S "reg load hklm\minipe %~dp0build\system">NUL
:::||start "" /w /min %NSudo% -U:S -P:E -M:S "reg add "HKLM\minipe\ControlSet001\Services\mpssvc" /f /v "Start" /t REG_DWORD /d 3">NUL
:::||echo. & echo �����޸���ϣ�����ע���...... & echo.
:::||start "" /w /min %NSudo% -U:S -P:E -M:S "reg unload hklm\minipe">nul
:::||start "" /w /min %NSudo% -U:S -P:E -M:S "reg unload hklm\minipe">nul
:::||echo. & echo ����%wimfile%�е�ע���...... & echo.
:::||bin\wimlib update %wimfile% --command="add '%~dp0build\system' '\Windows\System32\config\system'"
:::||::�޸�ע������
  echo. & echo ������ɾ����%wimfile%������ļ�����PE�����У�������΢�ȴ� ...... & echo.
bin\wimlib dir %wimfile% 1 --path=Windows\SysWOW64 | find ".exe" >NUL && (set FD=x64) || (set FD=x86)
bin\wimlib update %wimfile%<excel.txt>NUL
bin\wimlib update %wimfile%<%FD%\add2wim.txt>NUL
::������ļ�
::bin\wimlib update %wimfile% --command="add '%~dp0%FD%\lite\simsun.ttc' '\Windows\Fonts\simsun.ttc'"
::bin\wimlib update %wimfile% --command="add '%~dp0%FD%\lite\imageres.dll' '\Windows\system32\imageres.dll'"
::bin\wimlib update %wimfile% --command="add '%~dp0%FD%\lite\shell32.dll.mun' '\Windows\SystemResources\shell32.dll.mun'"
::����wim
bin\wimlib optimize %wimfile%
set endT=%time%
set /a costM=3%endT:~3,2%-3%startT:~3,2%
if %costM% lss 0 set /a costM=%costM%+60
set /a costT=3%endT:~9,2%-3%startT:~9,2%+(3%endT:~6,2%-3%startT:~6,2%+%costM%*60)*100
echo. & echo ����ʱ�䣺%endT%   ��ʱ��%costT:~0,-2%.%costT:~-2% ��
del /f /q *.txt
set output=%date:~0,4%%date:~5,2%%date:~8,2%%time:~0,2%%time:~3,2%%wimfile%
ren %wimfile% "%output%"
echo. & echo ��л���ĵȴ�������PE�Ѿ�������ɣ�%output%������������ͷ��pe��Ʒ�� & echo.
echo. & echo ���ڽ����������PE�����WindowsPE.iso & echo.
copy /y "%output%" %~dp0build\iso\Makeiso\boot\boot.wim
pause
%~dp0build\oscdimg.exe -h -d -m -o -u1 -lWindowsPE -bootdata:2#p00,e,b%~dp0build\iso\boot.bin#pEF,e,b%~dp0build\iso\efiboot.img %~dp0build\iso\Makeiso %~dp0WindowsPE.iso
echo ����ISO�ļ������ɣ������ڣ�%~dp0WindowsPE.iso
del /s /Q %~dp0build\iso\Makeiso\boot\boot.wim
pause
EXIT
