-- ============================================================================
-- SQL for Data Science: Session 4
-- SELECT Statement Basics (Projection, LIMIT, DISTINCT & Aliases)
-- Target Dialect: MySQL 8.0+
-- Database: select_basics_db
-- ============================================================================

CREATE DATABASE IF NOT EXISTS select_basics_db
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE select_basics_db;

-- ----------------------------------------------------------------------------
-- TASK 1: Create 'MusicPlaylist' table & Insert at least 5 songs
-- Columns: id, song_name, artist, genre, duration (seconds)
-- ----------------------------------------------------------------------------
DROP TABLE IF EXISTS MusicPlaylist;

CREATE TABLE MusicPlaylist (
    id INT AUTO_INCREMENT PRIMARY KEY,
    song_name VARCHAR(100) NOT NULL,
    artist VARCHAR(100) NOT NULL,
    genre VARCHAR(50) NOT NULL,
    duration INT NOT NULL,  -- duration in seconds
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

INSERT INTO MusicPlaylist (song_name, artist, genre, duration) VALUES
    ('Starboy', 'The Weeknd', 'Synth-pop / R&B', 230),
    ('Blinding Lights', 'The Weeknd', 'Synth-wave', 200),
    ('Tum Hi Ho', 'Arijit Singh', 'Bollywood Romantic', 262),
    ('Brown Munde', 'AP Dhillon', 'Punjabi Hip-Hop', 265),
    ('Shape of You', 'Ed Sheeran', 'Pop', 233),
    ('Kesariya', 'Arijit Singh', 'Bollywood', 268);

-- Task 1 Query: Retrieve all columns for all songs
SELECT * FROM MusicPlaylist;

-- ----------------------------------------------------------------------------
-- TASK 2: Display only 'song_name' and 'artist', first 3 records using LIMIT
-- ----------------------------------------------------------------------------
SELECT song_name, artist
FROM MusicPlaylist
LIMIT 3;

-- ----------------------------------------------------------------------------
-- TASK 3: Create 'FoodOrders' table & query unique restaurants with DISTINCT
-- Columns: id, restaurant, food_item, order_date
-- ----------------------------------------------------------------------------
DROP TABLE IF EXISTS FoodOrders;

CREATE TABLE FoodOrders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    restaurant VARCHAR(100) NOT NULL,
    food_item VARCHAR(100) NOT NULL,
    order_date DATE NOT NULL
) ENGINE=InnoDB;

INSERT INTO FoodOrders (restaurant, food_item, order_date) VALUES
    ('Haldiram''s', 'Chole Bhature', '2026-10-20'),
    ('Paradise Biryani', 'Chicken Biryani', '2026-10-22'),
    ('Haldiram''s', 'Raj Kachori', '2026-10-25'),
    ('Glen''s Bakehouse', 'Red Velvet Cupcake', '2026-10-28'),
    ('Paradise Biryani', 'Mutton Biryani', '2026-10-30'),
    ('Bademiya', 'Chicken Baida Roti', '2026-11-01'),
    ('Haldiram''s', 'Gulab Jamun', '2026-11-02');

-- Task 3 Query: List all unique restaurant names using DISTINCT
SELECT DISTINCT restaurant
FROM FoodOrders;

-- ----------------------------------------------------------------------------
-- TASK 4: Column Aliases ('Dish' and 'Date Ordered')
-- ----------------------------------------------------------------------------
SELECT 
    food_item AS 'Dish',
    order_date AS 'Date Ordered'
FROM FoodOrders;

-- ----------------------------------------------------------------------------
-- TASK 5: Diagnostic & Fix for Query with LIMIT / DISTINCT
-- Given Query: SELECT DISTINCT food_item, restaurant FROM FoodOrders LIMIT 2
-- Diagnosis:
--   1. Syntax Placement: In SQL clause order, LIMIT must appear strictly after FROM/WHERE.
--   2. Multi-column DISTINCT: DISTINCT applies to the entire row tuple (food_item, restaurant),
--      not just food_item. If unique restaurants only were intended, select only restaurant.
--   3. Determinism: Without an ORDER BY clause, LIMIT 2 returns unpredictable rows.
-- ----------------------------------------------------------------------------

-- Corrected Version A (Deterministic top 2 distinct dish + restaurant combinations):
SELECT DISTINCT food_item, restaurant
FROM FoodOrders
ORDER BY restaurant, food_item
LIMIT 2;

-- Corrected Version B (If goal was to get 2 unique restaurants):
SELECT DISTINCT restaurant
FROM FoodOrders
ORDER BY restaurant
LIMIT 2;
