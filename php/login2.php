<?php
session_start();

$serverName = "DESKTOP-U0GRF4M";                // e.g. "localhost", "localhost\SQLEXPRESS", or "your-sql-server,1433"
$connectionOptions = [
    "Database" => "AirlineReservationDB",
    "Uid"      => "",                   // change to your DB user
    "PWD"      => ""                  // change to your DB password
];

$conn = sqlsrv_connect($serverName, $connectionOptions);
if ($conn === false) {
    // In production, do not echo raw errors
    die("Connection failed: " . print_r(sqlsrv_errors(), true));
}

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['text'], $_POST['password'])) {
    $username = $_POST['text'];
    $password = $_POST['password'];

    // Use parameterized query to avoid SQL injection
    $tsql = "SELECT Username, User_Password FROM Sys_user WHERE Username = ? AND User_Password = ?";
    $params = [$username, $password];

    $stmt = sqlsrv_query($conn, $tsql, $params);
    if ($stmt === false) {
        die("Query error: " . print_r(sqlsrv_errors(), true));
    }

    $row = sqlsrv_fetch_array($stmt, SQLSRV_FETCH_ASSOC);
    if ($row) {
        // Authenticated
        $_SESSION['username'] = $row['Username'];
        // regenerate session id for safety
        session_regenerate_id(true);
        header("Location: sidebar.php");
        exit;
    } else {
        echo "username and password not correct";
    }

    sqlsrv_free_stmt($stmt);
}

sqlsrv_close($conn);
?>