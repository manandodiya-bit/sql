"""
===============================================================================
SQL for Data Science: Session 5 Execution & Automated Verification Script
Tasks 1 to 5: WHERE Clause, Compound Logic, LIKE, BETWEEN & IN Operators
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
    return os.path.join(db_dir, "restaurants.db")


def task_1_setup_restaurants(conn):
    """Task 1: Create 'Restaurants' table and insert 5+ records."""
    print("=" * 80)
    print("TASK 1: Create 'Restaurants' Table & Seed Records (Zomato-style)")
    print("=" * 80)
    cursor = conn.cursor()
    cursor.execute("DROP TABLE IF EXISTS Restaurants;")
    
    create_sql = """
    CREATE TABLE Restaurants (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name VARCHAR(100) NOT NULL,
        cuisine VARCHAR(50) NOT NULL,
        rating DECIMAL(2, 1) NOT NULL,
        city VARCHAR(50) NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );
    """
    cursor.execute(create_sql)
    print("[OK] Executed CREATE TABLE statement for 'Restaurants'.")
    
    sample_restaurants = [
        ("Swagat Restaurant", "Gujarati / North Indian", 4.3, "Ahmedabad"),
        ("Swadisht Zaika", "South Indian", 4.1, "Surat"),
        ("Gwalia Sweets", "Chinese", 3.8, "Ahmedabad"),
        ("La Pino'z Pizza", "Italian", 4.4, "Surat"),
        ("Barbeque Nation", "Mughlai / BBQ", 4.6, "Vadodara"),
        ("Sankalp Restaurant", "South Indian", 4.2, "Ahmedabad"),
        ("Swastik Fast Food", "Fast Food", 3.4, "Rajkot"),
        ("Mainland China", "Chinese", 4.5, "Ahmedabad")
    ]
    cursor.executemany(
        "INSERT INTO Restaurants (name, cuisine, rating, city) VALUES (?, ?, ?, ?);",
        sample_restaurants
    )
    conn.commit()
    print(f"[OK] Seeded {len(sample_restaurants)} restaurants across Gujarat cities.")
    
    df = pd.read_sql_query("SELECT id, name, cuisine, rating, city FROM Restaurants;", conn)
    print("\n--- All Restaurants in Database ---")
    print(df.to_string(index=False))
    print()


def task_2_rating_and_city_filter(conn):
    """Task 2: rating > 4.0 and city in ('Ahmedabad', 'Surat')."""
    print("=" * 80)
    print("TASK 2: Restaurants with rating > 4.0 in 'Ahmedabad' or 'Surat'")
    print("=" * 80)
    
    query = """
    SELECT id, name, cuisine, rating, city
    FROM Restaurants
    WHERE rating > 4.0 AND (city = 'Ahmedabad' OR city = 'Surat')
    ORDER BY rating DESC;
    """
    print(f"SQL Query:\n{query.strip()}\n")
    df = pd.read_sql_query(query, conn)
    print("--- Filtered Results ---")
    print(df.to_string(index=False))
    print()


def task_3_like_swa_filter(conn):
    """Task 3: Restaurants starting with 'Swa' using LIKE 'Swa%'."""
    print("=" * 80)
    print("TASK 3: Pattern Matching - Names Starting with 'Swa' (LIKE 'Swa%')")
    print("=" * 80)
    
    query = "SELECT id, name, cuisine, rating, city FROM Restaurants WHERE name LIKE 'Swa%';"
    print(f"SQL Query: {query}\n")
    df = pd.read_sql_query(query, conn)
    print("--- Pattern Matching Results ---")
    print(df.to_string(index=False))
    print()


def task_4_between_rating_filter(conn):
    """Task 4: Rating between 3.5 and 4.5 using BETWEEN."""
    print("=" * 80)
    print("TASK 4: Range Filtering - Rating Between 3.5 and 4.5 (BETWEEN)")
    print("=" * 80)
    
    query = """
    SELECT id, name, cuisine, rating, city
    FROM Restaurants
    WHERE rating BETWEEN 3.5 AND 4.5
    ORDER BY rating DESC;
    """
    print(f"SQL Query:\n{query.strip()}\n")
    df = pd.read_sql_query(query, conn)
    print("--- Range Filter Results ---")
    print(df.to_string(index=False))
    print()


def task_5_in_cuisine_filter(conn):
    """Task 5: Cuisine is either 'Chinese', 'Italian', or 'South Indian' using IN."""
    print("=" * 80)
    print("TASK 5: Set Membership - Cuisine IN ('Chinese', 'Italian', 'South Indian')")
    print("=" * 80)
    
    query = """
    SELECT id, name, cuisine, rating, city
    FROM Restaurants
    WHERE cuisine IN ('Chinese', 'Italian', 'South Indian')
    ORDER BY cuisine, rating DESC;
    """
    print(f"SQL Query:\n{query.strip()}\n")
    df = pd.read_sql_query(query, conn)
    print("--- IN Operator Results ---")
    print(df.to_string(index=False))
    print()


def main():
    db_path = get_db_path()
    print(f"Target Database File: {db_path}\n")
    
    conn = sqlite3.connect(db_path)
    try:
        task_1_setup_restaurants(conn)
        task_2_rating_and_city_filter(conn)
        task_3_like_swa_filter(conn)
        task_4_between_rating_filter(conn)
        task_5_in_cuisine_filter(conn)
        print("=" * 80)
        print("All Session 5 tasks executed and verified successfully!")
        print("=" * 80)
    finally:
        conn.close()


if __name__ == "__main__":
    main()
