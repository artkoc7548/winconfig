<?php 
$db = mysql_connect ('localhost', 'root', '1234') or die ('serwer bazy MySQL nie dziala');;
$db = mysql_select_db ('ckziu') or die ('Nie dziala baza ckziu');
$wynik = mysql_query ('select * from pracownicy');
$txt = mysql_fetch_assoc($wynik);
?>



