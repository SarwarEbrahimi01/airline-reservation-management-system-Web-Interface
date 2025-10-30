<?php
// Database connection parameters
$serverName = "DESKTOP-U0GRF4M";
$connectionOptions = array(
    "Database" => "AirlineReservationDB",
    "Uid" => "",
    "PWD" => ""
);

// Establish database connection
try {
    $conn = sqlsrv_connect($serverName, $connectionOptions);
   
    if($conn === false) {
        die(print_r(sqlsrv_errors(), true));
    }

    // Check if form is submitted
    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        // Get form data and sanitize inputs
        $username = filter_input(INPUT_POST, 'username', FILTER_SANITIZE_STRING);
        $password = $_POST['password']; // Will be hashed
        $email = filter_input(INPUT_POST, 'email', FILTER_SANITIZE_EMAIL);



        // Prepare SQL statement
        $sql = "INSERT INTO Sys_user (Username, User_Password, User_Email) VALUES (?, ?, ?)";
       
        // Prepare and execute the statement
        $params = array($username, $password, $email);
        $stmt = sqlsrv_prepare($conn, $sql, $params);
       
        if($stmt === false) {
            die(print_r(sqlsrv_errors(), true));
        }

        if(sqlsrv_execute($stmt)) {
            echo "Registration successful!";
        } else {
            echo "Error registering user.";
            die(print_r(sqlsrv_errors(), true));
        }

        // Close the statement
        sqlsrv_free_stmt($stmt);
    }
} catch(Exception $e) {
    echo "Error: " . $e->getMessage();
} finally {
    // Close the connection
    if(isset($conn)) {
        sqlsrv_close($conn);
    }
}
?>