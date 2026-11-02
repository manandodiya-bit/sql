# Session 7: Aggregate Functions (COUNT, AVG, MAX, MIN & SUM)

This directory contains the complete solutions, architectural documentation, production SQL scripts, automated Python verification suite, and an interactive Jupyter Notebook for **Session 7: Aggregate Functions**.

---

## Overview of Tasks

| Task | Topic | Deliverables & Description |
|---|---|---|
| **Task 1** | Schema Design & NULL Handling | Created `Orders` table (`order_id`, `user_name`, `total_amount`, `order_date`) with sample rows containing intentional `NULL` amounts. |
| **Task 2** | Categorical Counting (`COUNT(*)`) | Counted the number of orders placed by each distinct user using `COUNT(*)` with `GROUP BY`. |
| **Task 3** | Average Value (`AVG`) | Calculated the average order amount (`AVG(total_amount)`), analyzing how SQL natively disregards `NULL` values. |
| **Task 4** | Dashboard Extremes (`MAX` & `MIN`) | Extracted both highest and lowest order values simultaneously in a single result row. |
| **Task 5** | Revenue Summation (`SUM`) | Computed total sales revenue using `SUM(total_amount)` with an explicit `WHERE total_amount IS NOT NULL` filter. |

---

## Task Details & Solutions

### Task 1: Create 'Orders' Table & Seed Records
> **Prompt:** Create a table called Orders with columns: order_id, user_name, total_amount, and order_date. Insert 5 sample rows with different users and order amounts, including at least one NULL value for total_amount.

```sql
CREATE TABLE Orders (
    order_id INTEGER PRIMARY KEY AUTOINCREMENT,        -- For MySQL: order_id INT AUTO_INCREMENT PRIMARY KEY
    user_name VARCHAR(50) NOT NULL,
    total_amount DECIMAL(10, 2) NULL,                  -- Allows NULL (e.g. pending/unbilled order)
    order_date DATE NOT NULL
);

INSERT INTO Orders (user_name, total_amount, order_date) VALUES
    ('Rahul', 1500.00, '2026-10-15'),
    ('Priya', 2499.50, '2026-10-18'),
    ('Rahul', 850.00, '2026-10-20'),
    ('Amit', NULL, '2026-10-22'),                      -- Sample NULL record
    ('Priya', 3200.00, '2026-10-25');
```

---

### Task 2: Count Orders Per User (COUNT + GROUP BY)
> **Prompt:** Write a SQL query to count how many orders were placed by each user in the Orders table, displaying user_name and the number of orders as order_count.

```sql
SELECT 
    user_name,
    COUNT(*) AS order_count
FROM Orders
GROUP BY user_name
ORDER BY order_count DESC, user_name ASC;
```

#### Analytical Breakdown:
- `COUNT(*)` counts all physical rows matching each group (including Amit's pending order).
- `COUNT(total_amount)` would count only rows where `total_amount` is not NULL (yielding 0 for Amit).
- Using `COUNT(*)` reflects the true number of order attempts/records placed by that user.

#### Output:
| user_name | order_count |
|---|---|
| Priya | 2 |
| Rahul | 2 |
| Amit | 1 |

---

### Task 3: Average Order Amount (Ignoring NULL Values)
> **Prompt:** Write a SQL query to calculate the average total_amount of all orders in the Orders table, making sure to ignore any NULL values.

```sql
SELECT 
    ROUND(AVG(total_amount), 2) AS average_order_amount
FROM Orders
WHERE total_amount IS NOT NULL;
```

#### How SQL Handles NULLs in Aggregation:
> [!NOTE]
> By ANSI SQL standard design, all aggregate functions (except `COUNT(*)`) **automatically ignore NULL values**.
> In our dataset:
> $$\text{Non-NULL Amounts} = [1500.00, 2499.50, 850.00, 3200.00]$$
> $$\text{Sum} = 8049.50, \quad n = 4$$
> $$\text{Average} = \frac{8049.50}{4} = 2012.38$$
> The NULL entry for Amit is excluded from both the numerator and the denominator, preventing division distortion!

#### Output:
| average_order_amount |
|---|
| 2012.38 |

---

### Task 4: Highest & Lowest Order Amounts (MAX & MIN)
> **Prompt:** Suppose you are building a Flipkart-style dashboard: Write a SQL query to find the highest and lowest order amounts (MAX and MIN) from the Orders table, and display both values in a single result row.

```sql
SELECT 
    MAX(total_amount) AS highest_order_amount,
    MIN(total_amount) AS lowest_order_amount
FROM Orders;
```

- Both `MAX` and `MIN` ignore `NULL` entries and evaluate exclusively against populated monetary amounts.

#### Output:
| highest_order_amount | lowest_order_amount |
|---|---|
| ₹3,200.00 | ₹850.00 |

---

### Task 5: Total Sales (SUM with Explicit IS NOT NULL Filter)
> **Prompt:** Write a SQL query to calculate the total sales (SUM of total_amount) for all orders, but only include orders where total_amount is not NULL.
>
> *Hint: Use a WHERE clause to filter out NULL values before applying the SUM function.*

```sql
SELECT 
    SUM(total_amount) AS total_sales
FROM Orders
WHERE total_amount IS NOT NULL;
```

#### Calculation:
$$\text{Total Sales} = 1500.00 + 2499.50 + 850.00 + 3200.00 = 8049.50$$

#### Output:
| total_sales |
|---|
| ₹8,049.50 |

---

## File Directory

```
Session 7/
├── README.md                      # Comprehensive session documentation & task analysis
├── session_7.sql                  # Unified SQL execution script (Tasks 1 - 5)
├── orders_aggregates_mysql.sql    # Dedicated MySQL 8.0+ production DDL & queries
├── orders_aggregates_sqlite.sql   # Dedicated SQLite 3 script
├── session_7.py                   # Automated Python verification suite
├── session_7.ipynb                # Interactive Jupyter Notebook
└── database/
    └── orders.db                  # Populated SQLite database with seeded data
```

---

## How to Run Locally

### 1. Execute the Python Automated Verification Script
```bash
python "Session 7/session_7.py"
```

### 2. Run in SQLite CLI
```bash
python -m sqlite3 "Session 7/database/orders.db" < "Session 7/orders_aggregates_sqlite.sql"
```

### 3. Run in MySQL Workbench / Command Line
```bash
mysql -u root -p < "Session 7/orders_aggregates_mysql.sql"
```
