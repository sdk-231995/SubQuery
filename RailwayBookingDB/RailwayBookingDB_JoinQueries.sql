-- We want to get a passenger's name, their train name, and the ticket status for each booking.
SELECT 
    p.full_name AS Passenger_Name,
    t.train_name AS Train_Name,
    tk.status AS Ticket_Status
FROM Passengers p
JOIN Bookings b ON p.passenger_id = b.passenger_id
JOIN Trains t ON b.train_id = t.train_id
JOIN Tickets tk ON b.booking_id = tk.booking_id
WHERE tk.status = 'Confirmed';

-- We want to fetch the following:Passenger name ,Train name, Source and destination station names,Ticket status
SELECT 
    p.full_name AS Passenger_Name,
    t.train_name AS Train_Name,
    src.station_name AS Source_Station,
    dest.station_name AS Destination_Station,
    tk.status AS Ticket_Status
FROM Passengers p
JOIN Bookings b ON p.passenger_id = b.passenger_id
JOIN Trains t ON b.train_id = t.train_id
JOIN Stations src ON b.source_station_id = src.station_id
JOIN Stations dest ON b.destination_station_id = dest.station_id
JOIN Tickets tk ON b.booking_id = tk.booking_id
WHERE tk.status = 'Confirmed' AND b.travel_date = '2025-08-01'
;
-- We want to fetch:Passenger name,Train name,Source & Destination Station names,Ticket status,Payment amount & status

SELECT 
    p.full_name AS Passenger_Name,
    t.train_name AS Train_Name,
    src.station_name AS Source_Station,
    dest.station_name AS Destination_Station,
    tk.status AS Ticket_Status,
    pay.amount AS Payment_Amount,
    pay.status AS Payment_Status
FROM Passengers p
JOIN Bookings b ON p.passenger_id = b.passenger_id
JOIN Trains t ON b.train_id = t.train_id
JOIN Stations src ON b.source_station_id = src.station_id
JOIN Stations dest ON b.destination_station_id = dest.station_id
JOIN Tickets tk ON b.booking_id = tk.booking_id
JOIN Payments pay ON b.booking_id = pay.booking_id
WHERE pay.status = 'Success';

-- We want to fetch:Passenger name,Train name,Source & Destination station names,Ticket status,Payment amount 
-- & status,Train current location and delay in minutes on the travel date

SELECT 
    p.full_name AS Passenger_Name,
    t.train_name AS Train_Name,
    src.station_name AS Source_Station,
    dest.station_name AS Destination_Station,
    tk.status AS Ticket_Status,
    pay.amount AS Payment_Amount,
    pay.status AS Payment_Status,
    ts.current_location AS Train_Current_Location,
    ts.delay_minutes AS Delay_Minutes
FROM Passengers p
JOIN Bookings b ON p.passenger_id = b.passenger_id
JOIN Trains t ON b.train_id = t.train_id
JOIN Stations src ON b.source_station_id = src.station_id
JOIN Stations dest ON b.destination_station_id = dest.station_id
JOIN Tickets tk ON b.booking_id = tk.booking_id
JOIN Payments pay ON b.booking_id = pay.booking_id
JOIN Train_Status ts ON b.train_id = ts.train_id AND b.travel_date = ts.travel_date
-- WHERE ts.delay_minutes > 0;
-- WHERE tk.status = 'Confirmed';
WHERE tk.status = 'Confirmed' and ts.delay_minutes > 0;

-- Get all passengers and their booking info, even if they haven’t booked anything yet.
SELECT 
    p.full_name AS Passenger_Name,
    b.booking_id,
    t.train_name
FROM Passengers p
LEFT JOIN Bookings b ON p.passenger_id = b.passenger_id
LEFT JOIN Trains t ON b.train_id = t.train_id;

-- Get all bookings, even if the passenger record is missing (e.g., deleted or corrupted).
SELECT 
    p.full_name,
    b.booking_id,
    t.train_name
FROM Passengers p
RIGHT JOIN Bookings b ON p.passenger_id = b.passenger_id
RIGHT JOIN Trains t ON b.train_id = t.train_id;

-- Full Ticket Info Even if Payment is Missing

SELECT 
    p.full_name,
    t.train_name,
    tk.status AS Ticket_Status,
    pay.amount AS Payment_Amount
FROM Passengers p
LEFT JOIN Bookings b ON p.passenger_id = b.passenger_id
LEFT JOIN Trains t ON b.train_id = t.train_id
LEFT JOIN Tickets tk ON b.booking_id = tk.booking_id
LEFT JOIN Payments pay ON b.booking_id = pay.booking_id;

-- All Payments even if passenger info missing
SELECT 
    p.full_name,
    pay.amount,
    pay.status,
    b.booking_id,
    t.train_name
FROM Payments pay
RIGHT JOIN Bookings b ON pay.booking_id = b.booking_id
RIGHT JOIN Passengers p ON b.passenger_id = p.passenger_id
RIGHT JOIN Trains t ON b.train_id = t.train_id;

-- Selective Payments with Stations Info
SELECT 
    p.full_name,
    t.train_name,
    src.station_name AS Source,
    dest.station_name AS Destination,
    pay.amount,
    pay.status
FROM Passengers p
INNER JOIN Bookings b ON p.passenger_id = b.passenger_id
INNER JOIN Trains t ON b.train_id = t.train_id
LEFT JOIN Stations src ON b.source_station_id = src.station_id
LEFT JOIN Stations dest ON b.destination_station_id = dest.station_id
LEFT JOIN Payments pay ON b.booking_id = pay.booking_id;

-- Find passengers who paid more than the average payment
SELECT full_name 
FROM Passengers 
WHERE passenger_id IN (
    SELECT b.passenger_id 
    FROM Bookings b 
    JOIN Payments p ON b.booking_id = p.booking_id 
    WHERE p.amount > (
        SELECT AVG(amount) FROM Payments
    )
);

-- List all trains that have bookings
SELECT train_name 
FROM Trains 
WHERE train_id IN (
    SELECT DISTINCT train_id FROM Bookings
);

-- Get passengers who haven’t booked any train

SELECT full_name 
FROM Passengers 
WHERE passenger_id NOT IN (
    SELECT passenger_id FROM Bookings
);
-- Find the train(s) with the maximum number of bookings
SELECT train_name 
FROM Trains 
WHERE train_id = (
    SELECT train_id 
    FROM Bookings 
    GROUP BY train_id 
    ORDER BY COUNT(*) DESC 
    LIMIT 1
);

-- List tickets where booking was made on the latest booking date

SELECT * 
FROM Tickets 
WHERE booking_id IN (
    SELECT booking_id 
    FROM Bookings 
    WHERE booking_date = (
        SELECT MAX(booking_date) FROM Bookings
    )
);

-- Get all stations where Rajdhani Express stops
SELECT station_name 
FROM Stations 
WHERE station_id IN (
    SELECT station_id 
    FROM Train_Routes 
    WHERE train_id = (
        SELECT train_id 
        FROM Trains 
        WHERE train_name = 'Rajdhani Express'
    )
);

--  7. Find passengers who have booked tickets on a delayed train
SELECT full_name 
FROM Passengers 
WHERE passenger_id IN (
    SELECT b.passenger_id 
    FROM Bookings b
    JOIN Train_Status ts ON b.train_id = ts.train_id AND b.travel_date = ts.travel_date
    WHERE ts.delay_minutes > 0
);

-- 8. List all confirmed tickets of passengers from ‘Delhi Junction’

SELECT ticket_id, seat_number 
FROM Tickets 
WHERE booking_id IN (
    SELECT booking_id 
    FROM Bookings 
    WHERE source_station_id = (
        SELECT station_id FROM Stations WHERE station_name = 'Delhi Junction'
    ) AND booking_id IN (
        SELECT booking_id FROM Tickets WHERE status = 'Confirmed'
    )
);

-- Find bookings with payments failed

SELECT booking_id 
FROM Bookings 
WHERE booking_id IN (
    SELECT booking_id 
    FROM Payments 
    WHERE status = 'Failed'
);

--  10. Get the most recent payment made by each passenger
SELECT * 
FROM Payments p1 
WHERE payment_date = (
    SELECT MAX(p2.payment_date) 
    FROM Payments p2 
    WHERE p2.booking_id = p1.booking_id
);
