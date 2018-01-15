@echo off 
cls
title Instalacja stanowiska
md c:\install
net use z: \\10.10.0.1\kopia
xcopy /e z:\*.* c:\install\
c:\install\office2010\install.bat

net use z: /delete
