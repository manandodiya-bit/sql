# Session 3: INSERT, UPDATE & DELETE (DML Operations)

This directory contains the complete solutions, architectural documentation, production SQL scripts, automated Python verification suite, and an interactive Jupyter Notebook for **Session 3: INSERT, UPDATE & DELETE**.

---

## Overview of Tasks

| Task | Topic | Deliverables & Description |
|---|---|---|
| **Task 1** | Table Setup & Favorite Song | Created `Playlist` table (`id`, `song_name`, `artist`, `duration`) and inserted favorite song with initial artist typo. |
| **Task 2** | Spotify Data Ingestion | Seeded multiple recently listened tracks from Spotify with varied durations and artist metadata. |
| **Task 3** | Data Cleansing (Typo Fix) | Updated artist name from `'Arjit Singh'` to `'Arijit Singh'` using targeted `UPDATE ... WHERE`. |
| **Task 4** | Safe Record Deletion | Removed sub-120 second interludes using `DELETE ... WHERE duration < 120` with safety guidelines. |
| **Task 5** | Compound Conditional Update | Appended `' (Remix)'` to songs by `'AP Dhillon'` having `duration > 180s` using multi-condition filtering. |

---

## Task Details & Solutions

### Task 1: Create 'Playlist' Table & Insert Initial Song
> **Prompt:** Create a table called Playlist with columns: id (INT, primary key), song_name (VARCHAR), artist (VARCHAR), and duration (INT, seconds). Insert a single row for your current favorite song.

```sql
CREATE TABLE Playlist (
    id INTEGER PRIMARY KEY AUTOINCREMENT,        -- For MySQL: id INT AUTO_INCREMENT PRIMARY KEY
    song_name VARCHAR(100) NOT NULL,
    artist VARCHAR(100) NOT NULL,
    duration INT NOT NULL,                       -- Duration in seconds
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert favorite song (with intentional typo 'Arjit Singh' to set up Task 3):
INSERT INTO Playlist (song_name, artist, duration)
VALUES ('Tum Hi Ho', 'Arjit Singh', 262);
```

---

### Task 2: Insert Recent Spotify Tracks
> **Prompt:** Insert 3 new rows into the Playlist table for songs you recently listened to on Spotify, including their song_name, artist, and duration.

```sql
INSERT INTO Playlist (song_name, artist, duration) VALUES
    ('Brown Munde', 'AP Dhillon', 265),
    ('Intro (Interlude)', 'Various Artists', 95),       -- Short track (< 120s) for Task 4
    ('Excuses', 'AP Dhillon', 195),                     -- Long track (> 180s) for Task 5
    ('With You', 'AP Dhillon', 150),                    -- Short AP Dhillon track (<= 180s)
    ('Kesariya', 'Arijit Singh', 268);
```

---

### Task 3: Fix Artist Typo via UPDATE
> **Prompt:** Update the artist name for one of your Playlist entries to fix a typo (for example, change 'Arjit Singh' to 'Arijit Singh') using the UPDATE statement with a WHERE clause.

```sql
UPDATE Playlist
SET artist = 'Arijit Singh'
WHERE artist = 'Arjit Singh';
```

- **Safety & Verification:** Before running an `UPDATE`, execute `SELECT * FROM Playlist WHERE artist = 'Arjit Singh';` to verify only the intended target rows will be affected.

---

### Task 4: Delete Short Tracks (< 120 Seconds)
> **Prompt:** Delete a song from the Playlist table where the duration is less than 120 seconds using the DELETE statement and a WHERE clause.
>
> *Hint: Make sure your WHERE clause is specific so you don't accidentally delete all rows.*

```sql
DELETE FROM Playlist
WHERE duration < 120;
```

#### Production Safety Rule:
> [!WARNING]
> In SQL, executing `DELETE FROM Playlist;` without a `WHERE` clause immediately truncates/deletes **every single record** in the table. Always execute a preview query (`SELECT * FROM Playlist WHERE duration < 120;`) before triggering `DELETE`.

- **Effect:** Successfully removed `'Intro (Interlude)'` (95 seconds).

---

### Task 5: Compound Conditional Update (AP Dhillon Remixes)
> **Prompt:** Write an SQL statement that would update the song_name for all songs by 'AP Dhillon' in your Playlist to add '(Remix)' at the end of the name, but only if the duration is more than 180 seconds.
>
> *Constraint: Combine UPDATE with WHERE to target only the correct rows.*

#### SQLite Dialect (String Concatenation with `||`):
```sql
UPDATE Playlist
SET song_name = song_name || ' (Remix)'
WHERE artist = 'AP Dhillon' AND duration > 180;
```

#### MySQL Dialect (Using `CONCAT`):
```sql
UPDATE Playlist
SET song_name = CONCAT(song_name, ' (Remix)')
WHERE artist = 'AP Dhillon' AND duration > 180;
```

#### Target Verification:
- `'Brown Munde'` (265s, AP Dhillon) $\rightarrow$ Updated to `'Brown Munde (Remix)'` ✅
- `'Excuses'` (195s, AP Dhillon) $\rightarrow$ Updated to `'Excuses (Remix)'` ✅
- `'With You'` (150s, AP Dhillon) $\rightarrow$ **Unchanged** (Condition `duration > 180` evaluates to `FALSE`) ✅

---

## State Transition Summary

| Step | Operation | Resulting Table State |
|---|---|---|
| **1. Creation** | Table defined | Empty table ready for DML |
| **2. Initial Insert** | Task 1 | 1 row: `Tum Hi Ho` (Arjit Singh, 262s) |
| **3. Batch Insert** | Task 2 | 6 rows total |
| **4. Typo Fix** | Task 3 | `Arjit Singh` $\rightarrow$ `Arijit Singh` |
| **5. Deletion** | Task 4 | 95s interlude purged (5 rows remaining) |
| **6. Remix Update** | Task 5 | Tracks $>180\text{s}$ by AP Dhillon updated |

#### Final Data Snapshot:
| id | song_name | artist | duration |
|---|---|---|---|
| 1 | Tum Hi Ho | Arijit Singh | 262 |
| 2 | Brown Munde (Remix) | AP Dhillon | 265 |
| 4 | Excuses (Remix) | AP Dhillon | 195 |
| 5 | With You | AP Dhillon | 150 |
| 6 | Kesariya | Arijit Singh | 268 |

---

## File Directory

```
Session 3/
├── README.md                      # Comprehensive session documentation & task analysis
├── session_3.sql                  # Unified SQL execution script (Tasks 1 - 5)
├── playlist_mysql.sql             # Dedicated MySQL 8.0+ production DDL & queries
├── playlist_sqlite.sql            # Dedicated SQLite 3 script
├── session_3.py                   # Automated Python verification suite
├── session_3.ipynb                # Interactive Jupyter Notebook
└── database/
    └── spotify_playlist.db        # Populated SQLite database with seeded data
```

---

## How to Run Locally

### 1. Execute the Python Automated Verification Script
```bash
python "Session 3/session_3.py"
```

### 2. Run in SQLite CLI
```bash
python -m sqlite3 "Session 3/database/spotify_playlist.db" < "Session 3/playlist_sqlite.sql"
```

### 3. Run in MySQL Workbench / Command Line
```bash
mysql -u root -p < "Session 3/playlist_mysql.sql"
```
