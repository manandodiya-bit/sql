-- ============================================================================
-- SQL for Data Science: Session 1 Complete Script
-- Database Introduction & SQL Basics (Tasks 1 to 5)
-- Compatible with SQLite and MySQL
-- ============================================================================

-- ============================================================================
-- TASK 1: Database Setup & Connectivity
-- ============================================================================
-- MySQL:
-- CREATE DATABASE IF NOT EXISTS music_streaming_app;
-- USE music_streaming_app;
--
-- SQLite:
-- Automatically created upon connection to 'music_streaming_app.db'

-- ============================================================================
-- TASK 2: Create Table 'playlists'
-- Columns:
--   - playlist_id: Integer, Primary Key, Auto-increment
--   - name: Varchar(100), Name of playlist
--   - created_by: Varchar(50), User name / owner
-- ============================================================================

DROP TABLE IF EXISTS playlists;

CREATE TABLE playlists (
    playlist_id INTEGER PRIMARY KEY AUTOINCREMENT,   -- MySQL: playlist_id INT AUTO_INCREMENT PRIMARY KEY
    name VARCHAR(100) NOT NULL,
    created_by VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================================
-- TASK 3: Insert Sample Data
-- Three sample rows representing playlists like 'Bollywood Hits', 'Chill Vibes',
-- and 'Workout Mix', each created by a different user.
-- ============================================================================

INSERT INTO playlists (name, created_by) VALUES
    ('Bollywood Hits', 'Amit'),
    ('Chill Vibes', 'Priya'),
    ('Workout Mix', 'Rohan'),
    ('Retro 90s Classics', 'Amit');

-- ============================================================================
-- TASK 4: Display All Playlists Created by 'Amit' (Using WHERE Clause)
-- ============================================================================

SELECT playlist_id, name, created_by, created_at
FROM playlists
WHERE created_by = 'Amit';

-- ============================================================================
-- TASK 5: Conceptual Explanation - Table vs Row vs Column (Zomato Example)
-- ============================================================================
/*
--------------------------------------------------------------------------------
CONCEPTUAL ARCHITECTURE (ZOMATO APP EXAMPLE):
--------------------------------------------------------------------------------
Imagine you open the Zomato app to order food. How is the restaurant data stored?

1. TABLE (The Entire Entity / Collection):
   - Definition: A 2D structured grid of data representing a real-world entity.
   - Zomato Example: The `restaurants` table.
   - It holds all restaurants listed on Zomato across India.

2. COLUMN (The Attribute / Field / Feature):
   - Definition: The vertical slice of a table defining a specific property of the entity.
   - Zomato Example: `restaurant_name`, `cuisine`, `rating`, `delivery_time_mins`.
   - Every column has a specific data type (e.g., VARCHAR for cuisine, DECIMAL for rating).

3. ROW (The Record / Tuple / Instance):
   - Definition: A single horizontal entry across all columns representing one unique item.
   - Zomato Example: One specific restaurant entry:
     [ID: 101 | Name: "Paradise Biryani" | Cuisine: "Hyderabadi" | Rating: 4.5 | Location: "Hyderabad"]
--------------------------------------------------------------------------------
*/

-- Verification: View all playlists
SELECT * FROM playlists;
