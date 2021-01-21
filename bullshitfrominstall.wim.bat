@echo off&& cd /d %~dp0
%~dp0bin\7z.exe e -o%~dp0x64 -aoa install.wim -spf @%~dp0x64\syswow64.lst
