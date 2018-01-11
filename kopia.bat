@echo off
mkdir d:\userkopia
mkdir d:\Backup
robocopy %USERPROFILE%\Documents d:\userkopia\%username%\Documents\ /E /MIR /XJ /njh /njs /dcopy:t /ndl
robocopy %USERPROFILE%\Desktop d:\userkopia\%username%\Desktop\ /E /MIR /XJ /njh /njs /dcopy:t /ndl

"C:\Program Files\7-Zip\7z.exe" a -tzip "d:\Backup\%username%_%DATE:~-4%_%DATE:~4,2%_%DATE:~7,2%.zip" d:\userkopia

pause
rmdir /s /q d:\userkopia
pause
del /f /s /q %USERPROFILE%\Documents\
del /f /s /q %USERPROFILE%\Desktop\
pause
robocopy d:\Backup\ \\192.168.66.200\kopia$\%computername%\ /mir
pause