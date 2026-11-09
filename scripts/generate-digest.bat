@echo off
REM Morning Wire — runs on login, skips if already done today

REM Wait for network (up to 60s)
set TRIES=0
:waitnet
ping -n 1 github.com >nul 2>&1
if %errorlevel%==0 goto ready
set /a TRIES+=1
if %TRIES% GEQ 12 (
  echo Network not available after 60s, aborting. >> C:\01-Projects\RealProjects\morning-digest\scripts\digest-log.txt
  exit /b 1
)
timeout /t 5 /nobreak >nul
goto waitnet

:ready
cd /d C:\01-Projects\RealProjects\morning-digest
powershell -ExecutionPolicy Bypass -File scripts\generate-digest.ps1 >> scripts\digest-log.txt 2>&1
