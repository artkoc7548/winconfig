rem @echo off
cls
mkdir C:\userkopia
echo Skrypt synchronizujacy
echo.
echo --- Kopiowanie dokumentow ---
robocopy %USERPROFILE%\Documents C:\userkopia\%username%\Documents\ /E /MIR /XJ /njh /njs /dcopy:t /ndl
echo.
echo --- Kopiowanie zawartosci pulpitu ---
robocopy %USERPROFILE%\Desktop C:\userkopia\%username%\Desktop\ /E /MIR /XJ /njh /njs /dcopy:t /ndl
echo.
echo --- Kopiowanie zakonczone ---

pause
"C:\Program Files\7-Zip\7z.exe" a c:\Backup\%date%.zip c:\userkopia
rem set PATH=%PATH%;%PROGRAMFILES%\7-zip
pause
rmdir /s /q C:\userkopia

pause
rem echo on