-- Food Management System Database

create schema Food_Management;

use Food_Management;

-- List of Tables

-- 1. Customers table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15) UNIQUE,
    address TEXT,
    registered_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Menu Items table
CREATE TABLE MenuItems (
    item_id INT PRIMARY KEY AUTO_INCREMENT,
    item_name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(5,2) NOT NULL,
    is_available BOOLEAN DEFAULT TRUE
);

-- 3. Orders table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_type ENUM('online', 'offline') NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2),
    payment_method VARCHAR(50),
    delivery_address TEXT,
    delivery_status VARCHAR(50),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- 4. Ordered Items table
CREATE TABLE OrderedItems (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    item_id INT,
    quantity INT NOT NULL,
    price DECIMAL(5,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (item_id) REFERENCES MenuItems(item_id)
);

-- 5. Payment Methods table
CREATE TABLE PaymentMethods (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    payment_type VARCHAR(50) NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

-- 6. Delivery table
CREATE TABLE Delivery (
    delivery_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    delivery_address TEXT,
    delivery_time TIMESTAMP,
    delivery_status VARCHAR(50),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

-- 7. Customer Reviews table
CREATE TABLE CustomerReviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    item_id INT,
    review_text TEXT,
    rating INT CHECK (rating >= 1 AND rating <= 5),
    review_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (item_id) REFERENCES MenuItems(item_id)
);

-- 8. Food Coupons table
CREATE TABLE FoodCoupons (
    coupon_id INT PRIMARY KEY AUTO_INCREMENT,
    coupon_code VARCHAR(50) UNIQUE NOT NULL,
    discount_percentage DECIMAL(5,2),
    expiry_date DATE
);

-- 9. Restaurant Table Booking table
CREATE TABLE TableBooking (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    booking_date DATE NOT NULL,
    booking_time TIME NOT NULL,
    number_of_guests INT NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- 10. Offers table
CREATE TABLE Offers (
    offer_id INT PRIMARY KEY AUTO_INCREMENT,
    offer_name VARCHAR(100) NOT NULL,
    description TEXT,
    start_date DATE,
    end_date DATE,
    discount_percentage DECIMAL(5,2)
);

-- Customers table
INSERT INTO Customers (name, email, phone, address) VALUES
('John Doe', 'john@example.com', '1234567890', '123 Maple Street'),
('Jane Smith', 'jane@example.com', '2345678901', '456 Oak Avenue'),
('Mike Johnson', 'mike@example.com', '3456789012', '789 Pine Road'),
('Alice Brown', 'alice@example.com', '4567890123', '101 Elm Street'),
('Bob White', 'bob@example.com', '5678901234', '202 Birch Lane'),
('Carol Black', 'carol@example.com', '6789012345', '303 Cedar Boulevard'),
('David Green', 'david@example.com', '7890123456', '404 Willow Road'),
('Eva Gray', 'eva@example.com', '8901234567', '505 Fir Avenue');

-- Menu Items table
INSERT INTO MenuItems (item_name, price, is_available) VALUES
('Cheeseburger', 5.99, TRUE),
('Grilled Cheese', 3.99, TRUE),
('Chicken Sandwich', 6.49, TRUE),
('French Fries', 2.49, TRUE),
('Garden Salad', 4.99, TRUE),
('Parota', 1.99, TRUE),
('Biryani', 8.49, TRUE),
('Noodles', 7.99, TRUE),
('Chicken Tikka', 9.49, TRUE),
('Paneer Butter Masala', 7.49, TRUE);

-- Orders table
INSERT INTO Orders (customer_id, order_type, total_amount, payment_method, delivery_address, delivery_status) VALUES
(1, 'online', 21.97, 'Credit Card', '123 Maple Street', 'Delivered'),
(2, 'offline', 12.98, 'Cash', NULL, 'Completed'),
(3, 'online', 16.48, 'Debit Card', '789 Pine Road', 'In Progress'),
(4, 'online', 9.98, 'PayPal', '101 Elm Street', 'Delivered'),
(5, 'offline', 15.48, 'Cash', NULL, 'Completed'),
(6, 'online', 18.47, 'Credit Card', '303 Cedar Boulevard', 'In Progress'),
(7, 'offline', 8.97, 'Cash', NULL, 'Completed'),
(8, 'online', 13.49, 'Debit Card', '505 Fir Avenue', 'Delivered');

-- Ordered Items table
INSERT INTO OrderedItems (order_id, item_id, quantity, price) VALUES
(1, 1, 2, 11.98),
(1, 4, 1, 2.49),
(2, 2, 2, 7.98),
(3, 3, 1, 6.49),
(3, 5, 1, 4.99),
(4, 6, 3, 5.97),
(5, 7, 1, 8.49),
(6, 8, 2, 15.98),
(7, 9, 1, 9.49),
(8, 10, 2, 14.98);

-- Payment Methods table
INSERT INTO PaymentMethods (order_id, payment_type, amount) VALUES
(1, 'Credit Card', 21.97),
(2, 'Cash', 12.98),
(3, 'Debit Card', 16.48),
(4, 'PayPal', 9.98),
(5, 'Cash', 15.48),
(6, 'Credit Card', 18.47),
(7, 'Cash', 8.97),
(8, 'Debit Card', 13.49);

-- Delivery data table
INSERT INTO Delivery (order_id, delivery_address, delivery_time, delivery_status) VALUES
(1, '123 Maple Street', '2024-08-25 18:00:00', 'Delivered'),
(3, '789 Pine Road', '2024-08-25 19:00:00', 'In Progress'),
(4, '101 Elm Street', '2024-08-25 17:00:00', 'Delivered'),
(6, '303 Cedar Boulevard', '2024-08-25 20:00:00', 'In Progress'),
(8, '505 Fir Avenue', '2024-08-25 18:30:00', 'Delivered');

-- Customer Reviews table
INSERT INTO CustomerReviews (customer_id, item_id, review_text, rating) VALUES
(1, 1, 'Delicious cheeseburger!', 5),
(2, 2, 'Grilled cheese was a bit too crispy.', 3),
(3, 3, 'Chicken sandwich was great!', 4),
(4, 6, 'Tasty parota!', 5),
(5, 7, 'Biryani was good but could use more spice.', 4),
(6, 8, 'Noodles were perfectly cooked.', 5),
(7, 9, 'Chicken tikka was amazing!', 5),
(8, 10, 'Paneer butter masala was creamy and flavorful.', 4);

-- Food Coupons table
INSERT INTO FoodCoupons (coupon_code, discount_percentage, expiry_date) VALUES
('SAVE10', 10.00, '2024-12-31'),
('SUMMER20', 20.00, '2024-09-30'),
('FREESHIP', 0.00, '2024-12-31'),
('WELCOME15', 15.00, '2024-11-30'),
('LUNCH50', 50.00, '2024-09-15'),
('DINNER10', 10.00, '2024-10-31'),
('HAPPYHOUR25', 25.00, '2024-08-31'),
('LOYALTY5', 5.00, '2024-12-31');

-- Table Booking table
INSERT INTO TableBooking (customer_id, booking_date, booking_time, number_of_guests) VALUES
(1, '2024-08-30', '11:00:00', 2),
(2, '2024-09-01', '02:30:00', 4),
(3, '2024-09-05', '06:00:00', 6),
(4, '2024-09-10', '09:30:00', 3),
(5, '2024-09-15', '12:00:00', 2),
(6, '2024-09-20', '04:00:00', 5),
(7, '2024-09-25', '10:00:00', 4),
(8, '2024-10-01', '08:00:00', 3);

-- Offers table
INSERT INTO Offers (offer_name, description, start_date, end_date, discount_percentage) VALUES
('Weekend Special', 'Get 15% off on all orders this weekend', '2024-09-07', '2024-09-09', 15.00),
('Lunch Combo', 'Buy 1 Get 1 Free on all lunch items', '2024-09-01', '2024-09-30', 50.00),
('Dinner Delight', '20% off on dinner orders after 6 PM', '2024-08-01', '2024-08-31', 20.00),
('Happy Hour', '25% off on all orders between 4 PM and 6 PM', '2024-08-25', '2024-08-31', 25.00),
('Birthday Special', '10% off on your birthday month', '2024-08-01', '2024-08-31', 10.00),
('Family Feast', '20% off on orders for 4 or more guests', '2024-09-05', '2024-09-30', 20.00),
('Early Bird', '15% off on orders before 5 PM', '2024-08-25', '2024-08-31', 15.00),
('Loyalty Reward', '5% off on your next order', '2024-08-25', '2024-12-31', 5.00);

-- 1. Join the Customers with Orders from the Table
SELECT Customers.name, Orders.order_id, Orders.total_amount, Orders.order_type
FROM Customers
JOIN Orders ON Customers.customer_id = Orders.customer_id;

-- 2. Join the Orders with OrderedItems and MenuItems from the Table
SELECT Orders.order_id, MenuItems.item_name, OrderedItems.quantity, OrderedItems.price
FROM Orders
JOIN OrderedItems ON Orders.order_id = OrderedItems.order_id
JOIN MenuItems ON OrderedItems.item_id = MenuItems.item_id;

-- 3. Join the Customers with CustomerReviews and MenuItems from the Table
SELECT Customers.name, MenuItems.item_name, CustomerReviews.review_text, CustomerReviews.rating
FROM Customers
JOIN CustomerReviews ON Customers.customer_id = CustomerReviews.customer_id
JOIN MenuItems ON CustomerReviews.item_id = MenuItems.item_id;

-- 4. Join the Orders with Delivery from the Table
SELECT Orders.order_id, Orders.total_amount, Delivery.delivery_address, Delivery.delivery_status
FROM Orders
JOIN Delivery ON Orders.order_id = Delivery.order_id;
