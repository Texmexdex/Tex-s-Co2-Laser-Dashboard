@echo off
setlocal
cd /d "%~dp0"
start "FluidNC Dashboard Server" /min powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0serve-fluidnc-dashboard.ps1"
timeout /t 1 /nobreak >nul
start "" "http://localhost:8000/fluidnc-dashboard.html"
echo FluidNC dashboard opened. Keep the minimized server window running.
echo Close that server window when you are finished.
pause