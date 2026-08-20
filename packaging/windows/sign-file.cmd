@echo off
setlocal
signtool.exe sign /fd SHA256 /tr http://timestamp.digicert.com /td SHA256 /f "%~dp0..\..\release-secrets\windows-signing.pfx" /p "%WINDOWS_CERTIFICATE_PASSWORD%" "%~1"
exit /b %errorlevel%
