<?php
require_once 'db_connection.php';

header('Content-Type: application/json');

$email = isset($_GET['email']) ? trim($_GET['email']) : '';
if (!$email) {
    echo json_encode([]);
    exit;
}

$query = "SELECT r.ReservationId, r.ReservationStatus, r.CreatedAt, f.FlightId, f.DepartureDateTime, f.ArrivalDateTime,
          a.AirlineName, sa.AirportCity AS SourceCity, da.AirportCity AS DestinationCity
          FROM Reservation r
          JOIN FlightDetails f ON r.FlightId = f.FlightId
          JOIN Airline a ON f.AirlineId = a.AirlineId
          JOIN Airport sa ON f.SourceAirportId = sa.AirportId
          JOIN Airport da ON f.DestinationAirportId = da.AirportId
          JOIN Passenger p ON r.PassengerId = p.PassengerId
          WHERE p.P_Email = ?
          ORDER BY r.CreatedAt DESC";

$params = array($email);
$stmt = sqlsrv_query($conn, $query, $params);
if ($stmt === false) {
    echo json_encode([]);
    exit;
}

$results = array();
while ($row = sqlsrv_fetch_array($stmt, SQLSRV_FETCH_ASSOC)) {
    $results[] = $row;
}

echo json_encode($results);
