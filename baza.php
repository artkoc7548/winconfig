<!DOCTYPE html>
<html>
<body>
"My first PHP script!"
<br/>
<br/>
<br/>
<?php 

echo "My first PHP script!";

$db = mysql_connect ('127.0.0.1', 'root', '1234') or die ('serwer bazy MySQL nie dziala');
$db = mysql_select_db ('ckziu') or die ('Nie dziala baza ckziu');
$wynik = mysql_query ('select * from pracownicy');
$txt = mysql_fetch_assoc($wynik);
print_r($txt);
?>

</body>
</html>