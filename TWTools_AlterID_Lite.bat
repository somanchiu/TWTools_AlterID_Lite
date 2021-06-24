@echo off
taskkill /IM "TeamViewer.exe" /F
taskkill /IM "TeamViewer_Service.exe" /F

SET currentPath=%~dp0
cd /d %currentPath:~0,-1%

wmic path win32_computersystemproduct GET UUID >> UUID_bak.txt

Powershell -executionpolicy remotesigned -File createMOFfile.ps1

mofcomp changeUUID.mof

reg delete HKLM\SOFTWARE\WOW6432Node\TeamViewer /v ClientIC /f
reg delete HKLM\SOFTWARE\WOW6432Node\TeamViewer /v ClientID /f
reg delete HKLM\SOFTWARE\WOW6432Node\TeamViewer /v MIDInitiativeGUID /f
reg delete HKLM\SOFTWARE\WOW6432Node\TeamViewer /v LicenseType /f
reg add HKLM\SOFTWARE\WOW6432Node\TeamViewer /v UsageEnvironment /t REG_DWORD /d 2 /f

pause