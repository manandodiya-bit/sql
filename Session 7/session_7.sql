-- ============================================================================
-- SQL for Data Science: Session 7 Complete Script
-- Aggregate Functions (Tasks 1 to 5)
-- Dialect: Compatible with SQLite & MySQL
-- ============================================================================

-- ============================================================================
-- TASK 1: Create 'Orders' Table & Seed Data (with NULL total_amount)
-- Columns: order_id, user_name, total_amount, order_date
-- ============================================================================

DROP TABLE IF EXISTS Orders;

CREATE TABLE Orders (
    order_id INTEGER PRIMARY KEY AUTOINCREMENT,        -- MySQL: order_id INT AUTO_INCREMENT PRIMARY KEY
    user_name VARCHAR(50) NOT NULL,
    total_amount DECIMAL(10, 2) NULL,                  -- Allows NULL values
    order_date DATE NOT NULL
);

INSERT INTO Orders (user_name, total_amount, order_date) VALUES
    ('Rahul', 1500.00, '2026-10-15'),
    ('Priya', 2499.50, '2026-10-18'),
    ('Rahul', 850.00, '2026-10-20'),
    ('Amit', NULL, '2026-10-22'),                      -- Sample NULL record
    ('Priya', 3200.00, '2026-10-25');

-- Display raw table
SELECT order_id, user_name, total_amount, order_date FROM Orders;

-- ============================================================================
-- TASK 2: Count Orders Per User (COUNT + GROUP BY)
-- Displays: user_name, order_count
-- ============================================================================

SELECT 
    user_name,
    COUNT(*) AS order_count
FROM Orders
GROUP BY user_name
ORDER BY order_count DESC, user_name ASC;

-- ============================================================================
-- TASK 3: Average Order Amount (Ignoring NULL Values)
-- Calculation:
--   Non-NULL Sum: 1500.00 + 2499.50 + 850.00 + 3200.00 = 8049.50
--   Non-NULL Count: 4
--   Average: 8049.50 / 4 = 2012.38
-- ============================================================================

SELECT 
    ROUND(AVG(total_amount), 2) AS average_order_amount
FROM Orders
WHERE total_amount IS NOT NULL;

-- ============================================================================
-- TASK 4: Flipkart Dashboard - Highest and Lowest Order Amounts in Single Row
-- ============================================================================

SELECT 
    MAX(total_amount) AS highest_order_amount,
    MIN(total_amount) AS lowest_order_amount
FROM Orders;

-- ============================================================================
-- TASK 5: Total Sales (SUM with Explicit IS NOT NULL Filter)
-- ============================================================================

SELECT 
    SUM(total_amount) AS total_sales
FROM Orders
WHERE total_amount IS NOT NULL;
