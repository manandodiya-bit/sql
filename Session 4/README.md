# Session 4: SELECT Statement Basics

This directory contains the complete solutions, architectural documentation, production SQL scripts, automated Python verification suite, and an interactive Jupyter Notebook for **Session 4: SELECT Statement Basics**.

---

## Overview of Tasks

| Task | Topic | Deliverables & Description |
|---|---|---|
| **Task 1** | Table Creation & Full Projection | Created `MusicPlaylist` (`id`, `song_name`, `artist`, `genre`, `duration`), seeded 6 tracks, and retrieved all rows via `SELECT *`. |
| **Task 2** | Column Projection & Pagination | Projected only `song_name` and `artist`, fetching the first 3 rows using `LIMIT 3`. |
| **Task 3** | Deduplication with `DISTINCT` | Created `FoodOrders` table with duplicate restaurant orders and extracted unique restaurant names using `DISTINCT`. |
| **Task 4** | Column Aliasing with `AS` | Aliased `food_item` as `'Dish'` and `order_date` as `'Date Ordered'` for analytical clarity. |
| **Task 5** | Grammar & Logic Debugging | Diagnosed syntax and logical pitfalls in queries combining `DISTINCT` and `LIMIT`, providing deterministic corrections. |

---

## Task Details & Solutions

### Task 1: Create 'MusicPlaylist' Table & Retrieve All Columns
> **Prompt:** Create a table named MusicPlaylist with columns: id, song_name, artist, genre, and duration. Insert at least 5 records representing songs from your favorite Spotify playlist, then write a SELECT statement to retrieve all columns for all songs.

```sql
CREATE TABLE MusicPlaylist (
    id INTEGER PRIMARY KEY AUTOINCREMENT,        -- For MySQL: id INT AUTO_INCREMENT PRIMARY KEY
    song_name VARCHAR(100) NOT NULL,
    artist VARCHAR(100) NOT NULL,
    genre VARCHAR(50) NOT NULL,
    duration INT NOT NULL,                       -- Duration in seconds
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO MusicPlaylist (song_name, artist, genre, duration) VALUES
    ('Starboy', 'The Weeknd', 'Synth-pop / R&B', 230),
    ('Blinding Lights', 'The Weeknd', 'Synth-wave', 200),
    ('Tum Hi Ho', 'Arijit Singh', 'Bollywood Romantic', 262),
    ('Brown Munde', 'AP Dhillon', 'Punjabi Hip-Hop', 265),
    ('Shape of You', 'Ed Sheeran', 'Pop', 233),
    ('Kesariya', 'Arijit Singh', 'Bollywood', 268);

-- Retrieve all columns for all songs:
SELECT * FROM MusicPlaylist;
```

---

### Task 2: Project 'song_name' & 'artist' with LIMIT 3
> **Prompt:** Write a SQL query to display only the song_name and artist columns from the MusicPlaylist table, showing just the first 3 records using the LIMIT keyword.

```sql
SELECT song_name, artist
FROM MusicPlaylist
LIMIT 3;
```

#### Output:
| song_name | artist |
|---|---|
| Starboy | The Weeknd |
| Blinding Lights | The Weeknd |
| Tum Hi Ho | Arijit Singh |

---

### Task 3: Unique Restaurants Using DISTINCT
> **Prompt:** Suppose you have a table named FoodOrders with columns: id, restaurant, food_item, and order_date. Write a SQL query to list all unique restaurant names where you have placed orders, using the DISTINCT keyword.

```sql
CREATE TABLE FoodOrders (
    id INTEGER PRIMARY KEY AUTOINCREMENT,        -- For MySQL: id INT AUTO_INCREMENT PRIMARY KEY
    restaurant VARCHAR(100) NOT NULL,
    food_item VARCHAR(100) NOT NULL,
    order_date DATE NOT NULL
);

INSERT INTO FoodOrders (restaurant, food_item, order_date) VALUES
    ('Haldiram''s', 'Chole Bhature', '2026-10-20'),
    ('Paradise Biryani', 'Chicken Biryani', '2026-10-22'),
    ('Haldiram''s', 'Raj Kachori', '2026-10-25'),
    ('Glen''s Bakehouse', 'Red Velvet Cupcake', '2026-10-28'),
    ('Paradise Biryani', 'Mutton Biryani', '2026-10-30'),
    ('Bademiya', 'Chicken Baida Roti', '2026-11-01'),
    ('Haldiram''s', 'Gulab Jamun', '2026-11-02');

-- Query all unique restaurants:
SELECT DISTINCT restaurant
FROM FoodOrders;
```

#### Output:
- `Bademiya`
- `Glen's Bakehouse`
- `Haldiram's`
- `Paradise Biryani`

---

### Task 4: Column Aliases ('Dish' and 'Date Ordered')
> **Prompt:** Write a SQL query on the FoodOrders table to select food_item as 'Dish' and order_date as 'Date Ordered', displaying only these two columns with the column aliases in the output.

```sql
SELECT 
    food_item AS "Dish",
    order_date AS "Date Ordered"
FROM FoodOrders;
```

#### Output:
| Dish | Date Ordered |
|---|---|
| Chole Bhature | 2026-10-20 |
| Chicken Biryani | 2026-10-22 |
| Raj Kachori | 2026-10-25 |
| Red Velvet Cupcake | 2026-10-28 |
| Mutton Biryani | 2026-10-30 |
| Chicken Baida Roti | 2026-11-01 |
| Gulab Jamun | 2026-11-02 |

---

### Task 5: Debugging & Correcting Query with LIMIT and DISTINCT
> **Prompt:** You tried running this query: `SELECT DISTINCT food_item, restaurant FROM FoodOrders LIMIT 2`, but it returns an error or doesn't work as expected. Identify and fix the mistake in the query.
>
> *Hint: Check the correct placement and usage of the LIMIT keyword in SQL syntax.*

#### Architectural & Syntactic Diagnosis:

1. **Clause Order & Placement in SQL Grammar:**
   - In SQL execution syntax, clauses must strictly follow this order:
     $$\text{SELECT} \rightarrow \text{FROM} \rightarrow \text{WHERE} \rightarrow \text{GROUP BY} \rightarrow \text{HAVING} \rightarrow \text{ORDER BY} \rightarrow \text{LIMIT}$$
   - A common error is placing `LIMIT` prematurely before `FROM`:  
     `SELECT DISTINCT food_item, restaurant LIMIT 2 FROM FoodOrders;` $\rightarrow$ **`Syntax Error!`**
   - In standard SQL (MySQL / SQLite / PostgreSQL), `LIMIT` must always be placed at the very end.

2. **Multi-Column `DISTINCT` Scope:**
   - `DISTINCT` applies to the **entire row tuple** `(food_item, restaurant)`, not just `food_item`.
   - If the business intention was to get the top 2 distinct restaurants, the query must select only `restaurant`:
     ```sql
     SELECT DISTINCT restaurant FROM FoodOrders LIMIT 2;
     ```

3. **Determinism Requirement (`ORDER BY`):**
   - Without an `ORDER BY` clause, a relational database does not guarantee any specific row sequence. Running `LIMIT 2` produces non-deterministic, inconsistent results across query runs.

#### Corrected Queries:

- **Fix A (Deterministic top 2 distinct dish + restaurant combinations):**
  ```sql
  SELECT DISTINCT food_item, restaurant
  FROM FoodOrders
  ORDER BY restaurant, food_item
  LIMIT 2;
  ```

- **Fix B (Top 2 distinct restaurants):**
  ```sql
  SELECT DISTINCT restaurant
  FROM FoodOrders
  ORDER BY restaurant
  LIMIT 2;
  ```

---

## File Directory

```
Session 4/
├── README.md                      # Comprehensive session documentation & task analysis
├── session_4.sql                  # Unified SQL execution script (Tasks 1 - 5)
├── music_and_orders_mysql.sql     # Dedicated MySQL 8.0+ production DDL & queries
├── music_and_orders_sqlite.sql    # Dedicated SQLite 3 script
├── session_4.py                   # Automated Python verification suite
├── session_4.ipynb                # Interactive Jupyter Notebook
└── database/
    └── music_and_orders.db        # Populated SQLite database with seeded data
```

---

## How to Run Locally

### 1. Execute the Python Automated Verification Script
```bash
python "Session 4/session_4.py"
```

### 2. Run in SQLite CLI
```bash
python -m sqlite3 "Session 4/database/music_and_orders.db" < "Session 4/music_and_orders_sqlite.sql"
```

### 3. Run in MySQL Workbench / Command Line
```bash
mysql -u root -p < "Session 4/music_and_orders_mysql.sql"
```
