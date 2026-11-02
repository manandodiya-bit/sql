"""
===============================================================================
SQL for Data Science: Session 1 Execution & Automated Verification Script
Tasks 1 to 5: Database Intro, Table Creation, Insertion, Filtering & Concepts
===============================================================================
"""

import os
import sqlite3
import pandas as pd


def get_db_path():
    """Returns absolute path to the database file."""
    base_dir = os.path.dirname(os.path.abspath(__file__))
    db_dir = os.path.join(base_dir, "database")
    os.makedirs(db_dir, exist_ok=True)
    return os.path.join(db_dir, "music_streaming_app.db")


def task_1_environment_check():
    """Task 1: Verify database engine connectivity."""
    print("=" * 80)
    print("TASK 1: Database Setup & Connectivity Verification")
    print("=" * 80)
    print(f"[OK] SQLite Version : {sqlite3.sqlite_version}")
    
    mysql_path = r"C:\wamp64\bin\mysql\mysql8.0.18\bin\mysql.exe"
    if os.path.exists(mysql_path):
        print(f"[OK] MySQL Community Server detected at: {mysql_path}")
    else:
        print("[INFO] MySQL Server not found in default path; SQLite active.")
    print("Database environment verified successfully!\n")


def task_2_create_playlists_table(conn):
    """Task 2: Create 'playlists' table."""
    print("=" * 80)
    print("TASK 2: Create 'playlists' Table in 'music_streaming_app'")
    print("=" * 80)
    cursor = conn.cursor()
    cursor.execute("DROP TABLE IF EXISTS playlists;")
    
    create_sql = """
    CREATE TABLE playlists (
        playlist_id INTEGER PRIMARY KEY AUTOINCREMENT,
        name VARCHAR(100) NOT NULL,
        created_by VARCHAR(50) NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );
    """
    cursor.execute(create_sql)
    conn.commit()
    print("[OK] Executed CREATE TABLE statement:")
    print(create_sql.strip())
    print("[OK] Table 'playlists' created successfully.\n")


def task_3_insert_sample_rows(conn):
    """Task 3: Insert sample rows representing playlists created by different users."""
    print("=" * 80)
    print("TASK 3: Insert Sample Playlist Records")
    print("=" * 80)
    cursor = conn.cursor()
    
    sample_data = [
        ("Bollywood Hits", "Amit"),
        ("Chill Vibes", "Priya"),
        ("Workout Mix", "Rohan"),
        ("Retro 90s Classics", "Amit")
    ]
    cursor.executemany(
        "INSERT INTO playlists (name, created_by) VALUES (?, ?);",
        sample_data
    )
    conn.commit()
    print(f"[OK] Inserted {len(sample_data)} sample rows into 'playlists':")
    for row in sample_data:
        print(f"  - Playlist: '{row[0]}' | Created by: '{row[1]}'")
    print()


def task_4_query_amit_playlists(conn):
    """Task 4: Select playlists created by 'Amit' using WHERE clause."""
    print("=" * 80)
    print("TASK 4: Query Playlists Created by 'Amit' (WHERE Filter)")
    print("=" * 80)
    
    query = "SELECT playlist_id, name, created_by, created_at FROM playlists WHERE created_by = 'Amit';"
    print("SQL Query:")
    print(f"  {query}\n")
    
    df_amit = pd.read_sql_query(query, conn)
    print("Filtered Query Results (Amit's Playlists):")
    print(df_amit.to_string(index=False))
    print()


def task_5_conceptual_explanation():
    """Task 5: Difference between Table, Row, and Column (Zomato Example)."""
    print("=" * 80)
    print("TASK 5: Conceptual Explanation - Table vs Row vs Column (Zomato Example)")
    print("=" * 80)
    explanation = """
Imagine you are browsing Zomato on your smartphone:

1. TABLE (The Entire Entity / Collection):
   - Definition: The full two-dimensional grid of structured data representing an entire
     business entity.
   - Zomato Example: The `restaurants` table.
   - It represents all restaurants partnered with Zomato across India.

2. COLUMN (The Attribute / Field / Characteristic):
   - Definition: A vertical slice of the table defining a single property or data attribute.
   - Zomato Example: `restaurant_id`, `name`, `cuisine`, `rating`, `location`.
   - Every column enforces a specific data type and domain rules (e.g., rating must be a decimal).

3. ROW (The Record / Tuple / Individual Instance):
   - Definition: A single horizontal entry containing data across all columns for one
     specific, individual item.
   - Zomato Example: One specific restaurant card in your app:
     [restaurant_id: 101 | name: "Haldiram's" | cuisine: "North Indian" | rating: 4.3 | location: "Delhi"]
"""
    print(explanation.strip())
    print("\n" + "=" * 80)


def display_all_records(conn):
    """Displays entire table."""
    print("ALL PLAYLISTS IN 'music_streaming_app.db':")
    df_all = pd.read_sql_query("SELECT * FROM playlists;", conn)
    print(df_all.to_string(index=False))
    print("=" * 80)


def main():
    db_path = get_db_path()
    print(f"Target Database File: {db_path}\n")
    
    task_1_environment_check()
    
    conn = sqlite3.connect(db_path)
    try:
        task_2_create_playlists_table(conn)
        task_3_insert_sample_rows(conn)
        task_4_query_amit_playlists(conn)
        task_5_conceptual_explanation()
        display_all_records(conn)
    finally:
        conn.close()


if __name__ == "__main__":
    main()
