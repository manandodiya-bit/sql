-- ============================================================================
-- SQL for Data Science: Session 5 Complete Script
-- WHERE Clause + LIKE (Tasks 1 to 5)
-- Dialect: Compatible with SQLite & MySQL
-- ============================================================================

-- ============================================================================
-- TASK 1: Create 'Restaurants' Table & Seed Records (Zomato-style)
-- Columns: id, name, cuisine, rating, city
-- ============================================================================

DROP TABLE IF EXISTS Restaurants;

CREATE TABLE Restaurants (
    id INTEGER PRIMARY KEY AUTOINCREMENT,        -- MySQL: id INT AUTO_INCREMENT PRIMARY KEY
    name VARCHAR(100) NOT NULL,
    cuisine VARCHAR(50) NOT NULL,
    rating DECIMAL(2, 1) NOT NULL,
    city VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO Restaurants (name, cuisine, rating, city) VALUES
    ('Swagat Restaurant', 'Gujarati / North Indian', 4.3, 'Ahmedabad'),
    ('Swadisht Zaika', 'South Indian', 4.1, 'Surat'),
    ('Gwalia Sweets', 'Chinese', 3.8, 'Ahmedabad'),
    ('La Pino''z Pizza', 'Italian', 4.4, 'Surat'),
    ('Barbeque Nation', 'Mughlai / BBQ', 4.6, 'Vadodara'),
    ('Sankalp Restaurant', 'South Indian', 4.2, 'Ahmedabad'),
    ('Swastik Fast Food', 'Fast Food', 3.4, 'Rajkot'),
    ('Mainland China', 'Chinese', 4.5, 'Ahmedabad');

-- Display full dataset
SELECT id, name, cuisine, rating, city FROM Restaurants;

-- ============================================================================
-- TASK 2: Filter: rating > 4.0 AND city IN ('Ahmedabad', 'Surat')
-- Demonstrates compound Boolean logic.
-- NOTE: Parentheses around (city = 'Ahmedabad' OR city = 'Surat') are vital
-- because AND has higher operator precedence than OR!
-- ============================================================================

SELECT id, name, cuisine, rating, city
FROM Restaurants
WHERE rating > 4.0 
  AND (city = 'Ahmedabad' OR city = 'Surat');

-- Or equivalently using the IN operator:
-- SELECT id, name, cuisine, rating, city
-- FROM Restaurants
-- WHERE rating > 4.0 AND city IN ('Ahmedabad', 'Surat');

-- ============================================================================
-- TASK 3: Wildcard Pattern Matching with LIKE ('Swa%')
-- Matches any restaurant name starting with 'Swa' followed by zero or more chars.
-- ============================================================================

SELECT id, name, cuisine, rating, city
FROM Restaurants
WHERE name LIKE 'Swa%';

-- ============================================================================
-- TASK 4: Range Query with BETWEEN (Rating 3.5 to 4.5 inclusive)
-- Equivalent to: rating >= 3.5 AND rating <= 4.5
-- ============================================================================

SELECT id, name, cuisine, rating, city
FROM Restaurants
WHERE rating BETWEEN 3.5 AND 4.5
ORDER BY rating DESC;

-- ============================================================================
-- TASK 5: Set Membership Filtering with IN Operator
-- Cuisines: 'Chinese', 'Italian', or 'South Indian'
-- Replaces verbose chained OR conditions:
--   cuisine = 'Chinese' OR cuisine = 'Italian' OR cuisine = 'South Indian'
-- ============================================================================

SELECT id, name, cuisine, rating, city
FROM Restaurants
WHERE cuisine IN ('Chinese', 'Italian', 'South Indian')
ORDER BY cuisine, rating DESC;
