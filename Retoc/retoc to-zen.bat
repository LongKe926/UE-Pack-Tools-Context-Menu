@echo off
chcp 65001
setlocal enabledelayedexpansion

set "UILang="
for /f "tokens=3" %%a in ('reg query "HKCU\Control Panel\Desktop" /v PreferredUILanguages 2^>nul ^| findstr /i "PreferredUILanguages"') do set "UILang=%%a"
set "LangCode=!UILang:~0,2!"

:input_version
if /i "!LangCode!"=="zh" (
    echo(输入UE版本号 ^(例如 UE4_25, UE4_26, UE5_0, UE5_1^):
) else (
    echo(Enter UE version ^(Example UE4_25, UE4_26, UE5_0, UE5_1^):
)
set /p VERSION=
if "%VERSION%"=="" (
   if /i "!LangCode!"=="zh" (
        echo(UE版本号不能为空
) else (
        echo(Version cannot be empty.
)
    goto input_version
)

%~dp0retoc.exe to-zen %~1 %~n1.utoc --version %VERSION%
