-- ============================================================================
-- SQL for Data Science: Session 2
-- Database Setup + CREATE TABLE
-- Target Dialect: MySQL 8.0+
-- Application Simulation: 'foodie_app' (Zomato Backend) & 'users' (Flipkart Backend)
-- ============================================================================

-- ----------------------------------------------------------------------------
-- TASK 2: Create a new database named 'foodie_app'
-- ----------------------------------------------------------------------------
CREATE DATABASE IF NOT EXISTS foodie_app
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE foodie_app;

-- ----------------------------------------------------------------------------
-- TASK 3: Define 'restaurants' table in 'foodie_app'
-- Columns:
--   - id: INT, Primary Key, Auto-incremented
--   - name: VARCHAR(100), Restaurant Name
--   - cuisine: VARCHAR(50), Cuisine type (e.g., North Indian, Italian, Biryani)
--   - rating: DECIMAL(2, 1), E.g., 4.5, valid range [0.0, 5.0]
--   - location: VARCHAR(100), City / Neighborhood location
-- ----------------------------------------------------------------------------
DROP TABLE IF EXISTS restaurants;

CREATE TABLE restaurants (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    cuisine VARCHAR(50) NOT NULL,
    rating DECIMAL(2, 1) CHECK (rating >= 0.0 AND rating <= 5.0),
    location VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- TASK 4: Design and create a 'users' table for a Flipkart-style app
-- Design Rationale:
--   - user_id: INT PRIMARY KEY AUTO_INCREMENT
--   - username: VARCHAR(50) NOT NULL UNIQUE (Unique handle for login)
--   - email: VARCHAR(255) NOT NULL UNIQUE (RFC 5321 standard length)
--   - phone_number: VARCHAR(15) NOT NULL UNIQUE (Preserves leading zeros and country codes e.g. +91)
--   - created_at: TIMESTAMP DEFAULT CURRENT_TIMESTAMP (Audit tracking)
-- ----------------------------------------------------------------------------
DROP TABLE IF EXISTS users;

CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone_number VARCHAR(15) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- SEED DATA: Insert verification records
-- ----------------------------------------------------------------------------
INSERT INTO restaurants (name, cuisine, rating, location) VALUES
    ('Haldiram''s', 'North Indian / Sweets', 4.3, 'Connaught Place, New Delhi'),
    ('Paradise Biryani', 'Hyderabadi Biryani', 4.5, 'Secunderabad, Hyderabad'),
    ('Glen''s Bakehouse', 'Bakery / Italian', 4.6, 'Indiranagar, Bengaluru'),
    ('Bademiya', 'Mughlai / Kebabs', 4.1, 'Colaba, Mumbai'),
    ('Peter Cat', 'Continental / Indian', 4.7, 'Park Street, Kolkata');

INSERT INTO users (username, email, phone_number) VALUES
    ('rahul_verma', 'rahul.verma@example.com', '+919876543210'),
    ('priya_sharma', 'priya.sharma@domain.in', '+919812345678'),
    ('amit_kumar', 'amit.k@techmail.com', '+919701234567'),
    ('neha_patel', 'neha.patel@webmail.org', '+919654321876');

-- ----------------------------------------------------------------------------
-- VERIFICATION QUERIES
-- ----------------------------------------------------------------------------
SELECT * FROM restaurants;
SELECT * FROM users;
