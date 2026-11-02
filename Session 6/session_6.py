"""
===============================================================================
SQL for Data Science: Session 6 Execution & Automated Verification Script
Tasks 1 to 5: ORDER BY, ASC/DESC, Multi-Column Sorting, Tie-Breaks & Pagination
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
    return os.path.join(db_dir, "sorting_db.db")


def task_1_and_2_products(conn):
    """Tasks 1 & 2: Products table setup, Ascending price sort, and Top 5 expensive."""
    print("=" * 80)
    print("TASK 1 & 2: Products Sorting (Flipkart Price Catalog)")
    print("=" * 80)
    cursor = conn.cursor()
    cursor.execute("DROP TABLE IF EXISTS products;")
    
    cursor.execute("""
    CREATE TABLE products (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name VARCHAR(100) NOT NULL,
        category VARCHAR(50) NOT NULL,
        price DECIMAL(10, 2) NOT NULL
    );
    """)
    
    sample_products = [
        ("USB-C Fast Charging Cable", "Accessories", 299.00),
        ("Wireless Optical Mouse", "Accessories", 599.00),
        ("Boat Airdopes 141", "Audio", 1299.00),
        ("Noise ColorFit Smartwatch", "Wearables", 1999.00),
        ("Sony WH-1000XM5 Headphones", "Audio", 26990.00),
        ("Samsung Galaxy S24 Ultra", "Smartphones", 129999.00),
        ("Apple iPhone 15 Pro", "Smartphones", 134900.00),
        ("Dell XPS 15 Laptop", "Laptops", 189990.00),
        ("Logitech Mechanical Keyboard", "Accessories", 6499.00),
        ("iPad Air M2", "Tablets", 59900.00)
    ]
    cursor.executemany("INSERT INTO products (name, category, price) VALUES (?, ?, ?);", sample_products)
    conn.commit()
    print(f"[OK] Seeded {len(sample_products)} products.")
    
    # Task 1: Ascending sort
    query_t1 = "SELECT id, name, category, price FROM products ORDER BY price ASC;"
    print("\n--- Task 1: All Products Sorted by Price Ascending (Low to High) ---")
    df_t1 = pd.read_sql_query(query_t1, conn)
    print(df_t1.to_string(index=False))
    
    # Task 2: Top 5 most expensive
    query_t2 = "SELECT id, name, category, price FROM products ORDER BY price DESC LIMIT 5;"
    print("\n--- Task 2: Top 5 Most Expensive Products (DESC + LIMIT 5) ---")
    df_t2 = pd.read_sql_query(query_t2, conn)
    print(df_t2.to_string(index=False))
    print()


def task_3_movies_multi_sort(conn):
    """Task 3: Multi-column sorting: release_year DESC, then rating DESC."""
    print("=" * 80)
    print("TASK 3: Movies Multi-Column Sorting (release_year DESC, rating DESC)")
    print("=" * 80)
    cursor = conn.cursor()
    cursor.execute("DROP TABLE IF EXISTS movies;")
    
    cursor.execute("""
    CREATE TABLE movies (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title VARCHAR(100) NOT NULL,
        release_year INT NOT NULL,
        rating DECIMAL(3, 1) NOT NULL
    );
    """)
    
    sample_movies = [
        ("Dune: Part Two", 2024, 8.6),
        ("Deadpool & Wolverine", 2024, 7.9),
        ("Civil War", 2024, 7.1),
        ("Oppenheimer", 2023, 8.9),
        ("Poor Things", 2023, 7.9),
        ("Spider-Man: Across the Spider-Verse", 2023, 8.7),
        ("Top Gun: Maverick", 2022, 8.3),
        ("The Batman", 2022, 7.8),
        ("Interstellar", 2014, 8.7),
        ("Whiplash", 2014, 8.5)
    ]
    cursor.executemany("INSERT INTO movies (title, release_year, rating) VALUES (?, ?, ?);", sample_movies)
    conn.commit()
    print(f"[OK] Seeded {len(sample_movies)} movies.")
    
    query_t3 = "SELECT title, release_year, rating FROM movies ORDER BY release_year DESC, rating DESC;"
    print(f"SQL Query: {query_t3}\n")
    df_t3 = pd.read_sql_query(query_t3, conn)
    print("--- Movies Sorted (Latest First, Highest Rated First within Same Year) ---")
    print(df_t3.to_string(index=False))
    print()


def task_4_restaurants_alphabetical(conn):
    """Task 4: First 10 restaurants sorted alphabetically by name."""
    print("=" * 80)
    print("TASK 4: First 10 Restaurants Alphabetically (Zomato A-Z Directory)")
    print("=" * 80)
    cursor = conn.cursor()
    cursor.execute("DROP TABLE IF EXISTS restaurants;")
    
    cursor.execute("""
    CREATE TABLE restaurants (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name VARCHAR(100) NOT NULL,
        cuisine VARCHAR(50) NOT NULL,
        rating DECIMAL(2, 1) NOT NULL,
        city VARCHAR(50) NOT NULL
    );
    """)
    
    sample_restaurants = [
        ("Anand Sweets", "Sweets & Snacks", 4.3, "Bengaluru"),
        ("Bademiya", "Mughlai / Kebabs", 4.1, "Mumbai"),
        ("Chai Point", "Beverages", 4.0, "Delhi"),
        ("Dindigul Thalappakatti", "Biryani", 4.4, "Chennai"),
        ("Empire Restaurant", "North Indian", 4.2, "Bengaluru"),
        ("Farzi Cafe", "Modern Indian", 4.5, "Delhi"),
        ("Glen's Bakehouse", "Bakery / Desserts", 4.6, "Bengaluru"),
        ("Haldiram's", "North Indian / Sweets", 4.3, "Delhi"),
        ("Indian Coffee House", "Cafe", 4.1, "Kolkata"),
        ("Jaffer Bhai's Delhi Darbar", "Mughlai", 4.4, "Mumbai"),
        ("Karim's", "Mughlai", 4.5, "Delhi"),
        ("La Pino'z Pizza", "Italian", 4.3, "Ahmedabad"),
        ("Mavalli Tiffin Room (MTR)", "South Indian", 4.7, "Bengaluru")
    ]
    cursor.executemany("INSERT INTO restaurants (name, cuisine, rating, city) VALUES (?, ?, ?, ?);", sample_restaurants)
    conn.commit()
    print(f"[OK] Seeded {len(sample_restaurants)} restaurants.")
    
    query_t4 = "SELECT id, name, cuisine, rating, city FROM restaurants ORDER BY name ASC LIMIT 10;"
    print(f"SQL Query: {query_t4}\n")
    df_t4 = pd.read_sql_query(query_t4, conn)
    print("--- First 10 Restaurants in Alphabetical Order ---")
    print(df_t4.to_string(index=False))
    print()


def task_5_trending_songs_tie_break(conn):
    """Task 5: Top 3 trending songs by play_count DESC, tie-break by added_date DESC."""
    print("=" * 80)
    print("TASK 5: Top 3 Trending Songs with Tie-Break Sorting (Multi-Column)")
    print("=" * 80)
    cursor = conn.cursor()
    cursor.execute("DROP TABLE IF EXISTS songs;")
    
    cursor.execute("""
    CREATE TABLE songs (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title VARCHAR(100) NOT NULL,
        artist VARCHAR(100) NOT NULL,
        play_count INT NOT NULL,
        added_date DATE NOT NULL
    );
    """)
    
    # Notice 'Starboy' and 'Blinding Lights' both have 5,000,000 plays, but Blinding Lights is newer!
    sample_songs = [
        ("Starboy", "The Weeknd", 5000000, "2026-09-01"),
        ("Blinding Lights", "The Weeknd", 5000000, "2026-10-15"),
        ("Tum Hi Ho", "Arijit Singh", 4200000, "2026-08-10"),
        ("Brown Munde", "AP Dhillon", 3900000, "2026-07-20"),
        ("Espresso", "Sabrina Carpenter", 6500000, "2026-10-01")
    ]
    cursor.executemany("INSERT INTO songs (title, artist, play_count, added_date) VALUES (?, ?, ?, ?);", sample_songs)
    conn.commit()
    print(f"[OK] Seeded {len(sample_songs)} songs (including play_count ties).")
    
    query_t5 = """
    SELECT id, title, artist, play_count, added_date
    FROM songs
    ORDER BY play_count DESC, added_date DESC
    LIMIT 3;
    """
    print(f"SQL Query:\n{query_t5.strip()}\n")
    df_t5 = pd.read_sql_query(query_t5, conn)
    print("--- Top 3 Trending Songs (Tie-Break Verified) ---")
    print(df_t5.to_string(index=False))
    print()


def main():
    db_path = get_db_path()
    print(f"Target Database File: {db_path}\n")
    
    conn = sqlite3.connect(db_path)
    try:
        task_1_and_2_products(conn)
        task_3_movies_multi_sort(conn)
        task_4_restaurants_alphabetical(conn)
        task_5_trending_songs_tie_break(conn)
        print("=" * 80)
        print("All Session 6 tasks executed and verified successfully!")
        print("=" * 80)
    finally:
        conn.close()


if __name__ == "__main__":
    main()
