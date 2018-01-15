@echo off
REM Skrypt dla Windows SBS2003: Pracownia internetowa w ka¿dej szkole 2004.
REM Wygenerowany: 2004-07-26 21:54:43
REM Copyright by mgr in¿. Dariusz Fabicki (fabik@oeiizk.waw.pl)
REM Skrypt s³u¿y do usuwania plików u¿ytkownikow lub kont i plików u¿ytkownikow


REM ===== Zmienne predefiniowane ==========================================================

REM ===== OEIiZK ====
rem H Œcie¿ka do nadrzêdnego katalogu domowego u¿ytkownika, w którym s¹
rem przechowywane foldery Pulpit oraz Moje dokumenty, dla kont znajduj¹cych siê poza
rem jednostkami organizacyjnymi PoziomA, PoziomB, PoziomC, PoziomD, Nauczyciele
SET H=O:\Home

rem W Œcie¿ka do g³ównego katalogu WWW, w którym s¹ przechowywane strony domowe
rem u¿ytkowników, dla kont znajduj¹cych siê poza
rem jednostkami organizacyjnymi PoziomA, PoziomB, PoziomC, PoziomD, Nauczyciele
SET W=O:\WWW

rem PROFILE Œcie¿ka do profili mobilnych u¿ytkowników, dla kont znajduj¹cych siê poza 
rem jednostkami organizacyjnymi PoziomA, PoziomB, PoziomC, PoziomD, Nauczyciele
SET PROFILE=O:\PROFILE
REM ===== OEIiZK KONIEC===== 

REM ===== MENIS ============
rem PROFMENIS Œcie¿ka do profili mobilnych u¿ytkowników, dla kont zak³adanych w 
rem jednostkach organizacyjnych PoziomA, PoziomB, PoziomC, PoziomD, Nauczyciele
SET PROFMENIS=O:\PROFILES

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
REM ===== Zmienne predefionowane KONIEC ===================================================



REM Zmienne przekazane ======================================================================================
if "%1%" == "" goto BLAD
rem CO_USUWAM Okreœla, czy usuwane s¹ pliki (wartoœæ PLIKI), czy pliki i konto u¿ytkownika (wartoœæ WSZYSTKO)
SET CO_USUWAM=%1%


if "%2%" == "" goto BLAD
rem U nazwa u¿ytkownika (username) drugi parametr wywo³ania
SET U=%2%

if "%3%" == "" goto NOMENIS
rem POZIOM nazwa domyœlnej jednostki organizacyjnej (parametr opcjonalny) do której nale¿y u¿ytkownik
SET POZIOM=%3%
REM Zmienne przekazane KONIEC ===============================================================================


rem **************************************************************************************
rem Sekcja dla kont, które po utworzeniu zosta³y przeniesione do jednostek organizacyjnych
rem PoziomA, PoziomB, PoizomC, PoziomD, Nauczyciele
rem **************************************************************************************


rem === Dodaj konto na wypadek gdyby nie istnia³o ============================================
net user %u% asdertbsdwe34 /add /domain >NUL
rem === Dodaj konto na wypadek gdyby nie istnia³o KONIEC =====================================

rem =========== usuwanie folderu Pulpit ======================================================
IF EXIST %DESKTOP%\%POZIOM%\%U% echo T| rd %DESKTOP%\%POZIOM%\%U%\ /s/q >NUL

rem Usuwanie pzosta³ych folderów Pulpit, w przypadku, gdyby administrator przenosi³ w czasie,
rem konta do jednostek domyœlnych MENiS: PoziomA, PoziomB, PoziomC, PoziomD, Nauczyciele
IF EXIST %DESKTOP%\pozioma\%U% echo T| rd %DESKTOP%\pozioma\%U%\ /s/q >NUL
IF EXIST %DESKTOP%\poziomb\%U% echo T| rd %DESKTOP%\poziomb\%U%\ /s/q >NUL
IF EXIST %DESKTOP%\poziomc\%U% echo T| rd %DESKTOP%\poziomc\%U%\ /s/q >NUL
IF EXIST %DESKTOP%\poziomd\%U% echo T| rd %DESKTOP%\poziomd\%U%\ /s/q >NUL
IF EXIST %DESKTOP%\nauczyciele\%U% echo T| rd %DESKTOP%\nauczyciele\%U%\ /s/q >NUL
rem =========== usuwanie folderu Pulpit KONIEC ===============================================




rem =========== usuwanie folderu Moje dokumenty ============================
IF EXIST %REDIRECTED%\%U% echo T| rd %REDIRECTED%\%U%\ /s/q >NUL
rem =========== usuwanie folderu Moje dokumenty Koniec =====================

rem =========== usuwanie osobistej strony WWW ==============================
IF EXIST %HOMEPAGES%\%U% echo T| rd %HOMEPAGES%\%U%\ /s/q >NUL
rem =========== usuwanie osobistej strony WWW Koniec =======================

rem =========== usuwanie osobistego profilu mobilnego ======================
IF EXIST %PROFMENIS%\%U% echo T| rd %PROFMENIS%\%U%\ /s/q >NUL
IF EXIST %PROFMENIS%\%U%.V2 echo T| rd %PROFMENIS%\%U%.V2\ /s/q >NUL
rem =========== usuwanie osobistego profilu mobilnego Koniec ===============

rem ======= Usuwanie osobistego profilu mobilnego u¿ytkownika ==============
IF EXIST %PROFILE%\%U% echo T| rd %PROFILE%\%U%\ /s/q >NUL
IF EXIST %PROFILE%\%U%.V2 echo T| rd %PROFILE%\%U%.V2\ /s/q >NUL
rem ======= Usuwanie osobistego profilu mobilnego u¿ytkownika KONIEC =======

rem =========== usuwanie folderu Dane aplikacje ============================
IF EXIST %APPDATA%\%U% echo T| rd %APPDATA%\%U%\ /s/q >NUL
rem =========== usuwanie folderu Dane aplikacje Koniec =====================



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
IF EXIST %DESKTOP%\nauczyciele\%U% echo T| cacls %REDIRECTED%\%U% /G Administratorzy:F %U%:F SYSTEM:F TWàRCA-WA—CICIEL:F >NUL
REM =========== ZMIANA UPRAWNIEÑ Do FOLDERU MOJE DOKUMENTY U¯YTKOWNIKA KONIEC =================================================


REM =========== ZMIANA UPRAWNIEÑ Do FOLDERU PULPIT U¯YTKOWNIKA ================================================================
echo T| cacls %DESKTOP%\%POZIOM%\%U% /G Administratorzy:F %U%:C SYSTEM:F TWàRCA-WA—CICIEL:F nauczyciele:F >NUL
IF EXIST %DESKTOP%\nauczyciele\%U% echo T| cacls %DESKTOP%\%POZIOM%\%U% /G Administratorzy:F %U%:C SYSTEM:F TWàRCA-WA—CICIEL:F >NUL
REM =========== ZMIANA UPRAWNIEÑ Do FOLDERU PULPIT U¯YTKOWNIKA KONIEC =========================================================


REM =========== ZMIANA UPRAWNIEÑ Do OSOBISTEJ STRONY WWW U¯YTKOWNIKA ==========================================================
echo T| cacls %HOMEPAGES%\%U% /G Administratorzy:F %U%:F SYSTEM:F U¾ytkownicy:R nauczyciele:F >NUL
IF EXIST %DESKTOP%\nauczyciele\%U% echo T| cacls %HOMEPAGES%\%U% /G Administratorzy:F %U%:F SYSTEM:F U¾ytkownicy:R >NUL
REM =========== ZMIANA UPRAWNIEÑ Do OSOBISTEJ STRONY WWW U¯YTKOWNIKA KONIEC ===================================================




rem **************************************************************************************
rem Sekcja dla kont, które po utworzeniu zosta³y przeniesione do jednostek organizacyjnych
rem PoziomA, PoziomB, PoizomC, PoziomD, Nauczyciele KONIEC
rem **************************************************************************************



GOTO PRAWIE_KONIEC


:NOMENIS

rem ======================================================================================
rem ****************************************************************************************************************
rem Sekcja dla kont, które po za³o¿eniu zosta³y przeniesione do jednostek organizacyjnych:
rem innych ni¿ PoziomA, PoziomB, PoizomC, PoziomD, Nauczyciele, a teraz znajduj¹ siê gdziekolwiek w Active Direcotry
rem ****************************************************************************************************************


rem === Dodaj konto na wypadek gdyby nie istnia³o ============================================
net user %u% asdertbsdwe34 /add /domain >NUL
rem === Dodaj konto na wypadek gdyby nie istnia³o KONIEC =====================================


rem Usuwanie zawartoœci pulpitów, w przypadku, gdyby administrator przenosi³, w czasie pracy,
rem konta do jednostek domyœlnych MENiS
rem =========== Usuwanie folderu Pulpit =============================================
IF EXIST %DESKTOP%\%POZIOM%\%U% echo T| rd %DESKTOP%\%POZIOM%\%U%\ /s/q >NUL
IF EXIST %DESKTOP%\pozioma\%U% echo T| rd %DESKTOP%\pozioma\%U%\ /s/q >NUL
IF EXIST %DESKTOP%\poziomb\%U% echo T| rd %DESKTOP%\poziomb\%U%\ /s/q >NUL
IF EXIST %DESKTOP%\poziomc\%U% echo T| rd %DESKTOP%\poziomc\%U%\ /s/q >NUL
IF EXIST %DESKTOP%\poziomd\%U% echo T| rd %DESKTOP%\poziomd\%U%\ /s/q >NUL
IF EXIST %DESKTOP%\nauczyciele\%U% echo T| rd %DESKTOP%\nauczyciele\%U%\ /s/q >NUL
rem =========== Usuwanie folderu Pulpit KONIEC ======================================



rem Usuwanie zawartoœci dokumentów, www oraz  profilu u¿ytkownika, gdyby administrator przenosi³,
rem w czasie pracy, konta do jednostek domyœlnych MENiS

rem =========== usuwanie folderu Moje dokumenty ============================
IF EXIST %REDIRECTED%\%U% echo T| rd %REDIRECTED%\%U%\ /s/q >NUL
rem =========== usuwanie folderu Moje dokumenty Koniec =====================

rem =========== usuwanie osobistej strony WWW ==============================
IF EXIST %HOMEPAGES%\%U% echo T| rd %HOMEPAGES%\%U%\ /s/q >NUL
rem =========== usuwanie osobistej strony WWW Koniec =======================

rem =========== usuwanie osobistego profilu mobilnego ======================
IF EXIST %PROFMENIS%\%U% echo T| rd %PROFMENIS%\%U%\ /s/q >NUL
IF EXIST %PROFMENIS%\%U%.V2 echo T| rd %PROFMENIS%\%U%.V2\ /s/q >NUL
rem =========== usuwanie osobistego profilu mobilnego Koniec ===============

rem ======= Usuwanie osobistego profilu mobilnego u¿ytkownika ==============
IF EXIST %PROFILE%\%U% echo T| rd %PROFILE%\%U%\ /s/q >NUL
IF EXIST %PROFILE%\%U%.V2 echo T| rd %PROFILE%\%U%.V2\ /s/q >NUL
rem ======= Usuwanie osobistego profilu mobilnego u¿ytkownika KONIEC =======

rem =========== usuwanie folderu Dane aplikacje ============================
IF EXIST %APPDATA%\%U% echo T| rd %APPDATA%\%U%\ /s/q >NUL
rem =========== usuwanie folderu Dane aplikacje Koniec =====================



rem ======= Usuwanie zasobu sieciowego, udostêpniaj¹cego foldery Pulpit oraz Moje dokumenty u¿ytkownika =============
net share %U%$$ /DELETE /yes >NUL
rem ======= Usuwanie zasobu sieciowego, udostêpniaj¹cego foldery Pulpit oraz Moje dokumenty u¿ytkownika KONIEC ======

rem ======= Usuwanie katalogu zawieraj¹cego foldery Pulpit oraz Moje dokumenty u¿ytkownika ==========================
IF EXIST %H%\%U% echo T| rd %H%\%U%\ /s/q >NUL
rem ======= Usuwanie katalogu zawieraj¹cego foldery Pulpit oraz Moje dokumenty u¿ytkownika KONIEC ===================

rem ======= Tworzenie katalogu, w którym bêd¹ przechowywane foldery Pulpit oraz Moje dokumenty u¿ytkownika ==========
mkdir "%H%\%U%" >NUL
mkdir "%H%\%U%\Moje dokumenty" >NUL
mkdir "%H%\%U%\Pulpit" >NUL
rem ======= Tworzenie katalogu, w którym bêd¹ przechowywane foldery Pulpit oraz Moje dokumenty u¿ytkownika KONIEC ===

rem ======= Okreœlanie praw dostêpu do folderów u¿ytkownika (tworzy now¹ listê dostêpu) =============================
echo T|cacls "%H%\%U%" /T /P "Administratorzy":F %U%:F >NUL
rem ======= Okreœlanie praw dostêpu do folderów u¿ytkownika (tworzy now¹ listê dostêpu) KONIEC ======================


rem ======= Tworzenie zasobu sieciowego, zawieraj¹cego foldery Pulpit oraz Moje dokumenty u¿ytkownika ===============
net share %U%$$="%H%\%U%" /grant:Wszyscy,full /yes >NUL
rem ======= Tworzenie zasobu sieciowego, zawieraj¹cego foldery Pulpit oraz Moje dokumenty u¿ytkownika KONIEC ========




rem ======= Usuwanie zasobu sieciowego, udostêpniaj¹cego osobist¹ stronê WWW u¿ytkownika ============================
net share "%U%$" /DELETE /yes >NUL
rem ======= Usuwanie zasobu sieciowego, udostêpniaj¹cego osobist¹ stronê WWW u¿ytkownika KONIEC =====================

rem ======= Usuwanie katalogu zawieraj¹cego osobist¹ stronê WWW u¿ytkownika =========================================
IF EXIST %W%\%U% echo T| rd %W%\%U%\ /s/q >NUL
rem ======= Usuwanie katalogu zawieraj¹cego osobist¹ stronê WWW u¿ytkownika KONIEC ==================================

rem ======= Tworzenie katalogu, w którym bêdzie przechowywana osobista strona WWW u¿ytkownika =======================
mkdir "%W%\%U%" >NUL
rem ======= Tworzenie katalogu, w którym bêdzie przechowywana osobista strona WWW u¿ytkownika KONIEC ================

rem ======= Tworzenie katalogu, w którym bêdzie przechowywana osobista strona WWW u¿ytkownika na wypadek póŸniejszego przeniesienia konta do jednej z domyœlnych jednostek organizacyjnych MENiS ===========
mkdir "%HOMEPAGES%\%U%" >NUL
rem ======= Tworzenie katalogu, w którym bêdzie przechowywana osobista strona WWW u¿ytkownika na wypadek póŸniejszego przeniesienia konta do jednej z domyœlnych jednostek organizacyjnych MENiS KONIEC ====

rem ======= Okreœlanie praw dostêpu do osobistego katalogu WWW u¿ytkownika (tworzy now¹ listê dostêpu) ==============
echo T|cacls "%W%\%U%" /T /P "IUSR_%COMPUTERNAME%":R "Administratorzy":F %U%:F >NUL
rem ======= Okreœlanie praw dostêpu do osobistego katalogu WWW u¿ytkownika (tworzy now¹ listê dostêpu) KONIEC =======

rem ======= Okreœlanie praw dostêpu do osobistego katalogu WWW u¿ytkownika (HOMEPAGES) (tworzy now¹ listê dostêpu) na wypadek póŸniejszego przeniesienia konta do jednej z domyœlnych jednostek organizacyjnych MENiS ==========
echo T|cacls "%HOMEPAGES%\%U%" /T /P "IUSR_%COMPUTERNAME%":R "Administratorzy":F "U¾ytkownicy":R %U%:F >NUL
rem ======= Okreœlanie praw dostêpu do osobistego katalogu WWW u¿ytkownika (HOMEPAGES) (tworzy now¹ listê dostêpu) na wypadek póŸniejszego przeniesienia konta do jednej z domyœlnych jednostek organizacyjnych MENiS KONIEC ===

rem ======= Tworzenie zasobu sieciowego udostêpniaj¹cego osobist¹ stronê WWW u¿ytkonika =============================
net share "%U%$"="%W%\%U%" /grant:Wszyscy,full  /yes >NUL
rem ======= Tworzenie zasobu sieciowego udostêpniaj¹cego osobist¹ stronê WWW u¿ytkonika KONIEC ======================




rem =================================================================================================================

rem ***********************************************************************************************************************
rem Sekcja dla kont, które po za³o¿eniu zosta³y przeniesione do jednostek organizacyjnych:
rem innych ni¿ PoziomA, PoziomB, PoizomC, PoziomD, Nauczyciele, a teraz znajduj¹ siê gdziekolwiek w Active Direcotry KONIEC
rem ***********************************************************************************************************************



GOTO PRAWIE_KONIEC


:PRAWIE_KONIEC
@echo -------------------------------------
@echo Usunieto zawartosc folderow konta %U%
@echo -------------------------------------
 IF "%CO_USUWAM%"=="WSZYSTKO" GOTO WSZYSTKO
 IF "%CO_USUWAM%"=="wszystko" GOTO WSZYSTKO
 IF "%CO_USUWAM%"=="Wszystko" GOTO WSZYSTKO
 IF "%CO_USUWAM%"=="wSZYSTKO" GOTO WSZYSTKO

GOTO KONIEC


:WSZYSTKO



rem =========== usuwanie folderu Pulpit ======================================================
IF EXIST %DESKTOP%\%POZIOM%\%U% echo T| rd %DESKTOP%\%POZIOM%\%U%\ /s/q >NUL

rem Usuwanie pzosta³ych folderów Pulpit, w przypadku, gdyby administrator przenosi³ w czasie,
rem konta do jednostek domyœlnych MENiS: PoziomA, PoziomB, PoziomC, PoziomD, Nauczyciele
IF EXIST %DESKTOP%\pozioma\%U% echo T| rd %DESKTOP%\pozioma\%U%\ /s/q >NUL
IF EXIST %DESKTOP%\poziomb\%U% echo T| rd %DESKTOP%\poziomb\%U%\ /s/q >NUL
IF EXIST %DESKTOP%\poziomc\%U% echo T| rd %DESKTOP%\poziomc\%U%\ /s/q >NUL
IF EXIST %DESKTOP%\poziomd\%U% echo T| rd %DESKTOP%\poziomd\%U%\ /s/q >NUL
IF EXIST %DESKTOP%\nauczyciele\%U% echo T| rd %DESKTOP%\nauczyciele\%U%\ /s/q >NUL
rem =========== usuwanie folderu Pulpit KONIEC ===============================================

rem =========== usuwanie folderu Moje dokumenty ============================
IF EXIST %REDIRECTED%\%U% echo T| rd %REDIRECTED%\%U%\ /s/q >NUL
rem =========== usuwanie folderu Moje dokumenty Koniec =====================

rem =========== usuwanie osobistej strony WWW ==============================
IF EXIST %HOMEPAGES%\%U% echo T| rd %HOMEPAGES%\%U%\ /s/q >NUL
rem =========== usuwanie osobistej strony WWW Koniec =======================


rem ======= Usuwanie zasobu sieciowego, udostêpniaj¹cego foldery Pulpit oraz Moje dokumenty u¿ytkownika =============
net share %U%$$ /DELETE /yes >NUL
rem ======= Usuwanie zasobu sieciowego, udostêpniaj¹cego foldery Pulpit oraz Moje dokumenty u¿ytkownika KONIEC ======


rem ======= Usuwanie katalogu zawieraj¹cego foldery Pulpit oraz Moje dokumenty u¿ytkownika ==========================
IF EXIST %H%\%U% echo T| rd %H%\%U%\ /s/q >NUL
rem ======= Usuwanie katalogu zawieraj¹cego foldery Pulpit oraz Moje dokumenty u¿ytkownika KONIEC ===================


rem ======= Usuwanie zasobu sieciowego, udostêpniaj¹cego osobist¹ stronê WWW u¿ytkownika ============================
net share "%U%$" /DELETE /yes >NUL
rem ======= Usuwanie zasobu sieciowego, udostêpniaj¹cego osobist¹ stronê WWW u¿ytkownika KONIEC =====================

rem ======= Usuwanie katalogu zawieraj¹cego osobist¹ stronê WWW u¿ytkownika =========================================
IF EXIST %W%\%U% echo T| rd %W%\%U%\ /s/q >NUL
rem ======= Usuwanie katalogu zawieraj¹cego osobist¹ stronê WWW u¿ytkownika KONIEC ==================================


rem ======= Usuwanie konta u¿ytkownika ==============================================================================
 IF "%CO_USUWAM%"=="WSZYSTKO" net user %U% /delete >NUL
 IF "%CO_USUWAM%"=="wszystko" net user %U% /delete >NUL
 IF "%CO_USUWAM%"=="Wszystko" net user %U% /delete >NUL
 IF "%CO_USUWAM%"=="wSZYSTKO" net user %U% /delete >NUL
rem ======= Usuwanie konta u¿ytkownika KONIEC =======================================================================

@echo ------------------
@echo Usunieto konto %U%
@echo ------------------

GOTO KONIEC


:BLAD
  echo _
  echo _
  echo _
  echo *****************************************
  echo Podano nieprawidlowe paramertry wywolania
  echo *****************************************
  echo Prawidlowe wywolanie:
  echo Parametr pierwszy: blablabla (usuwa tylko pliki)
  echo Parametr pierwszy: WSZYSTKO (usuwa pliki i konto uzytkownika)
  echo Parametr drugi: nazwa konta do usuniecia (bez znakow "")
  echo Parametr trzecie (opcjonalny): nazwa jednostki organizacyjnej MENiS do ktorej nalezy uzytkownik (bez znakow "")
  echo przykladowe wywolanie usuwajace konto fabik1:
  echo czysc.cmd PLIKI student001a pozioma
  echo czysc.cmd WSZYSTKO fabik1
  echo _
  echo _
  echo _
  pause

:KONIEC


