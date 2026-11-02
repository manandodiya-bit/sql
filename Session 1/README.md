# Session 1: Database Introduction & SQL Basics

This directory contains the complete solutions, architectural documentation, production SQL scripts, automated Python verification suite, and an interactive Jupyter Notebook for **Session 1: Database Introduction & SQL Basics**.

---

## Overview of Tasks

| Task | Topic | Deliverables & Description |
|---|---|---|
| **Task 1** | Database Setup & Connectivity | Created `music_streaming_app` database in **MySQL** and **SQLite 3**. Verified CLI and Python drivers. |
| **Task 2** | `playlists` Table Creation | Defined `playlists` table schema with columns: `playlist_id` (Primary Key), `name` (Varchar), and `created_by` (Varchar). |
| **Task 3** | Sample Data Insertion | Inserted sample rows representing popular playlists ('Bollywood Hits', 'Chill Vibes', 'Workout Mix') created by different users. |
| **Task 4** | Filtered Data Query | Wrote an SQL `SELECT` query utilizing the `WHERE` clause to display all playlists created by the user `'Amit'`. |
| **Task 5** | Core RDBMS Conceptual Analysis | Comprehensive explanation comparing a **Table**, a **Row**, and a **Column** using real-world **Zomato** application analogies. |

---

## Task Details & Solutions

### Task 1: Database Setup & Connectivity
> **Prompt:** Install MySQL or PostgreSQL on your system and create a new database named 'music_streaming_app' using the command line or GUI tool of your choice.

- **MySQL 8.0:**
  ```sql
  CREATE DATABASE IF NOT EXISTS music_streaming_app
      CHARACTER SET utf8mb4
      COLLATE utf8mb4_unicode_ci;

  USE music_streaming_app;
  ```
- **SQLite 3:**
  Initialized database file `music_streaming_app.db` via CLI and Python:
  ```bash
  python -m sqlite3 database/music_streaming_app.db
  ```

---

### Task 2: Create 'playlists' Table
> **Prompt:** Inside the 'music_streaming_app' database, create a table called 'playlists' with columns: playlist_id (integer, primary key), name (varchar), and created_by (varchar).

```sql
CREATE TABLE playlists (
    playlist_id INTEGER PRIMARY KEY AUTOINCREMENT,   -- For MySQL: playlist_id INT AUTO_INCREMENT PRIMARY KEY
    name VARCHAR(100) NOT NULL,
    created_by VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

#### Schema Breakdown:
- **`playlist_id` (`INTEGER / INT PRIMARY KEY AUTOINCREMENT`):** Uniquely identifies each playlist. Prevents manual collision of IDs.
- **`name` (`VARCHAR(100) NOT NULL`):** Title of the playlist (e.g., "Bollywood Hits").
- **`created_by` (`VARCHAR(50) NOT NULL`):** Username or user handle who curated the playlist.
- **`created_at` (`TIMESTAMP DEFAULT CURRENT_TIMESTAMP`):** Records creation date and time.

---

### Task 3: Insert Sample Data
> **Prompt:** Insert three sample rows into the 'playlists' table representing playlists like 'Bollywood Hits', 'Chill Vibes', and 'Workout Mix', each created by a different user.

```sql
INSERT INTO playlists (name, created_by) VALUES
    ('Bollywood Hits', 'Amit'),
    ('Chill Vibes', 'Priya'),
    ('Workout Mix', 'Rohan'),
    ('Retro 90s Classics', 'Amit');
```

---

### Task 4: Filter by User 'Amit' Using WHERE Clause
> **Prompt:** Write an SQL SELECT query to display all playlists created by the user 'Amit' from the 'playlists' table.
>
> *Hint: Use the WHERE clause to filter by the 'created_by' column.*

```sql
SELECT playlist_id, name, created_by, created_at
FROM playlists
WHERE created_by = 'Amit';
```

#### Query Execution Output:
| playlist_id | name | created_by | created_at |
|---|---|---|---|
| 1 | Bollywood Hits | Amit | 2026-11-02 10:15:00 |
| 4 | Retro 90s Classics | Amit | 2026-11-02 10:15:00 |

---

### Task 5: Conceptual Explanation - Table, Row, and Column (Zomato Example)
> **Prompt:** Open ChatGPT or Copilot and ask it to explain the difference between a table, a row, and a column in SQL using an example from a food delivery app like Zomato. Paste the explanation you receive into your assignment.

```
+----------------------------------------------------------------------------------------------------+
|                                    TABLE: restaurants                                              |
+---------------+---------------------+--------------------+--------+--------------------------------+
| restaurant_id | name                | cuisine            | rating | location                       |  <-- COLUMNS
+---------------+---------------------+--------------------+--------+--------------------------------+
| 101           | Haldiram's          | North Indian       | 4.3    | Connaught Place, New Delhi     |  <-- ROW 1
| 102           | Paradise Biryani    | Hyderabadi Biryani | 4.5    | Secunderabad, Hyderabad        |  <-- ROW 2
| 103           | Glen's Bakehouse    | Bakery / Italian   | 4.6    | Indiranagar, Bengaluru         |  <-- ROW 3
+---------------+---------------------+--------------------+--------+--------------------------------+
```

#### Detailed Breakdown:

1. **What is a TABLE? (The Entire Collection / Entity)**
   - **Definition:** A structured two-dimensional container composed of rows and columns that represents a distinct entity in your system.
   - **Zomato Example:** The **`restaurants`** table (or `orders` table, `delivery_partners` table).
   - **Analogy:** Think of a Table as an entire **Excel Spreadsheet** or a complete phonebook holding all restaurant partners listed on Zomato across the country.

2. **What is a COLUMN? (The Attribute / Field / Category)**
   - **Definition:** The vertical dimension of a table. A column defines a specific characteristic, property, or piece of metadata that every record in the table possesses.
   - **Zomato Example:** **`name`**, **`cuisine`**, **`rating`**, **`location`**.
   - **Key Property:** Every value inside a column shares the exact same data type (e.g., all values in `rating` are decimals like `4.3`, `4.5`; all values in `location` are text strings).

3. **What is a ROW? (The Record / Tuple / Single Instance)**
   - **Definition:** The horizontal dimension of a table. A row represents one single, unique, complete real-world instance of the entity.
   - **Zomato Example:** When you scroll down your Zomato home feed and see **"Paradise Biryani"**, that single restaurant card is a **row**:
     `[restaurant_id: 102, name: "Paradise Biryani", cuisine: "Hyderabadi Biryani", rating: 4.5, location: "Hyderabad"]`
   - **Analogy:** If the table is a folder of restaurant application forms, each individual sheet of paper filled out by a specific restaurant owner is a **row**.

---

## File Directory

```
Session 1/
├── README.md                      # Complete session documentation & task analysis
├── session_1.sql                  # Unified SQL execution script (Tasks 1 - 5)
├── music_streaming_mysql.sql      # Dedicated MySQL 8.0+ production DDL & queries
├── music_streaming_sqlite.sql     # Dedicated SQLite 3 script
├── session_1.py                   # Automated Python verification suite
├── session_1.ipynb                # Interactive Jupyter Notebook
└── database/
    └── music_streaming_app.db     # Populated SQLite database with seeded data
```

---

## How to Run Locally

### 1. Execute the Python Automated Verification Script
```bash
python "Session 1/session_1.py"
```

### 2. Run in SQLite CLI
```bash
python -m sqlite3 "Session 1/database/music_streaming_app.db" < "Session 1/music_streaming_sqlite.sql"
```

### 3. Run in MySQL Workbench / Command Line
```bash
mysql -u root -p < "Session 1/music_streaming_mysql.sql"
```
