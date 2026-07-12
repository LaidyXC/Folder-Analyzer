@echo off
cd /d "%~dp0"

powershell.exe -ExecutionPolicy Bypass -NoProfile -File "%~dp0FolderAnalyzerV1.ps1"

pause