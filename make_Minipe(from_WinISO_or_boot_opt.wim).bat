@echo off& cd /d %~dp0
if exist %~dp0boot.wim goto:start

for /f %%i in ('dir /b %~dp0*.iso') do set iso=%%i
if "%iso%"=="" exit

echo 正在解压出boot.wim....
%~dp0bin\7z.exe e -o%~dp0 -aoa  %~dp0%iso% sources/boot.wim
echo.

:start
echo 正在列表boot.wim第1分卷...
call:set_lst
%~dp0bin\wimlib dir %~dp0boot.wim 1 >List1.txt
type List1.txt | find "." >List2.txt
findstr /v %lst% List2.txt >List3.txt

echo.
echo 正在增删boot.wim包里的文件...
set dfr=delete --force --recursive
(for /f "delims=" %%i in (List3.txt) do (echo %dfr% "%%i")) >List4.txt

%~dp0bin\wimlib delete boot.WIM 1 --check
%~dp0bin\wimlib update boot.WIM <List4.txt
%~dp0bin\wimlib update boot.WIM <add2wim\add2wim.txt
%~dp0bin\wimlib optimize boot.WIM

del *.txt
echo 完成!!!
timeout 5 >nul
exit

:set_lst
set lst="simsun.ttc SortDefault F.3ware.inf F.acpi.inf F.acpidev.inf F.acpipagr.inf F.acpitime.inf F.adp80xx.inf F.amdgpio2.inf F.amdi2c.inf F.amdsata.inf F.amdsbs.inf F.arcsas.inf F.basicdisplay.inf F.basicrender.inf F.battery.inf F.buttonconverter.inf F.c_apo.inf F.c_avc.inf F.c_battery.inf F.c_biometric.inf F.c_cdrom.inf F.c_computeaccelerator.inf F.c_computer.inf F.c_diskdrive.inf F.c_display.inf F.c_extension.inf F.c_firmware.inf F.c_hdc.inf F.c_hidclass.inf F.c_image.inf F.c_keyboard.inf F.c_legacydriver.inf F.c_mcx.inf F.c_media.inf F.c_mediumchanger.inf F.c_memory.inf F.c_modem.inf F.c_monitor.inf F.c_mouse.inf F.c_mtd.inf F.c_multifunction.inf F.c_multiportserial.inf F.c_net.inf F.c_netdriver.inf F.c_netservice.inf F.c_nettrans.inf F.c_ports.inf F.c_processor.inf F.c_proximity.inf F.c_sbp2.inf F.c_scmdisk.inf F.c_scmvolume.inf F.c_scsiadapter.inf F.c_sdhost.inf F.c_smartcard.inf F.c_smartcardfilter.inf F.c_smartcardreader.inf F.c_smrdisk.inf F.c_smrvolume.inf F.c_sslaccel.inf F.c_swcomponent.inf F.c_swdevice.inf F.c_system.inf F.c_ucm.inf F.c_unknown.inf F.c_usb.inf F.c_usbdevice.inf F.c_usbfn.inf F.c_volsnap.inf F.c_volume.inf F.c_wceusbs.inf F.dc21x4vm.inf F.disk.inf F.dwup.inf F.e2xw10x64.inf F.ehstortcgdrv.inf F.errata.inf F.errdev.inf F.genericusbfn.inf F.hal.inf F.halextintclpiodma.inf F.halextpl080.inf F.hdaudbus.inf F.hdaudio.inf F.hdaudss.inf F.hidbatt.inf F.hiddigi.inf F.hidi2c.inf F.hidinterrupt.inf F.hidserv.inf F.hidspi_km.inf F.hidvhf.inf F.hpsamd.inf F.iagpio.inf F.iai2c.inf F.iaLPSS2i_GPIO2_BXT_P.inf F.iaLPSS2i_GPIO2_CNL.inf F.iaLPSS2i_GPIO2_GLK.inf F.iaLPSS2i_GPIO2_SKL.inf F.iaLPSS2i_I2C_BXT_P.inf F.iaLPSS2i_I2C_CNL.inf F.iaLPSS2i_I2C_GLK.inf F.iaLPSS2i_I2C_SKL.inf F.ialpssi_gpio.inf F.ialpssi_i2c.inf F.iastorav.inf F.iastorv.inf F.input.inf F.ipmidrv.inf F.ipoib6x.inf F.iscsi.inf F.ItSas35i.inf F.kdnic.inf F.keyboard.inf F.lltdio.inf F.lsi_sas.inf F.lsi_sas2i.inf F.lsi_sas3i.inf F.lsi_sss.inf F.machine.inf F.mausbhost.inf F.mchgr.inf F.megasas.inf F.megasas2i.inf F.megasas35i.inf F.megasr.inf F.mf.inf F.mlx4_bus.inf F.mshdc.inf F.msmouse.inf F.msports.inf F.mssmbios.inf F.mtconfig.inf F.mvumis.inf F.ndisimplatform.inf F.ndisimplatformmp.inf F.ndisuio.inf F.ndisvirtualbus.inf F.net1ix64.inf F.net1yx64.inf F.net40i68.inf F.net44amd.inf F.net7400-x64-n650.inf F.net7500-x64-n650f.inf F.net7800-x64-n650f.inf F.net9500-x64-n650f.inf F.netax88179_178a.inf F.netax88772.inf F.nete1e3e.inf F.nete1g3e.inf F.netefe3e.inf F.netg664.inf F.netimm.inf F.netip6.inf F.netjme.inf F.netk57a.inf F.netl160a.inf F.netl1e64.inf F.netl260a.inf F.netloop.inf F.netmscli.inf F.netmyk64.inf F.netnb.inf F.netnvma.inf F.netnwifi.inf F.netrasa.inf F.netrass.inf F.netrast.inf F.netrtl64.inf F.netserv.inf F.netsstpa.inf F.nett4x64.inf F.nettcpip.inf F.netvf63a.inf F.netvg63a.inf F.netxex64.inf F.netxix64.inf F.npsvctrig.inf F.nvdimm.inf F.nvraid.inf F.pci.inf F.percsas2i.inf F.percsas3i.inf F.pmem.inf F.puwk.inf F.qd3x64.inf F.ramdisk.inf F.rawsilo.inf F.rdshup.inf F.rspndr.inf F.rt640x64.inf F.rtux64w10.inf F.sbp2.inf F.sceregvl.inf F.scmbus.inf F.scmvolume.inf F.scsidev.inf F.sdbus.inf F.sdstor.inf F.secrecs.inf F.sisraid2.inf F.sisraid4.inf F.SmartSAMD.inf F.smrdisk.inf F.smrvolume.inf F.spaceport.inf F.stexstor.inf F.stornvme.inf F.storufs.inf F.swenum.inf F.uaspstor.inf F.uefi.inf F.ufxchipidea.inf F.ufxsynopsys.inf F.umbus.inf F.umpass.inf F.unknown.inf F.usb.inf F.usbhub3.inf F.usbnet.inf F.usbport.inf F.usbser.inf F.usbstor.inf F.usbxhci.inf F.vdrvroot.inf F.vhdmp.inf F.virtdisk.inf F.volmgr.inf F.volsnap.inf F.volume.inf F.vsmraid.inf F.vstxraid.inf F.wdmaudiocoresystem.inf F.wdmvsc.inf F.whyperkbd.inf F.wmiacpi.inf F.wnetvsc.inf F.wstorflt.inf F.wstorvsc.inf F.wvmbus.inf F.wvmbushid.inf F.wvmbusvideo.inf F.ykinx64.inf L2Schemas aero.msstyles regedit aclui.dll advapi32.dll aepic.dll apisetschema.dll asycfilt.dll atl.dll authz.dll basesrv.dll bcd.dll bcdboot.exe bcdedit.exe 2.*bcrypt.dll bcryptprimitives.dll BFE.DLL BOOTVID.DLL BrokerLib.dll cabinet.dll cdd.dll cfgmgr32.dll ci.dll clb.dll cmd.exe cmdext.dll combase.dll comdlg32.dll coml2.dll conhost.exe console.dll credui.dll 2.*crypt32.dll cryptbase.dll 2.cryptdll.dll 2.cryptsp.dll 2.*cryptsvc.dll csrsrv.dll csrss.exe C_1252.NLS C_437.NLS C_936.NLS d2d1.dll d3d11.dll dab.dll dabapi.dll dbgcore.dll dbghelp.dll devobj.dll devrtl.dll dhcpcore.dll dhcpcore6.dll dhcpcsvc.dll dhcpcsvc6.dll diskpart.exe dllhost.exe dnsapi.dll dnsrslvr.dll 2.dpapi.dll 2.dpapisrv.dll drvinst.exe drvload.exe drvsetup.dll drvstore.dll dsparse.dll dsrole.dll dui70.dll duser.dll dwmapi.dll DWrite.dll dxgi.dll eappprxy.dll EventAggregation.dll feclient.dll find.exe findstr.exe FirewallAPI.dll fltLib.dll fmifs.dll fontdrvhost.exe format.com fsutil.exe fsutilext.dll fveapi.dll fwbase.dll fwpolicyiomgr.dll FWPUCLNT.DLL gdi32.dll gdi32full.dll gpapi.dll hal.dll hhsetup.dll iertutil.dll ifsutil.dll IKEEXT.DLL imagehlp.dll imageres.dll imapi2.dll imm32.dll ipconfig.exe IPHLPAPI.DLL joinutil.dll KBDUS.DLL kd.dll KerbClientShared.dll kerberos.dll kernel.appcore.dll kernel32.dll KernelBase.dll keyiso.dll ksuser.dll ktmw32.dll l2nacp.dll linkinfo.dll lmhsvc.dll 2.locale.nls logoncli.dll lsasrv.dll lsass.exe lsm.dll l_intl.nls mfc42u.dll mpr.dll MPSSVC.dll msasn1.dll msctf.dll msftedit.dll msimg32.dll msports.dll msprivs.dll msv1_0.dll msvcp110_win.dll msvcp_win.dll msvcrt.dll mswsock.dll 2.*msxml 2.*ncrypt.dll ncsi.dll net.exe net1.exe netapi32.dll netbios.dll netcfgx.dll netjoin.dll netlogon.dll netmsg.dll netprovfw.dll NetSetupApi.dll NetSetupEngine.dll NetSetupSvc.dll netshell.dll netutils.dll newdev.dll ninput.dll nlaapi.dll nlasvc.dll normaliz.dll notepad.exe nrpsrv.dll nsi.dll nsisvc.dll 2.ntasn1.dll ntdll.dll ntdsapi.dll ntlanman.dll NtlmShared.dll ntmarta.dll ntoskrnl.exe ole32.dll oleacc.dll oleaccrc.dll oleaut32.dll oledlg.dll OneCoreCommonProxyStub.dll onex.dll osuninst.dll powrprof.dll profapi.dll propsys.dll psapi.dll PSHED.DLL rasadhlp.dll 2.*rasapi32.dll 2.rasman.dll reg.exe regsvr32.exe RpcEpMap.dll rpcrt4.dll RpcRtRemote.dll rpcss.dll 2.rsaenh.dll rundll32.exe samcli.dll samsrv.dll schannel.dll schema.dat sechost.dll secur32.dll services.exe setupapi.dll SHCore.dll shell32.dll shlwapi.dll shutdownux.dll slc.dll SmiEngine.dll smss.exe spfileq.dll 2.spinf.dll sppc.dll srvcli.dll srvsvc.dll sscore.dll sspicli.dll sspisrv.dll stdole2.tlb Storprop.dll svchost.exe sxs.dll sxssrv.dll sysclass.dll sysntfy.dll SystemEventsBrokerServer.dll takeown.exe taskmgr.exe TextShaping.dll ucrtbase.dll uexfat.dll ufat.dll ulib.dll umpdc.dll umpnpmgr.dll umpo.dll unattend.dll untfs.dll urlmon.dll user32.dll userenv.dll usp10.dll UXInit.dll uxtheme.dll vds.exe vdsbas.dll vdsdyn.dll vdsldr.exe vdsutil.dll vdsvd.dll vds_ps.dll version.dll virtdisk.dll webio.dll wevtapi.dll wevtsvc.dll wimgapi.dll wimserv.exe win32k.sys win32kbase.sys win32kfull.sys win32u.dll winbrand.dll Windows.FileExplorer.Common.dll windows.storage.dll CatRoot 2.drivers DriverStore WindowsCodecs.dll winhttp.dll wininet.dll wininit.exe wininitext.dll winlogon.exe winmm.dll winmmbase.dll winnlsres.dll winnsi.dll winpeshl winspool.drv winsrv.dll winsrvext.dll winsta.dll 2.wintrust.dll WinTypes.dll wkscli.dll wkssvc.dll wlanapi.dll wlanhlp.dll wlanmsm.dll wlansec.dll wlansvc.dll wlanutil.dll Wldap32.dll 2.*wldp.dll wmiclnt.dll wpeutil ws2_32.dll wshhyperv.dll wsock32.dll wtsapi32.dll xcopy.exe xmllite.dll winload. driver.stl g.DEFAULT g.DRIVERS g.SAM g.SECURITY g.SOFTWARE g.SYSTEM NetworkList .*_microsoft.windows.c..-controls.resources_.*_zh-cn .*_microsoft.windows.common-controls .*_microsoft.windows.gdiplus_.*_none Manifests.*_microsoft.windows.i..utomation.proxystub Manifests.*_microsoft.windows.isolationautomation Manifests.*_microsoft.windows.systemcompatible"

goto:eof