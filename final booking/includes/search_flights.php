<?php
require_once 'db_connection.php';

$sourceAirportId = $_GET['from'];
$destAirportId = $_GET['to'];
$date = $_GET['date'];

$query = "SELECT 
    f.FlightId,
    a.AirlineName,
    src.AirportCity as SourceCity,
    dst.AirportCity as DestinationCity,
    f.DepartureDateTime,
    f.ArrivalDateTime,
    ft.AvailableSeats,
    MIN(fc.Cost) as MinCost
FROM FlightDetails f
JOIN Airline a ON f.AirlineId = a.AirlineId
JOIN Airport src ON f.SourceAirportId = src.AirportId
JOIN Airport dst ON f.DestinationAirportId = dst.AirportId
JOIN FlightTravelClass ft ON f.FlightId = ft.FlightId
JOIN FlightCost fc ON f.FlightId = fc.FlightId
WHERE f.SourceAirportId = ? 
AND f.DestinationAirportId = ?
AND CONVERT(date, f.DepartureDateTime) = ?
AND ft.AvailableSeats > 0
GROUP BY f.FlightId, a.AirlineName, src.AirportCity, dst.AirportCity, 
f.DepartureDateTime, f.ArrivalDateTime, ft.AvailableSeats";

$params = array($sourceAirportId, $destAirportId, $date);
$result = sqlsrv_query($conn, $query, $params);

if ($result === false) {
    die(json_encode(['error' => 'Error executing query: ' . print_r(sqlsrv_errors(), true)]));
}

$flights = [];
while ($row = sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC)) {
    // Format datetime objects
    $row['DepartureDateTime'] = $row['DepartureDateTime']->format('Y-m-d H:i:s');
    $row['ArrivalDateTime'] = $row['ArrivalDateTime']->format('Y-m-d H:i:s');
    $flights[] = $row;
}

header('Content-Type: application/json');
echo json_encode($flights);
?>