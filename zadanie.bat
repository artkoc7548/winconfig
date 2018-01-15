for /f „eol=” %i IN (lista_komputerow.txt) DO robocopy \\%i\zadanie\zadanie d:/zadanie/%i/
pause