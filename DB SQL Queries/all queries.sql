USE AirlineReservationDB

--CREATING ALL TABLES
--=========================================================
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


--========================================================================

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


--===============================================================================



--INSERT VALUES OR RECORDS INTO TABLES

USE AirlineReservationDB;
--AIRLINE TABLE
INSERT INTO Airline(AirlineId,AirlineName,AirlineCode) VALUES (1,'KamAir','KA')
select * from Airline
INSERT INTO Airline(AirlineId,AirlineName,AirlineCode) VALUES (2,'AirOne','AO')
INSERT INTO Airline(AirlineId,AirlineName,AirlineCode) VALUES (3,'Skymate','SM')
INSERT INTO Airline(AirlineId,AirlineName,AirlineCode) VALUES (4,'JetFast','JF')
INSERT INTO Airline(AirlineId,AirlineName,AirlineCode) VALUES (5,'AeroSwift','AS')
INSERT INTO Airline(AirlineId,AirlineName,AirlineCode) VALUES (6,'WingsAway','WA')
INSERT INTO Airline(AirlineId,AirlineName,AirlineCode) VALUES (7,'SkyExpress','SX')
INSERT INTO Airline(AirlineId,AirlineName,AirlineCode) VALUES (8,'CloudAir','CA')
INSERT INTO Airline(AirlineId,AirlineName,AirlineCode) VALUES (9,'ZoomFly','ZF')
INSERT INTO Airline(AirlineId,AirlineName,AirlineCode) VALUES (10,'SwiftJet','SJ')
INSERT INTO Airline(AirlineId,AirlineName,AirlineCode) VALUES (11,'OceanicLines','OL')
INSERT INTO Airline(AirlineId,AirlineName,AirlineCode) VALUES (12,'CityWings','SW')
INSERT INTO Airline(AirlineId,AirlineName,AirlineCode) VALUES (13,'GlobalLink','GL')
INSERT INTO Airline(AirlineId,AirlineName,AirlineCode) VALUES (14,'VioletAir','VA')
INSERT INTO Airline(AirlineId,AirlineName,AirlineCode) VALUES (15,'SunnyJet','SJ')
INSERT INTO Airline(AirlineId,AirlineName,AirlineCode) VALUES (16,'BlueSky','BS')
INSERT INTO Airline(AirlineId,AirlineName,AirlineCode) VALUES (17,'TimeFlyer','TF')
INSERT INTO Airline(AirlineId,AirlineName,AirlineCode) VALUES (18,'NovaJet','NJ')
INSERT INTO Airline(AirlineId,AirlineName,AirlineCode) VALUES (19,'AeroWorld','AW')
INSERT INTO Airline(AirlineId,AirlineName,AirlineCode) VALUES (20,'AirVista','AV')

USE AirlineReservationDB
--Inserting Records
--Airport Table
INSERT INTO Airport(AirportId,AirportName,AirportCity,AirportCountry)
VALUES (1,'Hamid Karzi Intl','Kabul','Afghanistan')

INSERT INTO Airport(AirportId,AirportName,AirportCity,AirportCountry)
VALUES (2,'Kandahar Intl','Kandahar','Afghanistan')

INSERT INTO Airport(AirportId,AirportName,AirportCity,AirportCountry)
VALUES (3,'Herat Intl','Herat','Afghanistan')

INSERT INTO Airport(AirportId,AirportName,AirportCity,AirportCountry)
VALUES (4,'Mazar-i-Sharif Intl','Mazar-i-Shrif','Afghanistan')

INSERT INTO Airport(AirportId,AirportName,AirportCity,AirportCountry)
VALUES (5,'Jalalabad Airport','Jalalabad','Afghanistan')

INSERT INTO Airport(AirportId,AirportName,AirportCity,AirportCountry)
VALUES (6,'JFK Intl','New York','USA')

INSERT INTO Airport(AirportId,AirportName,AirportCity,AirportCountry)
VALUES (7,'Heathrow','London','UK')

INSERT INTO Airport(AirportId,AirportName,AirportCity,AirportCountry)
VALUES (8,'Changi','Singapore','Singapore')

INSERT INTO Airport(AirportId,AirportName,AirportCity,AirportCountry)
VALUES (9,'Haneda','Tokyo','Japan')

INSERT INTO Airport(AirportId,AirportName,AirportCity,AirportCountry)
VALUES (10,'Charles de Gaulle','Paris','France')

INSERT INTO Airport(AirportId,AirportName,AirportCity,AirportCountry)
VALUES (11,'Indira Gandhi','Delhi','India')

INSERT INTO Airport(AirportId,AirportName,AirportCity,AirportCountry)
VALUES (12,'Frankfurt','Frankfurt','Germany')

INSERT INTO Airport(AirportId,AirportName,AirportCity,AirportCountry)
VALUES (13,'Sydney Intl','Sydney','Australia')

INSERT INTO Airport(AirportId,AirportName,AirportCity,AirportCountry)
VALUES (14,'Dubai Intl','Dubai','UAE')

INSERT INTO Airport(AirportId,AirportName,AirportCity,AirportCountry)
VALUES (15,'Toronto Pearson','Toronto','Canada')

INSERT INTO Airport(AirportId,AirportName,AirportCity,AirportCountry)
VALUES (16,'Incheon','Seoul','South Korea')

INSERT INTO Airport(AirportId,AirportName,AirportCity,AirportCountry)
VALUES (17,'Rome Fiumicino','Rome','Italy')

INSERT INTO Airport(AirportId,AirportName,AirportCity,AirportCountry)
VALUES (18,'Hong Kong Intl','Hong Kong','China')

INSERT INTO Airport(AirportId,AirportName,AirportCity,AirportCountry)
VALUES (19,'Suvarnabhumi','Bangkok','Thailand')

INSERT INTO Airport(AirportId,AirportName,AirportCity,AirportCountry)
VALUES (20,'Zurich Intl','Zurich','Swithzerland')

SELECT * FROM Airport

USE AirlineReservationDB
--Inserting Records
--Travel Class Table
INSERT INTO TravelClass(TravelClassId,TravelClassName,TravelClassCapacity) VALUES 
(1,'Economy',120),
(2,'Business',20),
(3,'First',8),
(4,'Premium Economy',30),
(5,'Flexi Economy',50),
(6,'Charter Business',12),
(7,'VIP Suite',4),
(8,'Regional Economy',60),
(9,'Cargo Cabin',10),
(10,'Student Discount',40),
(11,'Family',80),
(12,'Senior',30),
(13,'Community',35),
(14,'Health Assist',10),
(15,'Military',20),
(16,'Government',15),
(17,'Pliggrimage Class',50),
(18,'Seasonal Promo',90),
(19,'Crew',25),
(20,'Companion',12)
 
 --Flight Service Table
 INSERT INTO FlightService (ServiceId,ServiceName) VALUES 
 (1,'In-flight Tea/Coffee'),
 (2,'Local Meal'),
 (3,'Extra Baggage'),
 (4,'Priority Boarding'),
 (5,'Lounge Access'),
 (6,'WiFi (limited)'),
 (7,'Child Meal'),
 (8,'Medical Assistance'),
 (9,'Amenity Kit'),
 (10,'Prayer Mat'),
 (11,'Seat Upgrade'),
 (12,'Fast Track Security'),
 (13,'Cargo Handling'),
 (14,'Chauffeur Pickup'),
 (15,'SIM Card Starter Pack'),
 (16,'Blankets'),
 (17,'Duty-Free'),
 (18,'Priority Baggage'),
 (19,'Pet Travel (checked)'),
 (20,'In-flight Entertainment')
 Select * from FlightService

 --Passenger Table
 INSERT INTO Passenger(PassengerId,P_FirstName,P_LastName,P_Email,P_PhoneNumber,P_Address,P_City,P_State,P_ZipCode,P_Country)
 VALUES
 (1,'Ahmad','Ahmadi','ahmad.ahmadi@domain.af','+93700111001','House 12, Karte 4','Kabul','Kabul','1001','Afghanistan'),
 (2,'Fatima','Akbari','fatima.akbari@domain.af','+93700222002','Street 5, Qala-e-Fath','Kandahar','Kandahar','3801','Afghanistan'),
 (3,'Mohammad','Wasiq','m.wasiq@domain.af','+93700333003','House 8, Kohe Surkh','Kabul','Kabul','1002','Afghanistan'),
 (4,'Zainab','Hashemi','z.hashemi@domain.af','+93700444004','Near Herat Gate','Herat','Herat','3001','Afghanistan'),
 (5,'Abdul','Rahimi','abdul.rahimi@domain.af','+93700555005','Balkh St, House 2','Mazar-i-Sharif','Balkh','3401','Afghanistan'),
 (6,'Mariam','Karimi','mariam.karimi@domain.af','+93700666006','Jada 12, District 2','Jalalabad','Nangarhar','2101','Afghanistan'),
 (7,'Haroon','Fahim','haroon.fahim@domain.af','+93700777007','Zargaran','Bamyan','Bamyan','2201','Afghanistan'),
 (8,'Leila','Norr','leila.noor@domain.af','+93700888008','Main Rd, Khost Bazar','Khost','Khost','2301','Afghanistan'),
 (9,'Farid','Azimi','farid.azimi@domain.af','+93700999009','Chehlsito, City Center','Kunduz','Kunduz','2401','Afghanistan'),
 (10,'Roya','Sadat','roya.sadat@domain.af','+93701000010','River Rd, House 5','Faizabad','Badakhshan','3501','Afghanistan'),
 (11,'Nasir','Ghani','nasir.ghani@domain.af','+93701111011','Airport Rd','Lashkar Gah','Helmand','2701','Afghanistan'),
 (12,'Sadiq','Hamidi','sadiq.hamidi@domain.af','+93701222012','Market St','Farah','Farah','2801','Afghanistan'),
 (13,'Zarmina','Azad','zarmina.azad@domain.af','+93701333013','High St, District 1','Trinkot','Uruzgan','2901','Afghanistan'),
 (14,'Gul','Wafa','gul.wafa@domain.af','+93701444014','Old Town','Zaranj','Nimruz','2801','Afghanistan'),
 (15,'Hameed','Shah','hameed.shah@domain.af','+93701555015','Pul-e-Khumri Ave','Pul-e-Khumri','Baghlan','3002','Afghanistan'),
 (16,'Nasima','Faizi','nasima.faizi@domain.af','+93701666016','Parkside','Charikar','Parwan','3101','Afghanistan'),
 (17,'Omar','Niazi','omar.niazi@domain.af','+93701777017','Taloqan Rd, House 6','Taloqan','Takhar','3201','Afghanistan'),
 (18,'Shukria','Fazli','shukria.fazli@domain.af','+93701888018','Near Kabul University','Kabul','Kabul','1003','Afghanistan'),
 (19,'Ahmadullah','Yousufi','a.yousufi@domain.af','+93701999019','Market Lane','Herat','Herat','3002','Afghanistan'),
 (20,'Mahbouba','Sediqi','mahbouba.sediqi@domain.af','+93702000020','Central St, District 3','Ghazni','Ghazni','3802','Afghanistan')

 select * from Passenger

--INSERTING RECORDS
--Flight Details Table
INSERT INTO FlightDetails(FlightId,AirlineId,SourceAirportId,DestinationAirportId,DepartureDateTime,ArrivalDateTime,AirplaneType)
VALUES 
(1,1,1,2,'2025-03-01 07:00:00','2025-03-01 08:10:00','Boeing 737'),
(2,2,1,3,'2025-03-01 09:30:00','2025-03-01 10:50:00','Airbus A320'),
(3,3,3,4,'2025-03-02 06:00:00','2025-03-02 07:30:00','ATR 72'),
(4,4,4,5,'2025-03-02 11:00:00','2025-03-02 12:00:00','Bombardier Q400'),
(5,5,2,3,'2025-03-03 13:00:00','2025-03-03 14:10:00','Boeing 737'),
(6,6,1,4,'2025-03-03 15:30:00','2025-03-03 17:00:00','Airbus A320'),
(7,7,5,6,'2025-03-04 08:00:00','2025-03-04 09:00:00','Dornier 228'),
(8,8,6,7,'2025-03-04 10:30:00','2025-03-04 11:20:00','ATR 42'),
(9,9,7,8,'2025-03-05 07:45:00','2025-03-05 08:30:00','Cessna 208'),
(10,10,8,9,'2025-03-05 12:00:00','2025-03-05 13:10:00','ATR 72'),
(11,11,9,10,'2025-03-06 06:30:00','2025-03-06 07:10:00','Cessna 208'),
(12,12,10,11,'2025-03-06 14:00:00','2025-03-06 15:05:00','Dornier 228'),
(13,13,11,12,'2025-03-07 09:00:00','2025-03-07 10:20:00','ATR 72'),
(14,14,12,13,'2025-03-07 16:00:00','2025-03-07 17:00:00','Cessna 208'),
(15,15,13,14,'2025-03-08 08:30:00','2025-03-08 09:10:00','Cessna 208'),
(16,16,14,15,'2025-03-08 11:45:00','2025-03-08 12:40:00','ATR 42'),
(17,17,15,16,'2025-03-09 07:00:00','2025-03-09 07:40:00','Dornier 228'),
(18,18,16,17,'2025-03-09 13:30:00','2025-03-09 14:20:00','ATR 42'),
(19,19,17,18,'2025-03-10 09:15:00','2025-03-10 10:00:00','Cessna 208'),
(20,20,18,1,'2025-03-10 18:00:00','2025-03-10 19:10:00','Boeing 737');
SELECT* FROM FlightDetails
--FLIGHTDETAILS EXECUTED BUT NOT OTHERS

--Reservation Table
INSERT INTO Reservation(ReservationId,PassengerId,FlightId,SeatId,ReservationDate,ReservationStatus,CreatedAt,UpdatedAT)
VALUES
(1,1,1,'Booked','2025-02-01','Yes','No','2025-02-01','2025-02-01'),
(2,2,2,'Booked','2025-02-02','Yes','No','2025-02-02','2025-02-02'),
(3,3,3,'Booked','2025-02-03','Yes','No','2025-02-03','2025-02-03'),
(4,4,4,'Cancelled','2025-02-04','No','Yes','2025-02-04','2025-02-05'),
(5,5,5,'Booked','2025-02-05','Yes','No','2025-02-05','2025-02-05'),
(6,6,6,'Booked','2025-02-06','Yes','No','2025-02-06','2025-02-06'),
(7,7,7,'Booked','2025-02-07','Yes','No','2025-02-07','2025-02-07'),
(8,8,8,'Cancelled','2025-02-08','No','Yes','2025-02-08','2025-02-08'),
(9,9,9,'Booked','2025-02-09','Yes','No','2025-02-09','2025-02-09'),
(10,10,10,'Booked','2025-02-10','Yes','No','2025-02-10','2025-02-10'),
(11,11,11,'Booked','2025-02-11','Yes','No','2025-02-11','2025-02-11'),
(12,12,12,'Booked','2025-02-12','Yes','No','2025-02-12','2025-02-12'),
(13,13,13,'Cancelled','2025-02-13','No','Yes','2025-02-13','2025-02-14'),
(14,14,14,'Booked','2025-02-14','Yes','No','2025-02-14','2025-02-14'),
(15,15,15,'Booked','2025-02-15','Yes','No','2025-02-15','2025-02-15'),
(16,16,16,'Cancelled','2025-02-16','No','Yes','2025-02-16','2025-02-16'),
(17,17,17,'Booked','2025-02-17','Yes','No','2025-02-17','2025-02-17'),
(18,18,18,'Booked','2025-02-18','Yes','No','2025-02-18','2025-02-18'),
(19,19,19,'Booked','2025-02-19','Yes','No','2025-02-19','2025-02-19'),
(20,20,20,'Booked','2025-02-20','Yes','No','2025-02-20','2025-02-20');



--Payment Table
INSERT INTO Payment(PaymentId,ReservationId,PaymentAmount,PaymentMethod,PaymentDueDate,PaymentStatus,CreatedAt,UpdatedAt)
VALUES 
(1,1,4500,'Credit Card','2025-02-01 08:00:00','Success','2025-02-01','2025-02-01'),
(2,2,5000,'Mobile Wallet','2025-02-02 09:00:00','Success','2025-02-02','2025-02-02'),
(3,3,3500,'Cash','2025-02-03 10:00:00','Success','2025-02-03','2025-02-03'),
(4,4,2800,'Debit Card','2025-02-04 11:00:00','Failed','2025-02-04','2025-02-05'),
(5,5,4200,'Credit Card','2025-02-05 12:30:00','Success','2025-02-05','2025-02-05'),
(6,6,4800,'Mobile Wallet','2025-02-06 13:15:00','Success','2025-02-06','2025-02-06'),
(7,7,2200,'Cash','2025-02-07 14:00:00','Success','2025-02-07','2025-02-07'),
(8,8,2100,'Cash','2025-02-08 15:00:00','Failed','2025-02-08','2025-02-08'),
(9,9,1500,'Credit Card','2025-02-09 16:00:00','Success','2025-02-09','2025-02-09'),
(10,10,2300,'Debit Card','2025-02-10 17:00:00','Success','2025-02-10','2025-02-10'),
(11,11,1800,'Credit Card','2025-02-11 09:30:00','Success','2025-02-11','2025-02-11'),
(12,12,1600,'Mobile Wallet','2025-02-12 10:45:00','Success','2025-02-12','2025-02-12'),
(13,13,2600,'Credit Card','2025-02-13 11:00:00','Failed','2025-02-13','2025-02-14'),
(14,14,1700,'Cash','2025-02-14 12:00:00','Success','2025-02-14','2025-02-14'),
(15,15,0,'Corporate Billing','2025-02-15 13:00:00','Success','2025-02-15','2025-02-15'),
(16,16,0,'-','2025-02-16 14:00:00','Failed','2025-02-16','2025-02-16'),
(17,17,0,'Corporate Billing','2025-02-17 09:00:00','Success','2025-02-17','2025-02-17'),
(18,18,0,'Corporate Billing','2025-02-18 10:00:00','Success','2025-02-18','2025-02-18'),
(19,19,0,'Corporate Billing','2025-02-19 11:00:00','Success','2025-02-19','2025-02-19'),
(20,20,0,'Corporate Billing','2025-02-20 12:00:00','Success','2025-02-20','2025-02-20')
SELECT * FROM Payment

USE AirlineReservationDB;
SELECT * FROM SeatDetails;
ALTER TABLE SeatDetails
ALTER COLUMN SeatNumber NVARCHAR(50)


INSERT INTO SeatDetails(SeatId,TravelClassId,FlightId,AvailabilityStatus,SeatNumber) VALUES
(1,1,1,'Available','12A'),
(2,2,1,'Booked','1B'),
(3,1,2,'Booked','14C'),
(4,4,2,'Available','2A'),
(5,1,3,'Available','6A'),
(6,8,3,'Booked','R1'),
(7,1,4,'Booked','7D'),
(8,10,4,'Available','S2'),
(9,1,5,'Available','18B'),
(10,2,5,'Booked','2C'),
(11,1,6,'Available','20A'),
(12,2,6,'Available','1A'),
(13,8,7,'Available','R5'),
(14,8,8,'Booked','R2'),
(15,1,9,'Booked','3A'),
(16,1,10,'Available','19C'),
(17,8,11,'Booked','R3'),
(18,1,12,'Available','5B'),
(19,1,13,'Booked','10A'),
(20,1,14,'Available','2D');

INSERT INTO Reservation(ReservationId,PassengerId,FlightId,SeatId,ReservationDate,ReservationStatus,CreatedAt,UpdatedAT)
VALUES
(1,1,1,1,'2025-02-01','Confirmed','2025-02-01','2025-02-01'),
(2,2,2,2,'2025-02-02','Cancelled','2025-02-02','2025-02-02'),
(3,3,3,3,'2025-02-03','Confirmed','2025-02-03','2025-02-03'),
(4,4,4,4,'2025-02-04','Confirmed','2025-02-04','2025-02-05'),
(5,5,5,5,'2025-02-05','Cancelled','2025-02-05','2025-02-05'),
(6,6,6,6,'2025-02-06','Cancelled','2025-02-06','2025-02-06'),
(7,7,7,7,'2025-02-07','Confirmed','2025-02-07','2025-02-07'),
(8,8,8,8,'2025-02-08','Cancelled','2025-02-08','2025-02-08'),
(9,9,9,9,'2025-02-09','Confirmed','2025-02-09','2025-02-09'),
(10,10,10,10,'2025-02-10','Pending Payment','2025-02-10','2025-02-10'),
(11,11,11,11,'2025-02-11','Confirmed','2025-02-11','2025-02-11'),
(12,12,12,12,'2025-02-12','Cancelled','2025-02-12','2025-02-12'),
(13,13,13,13,'2025-02-13','Pending Payment','2025-02-13','2025-02-14'),
(14,14,14,14,'2025-02-14','Cancelled','2025-02-14','2025-02-14'),
(15,15,15,15,'2025-02-15','Confirmed','2025-02-15','2025-02-15'),
(16,16,16,16,'2025-02-16','Pending Payment','2025-02-16','2025-02-16'),
(17,17,17,17,'2025-02-17','Confirmed','2025-02-17','2025-02-17'),
(18,18,18,18,'2025-02-18','Confirmed','2025-02-18','2025-02-18'),
(19,19,19,19,'2025-02-19','Pending Payment','2025-02-19','2025-02-19'),
(20,20,20,20,'2025-02-20','Confirmed','2025-02-20','2025-02-20');

SELECT * FROM Reservation
INSERT INTO Payment(PaymentId,ReservationId,PaymentAmount,PaymentMethod,PaymentDueDate,PaymentStatus,CreatedAt,UpdatedAt)
VALUES
(1,1,4500,'Credit Card','2025-02-01 08:00:00','Success','2025-02-01','2025-02-01'),
(2,2,5000,'Mobile Wallet','2025-02-02 09:00:00','Success','2025-02-02','2025-02-02'),
(3,3,3500,'Cash','2025-02-03 10:00:00','Success','2025-02-03','2025-02-03'),
(4,4,2800,'Debit Card','2025-02-04 11:00:00','Failed','2025-02-04','2025-02-05'),
(5,5,4200,'Credit Card','2025-02-05 12:30:00','Success','2025-02-05','2025-02-05'),
(6,6,4800,'Mobile Wallet','2025-02-06 13:15:00','Success','2025-02-06','2025-02-06'),
(7,7,2200,'Cash','2025-02-07 14:00:00','Success','2025-02-07','2025-02-07'),
(8,8,2100,'Cash','2025-02-08 15:00:00','Failed','2025-02-08','2025-02-08'),
(9,9,1500,'Credit Card','2025-02-09 16:00:00','Success','2025-02-09','2025-02-09'),
(10,10,2300,'Debit Card','2025-02-10 17:00:00','Success','2025-02-10','2025-02-10'),
(11,11,1800,'Credit Card','2025-02-11 09:30:00','Success','2025-02-11','2025-02-11'),
(12,12,1600,'Mobile Wallet','2025-02-12 10:45:00','Success','2025-02-12','2025-02-12'),
(13,13,2600,'Credit Card','2025-02-13 11:00:00','Failed','2025-02-13','2025-02-14'),
(14,14,1700,'Cash','2025-02-14 12:00:00','Success','2025-02-14','2025-02-14'),
(15,15,0,'Corporate Billing','2025-02-15 13:00:00','Success','2025-02-15','2025-02-15'),
(16,16,0,'-','2025-02-16 14:00:00','Failed','2025-02-16','2025-02-16'),
(17,17,0,'Corporate Billing','2025-02-17 09:00:00','Success','2025-02-17','2025-02-17'),
(18,18,0,'Corporate Billing','2025-02-18 10:00:00','Success','2025-02-18','2025-02-18'),
(19,19,0,'Corporate Billing','2025-02-19 11:00:00','Success','2025-02-19','2025-02-19'),
(20,20,0,'Corporate Billing','2025-02-20 12:00:00','Success','2025-02-20','2025-02-20');

INSERT INTO FlightCost(FlightId,TravelClassId,Cost,ValidFromDate,ValidToDate) VALUES
(1,1,4500,'2025-01-01','2025-12-31'),
(1,2,12000,'2025-01-01','2025-12-31'),
(2,1,5000,'2025-01-01','2025-12-31'),
(2,4,9000,'2025-01-01','2025-12-31'),
(3,1,3500,'2025-01-01','2025-12-31'),
(3,8,2500,'2025-01-01','2025-12-31'),
(4,1,2800,'2025-01-01','2025-12-31'),
(4,10,2000,'2025-01-01','2025-12-31'),
(5,1,4200,'2025-01-01','2025-12-31'),
(5,2,11000,'2025-01-01','2025-12-31'),
(6,1,4800,'2025-01-01','2025-12-31'),
(6,2,10000,'2025-01-01','2025-12-31'),
(7,8,2200,'2025-01-01','2025-12-31'),
(8,8,2100,'2025-01-01','2025-12-31'),
(9,1,1500,'2025-01-01','2025-12-31'),
(10,1,2300,'2025-01-01','2025-12-31'),
(11,8,1800,'2025-01-01','2025-12-31'),
(12,1,1600,'2025-01-01','2025-12-31'),
(13,1,2600,'2025-01-01','2025-12-31'),
(14,1,1700,'2025-01-01','2025-12-31'),
(15,3,1080,'2025-01-01','2025-12-31'),
(16,1,1099,'2025-01-01','2025-12-31'),
(17,1,1900,'2025-01-01','2025-12-31'),
(18,2,1300,'2025-01-01','2025-12-31'),
(19,4,3000,'2025-01-01','2025-12-31'),
(20,9,2900,'2025-01-01','2025-12-31');
SELECT * FROM FlightCost

INSERT INTO FlightTravelClass(FlightId,TravelClassId,AvailableSeats,MaxSeats) VALUES
(1,1,110,120),
(2,1,100,120),
(3,1,55,60),
(4,1,45,50),
(5,1,115,120),
(6,1,105,120),
(7,8,40,50),
(8,8,50,60),
(9,1,12,20),
(10,1,45,60),
(11,8,18,25),
(12,1,10,12),
(13,1,60,60),
(14,1,8,10),
(15,2,18,20),
(16,4,25,30),
(17,8,5,6),
(18,10,20,20),
(19,2,15,20),
(20,2,10,12);
SELECT * FROM FlightTravelClass

INSERT INTO ServiceOffering(TravelClassId,ServiceId,FromDate,ToDate) VALUES
(1,1,'2025-01-01','2025-12-31'),
(1,6,'2025-01-01','2025-12-31'),
(2,5,'2025-01-01','2025-12-31'),
(2,4,'2025-01-01','2025-12-31'),
(3,11,'2025-01-01','2025-12-31'),
(4,1,'2025-01-01','2025-12-31'),
(4,6,'2025-01-01','2025-12-31'),
(5,3,'2025-01-01','2025-12-31'),
(6,14,'2025-01-01','2025-12-31'),
(7,14,'2025-01-01','2025-12-31'),
(8,1,'2025-01-01','2025-12-31'),
(8,16,'2025-01-01','2025-12-31'),
(9,13,'2025-01-01','2025-12-31'),
(10,10,'2025-01-01','2025-12-31'),
(11,15,'2025-01-01','2025-12-31'),
(12,16,'2025-01-01','2025-12-31'),
(13,12,'2025-01-01','2025-12-31'),
(14,9,'2025-01-01','2025-12-31'),
(15,18,'2025-01-01','2025-12-31'),
(16,4,'2025-01-01','2025-12-31'),
(17,20,'2025-01-01','2025-12-31'),
(18,11,'2025-01-01','2025-12-31'),
(19,2,'2025-01-01','2025-12-31'),
(20,3,'2025-01-01','2025-12-31');
SELECT * FROM ServiceOffering
DROP TABLE RegularPassenger
CREATE TABLE RegularPassenger
(
PassegerId INT NOT NULL,
LoyaltyPoints NVARCHAR(50) NOT NULL
CONSTRAINT RegularPassenger_PassengerId_FK	FOREIGN KEY (PassegerId) REFERENCES Passenger(PassengerId)
)

DROP TABLE CorporatePassenger
CREATE TABLE CorporatePassenger
(
PassengerId INT NOT NULL,
CompanyName NVARCHAR(50) NOT NULL,
EmployeeId NVARCHAR(50) NOT NULL
CONSTRAINT CorporatePassenger_PassengerId_FK	FOREIGN KEY (PassengerId) REFERENCES Passenger(PassengerId)
)

INSERT INTO RegularPassenger(PassengerId,LoyaltyPoints) VALUES
(1,1200),(2,3000),(3,800),(4,2100),(5,4500),(6,600),(7,1900),(8,3200),(9,1500),(10,900),
(11,2400),(12,700),(13,500),(14,1600),(15,1100),(16,1300),(17,400),(18,1750),(19,2200),(20,2800);
 
 select * from RegularPassenger
 INSERT INTO CorporatePassenger(PassengerId,CompanyName,EmployeeId) VALUES
 (1,'Roshan Telecom','R-1001'),
(2,'Afghan Logistics Ltd.','AL-2002'),
(3,'Kabul Bank','KB-3003'),
(4,'Herat Textiles','HT-4004'),
(5,'Balkh Agricultural Exporters','BAE-5005'),
(6,'Nangarhar Construction','NC-6006'),
(7,'Bamyan Cultural Trust','BCT-7007'),
(8,'Khost Energy Co.','KE-8008'),
(9,'Kunduz Transport Services','KTS-9009'),
(10,'Badakhshan Mining Ltd.','BML-1010'),
(11,'Helmand Water Authority','HWA-1111'),
(12,'Farah Foods','FF-1212'),
(13,'Uruzgan Health Services','UHS-1313'),
(14,'Nimruz Trade House','NTH-1414'),
(15,'Baghlan Agro','BA-1515'),
(16,'Parwan Education Trust','PET-1616'),
(17,'Takhar Builders','TB-1717'),
(18,'Kabul University','KU-1818'),
(19,'Herat Medical Center','HMC-1919'),
(20,'Kandahar Logistics','KL-2020');

SELECT * FROM CorporatePassenger


















