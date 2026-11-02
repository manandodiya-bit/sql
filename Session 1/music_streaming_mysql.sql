-- ============================================================================
-- SQL for Data Science: Session 1
-- Database Introduction & SQL Basics
-- Target Dialect: MySQL 8.0+
-- Database: music_streaming_app (Spotify-style Backend Simulation)
-- ============================================================================

-- ----------------------------------------------------------------------------
-- TASK 1: Create 'music_streaming_app' database
-- ----------------------------------------------------------------------------
CREATE DATABASE IF NOT EXISTS music_streaming_app
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE music_streaming_app;

-- ----------------------------------------------------------------------------
-- TASK 2: Create 'playlists' table
-- Columns:
--   - playlist_id: INT PRIMARY KEY AUTO_INCREMENT
--   - name: VARCHAR(100) NOT NULL
--   - created_by: VARCHAR(50) NOT NULL
--   - created_at: TIMESTAMP DEFAULT CURRENT_TIMESTAMP
-- ----------------------------------------------------------------------------
DROP TABLE IF EXISTS playlists;

CREATE TABLE playlists (
    playlist_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    created_by VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- TASK 3: Insert three sample rows representing playlists created by different users
-- ----------------------------------------------------------------------------
INSERT INTO playlists (name, created_by) VALUES
    ('Bollywood Hits', 'Amit'),
    ('Chill Vibes', 'Priya'),
    ('Workout Mix', 'Rohan'),
    ('Retro 90s Classics', 'Amit');

-- ----------------------------------------------------------------------------
-- TASK 4: Display all playlists created by the user 'Amit' using WHERE clause
-- ----------------------------------------------------------------------------
SELECT playlist_id, name, created_by, created_at
FROM playlists
WHERE created_by = 'Amit';

-- Display all records in table for verification
SELECT * FROM playlists;
