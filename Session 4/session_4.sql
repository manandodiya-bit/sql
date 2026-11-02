-- ============================================================================
-- SQL for Data Science: Session 4 Complete Script
-- SELECT Statement Basics (Tasks 1 to 5)
-- Dialect: Compatible with SQLite & MySQL
-- ============================================================================

-- ============================================================================
-- TASK 1: Create 'MusicPlaylist' Table & Retrieve All Columns
-- Requirements:
--   - Columns: id, song_name, artist, genre, duration
--   - Insert at least 5 records
--   - SELECT statement retrieving all columns for all songs
-- ============================================================================

DROP TABLE IF EXISTS MusicPlaylist;

CREATE TABLE MusicPlaylist (
    id INTEGER PRIMARY KEY AUTOINCREMENT,        -- MySQL: id INT AUTO_INCREMENT PRIMARY KEY
    song_name VARCHAR(100) NOT NULL,
    artist VARCHAR(100) NOT NULL,
    genre VARCHAR(50) NOT NULL,
    duration INT NOT NULL,                       -- Duration in seconds
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO MusicPlaylist (song_name, artist, genre, duration) VALUES
    ('Starboy', 'The Weeknd', 'Synth-pop / R&B', 230),
    ('Blinding Lights', 'The Weeknd', 'Synth-wave', 200),
    ('Tum Hi Ho', 'Arijit Singh', 'Bollywood Romantic', 262),
    ('Brown Munde', 'AP Dhillon', 'Punjabi Hip-Hop', 265),
    ('Shape of You', 'Ed Sheeran', 'Pop', 233),
    ('Kesariya', 'Arijit Singh', 'Bollywood', 268);

-- Retrieve all columns for all songs
SELECT id, song_name, artist, genre, duration, created_at
FROM MusicPlaylist;

-- ============================================================================
-- TASK 2: Projection & Pagination with LIMIT
-- Display only song_name and artist, first 3 records
-- ============================================================================

SELECT song_name, artist
FROM MusicPlaylist
LIMIT 3;

-- ============================================================================
-- TASK 3: Create 'FoodOrders' Table & Unique Restaurants with DISTINCT
-- ============================================================================

DROP TABLE IF EXISTS FoodOrders;

CREATE TABLE FoodOrders (
    id INTEGER PRIMARY KEY AUTOINCREMENT,        -- MySQL: id INT AUTO_INCREMENT PRIMARY KEY
    restaurant VARCHAR(100) NOT NULL,
    food_item VARCHAR(100) NOT NULL,
    order_date DATE NOT NULL
);

INSERT INTO FoodOrders (restaurant, food_item, order_date) VALUES
    ('Haldiram''s', 'Chole Bhature', '2026-10-20'),
    ('Paradise Biryani', 'Chicken Biryani', '2026-10-22'),
    ('Haldiram''s', 'Raj Kachori', '2026-10-25'),
    ('Glen''s Bakehouse', 'Red Velvet Cupcake', '2026-10-28'),
    ('Paradise Biryani', 'Mutton Biryani', '2026-10-30'),
    ('Bademiya', 'Chicken Baida Roti', '2026-11-01'),
    ('Haldiram''s', 'Gulab Jamun', '2026-11-02');

-- List all unique restaurant names using DISTINCT:
SELECT DISTINCT restaurant
FROM FoodOrders;

-- ============================================================================
-- TASK 4: Column Aliases (food_item as 'Dish', order_date as 'Date Ordered')
-- ============================================================================

SELECT 
    food_item AS "Dish",
    order_date AS "Date Ordered"
FROM FoodOrders;

-- ============================================================================
-- TASK 5: Diagnostic and Correction for Query with LIMIT / DISTINCT
--
-- Query Given in Prompt:
--   SELECT DISTINCT food_item, restaurant FROM FoodOrders LIMIT 2
--
-- Detailed Architectural Diagnosis:
--   1. Placement in SQL Clause Grammar:
--      In ANSI SQL / MySQL / SQLite, the mandatory clause evaluation sequence is:
--        SELECT -> FROM -> WHERE -> GROUP BY -> HAVING -> ORDER BY -> LIMIT
--      A very frequent mistake is attempting to place LIMIT immediately after
--      column names (e.g. `SELECT DISTINCT food_item, restaurant LIMIT 2 FROM FoodOrders`),
--      which triggers an immediate syntax error.
--
--   2. Multi-Column DISTINCT Semantics:
--      `DISTINCT` is NOT a function that wraps only the first column!
--      `SELECT DISTINCT col1, col2` evaluates the *combination* of (col1, col2).
--      If the intention was to find the first 2 distinct restaurants,
--      selecting `food_item` causes restaurants to repeat if the dishes differ!
--
--   3. Indeterminate Results without ORDER BY:
--      Running `LIMIT 2` without an `ORDER BY` clause produces non-deterministic
--      results because relational databases do not guarantee row storage order.
-- ============================================================================

-- Fix 1: Properly positioned, deterministic distinct combinations:
SELECT DISTINCT food_item, restaurant
FROM FoodOrders
ORDER BY restaurant, food_item
LIMIT 2;

-- Fix 2: If the objective was 2 distinct restaurants:
SELECT DISTINCT restaurant
FROM FoodOrders
ORDER BY restaurant
LIMIT 2;
