@echo off
for /f "delims=" %%a in (d:\adminwin\lista_komputerow.txt) do (
copy "kopiowanie.bat" "\\%%a\C$\"
)