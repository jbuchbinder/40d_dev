@echo off
del AUTOEXEC.BIN
set path=f:\_dev\chdk_gcc\;f:\_dev\chdk_gcc\bin;f:\_tools;f:\_dev\tools
gmake clean
gmake
rem gmake clean

pause