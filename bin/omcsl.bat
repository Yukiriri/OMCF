@echo off & chcp 65001 >nul & setlocal enabledelayedexpansion
::cmd arg: <jar> <Xmx> [GC]
::env arg: [JAVA_BIN]


if "%JAVA_BIN%" == "" (
  set JAVA_BIN=java
)

for /f "delims=" %%b in ('%JAVA_BIN% -version 2^>^&1 ^| findstr /C:"build"') do (
  for /f "delims=" %%v in ('echo %%b ^| findstr /C:"build 21"')  do set JAVA_VER=21
  for /f "delims=" %%v in ('echo %%b ^| findstr /C:"build 17"')  do set JAVA_VER=17
  for /f "delims=" %%v in ('echo %%b ^| findstr /C:"build 11"')  do set JAVA_VER=11
  for /f "delims=" %%v in ('echo %%b ^| findstr /C:"build 1.8"') do set JAVA_VER=8
)
if "%JAVA_VER%" == "" (
  set JAVA_VER=8
)

set gc_policy=%3
if "%gc_policy%" == ""      set gc_policy=G1GC
set gc_flags=%~dp0\..\flags\%gc_policy%.txt

if %JAVA_VER% EQU 8 (
  for /f "delims=" %%i in (%gc_flags%) do set JAVA_OPTS=!JAVA_OPTS! %%i
) else (
  set JAVA_OPTS=%JAVA_OPTS% @%gc_flags%
)

if %JAVA_VER% GEQ 17 (
  set JAVA_OPTS=%JAVA_OPTS% --add-modules jdk.incubator.vector
)

set boot_core=%1
if "%boot_core:~-3%" == "jar" set boot_core=-jar %boot_core%

if "%OMCSL_DEBUG%" == "1" (
  if exist "logs" if %JAVA_VER% GEQ 11 (
    set JAVA_OPTS=%JAVA_OPTS% @%~dp0\..\flags\GC-xlog.txt
  )
  echo --------------------------------------------------
  echo [OMCSL][DEBUG]: JAVA_BIN   = %JAVA_BIN%
  echo [OMCSL][DEBUG]: JAVA_VER   = %JAVA_VER%
  echo [OMCSL][DEBUG]: Xmx        = %2
  echo [OMCSL][DEBUG]: JAVA_OPTS  = !JAVA_OPTS!
  echo [OMCSL][DEBUG]: boot_core  = %boot_core%
  echo --------------------------------------------------
  %JAVA_BIN% -Xmx%2 !JAVA_OPTS! -XX:+PrintFlagsFinal 2>nul | findstr /C:"command line"
  echo --------------------------------------------------
)

%JAVA_BIN% -Xms%2 -Xmx%2 %JAVA_OPTS% %boot_core% --nogui
