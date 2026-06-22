CREATE DATABASE Car_Rental_db;
USE Car_Rental_db;

CREATE TABLE branches (
branch_id INT AUTO_INCREMENT PRIMARY KEY,
branch_name VARCHAR(100) NOT NULL UNIQUE,
city VARCHAR(50) NOT NULL, 
phone VARCHAR(20),
address VARCHAR(150)
);

CREATE TABLE employees (
employee_id INT AUTO_INCREMENT PRIMARY KEY,
branch_id INT NOT NULL,
full_name VARCHAR(100) NOT NULL,
role VARCHAR(50) NOT NULL, 
phone VARCHAR(20),
hire_date DATE,
FOREIGN KEY (branch_id) REFERENCES branches(branch_id)
);

CREATE TABLE vehicle_categories (
category_id INT AUTO_INCREMENT PRIMARY KEY,
category_name VARCHAR(50) NOT NULL,
daily_rate DECIMAL(10,2) NOT NULL,
DESCRIPTION VARCHAR(200)
);

CREATE TABLE vehicles (
vehicle_id INT AUTO_INCREMENT PRIMARY KEY,
category_id INT NOT NULL,
branch_id INT NOT NULL,
make VARCHAR(50) NOT NULL,
model VARCHAR(50) NOT NULL,
year INT, 
plate_number VARCHAR(20) NOT NULL UNIQUE,
status ENUM('available','rented','maintenance') DEFAULT 'available',
FOREIGN KEY (category_id) REFERENCES vehicle_categories(category_id),
FOREIGN KEY (branch_id) REFERENCES branches(branch_id)
);

CREATE TABLE customers (
customer_id INT AUTO_INCREMENT PRIMARY KEY,
full_name VARCHAR(100) NOT NULL,
phone VARCHAR(20) NOT NULL,
email VARCHAR(20),
license_number VARCHAR(30) NOT NULL UNIQUE,
registered_date DATE DEFAULT (CURRENT_DATE)
);

CREATE TABLE rentals (
rental_id INT AUTO_INCREMENT PRIMARY KEY,
customer_id INT NOT NULL,
vehicle_id INT NOT NULL,
employee_id INT NOT NULL,
rental_date DATE NOT NULL,
expected_return_date DATE NOT NULL,
actual_return_date DATE,
status ENUM('active','completed','overdue','cancelled') DEFAULT 'active',
total_amount DECIMAL(10,2),
FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id), 
FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

CREATE TABLE payments (
payment_id INT AUTO_INCREMENT PRIMARY KEY,
rental_id INT NOT NULL,
amount DECIMAL(10,2) NOT NULL,
payment_date DATE DEFAULT (CURRENT_DATE),
payment_method ENUM('cash','card','mobile_money') NOT NULL,
FOREIGN KEY (rental_id) REFERENCES rentals(rental_id)
);

CREATE TABLE maintenance (
maintenance_id INT AUTO_INCREMENT PRIMARY KEY,
vehicle_id INT NOT NULL,
service_date INT NOT NULL,
description VARCHAR(200),
cost DECIMAL(10,2),
FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id)
);

SHOW TABLES;
DESCRIBE rentals;

INSERT INTO branches (branch_name, city, phone, address) VALUES
('Blantyre Main Branch', 'Blantyre', '+265990854081','Glyn Jones Road, Blantyre'),
('Lilongwe City Branch', 'Lilongwe', '+265886585121', 'Capital city, Lilongwe'),
('Mzuzu Branch', 'Mzuzu', '+265999152696', 'M1 Road, Mzuzu');

INSERT INTO  vehicle_categories (category_name, daily_rate, description) VALUES
('Economy', '50000.00', 'Compact fuel-efficient cars'),
('SUV', '150000.00', '4x4 vehicles for rough terrain'),
('Luxury', '400000.00', 'Premium cars for executives'),
('Van', '65000.00', 'Group and cargo transport');

INSERT INTO vehicles (category_id, branch_id, make, model, year, plate_number, status) VALUES
(1, 1, 'Toyota', 'Vitz', 2019, 'BT 1234', 'available'),
(1, 1, 'Toyota', 'Axio', 2020, 'BT 2546', 'rented'),
(2, 1, 'Toyota', 'Land Cruiser', 2021, 'BT 5578', 'available'),
(2, 2, 'Nissan', 'X-trail', 2024, 'LL 4567', 'rented'),
(3, 2, 'Mercedes', 'C-class', 2022, 'LL 5877', 'maintenance'),
(4, 3, 'Toyota', 'Hiace', 2018, 'MZ 6789', 'rented');

INSERT INTO employees (branch_id, full_name, role, phone, hire_date) VALUES
(1, 'Elizabeth Kamiza', 'Branch Manager', '+265991000001', '2021-03-01'),
(1, 'Tamanda Phiri', 'Rental Agent', '+2659999897500', '2021-05-09'),
(2, 'Yamikani Kachingwe', 'Rental Agent', '+2658810005353', '2022-06-15'), 
(3, 'Grace Mvula', 'Branch Manager', '+2659905101010','2025-11-20');

INSERT INTO customers (full_name, phone, email, license_number) VALUES
('Memory Lukhere', '+265886865000', 'memory54@gmail.com', 'DL-MW-00123'),
('James Chirwa', '+265999102525', 'Jameschirwa@gmai.com', 'DL-MW-00456'),
('Esther Mhango', '+26599100100', 'Mhango22@gmai.com', 'DL-MW-00789'),
('Patrick Chisale', '+265888777888', 'pchisale@gmail.com', 'DL-MW-01011');


INSERT INTO rentals (customer_id, vehicle_id, employee_id, rental_date, expected_return_date, actual_return_date, status, total_amount) VALUES
(1, 2, 2, '2026-06-01', '2026-06-05', '2026-06-05', 'completed', 100000.00),
(2, 1, 2, '2026-06-10', '2026-06-12', NULL, 'active', 50000.00),
(3, 5, 3, '2026-05-20', '2026-05-25', '2026-05-27', 'completed', 475000.00),
(4, 6, 4, '2026-06-15', '2026-06-18', NULL, 'overdue', 210000.00);

INSERT INTO payments (rental_id, amount, payment_method) VALUES
(1, 100000.00, 'mobile_money'),
(2, 500000.00, 'cash'),
(3, 475000.00, 'card'),
(4, 250000.00, 'mobile_money');


DESCRIBE maintenance;

ALTER TABLE maintenance
MODIFY COLUMN service_date DATE;


INSERT INTO maintenance (vehicle_id, service_date, description, cost) VALUES
(4, '2026-06-08', 'Brake pad replacement', 45000.00),
(3, '2026-05-15', 'Routine oil change', 18000.00);

SELECT * FROM rentals;

#checking for available vehicles
SELECT vehicle_id, make, model, plate_number FROM vehicles WHERE status = 'available';

#Checking for customers
SELECT full_name, phone FROM customers ORDER BY full_name;

#checking for vehicles cheaper than MWK 60,000 a day
SELECT category_name, daily_rate FROM vehicle_categories WHERE daily_rate < 60000;

#Checking each rental, with the customers name and the car they rented
SELECT r.rental_id, c.full_name, v.make, v.model, r.rental_date, r.status
FROM rentals r
JOIN customers c ON r.customer_id = c.customer_id
JOIN vehicles v on r.vehicle_id = v.vehicle_id;

#checking for which employee proccesses which rental with branch name 
SELECT e.full_name AS employee, b.branch_name, r.rental_id, r.rental_date
FROM rentals r
JOIN employees e on r.employee_id = e.employee_id
JOIN branches b on e.branch_id = b.branch_id;

#Checking for total revenue per branch 
SELECT b.branch_name, SUM(r.total_amount) AS total_revenue
FROM rentals r
JOIN vehicles v ON r.vehicle_id = v.vehicle_id
JOIN branches b ON v.branch_id = b.branch_id
GROUP BY b.branch_name;

#total maintenance spend per vehicle 
SELECT v.plate_number, SUM(m.cost) AS total_maintenance_cost
FROM maintenance m
JOIN vehicles v ON m.vehicle_id = v.vehicle_id
GROUP BY v.plate_number;

#CREATING A VIEW 
CREATE VIEW active_rentals_view AS
SELECT r.rental_id, c.full_name AS customer, v.make, v.model, v.plate_number,
       r.rental_date, r.expected_return_date, r.status
FROM rentals r
JOIN customers c ON r.customer_id = c.customer_id
JOIN vehicles v ON r.vehicle_id = v.vehicle_id
WHERE r.status IN ('active', 'overdue');

ALTER TABLE maintenance 

SELECT * FROM active_rentals_view;
