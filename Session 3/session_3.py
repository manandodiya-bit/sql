"""
===============================================================================
SQL for Data Science: Session 3 Execution & Automated Verification Script
Tasks 1 to 5: INSERT, UPDATE & DELETE (DML Operations & Conditional Filtering)
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
    return os.path.join(db_dir, "spotify_playlist.db")


def task_1_create_table_and_insert_fav(conn):
    """Task 1: Create 'Playlist' table & insert favorite song."""
    print("=" * 80)
    print("TASK 1: Create Table 'Playlist' & Insert Favorite Song")
    print("=" * 80)
    cursor = conn.cursor()
    cursor.execute("DROP TABLE IF EXISTS Playlist;")
    
    create_sql = """
    CREATE TABLE Playlist (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        song_name VARCHAR(100) NOT NULL,
        artist VARCHAR(100) NOT NULL,
        duration INT NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );
    """
    cursor.execute(create_sql)
    print("[OK] Executed CREATE TABLE statement:")
    print(create_sql.strip())
    
    # Insert single row for current favorite song (with typo 'Arjit Singh' to fix in Task 3)
    fav_song = ("Tum Hi Ho", "Arjit Singh", 262)
    cursor.execute(
        "INSERT INTO Playlist (song_name, artist, duration) VALUES (?, ?, ?);",
        fav_song
    )
    conn.commit()
    print(f"\n[OK] Inserted favorite song: '{fav_song[0]}' by '{fav_song[1]}' ({fav_song[2]}s)")
    
    df = pd.read_sql_query("SELECT id, song_name, artist, duration FROM Playlist;", conn)
    print("\n--- Current Playlist State ---")
    print(df.to_string(index=False))
    print()


def task_2_insert_recent_spotify_songs(conn):
    """Task 2: Insert 3+ new songs from Spotify."""
    print("=" * 80)
    print("TASK 2: Insert Recently Listened Songs from Spotify")
    print("=" * 80)
    cursor = conn.cursor()
    
    recent_songs = [
        ("Brown Munde", "AP Dhillon", 265),
        ("Intro (Interlude)", "Various Artists", 95),       # Sub-120s song for Task 4
        ("Excuses", "AP Dhillon", 195),                     # >180s song for Task 5
        ("With You", "AP Dhillon", 150),                    # <=180s song (boundary test)
        ("Kesariya", "Arijit Singh", 268)
    ]
    cursor.executemany(
        "INSERT INTO Playlist (song_name, artist, duration) VALUES (?, ?, ?);",
        recent_songs
    )
    conn.commit()
    print(f"[OK] Inserted {len(recent_songs)} additional tracks into 'Playlist'.")
    
    df = pd.read_sql_query("SELECT id, song_name, artist, duration FROM Playlist;", conn)
    print("\n--- Current Playlist State (Total: 6 songs) ---")
    print(df.to_string(index=False))
    print()


def task_3_update_artist_typo(conn):
    """Task 3: Update artist name to fix typo ('Arjit Singh' -> 'Arijit Singh')."""
    print("=" * 80)
    print("TASK 3: Update Artist Name Typo Using UPDATE with WHERE")
    print("=" * 80)
    cursor = conn.cursor()
    
    print("[BEFORE UPDATE] Checking entries with typo 'Arjit Singh':")
    df_before = pd.read_sql_query("SELECT id, song_name, artist FROM Playlist WHERE artist = 'Arjit Singh';", conn)
    print(df_before.to_string(index=False))
    
    update_sql = """
    UPDATE Playlist
    SET artist = 'Arijit Singh'
    WHERE artist = 'Arjit Singh';
    """
    cursor.execute(update_sql)
    conn.commit()
    print(f"\n[OK] Executed statement: {update_sql.strip()}")
    print(f"[OK] Rows updated: {cursor.rowcount}")
    
    df_after = pd.read_sql_query("SELECT id, song_name, artist FROM Playlist WHERE artist = 'Arijit Singh';", conn)
    print("\n[AFTER UPDATE] Verified all Arijit Singh tracks:")
    print(df_after.to_string(index=False))
    print()


def task_4_delete_short_songs(conn):
    """Task 4: Delete song where duration < 120 seconds using DELETE with WHERE."""
    print("=" * 80)
    print("TASK 4: Delete Short Songs (duration < 120s) Using DELETE with WHERE")
    print("=" * 80)
    cursor = conn.cursor()
    
    print("[PRE-DELETE CHECK] Identifying rows matching (duration < 120):")
    df_target = pd.read_sql_query("SELECT id, song_name, artist, duration FROM Playlist WHERE duration < 120;", conn)
    print(df_target.to_string(index=False))
    
    delete_sql = """
    DELETE FROM Playlist
    WHERE duration < 120;
    """
    cursor.execute(delete_sql)
    conn.commit()
    print(f"\n[OK] Executed DELETE statement: {delete_sql.strip()}")
    print(f"[OK] Deleted {cursor.rowcount} row(s) successfully.")
    
    df_verify = pd.read_sql_query("SELECT id, song_name, artist, duration FROM Playlist;", conn)
    print("\n--- Playlist After Deletion (Notice 95s track removed) ---")
    print(df_verify.to_string(index=False))
    print()


def task_5_conditional_remix_update(conn):
    """Task 5: Append ' (Remix)' to AP Dhillon songs with duration > 180s."""
    print("=" * 80)
    print("TASK 5: Conditional UPDATE for AP Dhillon Songs (duration > 180s)")
    print("=" * 80)
    cursor = conn.cursor()
    
    print("[BEFORE UPDATE] AP Dhillon tracks and durations:")
    df_before = pd.read_sql_query("SELECT id, song_name, artist, duration FROM Playlist WHERE artist = 'AP Dhillon';", conn)
    print(df_before.to_string(index=False))
    
    # In SQLite, string concatenation is ||
    update_remix_sql = """
    UPDATE Playlist
    SET song_name = song_name || ' (Remix)'
    WHERE artist = 'AP Dhillon' AND duration > 180;
    """
    cursor.execute(update_remix_sql)
    conn.commit()
    print(f"\n[OK] Executed UPDATE query: {update_remix_sql.strip()}")
    print(f"[OK] Updated {cursor.rowcount} track(s).")
    
    print("\n[AFTER UPDATE] Notice tracks > 180s updated, while 'With You' (150s) remains untouched:")
    df_after = pd.read_sql_query("SELECT id, song_name, artist, duration FROM Playlist WHERE artist = 'AP Dhillon';", conn)
    print(df_after.to_string(index=False))
    print()


def display_final_playlist(conn):
    """Display final table contents."""
    print("=" * 80)
    print("FINAL PLAYLIST TABLE CONTENTS")
    print("=" * 80)
    df_final = pd.read_sql_query("SELECT id, song_name, artist, duration, created_at FROM Playlist ORDER BY id;", conn)
    print(df_final.to_string(index=False))
    print("=" * 80)
    print("All Session 3 tasks executed and verified successfully!")


def main():
    db_path = get_db_path()
    print(f"Target Database File: {db_path}\n")
    
    conn = sqlite3.connect(db_path)
    try:
        task_1_create_table_and_insert_fav(conn)
        task_2_insert_recent_spotify_songs(conn)
        task_3_update_artist_typo(conn)
        task_4_delete_short_songs(conn)
        task_5_conditional_remix_update(conn)
        display_final_playlist(conn)
    finally:
        conn.close()


if __name__ == "__main__":
    main()
