@echo off
chcp 65001
setlocal EnableDelayedExpansion

for /f "tokens=2*" %%a in ('reg query "HKCU\Control Panel\International" /v LocaleName 2^>nul ^| find "LocaleName"') do set "LocaleName=%%b"
set "LangCode=!LocaleName:~0,2!"

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    if /i "!LangCode!"=="zh" (
    echo(请以管理员身份运行:
) else (
    echo(Please run as an administrator.:
)
    echo.
    pause
    exit /b 1
)

set "BaseDir=%~dp0"
if "%BaseDir:~-1%"=="\" set "BaseDir=%BaseDir:~0,-1%"

reg add "HKCR\.pak\shell\Repak Extract" /ve /d "Repak Extract" /f
reg add "HKCR\.pak\shell\Repak Extract\command" /ve /d "\"%BaseDir%\Repak\repak Extract.bat\" \"%%1\"" /f

reg add "HKCR\.pak\shell\UnrealPak Extract" /ve /d "UnrealPak Extract" /f
reg add "HKCR\.pak\shell\UnrealPak Extract\command" /ve /d "\"%BaseDir%\UnrealPak\UnrealPak Extract.bat\" \"%%1\"" /f

reg add "HKCR\.pak\shell\Retoc to-legacy" /ve /d "Retoc to-legacy" /f
reg add "HKCR\.pak\shell\Retoc to-legacy\command" /ve /d "\"%BaseDir%\Retoc\retoc to-legacy.bat\" \"%%1\"" /f

reg add "HKCR\Directory\shell\Repak Compress" /ve /d "Repak Compress" /f
reg add "HKCR\Directory\shell\Repak Compress\command" /ve /d "\"%BaseDir%\Repak\repak Compress.bat\" \"%%1\"" /f

reg add "HKCR\Directory\shell\UnrealPak Compress" /ve /d "UnrealPak Compress" /f
reg add "HKCR\Directory\shell\UnrealPak Compress\command" /ve /d "\"%BaseDir%\UnrealPak\UnrealPak Compress.bat\" \"%%1\"" /f

reg add "HKCR\Directory\shell\Retoc to-zen" /ve /d "Retoc to-zen" /f
reg add "HKCR\Directory\shell\Retoc to-zen\command" /ve /d "\"%BaseDir%\Retoc\retoc to-zen.bat\" \"%%1\"" /f

echo.
pause
endlocal