@echo off 
cls
title Instalacja  sp1
net use z: \\10.10.0.1\kopia
copy z:\windows6.1-KB976932-X64.exe  c:\install 
net use z: /delete
c:\install\windows6.1-KB976932-X64.exe