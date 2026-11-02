# SQL for Data Science

Welcome to the **SQL for Data Science** repository. This repository contains complete solutions, schema architectures, production SQL scripts, interactive Jupyter Notebooks, datasets, and automated verification suites for relational database management and SQL sessions.

---

## Repository Structure

```
sql/
├── .gitignore
├── README.md                          # Main repository index & setup guide
├── Session 1/
│   ├── README.md                      # Detailed Task writeups & conceptual analysis
│   ├── session_1.sql                  # Complete SQL execution script (Tasks 1 - 5)
│   ├── music_streaming_mysql.sql      # Dedicated MySQL 8.0+ production DDL & queries
│   ├── music_streaming_sqlite.sql     # Dedicated SQLite 3 script
│   ├── session_1.py                   # Automated Python test & verification script
│   ├── session_1.ipynb                # Interactive Jupyter Notebook
│   └── database/
│       └── music_streaming_app.db     # Populated SQLite database file
├── Session 2/
│   ├── README.md                      # Detailed Task writeups, analysis & rationales
│   ├── session_2.sql                  # Complete SQL execution script (Tasks 1 - 5)
│   ├── foodie_app_mysql.sql           # Dedicated MySQL 8.0+ production DDL & seeds
│   ├── foodie_app_sqlite.sql          # Dedicated SQLite 3 script
│   ├── session_2.py                   # Automated Python test & verification script
│   ├── session_2.ipynb                # Interactive Jupyter Notebook
│   ├── generate_screenshot.py         # Screenshot generator script
│   ├── database/
│   │   └── foodie_app.db              # Active SQLite database file
│   └── screenshots/
│       └── task5_sql_error_and_correction.png # Diagnostic error screenshot
├── Session 3/
│   ├── README.md                      # Detailed DML documentation & state transitions
│   ├── session_3.sql                  # Complete SQL execution script (Tasks 1 - 5)
│   ├── playlist_mysql.sql             # Dedicated MySQL 8.0+ production DML script
│   ├── playlist_sqlite.sql            # Dedicated SQLite 3 script
│   ├── session_3.py                   # Automated Python test & verification script
│   ├── session_3.ipynb                # Interactive Jupyter Notebook
│   └── database/
│       └── spotify_playlist.db        # Populated SQLite database file
└── Session 4/
    ├── README.md                      # Comprehensive query documentation & grammar debugging
    ├── session_4.sql                  # Complete SQL execution script (Tasks 1 - 5)
    ├── music_and_orders_mysql.sql     # Dedicated MySQL 8.0+ production DDL & queries
    ├── music_and_orders_sqlite.sql    # Dedicated SQLite 3 script
    ├── session_4.py                   # Automated Python test & verification script
    ├── session_4.ipynb                # Interactive Jupyter Notebook
    └── database/
        └── music_and_orders.db        # Populated SQLite database file
```

---

## Curriculum Overview

| Session | Topic | Key Concepts | Status |
|---|---|---|---|
| **[Session 1](Session%201/)** | Database Introduction & SQL Basics | RDBMS Architecture, Table vs Row vs Column (Zomato), DDL `CREATE TABLE`, DML `INSERT`, `SELECT ... WHERE` Filter | **Completed** |
| **[Session 2](Session%202/)** | Database Setup + CREATE TABLE | Engine Setup, Data Types, Constraints (PK, UNIQUE, CHECK), Decimal Precision, Error Diagnosis & Fix | **Completed** |
| **[Session 3](Session%203/)** | INSERT, UPDATE & DELETE | DML Lifecycle, In-Place Updates, Safe Deletions with WHERE, Compound Filtering, String Concatenation | **Completed** |
| **[Session 4](Session%204/)** | SELECT Statement Basics | Column Projection, Row Pagination (`LIMIT`), Deduplication (`DISTINCT`), Column Aliases (`AS`), Grammar & Clause Placement | **Completed** |

---

## Session Highlights

### [Session 1: Database Introduction & SQL Basics](Session%201/)
- **Music Streaming App (`music_streaming_app`):** Created `playlists` table with `playlist_id`, `name`, and `created_by`.
- **Sample Data Insertion:** Inserted popular playlists ('Bollywood Hits', 'Chill Vibes', 'Workout Mix') by different users.
- **Filtered Queries:** Filtered playlists by user using `SELECT ... WHERE created_by = 'Amit'`.
- **Conceptual Architecture:** Comprehensive breakdown comparing **Table**, **Row**, and **Column** using real-world **Zomato** application analogies.

### [Session 2: Database Setup + CREATE TABLE](Session%202/)
- **Food Delivery Backend (`foodie_app` - Zomato Style):** Implemented `restaurants` table with `id`, `name`, `cuisine`, `rating`, `location` and `CHECK` constraints on ratings.
- **E-Commerce Backend (`users` - Flipkart Style):** Implemented `users` table with `user_id`, `username`, `email`, `phone_number`, `created_at`.
- **Data Type Rationale:** Deep architectural analysis explaining why `VARCHAR(15)` must be used for phone numbers over numeric integers (preserving leading zeroes, supporting `+` international format, preventing overflow).
- **Error Diagnostics:** Intentional syntax error demonstration, parser behavior analysis, corrected SQL, and visual terminal screenshot.

### [Session 3: INSERT, UPDATE & DELETE](Session%203/)
- **Spotify Playlist Table (`Playlist`):** Created table (`id`, `song_name`, `artist`, `duration`) and inserted favorite song.
- **Data Cleansing with UPDATE:** Fixed artist typo from `'Arjit Singh'` to `'Arijit Singh'` using `UPDATE ... WHERE`.
- **Safe Record Deletion:** Purged sub-120s audio interludes using `DELETE ... WHERE duration < 120`.
- **Compound Conditional Concatenation:** Appended `' (Remix)'` to songs by `'AP Dhillon'` with `duration > 180s` across SQLite (`||`) and MySQL (`CONCAT`).

### [Session 4: SELECT Statement Basics](Session%204/)
- **Full & Projected SELECT Queries:** Retrieved all columns (`SELECT *`) and specific subsets (`SELECT song_name, artist`) from `MusicPlaylist`.
- **Pagination with LIMIT:** Extracted top 3 rows using `LIMIT 3`.
- **Unique Records with DISTINCT:** Deduplicated restaurant names across order histories using `SELECT DISTINCT restaurant`.
- **Column Aliasing:** Renamed technical column headers to business terms (`Dish` and `Date Ordered`).
- **Clause Grammar Debugging:** Detailed analysis of `LIMIT` and `DISTINCT` placement, tuple-level uniqueness, and non-deterministic behavior without `ORDER BY`.

---

## Getting Started & Execution

### Prerequisites
- Python 3.10+ (SQLite 3 is built-in)
- Optional: MySQL Community Server 8.0+ / MySQL Workbench

### Running Any Session
```bash
python "Session 1/session_1.py"
python "Session 2/session_2.py"
python "Session 3/session_3.py"
python "Session 4/session_4.py"
```
