<?php
$serverName = "DESKTOP-U0GRF4M"; // Change this to your SQL Server instance name
$connectionInfo = array(
    "Database" => "AirlineReservationDatabase",
    "UID" => "", // Replace with your SQL Server username
    "PWD" => "", // Replace with your SQL Server password
    "CharacterSet" => "UTF-8"
);

$conn = sqlsrv_connect($serverName, $connectionInfo);

if(!$conn) {
    die(print_r(sqlsrv_errors(), true));
}
?>