USE AirlineReservationDB
CREATE TABLE Airline
(
AirlineId INT NOT NULL,
AirlineName NVARCHAR(50) NOT NULL,
AirlineCode NVARCHAR(50) NOT NULL,
CONSTRAINT Airline_AirlineId_PK PRIMARY KEY (AirlineId)
)
CREATE TABLE Airport
(
AirportId INT NOT NULL,
AirportName NVARCHAR(50) NOT NULL,
AirportCity NVARCHAR(50) NOT NULL,
AirportCountry NVARCHAR(50) NOT NULL,
CONSTRAINT Airport_AirportId_PK PRIMARY KEY(AirportId)
)
CREATE TABLE FlightDetails
(
FlightId INT NOT NULL,
AirlineId INT NOT NULL,
SourceAirportId INT NOT NULL,
DestinationAirportId INT NOT NULL,
DepartureDateTime DATETIME NOT NULL,
ArrivalDateTime DATETIME NOT NULL,
AirplaneType NVARCHAR(50),
CONSTRAINT FlightDetails_FlightId_PK PRIMARY KEY (FlightId)
)

CREATE TABLE SeatDetails
(
SeatId INT NOT NULL,
TravelClassId INT NOT NULL,
FlightId INT NOT NULL,
AvailabilityStatus NVARCHAR(50),
SeatNumber INT NOT NULL,
CONSTRAINT SeatDetails_SeatId_PK PRIMARY KEY(SeatId)
)

CREATE TABLE Reservation
(
ReservationId INT NOT NULL,
PassengerId INT NOT NULL,
FlightId INT NOT NULL,
SeatId INT NOT NULL,
ReservationDate DATE NOT NULL,
ReservationStatus NVARCHAR(50),
CreatedAt DATETIME NOT NULL,
UpdatedAT DATETIME NOT NULL,
CONSTRAINT Reservation_ReservationId_PK PRIMARY KEY(ReservationId)

)

CREATE TABLE TravelClass
(
TravelClassId INT NOT NULL,
TravelClassName NVARCHAR(50) NOT NULL,
TravelClassCapacity INT NOT NULL,
CONSTRAINT TravleClass_TravelClassId_PK PRIMARY KEY(TravelClassId)
)
CREATE TABLE Payment
(
PaymentId INT NOT NULL,
ReservationId INT NOT NULL,
PaymentAmount INT NOT NULL,
PaymentMethod VARCHAR(50) NOT NULL,
PaymentDueDate DATE NOT NULL,
PaymentStatus NVARCHAR(50) NOT NULL,
CreatedAt DATE NOT NULL,
UpdatedAt DATE NOT NULL,
CONSTRAINT Payment_PaymentId_PK PRIMARY KEY(PaymentId)

)
CREATE TABLE FlightService
(
ServiceId INT NOT NULL,
ServiceName NVARCHAR(50) NOT NULL,
CONSTRAINT FlightService_ServiceId_PK PRIMARY KEY(ServiceId)
)

CREATE TABLE FlightCost
(
FlightId INT NOT NULL,
TravelClassId INT NOT NULL,
Cost INT NOT NULL,
ValidFromDate DATE NOT NULL,
ValidToDate DATE NOT NULL,
CONSTRAINT FlightCost_FlightId_TravelClassId_CPK PRIMARY KEY(FlightId,TravelClassId)
)

CREATE TABLE FlightTravelClass
(
FlightId INT NOT NULL,
TravelClassId INT NOT NULL,
AvailableSeats INT NOT NULL,
MaxSeats INT,
CONSTRAINT FlightTravelClass_FlightId_TravelClassId_CPK PRIMARY KEY(FlightId,TravelClassId) 
)
CREATE TABLE ServiceOffering
(
TravelClassId INT NOT NULL,
ServiceId INT NOT NULL,
FromDate DATE NOT NULL,
ToDate DATE NOT NULL,
CONSTRAINT ServiceOffering_TravelClassId_ServiceId_CPk PRIMARY KEY(TravelClassId,ServiceId)
)
--SUPERTYPE TABLE
CREATE TABLE Passenger
(
PassengerId INT NOT NULL,
P_FirstName NVARCHAR(50) NOT NULL,
P_LastName NVARCHAR(50) NOT NULL,
P_Email NVARCHAR(50) NOT NULL,
P_PhoneNumber NVARCHAR(50) NOT NULL,
P_Address NVARCHAR(50) NOT NULL,
P_City  NVARCHAR(50) NOT NULL,
P_State NVARCHAR(50) NOT NULL,
P_ZipCode NVARCHAR(50) NOT NULL,
P_Country NVARCHAR(50) NOT NULL,
CONSTRAINT Passenger_PassengerId_PK PRIMARY KEY(PassengerId)

)
--SUBTYPE TABLE
CREATE TABLE RegularPassenger
(
LoyaltyPoints NVARCHAR(50)
)
CREATE TABLE CorporatePassenger
(
CompanyName VARCHAR(30) NOT NULL,
EmployeeId VARCHAR(40) NOT NULL
)

--USING ALTER TO ADD FOREIGN KEY CONSTRAINT

--FlightDetails Table
ALTER TABLE FlightDetails ADD CONSTRAINT FlightDetails_AirlineId_FK 
FOREIGN KEY(AirlineId) REFERENCES Airline(AirlineId)

ALTER TABLE FlightDetails ADD CONSTRAINT FlightDetails_SourceAirportId_FK 
FOREIGN KEY(SourceAirportId) REFERENCES Airport(AirportId) 

ALTER TABLE FlightDetails ADD CONSTRAINT FlightDetails_DestinationAirportId_FK
FOREIGN KEY (DestinationAirportId) REFERENCES Airport(AirportId)

--SeatDetails Table
ALTER TABLE SeatDetails ADD CONSTRAINT SeatDetails_TravelClassId_FK 
FOREIGN KEY (TravelClassId) REFERENCES TravelClass (TravleClassId)

ALTER TABLE SeatDetails ADD CONSTRAINT SeatDetails_FlightId_FK
FOREIGN KEY (FlightId) REFERENCES FlightDetails(FlightId)

--Reservation Table
ALTER TABLE Reservation ADD CONSTRAINT Reservation_PassengerId_FK
FOREIGN KEY (PassengerId) REFERENCES Passenger(PassengerId)

ALTER TABLE Reservation ADD CONSTRAINT Reservation_FlightId_FK
FOREIGN KEY (FlightId) REFERENCES FlightDetails(FlightId)

ALTER TABLE Reservation ADD CONSTRAINT Reservation_SeatId_FK 
FOREIGN KEY (SeatId) REFERENCES SeatDetails(SeatId)

--Payment Table
ALTER TABLE Payment ADD CONSTRAINT Payment_ReservationId_FK
FOREIGN KEY(ReservationId) REFERENCES Reservation(ReservationId)

--Associative ServiceOffering
ALTER TABLE ServiceOffering ADD CONSTRAINT ServiceOffering_TravelClassId_FK
FOREIGN KEY (TravelClassId) REFERENCES TravelClass(TravelClassId)

ALTER TABLE ServiceOffering ADD CONSTRAINT ServiceOffering_ServiceId_FK
FOREIGN KEY (ServiceId) REFERENCES FlightService(ServiceId)

--Associative FlightCost
ALTER TABLE FlightCost ADD CONSTRAINT FlightCost_FlightId_FK
FOREIGN KEY (FlightId) REFERENCES FlightDetails(FlightId)

ALTER TABLE FlightCost ADD CONSTRAINT FlightCost_TravelClassId_FK
FOREIGN KEY (TravelClassId) REFERENCES TravelClass (TravelClassId)

--Associative FlightTravelClass
ALTER TABLE FlightTravelClass ADD CONSTRAINT FlightTravelClass_FlightId_FK
FOREIGN KEY (FlightId) REFERENCES FlightDetails(FlightId)

ALTER TABLE FlightTravelClass ADD CONSTRAINT FlightTravelClass_TravelClassId_FK
FOREIGN KEY (TravelClassId) REFERENCES TravelClass(TravelClassId)