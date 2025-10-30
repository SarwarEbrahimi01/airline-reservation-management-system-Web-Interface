<?php
require_once 'db_connection.php';

$query = "SELECT AirportId, AirportName, AirportCity, AirportCountry FROM Airport";
$result = sqlsrv_query($conn, $query);

if ($result === false) {
    die(json_encode(['error' => 'Error executing query: ' . print_r(sqlsrv_errors(), true)]));
}

$airports = [];
while ($row = sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC)) {
    $airports[] = $row;
}

header('Content-Type: application/json');
echo json_encode($airports);
?>