<!DOCTYPE html>
<html>
<body>
"My first PHP script!"
<br/>
<br/>
<br/>
<?php
$servername = "localhost";
$username = "root";
$password = "1234";
$dbname = "ckziu";

// Create connection
$conn = mysqli_connect($servername, $username, $password, $dbname);

// Check connection
if (!$conn) {
    die("Brak połączenia z serwerem MySQL.: " . mysqli_connect_error());
}
echo "Connected successfully";
echo "";

$sql = "SELECT NR_PRAC, NAZWISKO, PLEC FROM pracownicy";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    // output data of each row
    while($row = $result->fetch_assoc()) {
        echo "NR: " . $row["NR_PRAC"]. " - NAZWISKO:  " . $row["NAZWISKO"]. " PLEC - " . $row["PLEC"]. "<br>";
    }
} else {
    echo "0 results";
}
$conn->close();
?>

</body>
</html>