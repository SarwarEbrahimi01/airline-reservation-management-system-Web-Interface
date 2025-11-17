USE AirlineReservationDB;

--====================================
--Adding check constraint to tables ==
--====================================

--Airline Table
ALTER TABLE Airline ADD CONSTRAINT CK_Airline_AirlineId CHECK (AirlineId>0);

--Airport Table
ALTER TABLE Airport ADD CONSTRAINT CK_Airport_AirportId CHECK (AirportId>0);

--Flight_Details Table
ALTER TABLE FlightDetails ADD CONSTRAINT CK_FlightDetails_FlightId CHECK (FlightId>0);

--Seat_Details Table
ALTER TABLE SeatDetails ADD CONSTRAINT CK_SeatDetails_SeatId CHECK (SeatId>0);

 --Reservation Table
 ALTER TABLE Reservation ADD CONSTRAINT CK_Reservation_ReservationId CHECK (ReservationId>0);

 --Passenger Table
 ALTER TABLE Passenger ADD CONSTRAINT CK_Passenger_PassengerId CHECK (PassengerId>0);

 --Payment Table
 ALTER TABLE Payment ADD CONSTRAINT CK_Payment_PaymentId CHECK (PaymentId>0);

 select * from FlightTravelClass

 --Flight_Travel Class Table
 ALTER TABLE FlightTravelClass ADD CONSTRAINT CK_FlightTravelClass_FId_AvSeat_Mx CHECK
 (FlightId>0 AND AvailableSeats>=0 AND MaxSeats>=0);

 select * from TravelClass

 --Travel Class Table
 ALTER TABLE TravelClass ADD CONSTRAINT CK_TravelClass_ID_Capacity CHECK (TravelClassId>0 AND TravelClassCapacity>0);

--Flight Service Table
ALTER TABLE FlightService ADD CONSTRAINT CK_FlightService_ServiceId CHECK (ServiceId>0);