-- ============================================================================
-- SQL for Data Science: Session 2 Complete Script
-- Database Setup + CREATE TABLE (Tasks 1 - 5)
-- Compatible with SQLite and MySQL (Notes provided for dialect differences)
-- ============================================================================

-- ============================================================================
-- TASK 1: Verification of Database Installation
-- ============================================================================
-- In SQLite CLI or Python:
--   python -m sqlite3 foodie_app.db
--   SELECT sqlite_version();
--
-- In MySQL Command Line or Workbench:
--   mysql -u root -p
--   SELECT VERSION(), CURRENT_USER();

-- ============================================================================
-- TASK 2: Database Creation
-- ============================================================================
-- For MySQL:
-- CREATE DATABASE IF NOT EXISTS foodie_app;
-- USE foodie_app;
--
-- For SQLite:
-- Created automatically upon connecting to 'foodie_app.db'

-- ============================================================================
-- TASK 3: Create 'restaurants' Table (Zomato-style Backend)
-- Requirements:
--   - id (integer, primary key)
--   - name (varchar/character, max 100)
--   - cuisine (varchar/character, max 50)
--   - rating (decimal, e.g., 4.5)
--   - location (varchar/character, max 100)
-- ============================================================================

DROP TABLE IF EXISTS restaurants;

CREATE TABLE restaurants (
    id INTEGER PRIMARY KEY AUTOINCREMENT,        -- For MySQL: id INT AUTO_INCREMENT PRIMARY KEY
    name VARCHAR(100) NOT NULL,
    cuisine VARCHAR(50) NOT NULL,
    rating DECIMAL(2, 1) CHECK (rating >= 0.0 AND rating <= 5.0),
    location VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Sample Data Insertion:
INSERT INTO restaurants (name, cuisine, rating, location) VALUES
    ('Haldiram''s', 'North Indian / Sweets', 4.3, 'Connaught Place, New Delhi'),
    ('Paradise Biryani', 'Hyderabadi Biryani', 4.5, 'Secunderabad, Hyderabad'),
    ('Glen''s Bakehouse', 'Bakery / Italian', 4.6, 'Indiranagar, Bengaluru'),
    ('Bademiya', 'Mughlai / Kebabs', 4.1, 'Colaba, Mumbai'),
    ('Peter Cat', 'Continental / Indian', 4.7, 'Park Street, Kolkata');

-- ============================================================================
-- TASK 4: Design and Create 'users' Table (Flipkart-style App)
-- Requirements:
--   - user_id (primary key)
--   - username
--   - email
--   - phone_number
--   - created_at (date/time)
--
-- Architectural Choices:
--   1. username: VARCHAR(50) NOT NULL UNIQUE
--      -> Prevents duplicate handles; compact indexing.
--   2. email: VARCHAR(255) NOT NULL UNIQUE
--      -> RFC 5321 specifies maximum email path length of 254 octets.
--      -> Marked UNIQUE to guarantee one account per email.
--   3. phone_number: VARCHAR(15) NOT NULL UNIQUE
--      -> Critical: Numeric types (INT / BIGINT) discard leading zeros (e.g. '098...').
--      -> Phone numbers frequently contain '+' prefix (E.164 format: '+919876543210').
--      -> Storing as VARCHAR(15) preserves international symbols and exact representations.
--   4. created_at: TIMESTAMP DEFAULT CURRENT_TIMESTAMP
--      -> Automatically timestamps account registration in UTC.
-- ============================================================================

DROP TABLE IF EXISTS users;

CREATE TABLE users (
    user_id INTEGER PRIMARY KEY AUTOINCREMENT,   -- For MySQL: user_id INT AUTO_INCREMENT PRIMARY KEY
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone_number VARCHAR(15) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Sample Data Insertion:
INSERT INTO users (username, email, phone_number) VALUES
    ('rahul_verma', 'rahul.verma@example.com', '+919876543210'),
    ('priya_sharma', 'priya.sharma@domain.in', '+919812345678'),
    ('amit_kumar', 'amit.k@techmail.com', '+919701234567'),
    ('neha_patel', 'neha.patel@webmail.org', '+919654321876');

-- ============================================================================
-- TASK 5: Intentional Error & Resolution Demonstration
-- ============================================================================

-- [A] Erroneous Statement (Missing comma after column specification):
-- ----------------------------------------------------------------------------
-- CREATE TABLE restaurants_syntax_error (
--     id INTEGER PRIMARY KEY
--     name VARCHAR(100) NOT NULL,
--     cuisine VARCHAR(50) NOT NULL
-- );
--
-- Resulting Error Message:
--   SQLite: sqlite3.OperationalError: near "name": syntax error
--   MySQL:  ERROR 1064 (42000): You have an error in your SQL syntax near 'name VARCHAR(100)...'
--
-- Root Cause:
--   SQL grammar requires column definitions inside CREATE TABLE (...) to be
--   separated by commas. Without the comma after 'id INTEGER PRIMARY KEY', the
--   lexical analyzer treats 'name' as an unexpected token following the primary key clause.

-- [B] Corrected Statement:
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS restaurants_corrected (
    id INTEGER PRIMARY KEY AUTOINCREMENT,        -- Added missing comma delimiter
    name VARCHAR(100) NOT NULL,
    cuisine VARCHAR(50) NOT NULL,
    rating DECIMAL(2, 1) CHECK (rating >= 0.0 AND rating <= 5.0),
    location VARCHAR(100) NOT NULL
);

-- ============================================================================
-- VERIFICATION AND INSPECTION
-- ============================================================================
SELECT '--- RESTAURANTS TABLE ---' AS section;
SELECT id, name, cuisine, rating, location FROM restaurants;

SELECT '--- USERS TABLE ---' AS section;
SELECT user_id, username, email, phone_number, created_at FROM users;
