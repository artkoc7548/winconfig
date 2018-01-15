@echo off
mkdir d:\userkopia
mkdir d:\Backup
robocopy %USERPROFILE%\Documents d:\userkopia\%username%\Documents\ /E /MIR /XJ /njh /njs /dcopy:t /ndl
robocopy %USERPROFILE%\Desktop d:\userkopia\%username%\Desktop\ /E /MIR /XJ /njh /njs /dcopy:t /ndl

"C:\Program Files\7-Zip\7z.exe" a -tzip "d:\Backup\kopia_%DATE:~2,10%.zip" %USERPROFILE%\Documents %USERPROFILE%\Desktop
rmdir /s /q d:\userkopia
del /f /s /q %USERPROFILE%\Documents\
del /f /s /q %USERPROFILE%\Desktop\
robocopy d:\Backup\ \\192.168.66.200\kopia$\%computername%\ /mir
