CREATE TABLE Management (
    manager_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    role VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(15),
    share_percent DECIMAL(5,2) DEFAULT 0.00
);


INSERT INTO Management (name, role, email, phone, share_percent) VALUES
('Rupa', 'Co-Founder & CEO', 'rupa@eventpro.com', '01710101010', 33.33),
('Prethela', 'Co-Founder & Operations Head', 'pre@eventpro.com', '01820202020', 33.33),
('Sumaiya', 'Co-Founder & Finance Lead', 'samu@eventpro.com', '01930303030', 33.34);

CREATE TABLE Customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    customer_city VARCHAR(50)
);

INSERT INTO Customer (name, email, phone, customer_city) VALUES
('Ayra', 'ayra@gmail.com', '01711111111', 'Dhaka'),
('Shayla', 'shayla@gmail.com', '01822222222', 'Chittagong'),
('Mark', 'mark@gmail.com', '01933333333', 'Sylhet'),
('Fiza', 'fiza@gmail.com', '01644444444', 'Dhaka'),
('Tanzim', 'tan@gmail.com', '01555555555', 'Rajshahi');

-- 2️⃣ VENUE TABLE

CREATE TABLE Venue (
    venue_id INT AUTO_INCREMENT PRIMARY KEY,
    venue_name VARCHAR(100),
    location VARCHAR(100),
    capacity INT,
    rent DECIMAL(10,2)
);

INSERT INTO Venue (venue_name, location, capacity, rent) VALUES
('Grand Palace', 'Gulshan', 500, 132000.00),
('XinXian Convention Hall', 'Banani', 300, 80000.00),
('Hojoborojo Resort', 'Cox\'s Bazar', 200, 100000.00),
('Dream Hall', 'Dhanmondi', 400, 95000.00),
('Royal Garden', 'Chittagong', 350, 85000.00);

-- 3️⃣ PACKAGE TABLE

CREATE TABLE Package (
    package_id INT AUTO_INCREMENT PRIMARY KEY,
    package_name VARCHAR(50),
    description VARCHAR(100),
    price DECIMAL(10,2)
);

INSERT INTO Package (package_name, description, price) VALUES
('Silver Package', 'Basic decoration & sound', 40000.00),
('Gold Package', 'Full catering and decoration', 75000.00),
('Platinum Package', 'Premium all-inclusive setup', 120000.00);

-- 4️⃣ Staff TABLE

CREATE TABLE Staff (
    staff_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    role VARCHAR(50),
    role_description VARCHAR(100),
    phone VARCHAR(15),
    salary DECIMAL(10,2),
    manager_id INT,
    event_id INT,
 
    FOREIGN KEY (manager_id) REFERENCES Management(manager_id)
);
INSERT INTO Staff (name, email, role, role_description, phone, salary) VALUES
('Arif', 'arif@eventpro.com', 'Event Manager', 'Oversees all events and staff', '01711110000', 40000.00),
('Nadia', 'nadia@eventpro.com', 'Coordinator', 'Coordinates event logistics', '01822223333', 35000.00),
('Rahim', 'rahim@eventpro.com', 'Sound Engineer', 'Manages sound and audio setup', '01933334444', 30000.00),
('Sabbir', 'sabbir@eventpro.com', 'Lighting Technician', 'Handles lighting and stage setup', '01644445555', 28000.00),
('Farzana', 'farzana@eventpro.com', 'Catering Supervisor', 'Oversees catering and meals', '01555556666', 32000.00);


-- 5️⃣ Event TABLE


CREATE TABLE Event (
    event_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    venue_id INT,
    package_id INT,
    event_type VARCHAR(50),
    event_date DATE,
    staff_id INT,
    status ENUM('Confirmed','Pending','Rescheduled','Cancelled') DEFAULT 'Pending',
    duration_days INT DEFAULT 1,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (venue_id) REFERENCES Venue(venue_id),
    FOREIGN KEY (package_id) REFERENCES Package(package_id),
    FOREIGN KEY (staff_id) REFERENCES Staff(staff_id)
   
);
INSERT INTO Event (customer_id, venue_id, package_id, event_type, event_date, status, duration_days) VALUES
(1, 1, 3, 'Wedding', '2025-10-15', 'Confirmed', 3),
(2, 2, 2, 'Birthday', '2025-11-01', 'Pending', 1),
(3, 3, 2, 'Conference', '2025-12-10', 'Confirmed', 2),
(4, 1, 1, 'Concert', '2025-11-10', 'Rescheduled', 1),
(5, 4, 3, 'Seminar', '2025-11-20', 'Confirmed', 1);


-- 6️⃣ Payment TABLE


CREATE TABLE Payment (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    event_id INT,
    amount DECIMAL(10,2),
    payment_status ENUM('Paid','Pending') DEFAULT 'Pending',
    payment_date DATE,
    FOREIGN KEY (event_id) REFERENCES Event(event_id)
);

INSERT INTO Payment (event_id, amount, payment_status, payment_date) VALUES
(1, 120000, 'Paid', '2025-10-10'),
(2, 50000, 'Pending', '2025-10-20'),
(3, 90000, 'Paid', '2025-12-01'),
(4, 10000, 'Pending', '2025-11-01'),
(5, 75000, 'Paid', '2025-11-15');


-- 7️⃣ EVENT_HISTORY TABLE

CREATE TABLE Event_History (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    event_id INT,
    event_type VARCHAR(50),
    event_date DATE,
    status VARCHAR(20),
    notes VARCHAR(100),
    FOREIGN KEY (event_id) REFERENCES Event(event_id)
);

INSERT INTO Event_History (event_id, event_type, event_date, status, notes) VALUES
(1, 'Wedding', '2025-09-15', 'Completed', 'Successfully organized'),
(2, 'Birthday', '2025-09-25', 'Cancelled', 'Client postponed'),
(3, 'Conference', '2025-09-30', 'Completed', 'Well-managed with 200 guests'),
(4, 'Concert', '2025-09-10', 'Completed', 'High attendance'),
(5, 'Seminar', '2025-09-20', 'Completed', 'Professional speakers');


-- 8️⃣ REVIEW TABLE


CREATE TABLE Review (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    event_id INT,
    customer_id INT,
    rating INT,
    comments VARCHAR(200),
    review_date DATE,
    FOREIGN KEY (event_id) REFERENCES Event(event_id),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

INSERT INTO Review (event_id, customer_id, rating, comments, review_date) VALUES
(1, 1, 5, 'Excellent wedding setup!', '2025-10-20'),
(3, 3, 4, 'Conference was very well managed.', '2025-12-12'),
(5, 5, 5, 'Very professional and organized!', '2025-11-25');

-- 🔹 EASY QUERIES

SELECT * FROM Management;
SELECT * FROM Payment;
UPDATE Event
SET event_date = '2025-11-05', status = 'Rescheduled'
WHERE event_type = 'Birthday';
SELECT * FROM Event;

UPDATE Payment
SET payment_status = 'Paid', amount = 50000
WHERE event_id = 2;
SELECT * FROM Payment;

UPDATE Staff
SET salary = salary * 1.10
WHERE role IN ('Event Manager', 'Coordinator');
SELECT * FROM Staff;

SELECT * FROM Event WHERE status = 'Confirmed';
SELECT SUM(amount) AS Total_Revenue FROM Payment;
SELECT AVG(rent) AS Average_Rent FROM Venue;
ALTER TABLE Customer
ADD customer_address VARCHAR(150) AFTER customer_city,
ADD customer_type ENUM('Regular','VIP') DEFAULT 'Regular' AFTER customer_address;
UPDATE Customer
SET customer_address = 'House 12, Road 5, Gulshan, Dhaka', customer_type = 'VIP'
WHERE customer_id = 1;

UPDATE Customer
SET customer_address = 'House 44, Nasirabad, Chittagong', customer_type = 'Regular'
WHERE customer_id = 2;

UPDATE Customer
SET customer_address = 'Zindabazar, Sylhet', customer_type = 'Regular'
WHERE customer_id = 3;

UPDATE Customer
SET customer_address = 'Road 8, Dhanmondi, Dhaka', customer_type = 'Regular'
WHERE customer_id = 4;

UPDATE Customer
SET customer_address = 'Ranibazar, Rajshahi', customer_type = 'VIP'
WHERE customer_id = 5;
SELECT * FROM Customer;
-- 1️⃣ Alter the table
ALTER TABLE Payment
ADD payment_method VARCHAR(50),
ADD transaction_id VARCHAR(50);

-- Update existing rows with sample data
UPDATE Payment
SET payment_method = 'Bkash',
    transaction_id = 'TXN1001'
WHERE payment_id = 1;

UPDATE Payment
SET payment_method = 'Cash',
    transaction_id = 'TXN1002'
WHERE payment_id = 2;

UPDATE Payment
SET payment_method = 'Card',
    transaction_id = 'TXN1003'
WHERE payment_id = 3;

UPDATE Payment
SET payment_method = 'Bkash',
    transaction_id = 'TXN1004'
WHERE payment_id = 4;

UPDATE Payment
SET payment_method = 'Bank Transfer',
    transaction_id = 'TXN1005'
WHERE payment_id = 5;


-- 1️⃣ Add transaction_time column
ALTER TABLE Payment
ADD transaction_time TIME;

-- 2️⃣ Update existing rows with sample times
UPDATE Payment
SET transaction_time = '14:30:00'
WHERE payment_id = 1;

UPDATE Payment
SET transaction_time = '16:00:00'
WHERE payment_id = 2;

UPDATE Payment
SET transaction_time = '11:00:00'
WHERE payment_id = 3;

UPDATE Payment
SET transaction_time = '15:45:00'
WHERE payment_id = 4;

UPDATE Payment
SET transaction_time = '10:15:00'
WHERE payment_id = 5;

-- 3️⃣ Verify changes
SELECT * FROM Payment;
delete from Staff where staff_id=1;
SELECT *from Staff;

-- 🔹 MID QUERIES

SELECT e.event_id, e.event_type, e.event_date, v.venue_name, c.name AS customer_name, p.package_name
FROM Event e
JOIN Venue v ON e.venue_id = v.venue_id
JOIN Customer c ON e.customer_id = c.customer_id
JOIN Package p ON e.package_id = p.package_id
WHERE e.event_date BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 30 DAY)
ORDER BY e.event_date;

SELECT * FROM Event WHERE status IN ('Pending','Rescheduled');
SELECT name, role, salary
FROM Staff
WHERE salary > (SELECT AVG(salary) FROM Staff);

-- Events with no reviews
SELECT e.event_id, e.event_type
FROM Event e
LEFT JOIN Review r ON e.event_id = r.event_id
WHERE r.review_id IS NULL;


SELECT p.package_name, SUM(pay.amount) AS Total_Revenue
FROM Event e
JOIN Package p ON e.package_id = p.package_id
JOIN Payment pay ON e.event_id = pay.event_id
GROUP BY p.package_id
ORDER BY Total_Revenue DESC;

-- Most booked packages
SELECT p.package_name, COUNT(e.event_id) AS Times_Booked
FROM Event e
JOIN Package p ON e.package_id = p.package_id
GROUP BY p.package_id
ORDER BY Times_Booked DESC;

-- Top spending customers
SELECT c.name, SUM(pay.amount) AS Total_Spent
FROM Customer c
JOIN Event e ON c.customer_id = e.customer_id
JOIN Payment pay ON e.event_id = pay.event_id
GROUP BY c.customer_id
ORDER BY Total_Spent DESC
LIMIT 5;

-- 🔹 ADVANCED / BUSINESS QUERIES

-- Total revenue per package
-- Upcoming events with packages
SELECT e.event_id, e.event_type, e.event_date, c.name AS Customer, p.package_name
FROM Event e
JOIN Customer c ON e.customer_id = c.customer_id
JOIN Package p ON e.package_id = p.package_id
WHERE e.event_date >= CURDATE()
ORDER BY e.event_date;

-- Pending payments older than 10 days
SELECT e.event_id, c.name, pay.amount, pay.payment_date
FROM Payment pay
JOIN Event e ON e.event_id = pay.event_id
JOIN Customer c ON c.customer_id = e.customer_id
WHERE pay.payment_status = 'Pending' AND DATEDIFF(CURDATE(), pay.payment_date) > 10;

-- Top-rated events
SELECT e.event_type, AVG(r.rating) AS Avg_Rating
FROM Event e
JOIN Review r ON e.event_id = r.event_id
GROUP BY e.event_id
ORDER BY Avg_Rating DESC;


-- 🔹 TRIGGER: Prevent Double Booking


DELIMITER //
CREATE TRIGGER prevent_double_booking
BEFORE INSERT ON Event
FOR EACH ROW
BEGIN
    DECLARE overlap_count INT;
    SELECT COUNT(*) INTO overlap_count
    FROM Event
    WHERE venue_id = NEW.venue_id
      AND (
           (NEW.event_date BETWEEN event_date AND DATE_ADD(event_date, INTERVAL duration_days - 1 DAY))
           OR
           (event_date BETWEEN NEW.event_date AND DATE_ADD(NEW.event_date, INTERVAL NEW.duration_days - 1 DAY))
          );
    IF overlap_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Venue already booked for the selected date range!';
    END IF;
END;
//
DELIMITER ;
-- 📦 Customers and their booked packages
SELECT c.name AS Customer_Name,
       e.event_type AS Event_Type,
       e.event_date AS Event_Date,
       p.package_name AS Package_Name,
       p.price AS Package_Price,
       e.status AS Event_Status
FROM Event e
JOIN Customer c ON e.customer_id = c.customer_id
JOIN Package p ON e.package_id = p.package_id
ORDER BY e.event_date;



