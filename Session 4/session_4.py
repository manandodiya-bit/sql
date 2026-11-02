"""
===============================================================================
SQL for Data Science: Session 4 Execution & Automated Verification Script
Tasks 1 to 5: SELECT Statement Basics, LIMIT, DISTINCT, Column Aliases & Grammar
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
    return os.path.join(db_dir, "music_and_orders.db")


def task_1_music_playlist_setup(conn):
    """Task 1: Create 'MusicPlaylist' table, insert 5+ records, and SELECT *."""
    print("=" * 80)
    print("TASK 1: Create 'MusicPlaylist' Table & Retrieve All Columns")
    print("=" * 80)
    cursor = conn.cursor()
    cursor.execute("DROP TABLE IF EXISTS MusicPlaylist;")
    
    create_sql = """
    CREATE TABLE MusicPlaylist (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        song_name VARCHAR(100) NOT NULL,
        artist VARCHAR(100) NOT NULL,
        genre VARCHAR(50) NOT NULL,
        duration INT NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );
    """
    cursor.execute(create_sql)
    print("[OK] Executed CREATE TABLE statement for 'MusicPlaylist'.")
    
    sample_songs = [
        ("Starboy", "The Weeknd", "Synth-pop / R&B", 230),
        ("Blinding Lights", "The Weeknd", "Synth-wave", 200),
        ("Tum Hi Ho", "Arijit Singh", "Bollywood Romantic", 262),
        ("Brown Munde", "AP Dhillon", "Punjabi Hip-Hop", 265),
        ("Shape of You", "Ed Sheeran", "Pop", 233),
        ("Kesariya", "Arijit Singh", "Bollywood", 268)
    ]
    cursor.executemany(
        "INSERT INTO MusicPlaylist (song_name, artist, genre, duration) VALUES (?, ?, ?, ?);",
        sample_songs
    )
    conn.commit()
    print(f"[OK] Seeded {len(sample_songs)} songs successfully.")
    
    query = "SELECT * FROM MusicPlaylist;"
    df = pd.read_sql_query(query, conn)
    print("\n--- All Records in 'MusicPlaylist' ---")
    print(df.to_string(index=False))
    print()


def task_2_select_columns_with_limit(conn):
    """Task 2: Select song_name and artist, first 3 records using LIMIT."""
    print("=" * 80)
    print("TASK 2: Display 'song_name' & 'artist', First 3 Records (LIMIT 3)")
    print("=" * 80)
    
    query = "SELECT song_name, artist FROM MusicPlaylist LIMIT 3;"
    print(f"SQL Query: {query}\n")
    
    df = pd.read_sql_query(query, conn)
    print("--- First 3 Records ---")
    print(df.to_string(index=False))
    print()


def task_3_food_orders_distinct(conn):
    """Task 3: Create 'FoodOrders' and query unique restaurant names using DISTINCT."""
    print("=" * 80)
    print("TASK 3: Create 'FoodOrders' & List Unique Restaurants (DISTINCT)")
    print("=" * 80)
    cursor = conn.cursor()
    cursor.execute("DROP TABLE IF EXISTS FoodOrders;")
    
    create_sql = """
    CREATE TABLE FoodOrders (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        restaurant VARCHAR(100) NOT NULL,
        food_item VARCHAR(100) NOT NULL,
        order_date DATE NOT NULL
    );
    """
    cursor.execute(create_sql)
    
    sample_orders = [
        ("Haldiram's", "Chole Bhature", "2026-10-20"),
        ("Paradise Biryani", "Chicken Biryani", "2026-10-22"),
        ("Haldiram's", "Raj Kachori", "2026-10-25"),
        ("Glen's Bakehouse", "Red Velvet Cupcake", "2026-10-28"),
        ("Paradise Biryani", "Mutton Biryani", "2026-10-30"),
        ("Bademiya", "Chicken Baida Roti", "2026-11-01"),
        ("Haldiram's", "Gulab Jamun", "2026-11-02")
    ]
    cursor.executemany(
        "INSERT INTO FoodOrders (restaurant, food_item, order_date) VALUES (?, ?, ?);",
        sample_orders
    )
    conn.commit()
    print(f"[OK] Seeded {len(sample_orders)} food orders with repeated restaurants.")
    
    query = "SELECT DISTINCT restaurant FROM FoodOrders;"
    print(f"\nSQL Query: {query}\n")
    df = pd.read_sql_query(query, conn)
    print("--- Unique Restaurants ---")
    print(df.to_string(index=False))
    print()


def task_4_column_aliases(conn):
    """Task 4: Column aliases: food_item as 'Dish', order_date as 'Date Ordered'."""
    print("=" * 80)
    print("TASK 4: Column Aliases ('Dish' and 'Date Ordered')")
    print("=" * 80)
    
    query = 'SELECT food_item AS "Dish", order_date AS "Date Ordered" FROM FoodOrders;'
    print(f"SQL Query: {query}\n")
    
    df = pd.read_sql_query(query, conn)
    print("--- Output with Column Aliases ---")
    print(df.to_string(index=False))
    print()


def task_5_diagnosis_and_fix(conn):
    """Task 5: Identify and fix mistake in query with LIMIT / DISTINCT."""
    print("=" * 80)
    print("TASK 5: Diagnosis and Fix for Query with LIMIT / DISTINCT")
    print("=" * 80)
    cursor = conn.cursor()
    
    print("[CASE 1: Misplaced LIMIT Syntax Error]")
    misplaced_sql = "SELECT DISTINCT food_item, restaurant LIMIT 2 FROM FoodOrders;"
    print(f"Erroneous Query (Misplaced LIMIT before FROM): {misplaced_sql}")
    try:
        cursor.execute(misplaced_sql)
    except sqlite3.OperationalError as err:
        print(f"--> Caught Syntax Error: {err}")
        print("--> Explanation: In SQL grammar, LIMIT must strictly appear at the end of")
        print("    the query, following the FROM and WHERE/ORDER BY clauses.\n")
    
    print("[CASE 2: Multi-Column DISTINCT Semantics & Determinism]")
    print("Original Query: SELECT DISTINCT food_item, restaurant FROM FoodOrders LIMIT 2;")
    print("--> Issue 1: DISTINCT evaluates the full row tuple (food_item, restaurant).")
    print("--> Issue 2: Without ORDER BY, the 2 rows returned by LIMIT are non-deterministic.\n")
    
    fix_query = """
    SELECT DISTINCT food_item, restaurant 
    FROM FoodOrders 
    ORDER BY restaurant, food_item 
    LIMIT 2;
    """
    print(f"Corrected Query (Deterministic with proper ORDER BY & LIMIT):\n{fix_query.strip()}\n")
    df_fix = pd.read_sql_query(fix_query, conn)
    print("--- Result of Corrected Query ---")
    print(df_fix.to_string(index=False))
    print()


def main():
    db_path = get_db_path()
    print(f"Target Database File: {db_path}\n")
    
    conn = sqlite3.connect(db_path)
    try:
        task_1_music_playlist_setup(conn)
        task_2_select_columns_with_limit(conn)
        task_3_food_orders_distinct(conn)
        task_4_column_aliases(conn)
        task_5_diagnosis_and_fix(conn)
        print("=" * 80)
        print("All Session 4 tasks executed and verified successfully!")
        print("=" * 80)
    finally:
        conn.close()


if __name__ == "__main__":
    main()
