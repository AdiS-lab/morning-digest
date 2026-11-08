@echo off
REM Morning Wire — runs on login, skips if already done today
cd /d C:\01-Projects\RealProjects\morning-digest
bash scripts/generate-digest.sh >> scripts\digest-log.txt 2>&1
