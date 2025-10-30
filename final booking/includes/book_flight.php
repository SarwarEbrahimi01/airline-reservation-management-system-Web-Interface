<?php
require_once 'db_connection.php';

// Start transaction
sqlsrv_begin_transaction($conn);

try {
    // Get form data (use full passenger fields)
    $firstName = isset($_POST['passenger-first']) ? trim($_POST['passenger-first']) : '';
    $lastName = isset($_POST['passenger-last']) ? trim($_POST['passenger-last']) : '';
    $passengerEmail = isset($_POST['passenger-email']) ? trim($_POST['passenger-email']) : '';
    $passengerPhone = isset($_POST['passenger-phone']) ? trim($_POST['passenger-phone']) : '';
    $address = isset($_POST['passenger-address']) ? trim($_POST['passenger-address']) : '';
    $city = isset($_POST['passenger-city']) ? trim($_POST['passenger-city']) : '';
    $state = isset($_POST['passenger-state']) ? trim($_POST['passenger-state']) : '';
    $zip = isset($_POST['passenger-zip']) ? trim($_POST['passenger-zip']) : '';
    $country = isset($_POST['passenger-country']) ? trim($_POST['passenger-country']) : '';
    // Optional: allow caller to provide an existing PassengerId (to avoid inserting duplicate passenger rows)
    $providedPassengerId = isset($_POST['passenger-id']) && $_POST['passenger-id'] !== '' ? intval($_POST['passenger-id']) : null;
    $flightId = isset($_POST['flightId']) ? intval($_POST['flightId']) : 0;
    $travelClassId = isset($_POST['seat-class']) ? intval($_POST['seat-class']) : 0;

    if (!$flightId || !$travelClassId) {
        throw new Exception('Missing required fields: flightId and seat-class are required');
    }

    // Determine passenger id: if provided by caller, use it; otherwise insert a new passenger and retrieve id
    $passengerId = $providedPassengerId;
    // If a passenger id was provided, validate it exists in the DB to avoid FK errors
    if (!empty($passengerId)) {
        $checkQuery = "SELECT PassengerId FROM Passenger WHERE PassengerId = ?";
        $checkStmt = sqlsrv_query($conn, $checkQuery, array($passengerId));
        if ($checkStmt === false) {
            throw new Exception('Error checking provided passenger id: ' . print_r(sqlsrv_errors(), true));
        }
        $exists = sqlsrv_fetch_array($checkStmt, SQLSRV_FETCH_ASSOC);
        if (!$exists) {
            throw new Exception('Provided passenger-id not found');
        }
    }
    if (empty($passengerId)) {
        // Require at least name or email to create a new passenger
        if (!$firstName && !$passengerEmail) {
            throw new Exception('Missing passenger information: provide passenger-id or at least first name or email');
        }

        // Insert new passenger and get inserted PassengerId using SCOPE_IDENTITY
        $passengerQuery = "INSERT INTO Passenger (P_FirstName, P_LastName, P_Email, P_PhoneNumber, P_Address, P_City, P_State, P_ZipCode, P_Country)
                           VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?); SELECT SCOPE_IDENTITY() AS id;";

        $params = array($firstName, $lastName, $passengerEmail, $passengerPhone, $address, $city, $state, $zip, $country);
        $stmt = sqlsrv_query($conn, $passengerQuery, $params);
        if ($stmt === false) {
            throw new Exception('Error inserting passenger: ' . print_r(sqlsrv_errors(), true));
        }

        // Retrieve inserted id
        // For SQL Server, after executing the batch with SELECT SCOPE_IDENTITY(), fetch result
        $passengerId = null;
        while ($row = sqlsrv_fetch_array($stmt, SQLSRV_FETCH_ASSOC)) {
            if (isset($row['id'])) { $passengerId = $row['id']; break; }
            if (isset($row['PassengerId'])) { $passengerId = $row['PassengerId']; break; }
        }
        // If still null, try querying by email and phone as fallback (not ideal but works)
        if (empty($passengerId) && $passengerEmail) {
            $q = "SELECT TOP 1 PassengerId FROM Passenger WHERE P_Email = ? AND P_PhoneNumber = ? ORDER BY PassengerId DESC";
            $r = sqlsrv_query($conn, $q, array($passengerEmail, $passengerPhone));
            if ($r === false) throw new Exception('Error retrieving passenger id: ' . print_r(sqlsrv_errors(), true));
            $row = sqlsrv_fetch_array($r, SQLSRV_FETCH_ASSOC);
            if ($row) $passengerId = $row['PassengerId'];
        }

        if (empty($passengerId)) throw new Exception('Could not determine PassengerId after insert');
    }

    // Get an available seat
    $seatQuery = "SELECT TOP 1 SeatId FROM SeatDetails 
                  WHERE FlightId = ? AND TravelClassId = ? AND AvailabilityStatus = 'Available'";
    $params = array($flightId, $travelClassId);
    $result = sqlsrv_query($conn, $seatQuery, $params);
    if ($result === false) {
        throw new Exception("Error finding available seat: " . print_r(sqlsrv_errors(), true));
    }
    $row = sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC);
    if (!$row) {
        throw new Exception('No available seats for selected class');
    }
    $seatId = $row['SeatId'];

    // Create reservation and get ReservationId
    $reservationQuery = "INSERT INTO Reservation (PassengerId, FlightId, SeatId, ReservationDate, ReservationStatus, CreatedAt, UpdatedAt)
                        OUTPUT INSERTED.ReservationId
                        VALUES (?, ?, ?, GETDATE(), 'Confirmed', GETDATE(), GETDATE())";
    $params = array($passengerId, $flightId, $seatId);
    $resStmt = sqlsrv_query($conn, $reservationQuery, $params);
    if ($resStmt === false) {
        throw new Exception("Error creating reservation: " . print_r(sqlsrv_errors(), true));
    }
    $reservationId = null;
    while ($rrow = sqlsrv_fetch_array($resStmt, SQLSRV_FETCH_ASSOC)) {
        if (isset($rrow['ReservationId'])) { $reservationId = $rrow['ReservationId']; break; }
        if (isset($rrow['id'])) { $reservationId = $rrow['id']; break; }
    }

    // Update seat status
    $updateSeatQuery = "UPDATE SeatDetails SET AvailabilityStatus = 'Booked' WHERE SeatId = ?";
    $params = array($seatId);
    $result = sqlsrv_query($conn, $updateSeatQuery, $params);
    if ($result === false) {
        throw new Exception("Error updating seat status: " . print_r(sqlsrv_errors(), true));
    }

    // Update available seats count
    $updateSeatsQuery = "UPDATE FlightTravelClass 
                        SET AvailableSeats = AvailableSeats - 1
                        WHERE FlightId = ? AND TravelClassId = ?";
    $params = array($flightId, $travelClassId);
    $result = sqlsrv_query($conn, $updateSeatsQuery, $params);
    if ($result === false) {
        throw new Exception("Error updating available seats: " . print_r(sqlsrv_errors(), true));
    }

    // Commit transaction
    sqlsrv_commit($conn);

    header('Content-Type: application/json');
    echo json_encode(['success' => true, 'passengerId' => $passengerId, 'reservationId' => $reservationId]);

} catch (Exception $e) {
    // Rollback transaction on error
    sqlsrv_rollback($conn);

    header('Content-Type: application/json');
    echo json_encode(['success' => false, 'message' => $e->getMessage()]);
}
?>