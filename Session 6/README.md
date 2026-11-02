# Session 6: ORDER BY + Sorting

This directory contains the complete solutions, architectural documentation, production SQL scripts, automated Python verification suite, and an interactive Jupyter Notebook for **Session 6: ORDER BY + Sorting**.

---

## Overview of Tasks

| Task | Topic | Deliverables & Description |
|---|---|---|
| **Task 1** | Ascending Sort (`ASC`) | Displayed all products from `products` sorted by price ascending (Flipkart low-to-high pricing). |
| **Task 2** | Descending Sort with `LIMIT` | Extracted the top 5 most expensive products using `ORDER BY price DESC LIMIT 5`. |
| **Task 3** | Multi-Column Sorting | Sorted `movies` primarily by `release_year DESC` (latest first), secondarily by `rating DESC` (highest rated first). |
| **Task 4** | Alphabetical Ordering | Listed the first 10 restaurants alphabetically by name (`ORDER BY name ASC LIMIT 10`) like Zomato's A-Z directory. |
| **Task 5** | Secondary Tie-Breaker Logic | Retrieved top 3 trending `songs` by `play_count DESC`, resolving identical play count ties by `added_date DESC` (newest first). |

---

## Task Details & Solutions

### Task 1: Products Sorted by Price Ascending (Flipkart Low to High)
> **Prompt:** Write an SQL query to display all products from a 'products' table and sort them by price in ascending order, similar to how Flipkart lists items from lowest to highest price.

```sql
SELECT id, name, category, price
FROM products
ORDER BY price ASC;
```

#### Output:
| id | name | category | price |
|---|---|---|---|
| 1 | USB-C Fast Charging Cable | Accessories | ₹299.00 |
| 2 | Wireless Optical Mouse | Accessories | ₹599.00 |
| 3 | Boat Airdopes 141 | Audio | ₹1,299.00 |
| 4 | Noise ColorFit Smartwatch | Wearables | ₹1,999.00 |
| 9 | Logitech Mechanical Keyboard | Accessories | ₹6,499.00 |
| 5 | Sony WH-1000XM5 Headphones | Audio | ₹26,990.00 |
| 10 | iPad Air M2 | Tablets | ₹59,900.00 |
| 6 | Samsung Galaxy S24 Ultra | Smartphones | ₹129,999.00 |
| 7 | Apple iPhone 15 Pro | Smartphones | ₹134,900.00 |
| 8 | Dell XPS 15 Laptop | Laptops | ₹189,990.00 |

---

### Task 2: Top 5 Most Expensive Products
> **Prompt:** Modify your previous query to show the top 5 most expensive products using ORDER BY with DESC and LIMIT.

```sql
SELECT id, name, category, price
FROM products
ORDER BY price DESC
LIMIT 5;
```

#### Output:
| id | name | category | price |
|---|---|---|---|
| 8 | Dell XPS 15 Laptop | Laptops | ₹189,990.00 |
| 7 | Apple iPhone 15 Pro | Smartphones | ₹134,900.00 |
| 6 | Samsung Galaxy S24 Ultra | Smartphones | ₹129,999.00 |
| 10 | iPad Air M2 | Tablets | ₹59,900.00 |
| 5 | Sony WH-1000XM5 Headphones | Audio | ₹26,990.00 |

---

### Task 3: Multi-Column Sorting (Movies by Year & Rating)
> **Prompt:** Given a 'movies' table with columns 'title', 'release_year', and 'rating', write an SQL query to list all movies sorted first by release_year in descending order (latest first), then by rating in descending order (highest rated first).

```sql
SELECT title, release_year, rating
FROM movies
ORDER BY release_year DESC, rating DESC;
```

#### Mechanics of Multi-Column Sort:
1. **Primary Sort:** The query groups rows chronologically from newest to oldest (`release_year DESC`).
2. **Secondary Sort:** When multiple movies share the exact same release year (e.g. 2024, 2023), the database breaks the tie by sorting them in descending order of their IMDb `rating`.

#### Output:
| title | release_year | rating |
|---|---|---|
| Dune: Part Two | 2024 | 8.6 |
| Deadpool & Wolverine | 2024 | 7.9 |
| Civil War | 2024 | 7.1 |
| Oppenheimer | 2023 | 8.9 |
| Spider-Man: Across the Spider-Verse | 2023 | 8.7 |
| Poor Things | 2023 | 7.9 |
| Top Gun: Maverick | 2022 | 8.3 |
| The Batman | 2022 | 7.8 |
| Interstellar | 2014 | 8.7 |
| Whiplash | 2014 | 8.5 |

---

### Task 4: Alphabetical Restaurant Directory (Zomato A-Z)
> **Prompt:** Write an SQL query to display the first 10 restaurants from a 'restaurants' table, sorted alphabetically by name, just like Zomato's A-Z listing.
>
> *Hint: Use ORDER BY with LIMIT.*

```sql
SELECT id, name, cuisine, rating, city
FROM restaurants
ORDER BY name ASC
LIMIT 10;
```

#### Output:
| id | name | cuisine | rating | city |
|---|---|---|---|---|
| 1 | Anand Sweets | Sweets & Snacks | 4.3 | Bengaluru |
| 2 | Bademiya | Mughlai / Kebabs | 4.1 | Mumbai |
| 3 | Chai Point | Beverages | 4.0 | Delhi |
| 4 | Dindigul Thalappakatti | Biryani | 4.4 | Chennai |
| 5 | Empire Restaurant | North Indian | 4.2 | Bengaluru |
| 6 | Farzi Cafe | Modern Indian | 4.5 | Delhi |
| 7 | Glen's Bakehouse | Bakery / Desserts | 4.6 | Bengaluru |
| 8 | Haldiram's | North Indian / Sweets | 4.3 | Delhi |
| 9 | Indian Coffee House | Cafe | 4.1 | Kolkata |
| 10 | Jaffer Bhai's Delhi Darbar | Mughlai | 4.4 | Mumbai |

---

### Task 5: Top 3 Trending Songs with Tie-Breaking
> **Prompt:** Suppose you want to display the top 3 trending songs from a 'songs' table based on play_count, but if two songs have the same play_count, the more recently added song should come first. Write the SQL query to achieve this.
>
> *Hint: Use ORDER BY with multiple columns.*

```sql
SELECT id, title, artist, play_count, added_date
FROM songs
ORDER BY play_count DESC, added_date DESC
LIMIT 3;
```

#### Tie-Breaking Scenario:
- *Espresso* leads the chart with `6,500,000` plays (Rank 1).
- Both *Blinding Lights* and *Starboy* have identical play counts (`5,000,000` plays).
- The secondary criterion `added_date DESC` evaluates:
  - *Blinding Lights* was added on `2026-10-15` (newer) $\rightarrow$ **Rank 2**
  - *Starboy* was added on `2026-09-01` (older) $\rightarrow$ **Rank 3**

#### Output:
| id | title | artist | play_count | added_date |
|---|---|---|---|---|
| 5 | Espresso | Sabrina Carpenter | 6,500,000 | 2026-10-01 |
| 2 | Blinding Lights | The Weeknd | 5,000,000 | 2026-10-15 |
| 1 | Starboy | The Weeknd | 5,000,000 | 2026-09-01 |

---

## File Directory

```
Session 6/
├── README.md                      # Comprehensive session documentation & task analysis
├── session_6.sql                  # Unified SQL execution script (Tasks 1 - 5)
├── sorting_mysql.sql              # Dedicated MySQL 8.0+ production DDL & queries
├── sorting_sqlite.sql             # Dedicated SQLite 3 script
├── session_6.py                   # Automated Python verification suite
├── session_6.ipynb                # Interactive Jupyter Notebook
└── database/
    └── sorting_db.db              # Populated SQLite database with seeded data
```

---

## How to Run Locally

### 1. Execute the Python Automated Verification Script
```bash
python "Session 6/session_6.py"
```

### 2. Run in SQLite CLI
```bash
python -m sqlite3 "Session 6/database/sorting_db.db" < "Session 6/sorting_sqlite.sql"
```

### 3. Run in MySQL Workbench / Command Line
```bash
mysql -u root -p < "Session 6/sorting_mysql.sql"
```
