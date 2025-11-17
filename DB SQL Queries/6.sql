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











