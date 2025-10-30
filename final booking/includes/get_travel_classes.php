<?php
require_once 'db_connection.php';

$flightId = $_GET['flightId'];

$query = "SELECT 
    tc.TravelClassId,
    tc.TravelClassName,
    fc.Cost
FROM TravelClass tc
JOIN FlightTravelClass ftc ON tc.TravelClassId = ftc.TravelClassId
JOIN FlightCost fc ON tc.TravelClassId = fc.TravelClassId AND fc.FlightId = ?
WHERE ftc.FlightId = ? AND ftc.AvailableSeats > 0";

$params = array($flightId, $flightId);
$result = sqlsrv_query($conn, $query, $params);

if ($result === false) {
    die(json_encode(['error' => 'Error executing query: ' . print_r(sqlsrv_errors(), true)]));
}

$travelClasses = [];
while ($row = sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC)) {
    $travelClasses[] = $row;
}

header('Content-Type: application/json');
echo json_encode($travelClasses);
?>