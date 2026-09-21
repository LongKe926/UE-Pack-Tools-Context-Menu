@echo off
setlocal enableextensions

%~dp0UnrealPak.exe %~1.pak %~1\*.* -compress
