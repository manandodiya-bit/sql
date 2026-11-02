-- ============================================================================
-- SQL for Data Science: Session 3 Complete Script
-- INSERT, UPDATE & DELETE (Tasks 1 to 5)
-- Dialect: Compatible with SQLite & MySQL (with dialect notes)
-- ============================================================================

-- ============================================================================
-- TASK 1: Create Table 'Playlist' & Insert Favorite Song
-- Requirements:
--   - id (INT, primary key)
--   - song_name (VARCHAR)
--   - artist (VARCHAR)
--   - duration (INT, seconds)
-- ============================================================================

DROP TABLE IF EXISTS Playlist;

CREATE TABLE Playlist (
    id INTEGER PRIMARY KEY AUTOINCREMENT,        -- MySQL: id INT AUTO_INCREMENT PRIMARY KEY
    song_name VARCHAR(100) NOT NULL,
    artist VARCHAR(100) NOT NULL,
    duration INT NOT NULL,                       -- Duration stored in seconds
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert single row for favorite song (introducing 'Arjit Singh' typo for Task 3):
INSERT INTO Playlist (song_name, artist, duration)
VALUES ('Tum Hi Ho', 'Arjit Singh', 262);

-- ============================================================================
-- TASK 2: Insert 3+ New Rows for Recently Listened Spotify Songs
-- ============================================================================

INSERT INTO Playlist (song_name, artist, duration) VALUES
    ('Brown Munde', 'AP Dhillon', 265),
    ('Intro (Interlude)', 'Various Artists', 95),       -- Sub-120s song for Task 4
    ('Excuses', 'AP Dhillon', 195),                     -- >180s song for Task 5
    ('With You', 'AP Dhillon', 150),                    -- <=180s song to test Task 5 filter
    ('Kesariya', 'Arijit Singh', 268);

-- State before DML updates:
SELECT * FROM Playlist;

-- ============================================================================
-- TASK 3: Fix Artist Typo ('Arjit Singh' -> 'Arijit Singh') using WHERE
-- ============================================================================

UPDATE Playlist
SET artist = 'Arijit Singh'
WHERE artist = 'Arjit Singh';

-- Verify Task 3:
SELECT * FROM Playlist WHERE artist = 'Arijit Singh';

-- ============================================================================
-- TASK 4: Delete Short Songs (duration < 120 seconds) using WHERE
-- CRITICAL SAFETY NOTE: Always test with SELECT before running DELETE!
-- ============================================================================

-- Pre-check which rows will be deleted:
-- SELECT * FROM Playlist WHERE duration < 120;

DELETE FROM Playlist
WHERE duration < 120;

-- Verify Task 4 (Intro (Interlude) with 95 seconds is removed):
SELECT * FROM Playlist;

-- ============================================================================
-- TASK 5: Append ' (Remix)' to Songs by 'AP Dhillon' with duration > 180s
-- SQLite: Uses pipe concatenation (||)
-- MySQL:  Uses CONCAT(song_name, ' (Remix)')
-- ============================================================================

-- For SQLite:
UPDATE Playlist
SET song_name = song_name || ' (Remix)'
WHERE artist = 'AP Dhillon' AND duration > 180;

-- For MySQL:
-- UPDATE Playlist
-- SET song_name = CONCAT(song_name, ' (Remix)')
-- WHERE artist = 'AP Dhillon' AND duration > 180;

-- ============================================================================
-- FINAL VERIFICATION QUERY
-- ============================================================================
SELECT id, song_name, artist, duration, created_at
FROM Playlist
ORDER BY id;
