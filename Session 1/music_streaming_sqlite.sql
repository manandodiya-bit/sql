-- ============================================================================
-- SQL for Data Science: Session 1
-- Database Introduction & SQL Basics
-- Target Dialect: SQLite 3
-- Database: music_streaming_app.db
-- ============================================================================

-- ----------------------------------------------------------------------------
-- TASK 2: Create 'playlists' table in SQLite
-- ----------------------------------------------------------------------------
DROP TABLE IF EXISTS playlists;

CREATE TABLE playlists (
    playlist_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(100) NOT NULL,
    created_by VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ----------------------------------------------------------------------------
-- TASK 3: Insert three sample rows representing playlists by different users
-- ----------------------------------------------------------------------------
INSERT INTO playlists (name, created_by) VALUES
    ('Bollywood Hits', 'Amit'),
    ('Chill Vibes', 'Priya'),
    ('Workout Mix', 'Rohan'),
    ('Retro 90s Classics', 'Amit');

-- ----------------------------------------------------------------------------
-- TASK 4: Display all playlists created by the user 'Amit'
-- ----------------------------------------------------------------------------
SELECT playlist_id, name, created_by, created_at
FROM playlists
WHERE created_by = 'Amit';

-- Display all rows
SELECT * FROM playlists;
