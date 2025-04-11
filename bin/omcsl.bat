@echo off & chcp 65001 >nul & setlocal enabledelayedexpansion
::cmd arg: <jar> <Xmx> <GC> [yggdrasil]
::env arg: [JAVA_BIN]


if "%JAVA_BIN%" == "" (
  set JAVA_BIN=java
)

if "%JAVA_VER%" == "" (
  for /f "delims=" %%b in ('%JAVA_BIN% -version 2^>^&1 ^| findstr /C:"build"') do (
    for /f "delims=" %%v in ('echo %%b ^| findstr /C:"build 21"') do set JAVA_VER=21
    for /f "delims=" %%v in ('echo %%b ^| findstr /C:"build 17"') do set JAVA_VER=17
    for /f "delims=" %%v in ('echo %%b ^| findstr /C:"build 11"') do set JAVA_VER=11
    for /f "delims=" %%v in ('echo %%b ^| findstr /C:"build 1.8"') do set JAVA_VER=8
  )
)
if "%JAVA_VER%" == "" (
  echo [OMCSL][ERROR]: JAVA_BIN error
  goto :EOF
)

set gc_policy=%3
if "%gc_policy%" == "" set gc_policy=gc8
if "%gc_policy:~0,3%" == "gc8" (
  set gc_flags=%~dp0\..\flags\GC8.txt
)
if "%gc_policy:~0,4%" == "gc21" (
  set gc_flags=%~dp0\..\flags\GC21.txt
)
if "%gc_policy:~0,5%" == "gc21c" (
  set gc_flags=%~dp0\..\flags\GC21c.txt
)

if "%4" == "ls" set yggdrasil_flags=%~dp0\..\flags\yggdrasil-littleskin.txt

if %JAVA_VER% GEQ 9 (
  if not "%yggdrasil_flags%" == "" set yggdrasil_flags=@%yggdrasil_flags%
  set JAVA_OPTS=@%gc_flags% %JAVA_OPTS% !yggdrasil_flags!
) else (
  if not "%yggdrasil_flags%" == "" set yggdrasil_flags=%yggdrasil_flags%
  for /f "delims=" %%i in (%gc_flags% !yggdrasil_flags!) do set JAVA_OPTS=!JAVA_OPTS! %%i
)

if %JAVA_VER% GEQ 17 (
  set JAVA_OPTS=%JAVA_OPTS% --add-modules=jdk.incubator.vector
)

set boot_core=%1
if "%boot_core:~-3%" == "jar" set boot_core=-jar %boot_core%

echo --------------------------------------------------
echo [OMCSL][DEBUG]: JAVA_BIN   = %JAVA_BIN%
echo [OMCSL][DEBUG]: JAVA_VER   = %JAVA_VER%
echo [OMCSL][DEBUG]: jar        = %1
echo [OMCSL][DEBUG]: Xmx        = %2
echo [OMCSL][DEBUG]: JAVA_OPTS  = %JAVA_OPTS%
echo [OMCSL][DEBUG]: boot_core  = %boot_core%
echo --------------------------------------------------
%JAVA_BIN% -Xmx%2 %JAVA_OPTS% -XX:+PrintFlagsFinal 2>nul | findstr /C:"command line"
echo --------------------------------------------------
if exist "logs" if %JAVA_VER% GEQ 11 (
  set JAVA_OPTS=!JAVA_OPTS! -Xlog:gc:file="logs/gc-heap.log"::filecount=0
  set JAVA_OPTS=!JAVA_OPTS! -Xlog:gc+metaspace:file="logs/gc-metaspace.log"::filecount=0
  set JAVA_OPTS=!JAVA_OPTS! -Xlog:codecache:file="logs/gc-codecache.log"::filecount=0
)

%JAVA_BIN% -Xms%2 -Xmx%2 %JAVA_OPTS% %boot_core% --nogui
