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







