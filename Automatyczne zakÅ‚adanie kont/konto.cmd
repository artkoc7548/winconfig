@echo off
@SET OLDUSERNAME=%USERNAME%
@SET USERNAME=USERNAME
@echo Skrypt dla Windows SBS2003: Pracownia internetowa w ka¾dej szkole 2004.
@echo Wygenerowany: 2004-07-26 21:54:43
@echo Modyfikacja dla potrzeb Edycji 2004-2007: 2005-05-17 19:11:13
@echo Copyright by mgr in¾. Dariusz Fabicki (fabik@oeiizk.waw.pl)

if "%1%" == "" goto BLAD
if %2% == "" goto BLAD
if "%3%" == "" goto BLAD
if %4% == "" goto BLAD
if %5% == "" goto BLAD

rem U nazwa uzytkownika (username) pierwszy parametr wywolania
SET U=%1%

rem F Pelna nazwa u¿ytkownika (Full name) drugi parametr wywolania
SET F=%2%

rem P Haslo uzytkownika (Password) trzeci parametr wywolania
SET P=%3%

rem G Grupa uzytkownika (Group name) czwarty parametr wywolania
SET G=%4%

rem C Komentarz do konta uzytkownika (Description) piaty paramter wywolania
SET C=%5%



rem H Œcie¿ka do nadrzêdnego katalogu domowego
SET H=O:\Home

rem W Œcie¿ka do g³ównego katalogu WWW
SET W=O:\WWW

rem PROFILE Sciezka do profili mobilnych uzytkownikow
SET PROFILE=O:\PROFILE

rem PROF Nazwa udzialu sieciowego w ktorym tworzone beda profile uzytkownikow
SET PROF=PROFILE

REM ===== MENIS ============
rem PROFMENIS Œcie¿ka do profili mobilnych u¿ytkowników, dla kont zak³adanych w 
rem jednostkach organizacyjnych PoziomA, PoziomB, PoziomC, PoziomD, Nauczyciele
SET PROFMENIS=O:\PROFILES


rem MENISPROF Nazwa udzialu sieciowego w ktorym tworzone beda profile uzytkownikow
SET MENISPROF=PROFILES$

rem HOMEPAGES Œcie¿ka do stron WWW u¿ytkoników zak³adanych w
rem jednostkach organizacyjnych PoziomA, PoziomB, PoziomC, PoziomD, Nauczyciele
SET HOMEPAGES=O:\HOMEPAGES

rem REDIRECTED G³ówna œcie¿ka do folderu Moje dokumenty dla kont zak³adanych w
rem jednostkach organizacyjnych PoziomA, PoziomB, PoziomC, PoziomD, Nauczyciele
SET REDIRECTED=O:\REDIRECTED


rem DESKTOP G³ówna œcie¿ka do folderu Pulpit dla kont zak³adanych w
rem jednostkach organizacyjnych PoziomA, PoziomB, PoziomC, PoziomD, Nauczyciele
SET DESKTOP=O:\DESKTOP

rem APPDATA G³ówna œcie¿ka do folderu Dane aplikacji dla kont zak³adanych w
rem jednostkach organizacyjnych PoziomA, PoziomB, PoziomC, PoziomD, Nauczyciele
SET APPDATA=O:\APPDATA

REM ===== MENIS KONIEC =====


@echo Rozpoczynamy operacje na bazie SAM
@echo --------------------------------------------------
@echo %F%
@echo --------------------------------------------------


echo Zalozenie konta i okreslenie hasla
net user %U% %P% /add /domain


echo Ponowne okreslenie hasla na wypadek, gdyby konto istnialo przed wywolaniem skryptu
net user %U% %P% /domain

rem Usun REM z linii ponizej aby zakladac konta z pustymi haslami
REM net user %U% "" /domain

echo Aktywacja konta
net user %U% /domain /active:yes

echo Okreslenie komentarza 
net user %U% /domain /comment:%C%

echo Okreslenie domyslnego kraju 
net user %U% /domain /countrycode:0

echo Okreslenie daty wygasniecia konta
net user %U% /domain /expires:never

echo Okreslenie pelnej nazwy uzytkownika
net user %U% /domain /fullname:%F%

rem echo Okreslania siezki do katalogu domowego
rem net user %U% /domain /homedir:"\\%COMPUTERNAME%\%U%"

echo Ustalanie mozliwosci zmiany hasla
net user %U% /domain /passwordchg:yes

echo Ustawianie wymagania co do hasla...
net user %U% /domain /passwordreq:yes

echo Ustalanie godzin logowania...
net user %U% /domain /times:all

echo Tworzenie grupy grupy %G% ...
net group %G% /add /domain

echo Dodawanie uzytkownika do grupy %G% ...
net group %G% %U% /add /domain

echo Dodawanie uzytkownika do grupy Internet Users ...
net group "SBS Internet Users" %U% /add /domain

rem ***************************************************************



echo Tworzenie g³ównego katalogu domowego...
mkdir "%H%"



echo Zabezpieczanie g³ównego katalogu domowego...

echo Odmawia prawa dostêpu IUSR_%COMPUTERNAME% do g³ównego katalogu domowego ... (dodaje do listy dostêpu)
echo T|cacls "%H%" /E /D "IUSR_%COMPUTERNAME%"

echo Przyznaje  pe³ne prawa dostêpu dla "Administratorzy" do g³ównego katalogu domowego ... (dodaje do listy dostêpu)
echo T|cacls "%H%" /E /G "Administratorzy:F"

echo Odwo³uje prawa dostêpu dla "Wszyscy" do g³ównego katalogu domowego ... (usuwa z listy dostêpu)
echo T|cacls "%H%" /E /R "Wszyscy"




echo Tworzenie katalogu domowego u¿ytkownika...
mkdir "%H%\%U%"

echo Tworzenie katalogu na przeadresowane Moje dokumenty u¿ytkownika...
mkdir "%H%\%U%\Moje dokumenty"

echo Tworzenie katalogu na przeadresowany Pulpit u¿ytkownika...
mkdir "%H%\%U%\Pulpit"

echo Okreslanie praw dostepu do katalogu domowego (tworzy now¹ listê dostêpu)
echo T|cacls "%H%\%U%" /T /P "Administratorzy":F %U%:F >NUL

echo Kasowanie zasobu sieciowego...
net share %U%$$ /DELETE /yes >NUL 

echo Tworzenie zasobu sieciowego...
net share %U%$$="%H%\%U%" /grant:Wszyscy,full /yes >NUL 



Rem **************** Obs³uga WWW ****************

echo Tworzenie g³ównego katalogu WWW...
mkdir "%W%"

echo Zabezpieczanie g³ównego katalogu WWW...

echo Przyznaje prawa dostêpu IUSR_%COMPUTERNAME% do g³ównego katalogu WWW ... (dodaje do listy dostêpu)
echo T|cacls "%W%" /E /G "IUSR_%COMPUTERNAME%:R"

echo Przyznaje  pe³ne prawa dostêpu dla "Administratorzy" do g³ównego katalogu WWW ... (dodaje do listy dostêpu)
echo T|cacls "%W%" /E /G "Administratorzy:F"

echo Odwo³uje prawa dostêpu dla "U¿ytkownicy" do g³ównego katalogu WWW ... (usuwa z listy dostêpu)
echo T|cacls "%W%" /E /R "U¾ytkownicy"
echo T|cacls "%W%" /E /R "U¿ytkownicy"

echo Tworzenie osobistego katalogu WWW u¿ytkownika...
mkdir "%W%\%U%"

echo Tworzenie osobistego katalogu WWW u¿ytkownika...
mkdir "%HOMEPAGES%\%U%"


echo Okreslanie praw dostepu do ososbistego katalogu WWW u¿ytkownika (tworzy now¹ listê dostêpu)
echo T|cacls "%W%\%U%" /T /P "IUSR_%COMPUTERNAME%":R "Administratorzy":F %U%:F >NUL

echo Okreslanie praw dostepu do ososbistego katalogu WWW u¿ytkownika (HOMEPAGES) (tworzy now¹ listê dostêpu)
echo T|cacls "%HOMEPAGES%\%U%" /T /P "IUSR_%COMPUTERNAME%":R "Administratorzy":F "U¾ytkownicy":R "nauczyciele":C %U%:c >NUL
echo T|cacls "%HOMEPAGES%\%U%" /T /P "IUSR_%COMPUTERNAME%":R "Administratorzy":F "U¿ytkownicy":R "nauczyciele":C %U%:c >NUL


echo Kasowanie zasobu sieciowego WWW...
net share "%U%$" /DELETE /yes >NUL 

echo Tworzenie zasobu sieciowego WWW...
net share "%U%$"="%W%\%U%" /grant:Wszyscy,full  /yes >NUL 

Rem ************ Koniec WWW ************



Rem *************************
Rem *** Wêdruj¹ce profile ***
Rem *************************

echo Tworzenie glownego katalogu na profile uzytkownikow

MKDIR "%PROFILE%"

echo Odwoluje prawa dostepu dla "Uzytkownicy" do glownego katalogu z profilami uzytkowników ... (usuwa z listy dostêpu)
echo T|cacls "%PROFILE%" /E /R "U¾ytkownicy"
echo T|cacls "%PROFILE%" /E /R "U¿ytkownicy"

echo Przyznaje prawa do prostego Zapisu dla "U¿ytkownicy" do g³ównego katalogu z profilami ... (dodaje do listy dostêpu)
echo T|cacls "%PROFILE%" /E /G "U¾ytkownicy:W"
echo T|cacls "%PROFILE%" /E /G "U¿ytkownicy:W"

echo Tworzenie zasobu sieciowego...
net share %PROF%="%PROFILE%" /grant:Wszyscy,full /yes >NUL

echo Definiowanie sciezki dla wedrujacych profili uzytkownikow
net user %U% /domain /profilepath:"\\%COMPUTERNAME%\%PROF%\%U%"

Rem ***************************************
Rem *** Koniec sekcji wêdruj¹ce profile ***
Rem ***************************************

Rem *************************************
Rem *** Skrypt logowania dla Win9x/Me ***
Rem *************************************

net user %U% /domain /scriptpath:"win9xme.bat"


if "%6%" == "" GOTO KONIEC

:POZIOM

SET POZIOM=%6%

rem Odtworzenie glownej struktury folderow uzytkownika

rem =========== Utworzenie folderu na Pulpit u¿ytkownika ===================
echo T| mkdir %DESKTOP%\%POZIOM%\%U%\ >NUL
rem =========== Utworzenie folderu na Pulpit u¿ytkownika KONIEC ============

rem =========== Utworzenie folderu na Moje dokumenty u¿ytkownika ===========
echo T| mkdir %REDIRECTED%\%U%\ >NUL
rem =========== Utworzenie folderu na Moje dokumenty u¿ytkownika KONIEC ====

rem =========== Utworzenie folderu na stronê WWW u¿ytkownika ===============
echo T| mkdir %HOMEPAGES%\%U%\ >NUL
rem =========== Utworzenie folderu na stronê WWW u¿ytkownika KONIEC ========



rem Zmiana uprawnieñ dla g³ównej struktury folderów u¿ytkownika

REM =========== ZMIANA UPRAWNIEÑ Do FOLDERU MOJE DOKUMENTY U¯YTKOWNIKA ========================================================
echo T| cacls %REDIRECTED%\%U% /G Administratorzy:F %U%:C SYSTEM:F TWàRCA-WA—CICIEL:F nauczyciele:F >NUL
echo T| cacls %REDIRECTED%\%U% /G Administratorzy:F %U%:C SYSTEM:F TWÓRCA-W£AŒCICIEL:F nauczyciele:F >NUL
IF EXIST %DESKTOP%\nauczyciele\%U% echo T| cacls %REDIRECTED%\%U% /G Administratorzy:F %U%:F SYSTEM:F TWàRCA-WA—CICIEL:F >NUL
IF EXIST %DESKTOP%\nauczyciele\%U% echo T| cacls %REDIRECTED%\%U% /G Administratorzy:F %U%:F SYSTEM:F TWÓRCA-W£AŒCICIEL:F >NUL
REM =========== ZMIANA UPRAWNIEÑ Do FOLDERU MOJE DOKUMENTY U¯YTKOWNIKA KONIEC =================================================


REM =========== ZMIANA UPRAWNIEÑ Do FOLDERU PULPIT U¯YTKOWNIKA ================================================================
echo T| cacls %DESKTOP%\%POZIOM%\%U% /G Administratorzy:F %U%:C SYSTEM:F TWàRCA-WA—CICIEL:F nauczyciele:F >NUL
echo T| cacls %DESKTOP%\%POZIOM%\%U% /G Administratorzy:F %U%:C SYSTEM:F TWÓRCA-W£AŒCICIEL:F nauczyciele:F >NUL
IF EXIST %DESKTOP%\nauczyciele\%U% echo T| cacls %DESKTOP%\%POZIOM%\%U% /G Administratorzy:F %U%:C SYSTEM:F TWàRCA-WA—CICIEL:F >NUL
IF EXIST %DESKTOP%\nauczyciele\%U% echo T| cacls %DESKTOP%\%POZIOM%\%U% /G Administratorzy:F %U%:C SYSTEM:F TWÓRCA-W£AŒCICIEL:F >NUL
REM =========== ZMIANA UPRAWNIEÑ Do FOLDERU PULPIT U¯YTKOWNIKA KONIEC =========================================================


REM =========== ZMIANA UPRAWNIEÑ Do OSOBISTEJ STRONY WWW U¯YTKOWNIKA ==========================================================
echo T| cacls %HOMEPAGES%\%U% /G Administratorzy:F %U%:F SYSTEM:F U¾ytkownicy:R nauczyciele:F >NUL
echo T| cacls %HOMEPAGES%\%U% /G Administratorzy:F %U%:F SYSTEM:F U¿ytkownicy:R nauczyciele:F >NUL
IF EXIST %DESKTOP%\nauczyciele\%U% echo T| cacls %HOMEPAGES%\%U% /G Administratorzy:F %U%:F SYSTEM:F U¾ytkownicy:R >NUL
IF EXIST %DESKTOP%\nauczyciele\%U% echo T| cacls %HOMEPAGES%\%U% /G Administratorzy:F %U%:F SYSTEM:F U¿ytkownicy:R >NUL
REM =========== ZMIANA UPRAWNIEÑ Do OSOBISTEJ STRONY WWW U¯YTKOWNIKA KONIEC ===================================================

echo Definiowanie sciezki dla wedrujacych profili uzytkownikow
net user %U% /domain /profilepath:"\\%COMPUTERNAME%\%MENISPROF%\%U%"



GOTO KONIEC


:BLAD
  echo _
  echo _
  echo _
  echo *****************************************
  echo Podano nieprawidlowe paramertry wywolania
  echo *****************************************
  echo Prawidlowe wywolanie:
  echo Parametr pierwszy: nazwa konta (bez znakow "")
  echo Parametr drugi : Pelna nazwa konta (w znakach  "")
  echo Parametr trzeci: Haslo (bez znakow "")
  echo parametr czwarty: Nazwa grupy (w znakach "")
  echo paramter piaty: Opis konta (w znakach "")
  echo paramter szosty (opcjonalny): nazwa poziomu MEN, do ktorego administrator przeniesie konto
  echo przykladowe wywolanie:
  echo konto.cmd fabik1 "Dariusz Fabicki" 123 PoziomC "Wysoki jak brzoza a ..."
  echo konto.cmd fabik1 "Dariusz Fabicki" 123 PoziomC "Wysoki jak brzoza a ..." nauczyciele
  echo konto.cmd fabik1 "Dariusz Fabicki" 123 PoziomC "Wysoki jak brzoza a ..." poziomb
  echo _
  echo _
  echo _
  pause

:KONIEC
rem -- koniec skryptu konto.cmd --
rem -- przywrócenie wartoœci pocz¹tkowych --
@echo **************************************************
@echo ***KONIEC***
@SET USERNAME=%OLDUSERNAME%
@SET OLDUSERNAME=
