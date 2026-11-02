-- ============================================================================
-- SQL for Data Science: Session 5
-- WHERE Clause + LIKE (Advanced Filtering, Logical Operators & Pattern Matching)
-- Target Dialect: MySQL 8.0+
-- Database: zomato_filters_db
-- ============================================================================

CREATE DATABASE IF NOT EXISTS zomato_filters_db
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE zomato_filters_db;

-- ----------------------------------------------------------------------------
-- TASK 1: Create 'Restaurants' table & Insert sample records
-- Columns: id, name, cuisine, rating, city
-- ----------------------------------------------------------------------------
DROP TABLE IF EXISTS Restaurants;

CREATE TABLE Restaurants (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    cuisine VARCHAR(50) NOT NULL,
    rating DECIMAL(2, 1) NOT NULL,
    city VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

INSERT INTO Restaurants (name, cuisine, rating, city) VALUES
    ('Swagat Restaurant', 'Gujarati / North Indian', 4.3, 'Ahmedabad'),
    ('Swadisht Zaika', 'South Indian', 4.1, 'Surat'),
    ('Gwalia Sweets', 'Chinese', 3.8, 'Ahmedabad'),
    ('La Pino''z Pizza', 'Italian', 4.4, 'Surat'),
    ('Barbeque Nation', 'Mughlai / BBQ', 4.6, 'Vadodara'),
    ('Sankalp Restaurant', 'South Indian', 4.2, 'Ahmedabad'),
    ('Swastik Fast Food', 'Fast Food', 3.4, 'Rajkot'),
    ('Mainland China', 'Chinese', 4.5, 'Ahmedabad');

-- Verify full table
SELECT * FROM Restaurants;

-- ----------------------------------------------------------------------------
-- TASK 2: Filter rating > 4.0 and city in ('Ahmedabad', 'Surat')
-- ----------------------------------------------------------------------------
SELECT id, name, cuisine, rating, city
FROM Restaurants
WHERE rating > 4.0 AND (city = 'Ahmedabad' OR city = 'Surat');

-- Alternative syntax using IN:
-- WHERE rating > 4.0 AND city IN ('Ahmedabad', 'Surat');

-- ----------------------------------------------------------------------------
-- TASK 3: Filter names starting with 'Swa' using LIKE 'Swa%'
-- ----------------------------------------------------------------------------
SELECT id, name, cuisine, rating, city
FROM Restaurants
WHERE name LIKE 'Swa%';

-- ----------------------------------------------------------------------------
-- TASK 4: Filter ratings between 3.5 and 4.5 (inclusive) using BETWEEN
-- ----------------------------------------------------------------------------
SELECT id, name, cuisine, rating, city
FROM Restaurants
WHERE rating BETWEEN 3.5 AND 4.5
ORDER BY rating DESC;

-- ----------------------------------------------------------------------------
-- TASK 5: Filter cuisine in ('Chinese', 'Italian', 'South Indian') using IN
-- ----------------------------------------------------------------------------
SELECT id, name, cuisine, rating, city
FROM Restaurants
WHERE cuisine IN ('Chinese', 'Italian', 'South Indian')
ORDER BY cuisine, name;
