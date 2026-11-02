-- ============================================================================
-- SQL for Data Science: Session 7
-- Aggregate Functions (COUNT, AVG, MAX, MIN, SUM, GROUP BY & NULL Handling)
-- Target Dialect: SQLite 3
-- Database: orders.db
-- ============================================================================

-- ----------------------------------------------------------------------------
-- TASK 1: Create 'Orders' table & Insert sample rows (with NULL)
-- ----------------------------------------------------------------------------
DROP TABLE IF EXISTS Orders;

CREATE TABLE Orders (
    order_id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_name VARCHAR(50) NOT NULL,
    total_amount DECIMAL(10, 2) NULL,  -- Intentional NULL allowed
    order_date DATE NOT NULL
);

INSERT INTO Orders (user_name, total_amount, order_date) VALUES
    ('Rahul', 1500.00, '2026-10-15'),
    ('Priya', 2499.50, '2026-10-18'),
    ('Rahul', 850.00, '2026-10-20'),
    ('Amit', NULL, '2026-10-22'),        -- Intentional NULL value
    ('Priya', 3200.00, '2026-10-25');

-- Verify raw data
SELECT * FROM Orders;

-- ----------------------------------------------------------------------------
-- TASK 2: Count how many orders were placed by each user
-- ----------------------------------------------------------------------------
SELECT 
    user_name,
    COUNT(*) AS order_count
FROM Orders
GROUP BY user_name
ORDER BY order_count DESC, user_name ASC;

-- ----------------------------------------------------------------------------
-- TASK 3: Average total_amount of all orders (ignoring NULL)
-- ----------------------------------------------------------------------------
SELECT 
    ROUND(AVG(total_amount), 2) AS average_order_amount
FROM Orders
WHERE total_amount IS NOT NULL;

-- ----------------------------------------------------------------------------
-- TASK 4: Highest and lowest order amounts in a single result row
-- ----------------------------------------------------------------------------
SELECT 
    MAX(total_amount) AS highest_order_amount,
    MIN(total_amount) AS lowest_order_amount
FROM Orders;

-- ----------------------------------------------------------------------------
-- TASK 5: Total sales (SUM of total_amount) filtering out NULLs
-- ----------------------------------------------------------------------------
SELECT 
    SUM(total_amount) AS total_sales
FROM Orders
WHERE total_amount IS NOT NULL;
