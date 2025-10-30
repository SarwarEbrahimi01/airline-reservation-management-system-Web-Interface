<?php
require_once 'db_connection.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Start transaction
    sqlsrv_begin_transaction($conn);
    
    try {
        $reservationId = $_POST['reservationId'];
        
        // Get reservation details
        $query = "SELECT FlightId, SeatId FROM Reservation WHERE ReservationId = ?";
        $params = array($reservationId);
        $result = sqlsrv_query($conn, $query, $params);
        
        if ($result === false) {
            throw new Exception("Error getting reservation details: " . print_r(sqlsrv_errors(), true));
        }
        
        $row = sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC);
        $flightId = $row['FlightId'];
        $seatId = $row['SeatId'];
        
        // Get travel class ID
        $query = "SELECT TravelClassId FROM SeatDetails WHERE SeatId = ?";
        $params = array($seatId);
        $result = sqlsrv_query($conn, $query, $params);
        
        if ($result === false) {
            throw new Exception("Error getting seat details: " . print_r(sqlsrv_errors(), true));
        }
        
        $row = sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC);
        $travelClassId = $row['TravelClassId'];
        
        // Update reservation status
        $query = "UPDATE Reservation 
                 SET ReservationStatus = 'Cancelled', UpdatedAt = GETDATE() 
                 WHERE ReservationId = ?";
        $params = array($reservationId);
        $result = sqlsrv_query($conn, $query, $params);
        
        if ($result === false) {
            throw new Exception("Error updating reservation: " . print_r(sqlsrv_errors(), true));
        }
        
        // Update seat availability
        $query = "UPDATE SeatDetails 
                 SET AvailabilityStatus = 'Available' 
                 WHERE SeatId = ?";
        $params = array($seatId);
        $result = sqlsrv_query($conn, $query, $params);
        
        if ($result === false) {
            throw new Exception("Error updating seat status: " . print_r(sqlsrv_errors(), true));
        }
        
        // Update available seats count
        $query = "UPDATE FlightTravelClass 
                 SET AvailableSeats = AvailableSeats + 1
                 WHERE FlightId = ? AND TravelClassId = ?";
        $params = array($flightId, $travelClassId);
        $result = sqlsrv_query($conn, $query, $params);
        
        if ($result === false) {
            throw new Exception("Error updating available seats: " . print_r(sqlsrv_errors(), true));
        }
        
        // Commit transaction
        sqlsrv_commit($conn);
        
        header('Content-Type: application/json');
        echo json_encode(['success' => true]);
        
    } catch (Exception $e) {
        // Rollback transaction on error
        sqlsrv_rollback($conn);
        
        header('Content-Type: application/json');
        echo json_encode(['success' => false, 'message' => $e->getMessage()]);
    }
} else {
    header('Content-Type: application/json');
    echo json_encode(['success' => false, 'message' => 'Invalid request method']);
}
?>