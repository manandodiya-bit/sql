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
| **[Session 1](Session%201/)** | Database Introduction & SQL Basics | RDBMS Architecture, Table vs Row vs Column (Zomato), DDL `CREATE TABLE`, DML `INSERT`, `SELECT ... WHERE` Filter | **Completed** |
| **[Session 2](Session%202/)** | Database Setup + CREATE TABLE | Engine Setup, Data Types, Constraints (PK, UNIQUE, CHECK), Decimal Precision, Error Diagnosis & Fix | **Completed** |

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

---

## Getting Started & Execution

### Prerequisites
- Python 3.10+ (SQLite 3 is built-in)
- Optional: MySQL Community Server 8.0+ / MySQL Workbench

### Running Session 1
```bash
python "Session 1/session_1.py"
```

### Running Session 2
```bash
python "Session 2/session_2.py"
```
