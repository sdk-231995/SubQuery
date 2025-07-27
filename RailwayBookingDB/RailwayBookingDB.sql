CREATE DATABASE RailwayBookingDB;
USE RailwayBookingDB;
CREATE TABLE Stations (
    station_id INT PRIMARY KEY AUTO_INCREMENT,
    station_name VARCHAR(100) NOT NULL,
    location VARCHAR(100)
);

CREATE TABLE Trains (
    train_id INT PRIMARY KEY AUTO_INCREMENT,
    train_name VARCHAR(100) NOT NULL,
    train_type VARCHAR(50),
    total_coaches INT
);

CREATE TABLE Train_Routes (
    route_id INT PRIMARY KEY AUTO_INCREMENT,
    train_id INT,
    station_id INT,
    arrival_time TIME,
    departure_time TIME,
    stop_number INT,
    FOREIGN KEY (train_id) REFERENCES Trains(train_id),
    FOREIGN KEY (station_id) REFERENCES Stations(station_id)
);
CREATE TABLE Passengers (
    passenger_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100),
    gender VARCHAR(10),
    age INT,
    contact_number VARCHAR(15)
);

CREATE TABLE Bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    passenger_id INT,
    train_id INT,
    booking_date DATE,
    travel_date DATE,
    source_station_id INT,
    destination_station_id INT,
    FOREIGN KEY (passenger_id) REFERENCES Passengers(passenger_id),
    FOREIGN KEY (train_id) REFERENCES Trains(train_id),
    FOREIGN KEY (source_station_id) REFERENCES Stations(station_id),
    FOREIGN KEY (destination_station_id) REFERENCES Stations(station_id)
);

CREATE TABLE Tickets (
    ticket_id INT PRIMARY KEY AUTO_INCREMENT,
    booking_id INT,
    seat_number VARCHAR(10),
    coach VARCHAR(5),
    class_type VARCHAR(20),
    status VARCHAR(20),
    FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id)
);

CREATE TABLE Payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    booking_id INT,
    amount DECIMAL(10,2),
    payment_date DATE,
    payment_mode VARCHAR(20),
    status VARCHAR(20),
    FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id)
);

CREATE TABLE Train_Status (
    status_id INT PRIMARY KEY AUTO_INCREMENT,
    train_id INT,
    travel_date DATE,
    current_location VARCHAR(100),
    delay_minutes INT,
    FOREIGN KEY (train_id) REFERENCES Trains(train_id)
);

INSERT INTO Stations (station_name, location) VALUES
('Mumbai Central', 'Mumbai'),
('Delhi Junction', 'Delhi'),
('Howrah', 'Kolkata'),
('Chennai Central', 'Chennai'),
('Secunderabad', 'Hyderabad'),
('Ahmedabad Jn', 'Ahmedabad'),
('Bhopal Jn', 'Bhopal'),
('Pune Jn', 'Pune'),
('Jaipur Jn', 'Jaipur'),
('Lucknow NR', 'Lucknow');

INSERT INTO Trains (train_name, train_type, total_coaches) VALUES
('Rajdhani Express', 'Superfast', 20),
('Duronto Express', 'Superfast', 18),
('Shatabdi Express', 'AC Express', 16),
('Garib Rath', 'Express', 20),
('Tejas Express', 'Semi-High Speed', 14),
('Intercity Express', 'Mail', 22),
('Jan Shatabdi', 'AC Chair Car', 15),
('Humsafar Express', 'AC 3-tier', 19),
('Sampark Kranti', 'Express', 18),
('Udyan Express', 'Mail', 17);




INSERT INTO Train_Routes (train_id, station_id, arrival_time, departure_time, stop_number) VALUES
(1, 1, '00:00:00', '06:00:00', 1),
(1, 2, '12:00:00', '12:10:00', 2),
(1, 3, '18:00:00', '18:15:00', 3),
(2, 2, '06:30:00', '06:45:00', 1),
(2, 4, '14:00:00', '14:20:00', 2),
(3, 3, '08:00:00', '08:05:00', 1),
(3, 5, '16:00:00', '16:30:00', 2),
(4, 6, '09:00:00', '09:10:00', 1),
(5, 7, '07:45:00', '07:55:00', 1),
(5, 8, '13:30:00', '13:45:00', 2);

INSERT INTO Passengers (full_name, gender, age, contact_number) VALUES
('Amit Sharma', 'Male', 34, '9876543210'),
('Priya Mehta', 'Female', 28, '9823456789'),
('Ravi Kumar', 'Male', 45, '9811122233'),
('Sneha Joshi', 'Female', 22, '9876512345'),
('John Dsouza', 'Male', 38, '9998887771'),
('Anjali Rao', 'Female', 30, '9898989898'),
('Suresh Das', 'Male', 50, '9845612345'),
('Nikita Jain', 'Female', 27, '9871234567'),
('Aarav Patel', 'Male', 31, '9856473829'),
('Meena Kumari', 'Female', 60, '9765432109');

INSERT INTO Bookings (passenger_id, train_id, booking_date, travel_date, source_station_id, destination_station_id) VALUES
(1, 1, '2025-07-20', '2025-08-01', 1, 2),
(2, 1, '2025-07-21', '2025-08-01', 1, 3),
(3, 2, '2025-07-22', '2025-08-02', 2, 4),
(4, 3, '2025-07-22', '2025-08-03', 3, 5),
(5, 4, '2025-07-23', '2025-08-04', 6, 7),
(6, 5, '2025-07-23', '2025-08-05', 7, 8),
(7, 6, '2025-07-24', '2025-08-06', 2, 6),
(8, 7, '2025-07-24', '2025-08-07', 5, 3),
(9, 8, '2025-07-25', '2025-08-08', 1, 5),
(10, 9, '2025-07-25', '2025-08-09', 8, 9);

INSERT INTO Tickets (booking_id, seat_number, coach, class_type, status) VALUES
(1, 'S1-45', 'S1', 'Sleeper', 'Confirmed'),
(2, 'B2-12', 'B2', 'AC 3 Tier', 'Confirmed'),
(3, 'A1-03', 'A1', 'AC 1 Tier', 'Confirmed'),
(4, 'D3-25', 'D3', 'Chair Car', 'Waitlisted'),
(5, 'S2-33', 'S2', 'Sleeper', 'Confirmed'),
(6, 'B3-07', 'B3', 'AC 2 Tier', 'Confirmed'),
(7, 'S1-11', 'S1', 'Sleeper', 'Cancelled'),
(8, 'D2-20', 'D2', 'Chair Car', 'Confirmed'),
(9, 'B1-06', 'B1', 'AC 3 Tier', 'Confirmed'),
(10, 'S3-18', 'S3', 'Sleeper', 'Waitlisted');

INSERT INTO Payments (booking_id, amount, payment_date, payment_mode, status) VALUES
(1, 1200.00, '2025-07-20', 'UPI', 'Success'),
(2, 1850.00, '2025-07-21', 'Credit Card', 'Success'),
(3, 2500.00, '2025-07-22', 'Net Banking', 'Success'),
(4, 950.00, '2025-07-22', 'UPI', 'Success'),
(5, 1350.00, '2025-07-23', 'Credit Card', 'Success'),
(6, 1800.00, '2025-07-23', 'Wallet', 'Failed'),
(7, 1100.00, '2025-07-24', 'Cash', 'Pending'),
(8, 900.00, '2025-07-24', 'UPI', 'Success'),
(9, 1650.00, '2025-07-25', 'Net Banking', 'Success'),
(10, 1100.00, '2025-07-25', 'UPI', 'Pending');

INSERT INTO Train_Status (train_id, travel_date, current_location, delay_minutes) VALUES
(1, '2025-08-01', 'Delhi', 10),
(2, '2025-08-02', 'Chennai', 5),
(3, '2025-08-03', 'Hyderabad', 0),
(4, '2025-08-04', 'Ahmedabad', 15),
(5, '2025-08-05', 'Pune', 0),
(6, '2025-08-06', 'Jaipur', 30),
(7, '2025-08-07', 'Lucknow', 0),
(8, '2025-08-08', 'Mumbai', 20),
(9, '2025-08-09', 'Bhopal', 5),
(10, '2025-08-10', 'Delhi', 0);

