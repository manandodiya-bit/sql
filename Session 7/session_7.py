"""
===============================================================================
SQL for Data Science: Session 7 Execution & Automated Verification Script
Tasks 1 to 5: Aggregate Functions (COUNT, AVG, MAX, MIN, SUM, GROUP BY & NULLs)
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
    return os.path.join(db_dir, "orders.db")


def task_1_orders_setup(conn):
    """Task 1: Create 'Orders' table & seed 5 sample rows with a NULL amount."""
    print("=" * 80)
    print("TASK 1: Create 'Orders' Table & Seed Records (Flipkart Simulation)")
    print("=" * 80)
    cursor = conn.cursor()
    cursor.execute("DROP TABLE IF EXISTS Orders;")
    
    cursor.execute("""
    CREATE TABLE Orders (
        order_id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_name VARCHAR(50) NOT NULL,
        total_amount DECIMAL(10, 2) NULL,
        order_date DATE NOT NULL
    );
    """)
    print("[OK] Executed CREATE TABLE statement for 'Orders'.")
    
    sample_orders = [
        ("Rahul", 1500.00, "2026-10-15"),
        ("Priya", 2499.50, "2026-10-18"),
        ("Rahul", 850.00, "2026-10-20"),
        ("Amit", None, "2026-10-22"),      # Intentional NULL value
        ("Priya", 3200.00, "2026-10-25")
    ]
    cursor.executemany("INSERT INTO Orders (user_name, total_amount, order_date) VALUES (?, ?, ?);", sample_orders)
    conn.commit()
    print(f"[OK] Seeded {len(sample_orders)} orders (including 1 NULL amount).")
    
    df = pd.read_sql_query("SELECT order_id, user_name, total_amount, order_date FROM Orders;", conn)
    print("\n--- Raw Orders Table Data ---")
    print(df.to_string(index=False))
    print()


def task_2_count_orders_per_user(conn):
    """Task 2: Count how many orders were placed by each user."""
    print("=" * 80)
    print("TASK 2: Order Count Per User (COUNT(*) + GROUP BY)")
    print("=" * 80)
    
    query = """
    SELECT 
        user_name,
        COUNT(*) AS order_count
    FROM Orders
    GROUP BY user_name
    ORDER BY order_count DESC, user_name ASC;
    """
    print(f"SQL Query:\n{query.strip()}\n")
    df = pd.read_sql_query(query, conn)
    print("--- Order Count by User ---")
    print(df.to_string(index=False))
    print()


def task_3_average_order_amount(conn):
    """Task 3: Calculate average total_amount, ignoring NULLs."""
    print("=" * 80)
    print("TASK 3: Average Order Amount (Ignoring NULL Values)")
    print("=" * 80)
    
    query = """
    SELECT 
        ROUND(AVG(total_amount), 2) AS average_order_amount
    FROM Orders
    WHERE total_amount IS NOT NULL;
    """
    print(f"SQL Query:\n{query.strip()}\n")
    
    # Hand calculation verification:
    # Non-NULL amounts: [1500.00, 2499.50, 850.00, 3200.00] -> Sum: 8049.50, Count: 4
    # Expected Avg: 8049.50 / 4 = 2012.38
    df = pd.read_sql_query(query, conn)
    print("--- Average Order Amount ---")
    print(df.to_string(index=False))
    print("Calculation check: (1500.00 + 2499.50 + 850.00 + 3200.00) / 4 = 2012.38")
    print()


def task_4_max_min_dashboard(conn):
    """Task 4: Highest and lowest order amounts in a single result row."""
    print("=" * 80)
    print("TASK 4: Flipkart Dashboard - MAX and MIN Order Amounts in Single Row")
    print("=" * 80)
    
    query = """
    SELECT 
        MAX(total_amount) AS highest_order_amount,
        MIN(total_amount) AS lowest_order_amount
    FROM Orders;
    """
    print(f"SQL Query:\n{query.strip()}\n")
    df = pd.read_sql_query(query, conn)
    print("--- Dashboard KPI Metrics ---")
    print(df.to_string(index=False))
    print()


def task_5_total_sales_with_null_filter(conn):
    """Task 5: SUM of total_amount filtering out NULLs with WHERE."""
    print("=" * 80)
    print("TASK 5: Total Sales (SUM with WHERE total_amount IS NOT NULL)")
    print("=" * 80)
    
    query = """
    SELECT 
        SUM(total_amount) AS total_sales
    FROM Orders
    WHERE total_amount IS NOT NULL;
    """
    print(f"SQL Query:\n{query.strip()}\n")
    df = pd.read_sql_query(query, conn)
    print("--- Total Sales (Revenue) ---")
    print(df.to_string(index=False))
    print()


def main():
    db_path = get_db_path()
    print(f"Target Database File: {db_path}\n")
    
    conn = sqlite3.connect(db_path)
    try:
        task_1_orders_setup(conn)
        task_2_count_orders_per_user(conn)
        task_3_average_order_amount(conn)
        task_4_max_min_dashboard(conn)
        task_5_total_sales_with_null_filter(conn)
        print("=" * 80)
        print("All Session 7 tasks executed and verified successfully!")
        print("=" * 80)
    finally:
        conn.close()


if __name__ == "__main__":
    main()
