# SQL for Data Science

Welcome to the **SQL for Data Science** repository. This repository contains complete solutions, schema architectures, production SQL scripts, interactive Jupyter Notebooks, datasets, and automated verification suites for relational database management and SQL sessions.

---

## Repository Structure

```
sql/
├── .gitignore
├── README.md                          # Main repository index & setup guide
└── Session 2/
    ├── README.md                      # Detailed Task writeups, analysis & rationales
    ├── session_2.sql                  # Complete SQL execution script (Tasks 1 - 5)
    ├── foodie_app_mysql.sql           # Dedicated MySQL 8.0+ production DDL & seeds
    ├── foodie_app_sqlite.sql          # Dedicated SQLite 3 script
    ├── session_2.py                   # Automated Python test & verification script
    ├── session_2.ipynb                # Interactive Jupyter Notebook
    ├── generate_screenshot.py         # Screenshot generator script
    ├── database/
    │   └── foodie_app.db              # Active SQLite database file
    └── screenshots/
        └── task5_sql_error_and_correction.png # Diagnostic error screenshot
```

---

## Curriculum Overview

| Session | Topic | Key Concepts | Status |
|---|---|---|---|
| **Session 1** | Introduction to Relational Databases | RDBMS Architecture, Relational Model, SQL vs NoSQL | Completed |
| **Session 2** | Database Setup + CREATE TABLE | Engine Setup, Data Types, Constraints (PK, UNIQUE, CHECK), Error Handling | **Completed** |

---

## Session 2 Highlights: Database Setup + CREATE TABLE

In this session, we build real-world backend schemas simulating popular e-commerce and food delivery systems:

1. **Database Setup & Multi-Engine Verification:**
   - Support for **SQLite 3** (zero-config, portable) and **MySQL 8.0 Community Server**.
2. **Food Delivery Backend (`foodie_app` - Zomato Style):**
   - Implemented `restaurants` table with columns: `id`, `name`, `cuisine`, `rating`, `location`.
   - Applied `DECIMAL(2, 1)` with `CHECK (rating >= 0.0 AND rating <= 5.0)`.
3. **E-Commerce Backend (`users` - Flipkart Style):**
   - Implemented `users` table with columns: `user_id`, `username`, `email`, `phone_number`, `created_at`.
   - Comprehensive architectural rationale for storing phone numbers as `VARCHAR(15)` rather than numeric integers (preserving leading zeros, supporting `+` international prefixes, preventing integer overflow).
   - Enforced `UNIQUE` constraints on `username`, `email`, and `phone_number`.
4. **Intentional Error & Diagnostic Resolution:**
   - Demonstrated intentional syntax errors (missing comma separator).
   - Documented the database parser behavior across SQLite and MySQL.
   - High-resolution terminal capture included in [`Session 2/screenshots/`](Session%202/screenshots/task5_sql_error_and_correction.png).

---

## Getting Started & Execution

### Prerequisites
- Python 3.10+ (SQLite 3 is built-in)
- Optional: MySQL Community Server 8.0+ / MySQL Workbench

### Running the Python Automated Verification
Clone the repository and run the Session 2 script:
```bash
python "Session 2/session_2.py"
```

### Running with SQLite CLI
```bash
python -m sqlite3 "Session 2/database/foodie_app.db"
```

### Running with MySQL
```bash
mysql -u root -p < "Session 2/foodie_app_mysql.sql"
```
