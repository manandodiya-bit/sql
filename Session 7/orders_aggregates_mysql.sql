-- ============================================================================
-- SQL for Data Science: Session 7
-- Aggregate Functions (COUNT, AVG, MAX, MIN, SUM, GROUP BY & NULL Handling)
-- Target Dialect: MySQL 8.0+
-- Database: flipkart_analytics_db
-- ============================================================================

CREATE DATABASE IF NOT EXISTS flipkart_analytics_db
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE flipkart_analytics_db;

-- ----------------------------------------------------------------------------
-- TASK 1: Create 'Orders' table & Insert sample rows (including NULL total_amount)
-- Columns: order_id, user_name, total_amount, order_date
-- ----------------------------------------------------------------------------
DROP TABLE IF EXISTS Orders;

CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_name VARCHAR(50) NOT NULL,
    total_amount DECIMAL(10, 2) NULL,  -- NULL represents pending/unbilled order
    order_date DATE NOT NULL
) ENGINE=InnoDB;

INSERT INTO Orders (user_name, total_amount, order_date) VALUES
    ('Rahul', 1500.00, '2026-10-15'),
    ('Priya', 2499.50, '2026-10-18'),
    ('Rahul', 850.00, '2026-10-20'),
    ('Amit', NULL, '2026-10-22'),        -- Intentional NULL value
    ('Priya', 3200.00, '2026-10-25');

-- Verify raw data
SELECT * FROM Orders;

-- ----------------------------------------------------------------------------
-- TASK 2: Count how many orders were placed by each user (GROUP BY)
-- Displays: user_name, order_count
-- ----------------------------------------------------------------------------
SELECT 
    user_name,
    COUNT(*) AS order_count
FROM Orders
GROUP BY user_name
ORDER BY order_count DESC, user_name ASC;

-- ----------------------------------------------------------------------------
-- TASK 3: Average total_amount of all orders (ignoring NULL values)
-- In SQL, AVG() naturally ignores NULL values.
-- ----------------------------------------------------------------------------
SELECT 
    ROUND(AVG(total_amount), 2) AS average_order_amount
FROM Orders
WHERE total_amount IS NOT NULL;

-- ----------------------------------------------------------------------------
-- TASK 4: Flipkart Dashboard - Highest and Lowest Order Amounts in Single Row
-- Displays: highest_order_amount (MAX), lowest_order_amount (MIN)
-- ----------------------------------------------------------------------------
SELECT 
    MAX(total_amount) AS highest_order_amount,
    MIN(total_amount) AS lowest_order_amount
FROM Orders;

-- ----------------------------------------------------------------------------
-- TASK 5: Total Sales (SUM of total_amount) filtering out NULLs with WHERE
-- ----------------------------------------------------------------------------
SELECT 
    SUM(total_amount) AS total_sales
FROM Orders
WHERE total_amount IS NOT NULL;
