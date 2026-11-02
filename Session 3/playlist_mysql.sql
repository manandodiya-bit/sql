-- ============================================================================
-- SQL for Data Science: Session 3
-- INSERT, UPDATE & DELETE (Data Manipulation Language - DML)
-- Target Dialect: MySQL 8.0+
-- Database: music_streaming_app
-- ============================================================================

CREATE DATABASE IF NOT EXISTS music_streaming_app
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE music_streaming_app;

-- ----------------------------------------------------------------------------
-- TASK 1: Create 'Playlist' table & Insert favorite song (with typo to fix in Task 3)
-- Columns:
--   - id: INT PRIMARY KEY AUTO_INCREMENT
--   - song_name: VARCHAR(100) NOT NULL
--   - artist: VARCHAR(100) NOT NULL
--   - duration: INT NOT NULL (duration in seconds)
-- ----------------------------------------------------------------------------
DROP TABLE IF EXISTS Playlist;

CREATE TABLE Playlist (
    id INT AUTO_INCREMENT PRIMARY KEY,
    song_name VARCHAR(100) NOT NULL,
    artist VARCHAR(100) NOT NULL,
    duration INT NOT NULL,  -- duration in seconds
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- Insert single row for current favorite song (intentional typo 'Arjit Singh'):
INSERT INTO Playlist (song_name, artist, duration) VALUES
    ('Tum Hi Ho', 'Arjit Singh', 262);

-- Verify Task 1
SELECT * FROM Playlist;

-- ----------------------------------------------------------------------------
-- TASK 2: Insert 3 new rows for recently listened songs on Spotify
-- Included:
--   - Track with duration < 120s (for Task 4 deletion demonstration)
--   - AP Dhillon track with duration > 180s (for Task 5 remix update)
--   - AP Dhillon track with duration <= 180s (boundary condition verification)
-- ----------------------------------------------------------------------------
INSERT INTO Playlist (song_name, artist, duration) VALUES
    ('Brown Munde', 'AP Dhillon', 265),
    ('Intro (Interlude)', 'Various Artists', 95),
    ('Excuses', 'AP Dhillon', 195),
    ('With You', 'AP Dhillon', 150),
    ('Kesariya', 'Arijit Singh', 268);

-- View table before modifications
SELECT * FROM Playlist;

-- ----------------------------------------------------------------------------
-- TASK 3: Fix typo in artist name ('Arjit Singh' -> 'Arijit Singh') using WHERE
-- ----------------------------------------------------------------------------
UPDATE Playlist
SET artist = 'Arijit Singh'
WHERE artist = 'Arjit Singh';

-- Verify Task 3
SELECT * FROM Playlist WHERE artist = 'Arijit Singh';

-- ----------------------------------------------------------------------------
-- TASK 4: Delete song where duration is less than 120 seconds
-- WARNING: Always use a specific WHERE clause to prevent deleting the whole table!
-- ----------------------------------------------------------------------------
DELETE FROM Playlist
WHERE duration < 120;

-- Verify Task 4 (Intro (Interlude) with 95s should be gone)
SELECT * FROM Playlist;

-- ----------------------------------------------------------------------------
-- TASK 5: Update song_name for AP Dhillon songs to append ' (Remix)'
-- Constraint: ONLY if duration is greater than 180 seconds.
-- MySQL String Concatenation: CONCAT(song_name, ' (Remix)')
-- ----------------------------------------------------------------------------
UPDATE Playlist
SET song_name = CONCAT(song_name, ' (Remix)')
WHERE artist = 'AP Dhillon' AND duration > 180;

-- ----------------------------------------------------------------------------
-- FINAL VERIFICATION
-- ----------------------------------------------------------------------------
SELECT id, song_name, artist, duration, created_at
FROM Playlist
ORDER BY id;
