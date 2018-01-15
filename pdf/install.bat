@echo off 
cls
title Instalacja  gpo
net use z: \\10.10.0.1\kopia
xcopy z:\Windows  %SystemRoot% /S/E
net use z: /delete
pause