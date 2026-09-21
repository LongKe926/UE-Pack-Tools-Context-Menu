@echo off
chcp 65001
setlocal enabledelayedexpansion

for /f "tokens=2*" %%a in ('reg query "HKCU\Control Panel\International" /v LocaleName 2^>nul ^| find "LocaleName"') do set "LocaleName=%%b"
set "LangCode=!LocaleName:~0,2!"

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

:ask_aeskey
if /i "!LangCode!"=="zh" (
    echo(是否有AES加密？^(y/n^):
) else (
    echo(Is there AES Key? ^(y/n^):
)
set /p AES_ANSWER=
if /i "!AES_ANSWER!"=="y" (
    set "HAS_AES=1"
    goto input_aeskey
) else if /i "!AES_ANSWER!"=="n" (
    set "HAS_AES=0"
    goto ask_all
) else (
    if /i "!LangCode!"=="zh" (
        echo(请输入 y 或 n
    ) else (
        echo(Please enter y or n.
    )
    goto ask_aeskey
)

:input_aeskey
if /i "!LangCode!"=="zh" (
    echo(请输入AES Key:
) else (
    echo(Enter AES Key:
)
set /p AES_KEY=
if "!AES_KEY!"=="" (
    if /i "!LangCode!"=="zh" (
        echo(AES Key不能为空
    ) else (
        echo(AES Key cannot be empty.
    )
    goto input_aeskey
)

:ask_all
if /i "!LangCode!"=="zh" (
    echo(是否转换全部资产？^(y/n^):
) else (
    echo(Convert all assets? ^(y/n^):
)
set /p CONVERT_ALL=

if /i "!CONVERT_ALL!"=="y" (
    goto convert_all
) else if /i "!CONVERT_ALL!"=="n" (
    goto input_asset
) else (
    if /i "!LangCode!"=="zh" (
        echo(请输入 y 或 n
    ) else (
        echo(Please enter y or n.
    )
    goto ask_all
)

:convert_all
if "!HAS_AES!"=="1" (
    %~dp0retoc.exe to-legacy --no-shaders %~1 --version !VERSION! --aes-key !AES_KEY! %~dp0
) else (
    %~dp0retoc.exe to-legacy --no-shaders %~1 --version !VERSION! %~dp0
)
goto done

:input_asset
if /i "!LangCode!"=="zh" (
    echo(请输入资产文件路径 ^(例如 ^<GameName^>/Content/Visual/T_Body.uasset^):
) else (
    echo(Enter uasset path ^(Example ^<GameName^>/Content/Visual/T_Body.uasset^):
)
set /p ASSET_PATH=
if "!ASSET_PATH!"=="" (
    if /i "!LangCode!"=="zh" (
        echo(资产文件路径不能为空
    ) else (
        echo(Asset path cannot be empty.
    )
    goto input_asset
)

if "!HAS_AES!"=="1" (
    %~dp0retoc.exe to-legacy --no-shaders %~1 --filter !ASSET_PATH! --version !VERSION! --aes-key !AES_KEY! %~dp0
) else (
    %~dp0retoc.exe to-legacy --no-shaders %~1 --filter !ASSET_PATH! --version !VERSION! %~dp0
)
