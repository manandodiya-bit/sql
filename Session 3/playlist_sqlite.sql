-- ============================================================================
-- SQL for Data Science: Session 3
-- INSERT, UPDATE & DELETE (Data Manipulation Language - DML)
-- Target Dialect: SQLite 3
-- Database: spotify_playlist.db
-- ============================================================================

-- ----------------------------------------------------------------------------
-- TASK 1: Create 'Playlist' table & Insert initial favorite song
-- ----------------------------------------------------------------------------
DROP TABLE IF EXISTS Playlist;

CREATE TABLE Playlist (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    song_name VARCHAR(100) NOT NULL,
    artist VARCHAR(100) NOT NULL,
    duration INT NOT NULL,  -- duration in seconds
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Task 1: Insert single row for current favorite song (intentional typo 'Arjit Singh'):
INSERT INTO Playlist (song_name, artist, duration) VALUES
    ('Tum Hi Ho', 'Arjit Singh', 262);

-- ----------------------------------------------------------------------------
-- TASK 2: Insert 3+ new rows for recently listened Spotify tracks
-- ----------------------------------------------------------------------------
INSERT INTO Playlist (song_name, artist, duration) VALUES
    ('Brown Munde', 'AP Dhillon', 265),
    ('Intro (Interlude)', 'Various Artists', 95),
    ('Excuses', 'AP Dhillon', 195),
    ('With You', 'AP Dhillon', 150),
    ('Kesariya', 'Arijit Singh', 268);

-- ----------------------------------------------------------------------------
-- TASK 3: Fix typo in artist name ('Arjit Singh' -> 'Arijit Singh')
-- ----------------------------------------------------------------------------
UPDATE Playlist
SET artist = 'Arijit Singh'
WHERE artist = 'Arjit Singh';

-- ----------------------------------------------------------------------------
-- TASK 4: Delete song where duration < 120 seconds using WHERE
-- ----------------------------------------------------------------------------
DELETE FROM Playlist
WHERE duration < 120;

-- ----------------------------------------------------------------------------
-- TASK 5: Update song_name for AP Dhillon songs to add ' (Remix)' where duration > 180s
-- SQLite string concatenation uses ||
-- ----------------------------------------------------------------------------
UPDATE Playlist
SET song_name = song_name || ' (Remix)'
WHERE artist = 'AP Dhillon' AND duration > 180;

-- Final Verification Query
SELECT id, song_name, artist, duration, created_at FROM Playlist ORDER BY id;
