@echo off & chcp 65001 >nul & setlocal enabledelayedexpansion
::cmd arg: <jar> <Xmx> [GC]
::env arg: [JAVA_BIN]

set OMCSL_DEBUG=1
%~dp0\omcsl %*
