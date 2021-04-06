@echo off & pushd "%~dp0"
if exist winre.wim (
echo 发现winre.wim！准备制作！
set wimfile=winre.wim & goto :start
)

if exist boot.wim goto :boot_wim

for %%i in (*.iso) do (
echo 没有发现winre.wim和boot.wim，正在尝试从iso中解压出boot.wim ......
bin\7z.exe e -o"%~dp0" -aoa "%%i" sources/boot.wim>NUL
if exist boot.wim goto :boot_wim
)
echo. & echo 找不到winre.wim、boot.wim、系统iso任何一个，按任意键退出 ......
pause>nul & EXIT

:boot_wim
echo 发现boot.wim，直接制作，准备删除卷1 ......
bin\wimlib delete boot.wim 1 --check>NUL
set wimfile=boot.wim

:start

echo. & echo 开始时间：%time% & set startT=%time%
echo. & echo 稍候………………
if exist excel.txt del excel.txt /f /q
for /f "delims=" %%i in (bin\Win10x86_64.txt) do (
        echo %%i | find ".exe" >NUL && (
        for /f "delims=" %%a in ('bin\wimlib dir %wimfile% 1 ^| find "." ^| findstr /vil "%%i"') do echo delete --force --recursive "%%a">>excel.txt
        ) || (
        for /f "delims=" %%a in ('bin\wimlib dir %wimfile% 1 --path=windows\winsxs ^| find "." ^| findstr /vi "%%i"') do echo delete --force --recursive "%%a">>excel.txt
        )
)

:::||::挂载修改注册表方法备份
:::||echo. & echo 准备释放注册表...... & echo.
:::||if not exist %~dp0build md %~dp0build
:::||bin\7z.exe e -o%~dp0build -aoa %wimfile% Windows/System32/config/system>NUL
:::||if "%Processor_Architecture%%Processor_Architew6432%" equ "x86" (
:::||set "NSudo=%~dp0x86\NSudo32.exe"
:::||) else (
:::||set "NSudo=%~dp0x64\NSudo64.exe"
:::||) 
:::||start "" /w /min %NSudo% -U:S -P:E -M:S "reg load hklm\minipe %~dp0build\system">NUL
:::||start "" /w /min %NSudo% -U:S -P:E -M:S "reg add "HKLM\minipe\ControlSet001\Services\mpssvc" /f /v "Start" /t REG_DWORD /d 3">NUL
:::||echo. & echo 挂载修改完毕，上载注册表...... & echo.
:::||start "" /w /min %NSudo% -U:S -P:E -M:S "reg unload hklm\minipe">nul
:::||start "" /w /min %NSudo% -U:S -P:E -M:S "reg unload hklm\minipe">nul
:::||echo. & echo 覆盖%wimfile%中的注册表...... & echo.
:::||bin\wimlib update %wimfile% --command="add '%~dp0build\system' '\Windows\System32\config\system'"
:::||::修改注册表完毕
  echo. & echo 正在增删削减%wimfile%包里的文件制作PE过程中，请您稍微等待 ...... & echo.
bin\wimlib dir %wimfile% 1 --path=Windows\SysWOW64 | find ".exe" >NUL && (set FD=x64) || (set FD=x86)
bin\wimlib update %wimfile%<excel.txt>NUL
bin\wimlib update %wimfile%<%FD%\add2wim.txt>NUL
::精简大文件
::bin\wimlib update %wimfile% --command="add '%~dp0%FD%\lite\simsun.ttc' '\Windows\Fonts\simsun.ttc'"
::bin\wimlib update %wimfile% --command="add '%~dp0%FD%\lite\imageres.dll' '\Windows\system32\imageres.dll'"
::bin\wimlib update %wimfile% --command="add '%~dp0%FD%\lite\shell32.dll.mun' '\Windows\SystemResources\shell32.dll.mun'"
::生成wim
bin\wimlib optimize %wimfile%
set endT=%time%
set /a costM=3%endT:~3,2%-3%startT:~3,2%
if %costM% lss 0 set /a costM=%costM%+60
set /a costT=3%endT:~9,2%-3%startT:~9,2%+(3%endT:~6,2%-3%startT:~6,2%+%costM%*60)*100
echo. & echo 结束时间：%endT%   耗时：%costT:~0,-2%.%costT:~-2% 秒
del /f /q *.txt
set output=%date:~0,4%%date:~5,2%%date:~8,2%%time:~0,2%%time:~3,2%%wimfile%
ren %wimfile% "%output%"
if exist %~dp0build rd /s /q %~dp0build
echo. & echo 感谢您的等待，现在PE已经制作完成，%output%就是你的网络骨头版pe成品！ & echo.
pause
EXIT
