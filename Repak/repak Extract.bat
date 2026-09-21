@echo off
chcp 65001
setlocal enabledelayedexpansion

for /f "tokens=2*" %%a in ('reg query "HKCU\Control Panel\International" /v LocaleName 2^>nul ^| find "LocaleName"') do set "LocaleName=%%b"
set "LangCode=!LocaleName:~0,2!"

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
    goto extract
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

:extract
if "!HAS_AES!"=="1" (
    %~dp0repak.exe --aes-key !AES_KEY! unpack %~1
) else (
    %~dp0repak.exe unpack %~1
)

