# Session 5: WHERE Clause + LIKE (Advanced Filtering & Pattern Matching)

This directory contains the complete solutions, architectural documentation, production SQL scripts, automated Python verification suite, and an interactive Jupyter Notebook for **Session 5: WHERE Clause + LIKE**.

---

## Overview of Tasks

| Task | Topic | Deliverables & Description |
|---|---|---|
| **Task 1** | Schema Design & Data Seeding | Created `Restaurants` table (`id`, `name`, `cuisine`, `rating`, `city`) and seeded 8 realistic Zomato restaurant records. |
| **Task 2** | Compound Boolean Filtering | Filtered restaurants with `rating > 4.0` in `'Ahmedabad'` or `'Surat'`, demonstrating Boolean operator precedence. |
| **Task 3** | Pattern Matching with `LIKE` | Retrieved restaurant names starting with `'Swa'` using the `LIKE 'Swa%'` wildcard. |
| **Task 4** | Inclusive Range Queries | Queried restaurants with ratings in the interval $[3.5, 4.5]$ using the `BETWEEN` operator. |
| **Task 5** | Set Membership with `IN` | Filtered restaurants whose cuisine belongs to `('Chinese', 'Italian', 'South Indian')` using the `IN` operator. |

---

## Task Details & Solutions

### Task 1: Create 'Restaurants' Table & Seed Records
> **Prompt:** Create a table called Restaurants with columns: id, name, cuisine, rating, and city. Insert at least 5 sample records representing real or fictional restaurants you might find on Zomato.

```sql
CREATE TABLE Restaurants (
    id INTEGER PRIMARY KEY AUTOINCREMENT,        -- For MySQL: id INT AUTO_INCREMENT PRIMARY KEY
    name VARCHAR(100) NOT NULL,
    cuisine VARCHAR(50) NOT NULL,
    rating DECIMAL(2, 1) NOT NULL,
    city VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO Restaurants (name, cuisine, rating, city) VALUES
    ('Swagat Restaurant', 'Gujarati / North Indian', 4.3, 'Ahmedabad'),
    ('Swadisht Zaika', 'South Indian', 4.1, 'Surat'),
    ('Gwalia Sweets', 'Chinese', 3.8, 'Ahmedabad'),
    ('La Pino''z Pizza', 'Italian', 4.4, 'Surat'),
    ('Barbeque Nation', 'Mughlai / BBQ', 4.6, 'Vadodara'),
    ('Sankalp Restaurant', 'South Indian', 4.2, 'Ahmedabad'),
    ('Swastik Fast Food', 'Fast Food', 3.4, 'Rajkot'),
    ('Mainland China', 'Chinese', 4.5, 'Ahmedabad');
```

---

### Task 2: Filter by Rating (> 4.0) and City ('Ahmedabad' or 'Surat')
> **Prompt:** Write a SQL query to find all restaurants in the Restaurants table that have a rating greater than 4.0 and are located in either 'Ahmedabad' or 'Surat'.

```sql
SELECT id, name, cuisine, rating, city
FROM Restaurants
WHERE rating > 4.0 
  AND (city = 'Ahmedabad' OR city = 'Surat')
ORDER BY rating DESC;
```

#### Crucial Operator Precedence Note:
> [!IMPORTANT]
> In SQL logical evaluation, the `AND` operator has **higher precedence** than the `OR` operator (analogous to multiplication over addition).
> If you write without parentheses:
> ```sql
> WHERE rating > 4.0 AND city = 'Ahmedabad' OR city = 'Surat'
> ```
> SQL interprets it as:
> ```sql
> WHERE (rating > 4.0 AND city = 'Ahmedabad') OR (city = 'Surat')
> ```
> This would incorrectly include **any** restaurant in Surat regardless of its rating (even with a 2.0 rating!). Explicit parentheses `(city = 'Ahmedabad' OR city = 'Surat')` guarantee correct grouping.

#### Output:
| id | name | cuisine | rating | city |
|---|---|---|---|---|
| 8 | Mainland China | Chinese | 4.5 | Ahmedabad |
| 4 | La Pino'z Pizza | Italian | 4.4 | Surat |
| 1 | Swagat Restaurant | Gujarati / North Indian | 4.3 | Ahmedabad |
| 6 | Sankalp Restaurant | South Indian | 4.2 | Ahmedabad |
| 2 | Swadisht Zaika | South Indian | 4.1 | Surat |

---

### Task 3: Pattern Matching with LIKE ('Swa%')
> **Prompt:** Using the LIKE operator, write a query to select all restaurants whose names start with 'Swa' (for example, 'Swagat', 'Swadisht') from the Restaurants table.
>
> *Hint: Use LIKE 'Swa%'.*

```sql
SELECT id, name, cuisine, rating, city
FROM Restaurants
WHERE name LIKE 'Swa%';
```

#### Wildcard Mechanics:
- `%` (Percent Sign): Matches **zero, one, or multiple** characters.
- `_` (Underscore): Matches exactly **one** single character.
- `'Swa%'` anchors the match at the start: any string beginning with `Swa` followed by any suffix matches.

#### Output:
| id | name | cuisine | rating | city |
|---|---|---|---|---|
| 1 | Swagat Restaurant | Gujarati / North Indian | 4.3 | Ahmedabad |
| 2 | Swadisht Zaika | South Indian | 4.1 | Surat |
| 7 | Swastik Fast Food | Fast Food | 3.4 | Rajkot |

---

### Task 4: Range Query with BETWEEN (Rating 3.5 to 4.5)
> **Prompt:** Write a SQL query using the BETWEEN keyword to find all restaurants in the Restaurants table with a rating between 3.5 and 4.5 (inclusive).

```sql
SELECT id, name, cuisine, rating, city
FROM Restaurants
WHERE rating BETWEEN 3.5 AND 4.5
ORDER BY rating DESC;
```

- **Inclusivity:** The SQL `BETWEEN low AND high` operator is strictly inclusive on both ends:
  $$\text{rating} \in [3.5, 4.5] \iff \text{rating} \ge 3.5 \land \text{rating} \le 4.5$$

#### Output:
| id | name | cuisine | rating | city |
|---|---|---|---|---|
| 8 | Mainland China | Chinese | 4.5 | Ahmedabad |
| 4 | La Pino'z Pizza | Italian | 4.4 | Surat |
| 1 | Swagat Restaurant | Gujarati / North Indian | 4.3 | Ahmedabad |
| 6 | Sankalp Restaurant | South Indian | 4.2 | Ahmedabad |
| 2 | Swadisht Zaika | South Indian | 4.1 | Surat |
| 3 | Gwalia Sweets | Chinese | 3.8 | Ahmedabad |

*(Note: 'Barbeque Nation' at 4.6 and 'Swastik Fast Food' at 3.4 fall outside the range and are excluded).*

---

### Task 5: Set Membership Filtering with IN Operator
> **Prompt:** Write a query to find all restaurants whose cuisine is either 'Chinese', 'Italian', or 'South Indian' using the IN operator.

```sql
SELECT id, name, cuisine, rating, city
FROM Restaurants
WHERE cuisine IN ('Chinese', 'Italian', 'South Indian')
ORDER BY cuisine, rating DESC;
```

- **Advantage of `IN`:** Syntactically clean and avoids long chains of `OR` clauses (`WHERE cuisine = 'Chinese' OR cuisine = 'Italian' OR cuisine = 'South Indian'`). In modern database query optimizers, `IN` lists are executed with index hash lookups.

#### Output:
| id | name | cuisine | rating | city |
|---|---|---|---|---|
| 8 | Mainland China | Chinese | 4.5 | Ahmedabad |
| 3 | Gwalia Sweets | Chinese | 3.8 | Ahmedabad |
| 4 | La Pino'z Pizza | Italian | 4.4 | Surat |
| 6 | Sankalp Restaurant | South Indian | 4.2 | Ahmedabad |
| 2 | Swadisht Zaika | South Indian | 4.1 | Surat |

---

## File Directory

```
Session 5/
├── README.md                          # Comprehensive session documentation & task analysis
├── session_5.sql                      # Unified SQL execution script (Tasks 1 - 5)
├── restaurants_filtering_mysql.sql    # Dedicated MySQL 8.0+ production DDL & queries
├── restaurants_filtering_sqlite.sql   # Dedicated SQLite 3 script
├── session_5.py                       # Automated Python verification suite
├── session_5.ipynb                    # Interactive Jupyter Notebook
└── database/
    └── restaurants.db                 # Populated SQLite database with seeded data
```

---

## How to Run Locally

### 1. Execute the Python Automated Verification Script
```bash
python "Session 5/session_5.py"
```

### 2. Run in SQLite CLI
```bash
python -m sqlite3 "Session 5/database/restaurants.db" < "Session 5/restaurants_filtering_sqlite.sql"
```

### 3. Run in MySQL Workbench / Command Line
```bash
mysql -u root -p < "Session 5/restaurants_filtering_mysql.sql"
```
