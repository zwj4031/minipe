cd /d "%~dp0"
WinXShell.exe -luacode "Taskbar:Pin('cmd.exe', nil, '/k echo lua_test', 'shell32.dll',27)"
