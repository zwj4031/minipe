cd /d "X:\Program Files"
net start wlansvc
wpeutil.exe InitializeNetwork
start WinXShell.exe -ui -jcfg wxsUI\UI_WIFI.zip\main.jcfg -theme light