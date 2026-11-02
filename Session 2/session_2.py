"""
===============================================================================
SQL for Data Science: Session 2 Execution & Automated Verification Script
Tasks 1 to 5: Database Setup, CREATE TABLE, Constraints & Error Handling
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
    return os.path.join(db_dir, "foodie_app.db")


def task_1_verify_environment():
    """Task 1: Verify database environment connectivity."""
    print("=" * 80)
    print("TASK 1: Verify Installation and Database Connectivity")
    print("=" * 80)
    print(f"[OK] SQLite Version       : {sqlite3.sqlite_version}")
    
    # Check MySQL server binary availability
    mysql_path = r"C:\wamp64\bin\mysql\mysql8.0.18\bin\mysql.exe"
    if os.path.exists(mysql_path):
        print(f"[OK] MySQL Community Server detected at: {mysql_path}")
    else:
        print("[INFO] MySQL Server not found in default Wamp path; SQLite active.")
    print("Database environment verified successfully!\n")


def task_2_and_3_restaurants(conn):
    """Task 2 & 3: Database creation and 'restaurants' table schema."""
    print("=" * 80)
    print("TASK 2 & 3: Create 'restaurants' Table in 'foodie_app'")
    print("=" * 80)
    cursor = conn.cursor()
    
    cursor.execute("DROP TABLE IF EXISTS restaurants;")
    
    create_table_sql = """
    CREATE TABLE restaurants (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name VARCHAR(100) NOT NULL,
        cuisine VARCHAR(50) NOT NULL,
        rating DECIMAL(2, 1) CHECK (rating >= 0.0 AND rating <= 5.0),
        location VARCHAR(100) NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );
    """
    cursor.execute(create_table_sql)
    print("[OK] Executed CREATE TABLE statement for 'restaurants':")
    print(create_table_sql.strip())
    
    sample_restaurants = [
        ("Haldiram's", "North Indian / Sweets", 4.3, "Connaught Place, New Delhi"),
        ("Paradise Biryani", "Hyderabadi Biryani", 4.5, "Secunderabad, Hyderabad"),
        ("Glen's Bakehouse", "Bakery / Italian", 4.6, "Indiranagar, Bengaluru"),
        ("Bademiya", "Mughlai / Kebabs", 4.1, "Colaba, Mumbai"),
        ("Peter Cat", "Continental / Indian", 4.7, "Park Street, Kolkata")
    ]
    cursor.executemany(
        "INSERT INTO restaurants (name, cuisine, rating, location) VALUES (?, ?, ?, ?);",
        sample_restaurants
    )
    conn.commit()
    print(f"[OK] Seeded {len(sample_restaurants)} restaurants successfully into 'foodie_app.db'.\n")


def task_4_users(conn):
    """Task 4: Design and create 'users' table for Flipkart-style app."""
    print("=" * 80)
    print("TASK 4: Design and Create 'users' Table (Flipkart-style App)")
    print("=" * 80)
    cursor = conn.cursor()
    
    cursor.execute("DROP TABLE IF EXISTS users;")
    
    create_users_sql = """
    CREATE TABLE users (
        user_id INTEGER PRIMARY KEY AUTOINCREMENT,
        username VARCHAR(50) NOT NULL UNIQUE,
        email VARCHAR(255) NOT NULL UNIQUE,
        phone_number VARCHAR(15) NOT NULL UNIQUE,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );
    """
    cursor.execute(create_users_sql)
    print("[OK] Executed CREATE TABLE statement for 'users':")
    print(create_users_sql.strip())
    
    sample_users = [
        ("rahul_verma", "rahul.verma@example.com", "+919876543210"),
        ("priya_sharma", "priya.sharma@domain.in", "+919812345678"),
        ("amit_kumar", "amit.k@techmail.com", "+919701234567"),
        ("neha_patel", "neha.patel@webmail.org", "+919654321876")
    ]
    cursor.executemany(
        "INSERT INTO users (username, email, phone_number) VALUES (?, ?, ?);",
        sample_users
    )
    conn.commit()
    print(f"[OK] Seeded {len(sample_users)} users successfully.\n")

    # Constraint Demonstration: Attempt to insert duplicate email
    print("--- Demonstrating Integrity Constraint: Duplicate Email Rejection ---")
    try:
        cursor.execute(
            "INSERT INTO users (username, email, phone_number) VALUES (?, ?, ?);",
            ("rahul_duplicate", "rahul.verma@example.com", "+919999999999")
        )
    except sqlite3.IntegrityError as e:
        print(f"[VERIFIED] Expected constraint rejection caught: {e}")
    print()


def task_5_intentional_error_and_fix(conn):
    """Task 5: Intentionally execute erroneous SQL, capture output, and fix."""
    print("=" * 80)
    print("TASK 5: Intentional Error Generation & Resolution")
    print("=" * 80)
    cursor = conn.cursor()
    cursor.execute("DROP TABLE IF EXISTS restaurants_error_demo;")
    
    # 1. Erroneous SQL (Missing comma after column definition)
    bad_sql = """
    CREATE TABLE restaurants_error_demo (
        id INTEGER PRIMARY KEY
        name VARCHAR(100) NOT NULL,
        cuisine VARCHAR(50) NOT NULL
    );
    """
    print("[STEP 1] Executing Erroneous SQL (Missing Comma):")
    print(bad_sql.strip())
    
    try:
        cursor.execute(bad_sql)
    except sqlite3.OperationalError as e:
        print("\n[CAUGHT ERROR MESSAGE FROM DATABASE ENGINE]:")
        print(f"--> Type: sqlite3.OperationalError")
        print(f"--> Message: {e}")
        print("--> Explanation: The SQL parser encountered the token 'name' where it expected")
        print("    a comma (',') delimiter separating column declarations.\n")
    
    # 2. Corrected SQL
    corrected_sql = """
    CREATE TABLE restaurants_error_demo (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name VARCHAR(100) NOT NULL,
        cuisine VARCHAR(50) NOT NULL
    );
    """
    print("[STEP 2] Executing Corrected SQL:")
    print(corrected_sql.strip())
    cursor.execute(corrected_sql)
    conn.commit()
    print("[SUCCESS] Corrected table 'restaurants_error_demo' created without errors!\n")


def display_results(conn):
    """Inspect tables using pandas."""
    print("=" * 80)
    print("FINAL DATABASE VERIFICATION - TABLES IN 'foodie_app.db'")
    print("=" * 80)
    
    df_rest = pd.read_sql_query("SELECT id, name, cuisine, rating, location FROM restaurants;", conn)
    print("\n--- 'restaurants' Table Data (Zomato-style) ---")
    print(df_rest.to_string(index=False))
    
    df_users = pd.read_sql_query("SELECT user_id, username, email, phone_number, created_at FROM users;", conn)
    print("\n--- 'users' Table Data (Flipkart-style) ---")
    print(df_users.to_string(index=False))
    print("\nAll Session 2 tasks executed and validated successfully!")


def main():
    db_path = get_db_path()
    print(f"Target Database File: {db_path}\n")
    
    task_1_verify_environment()
    
    conn = sqlite3.connect(db_path)
    try:
        task_2_and_3_restaurants(conn)
        task_4_users(conn)
        task_5_intentional_error_and_fix(conn)
        display_results(conn)
    finally:
        conn.close()


if __name__ == "__main__":
    main()
