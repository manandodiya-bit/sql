-- ============================================================================
-- SQL for Data Science: Session 6
-- ORDER BY + Sorting (Single-Column, Multi-Column, ASC/DESC & Pagination)
-- Target Dialect: SQLite 3
-- Database: sorting_db.db
-- ============================================================================

-- ----------------------------------------------------------------------------
-- SCHEMA & DATA SETUP: Products (Flipkart Simulation)
-- ----------------------------------------------------------------------------
DROP TABLE IF EXISTS products;

CREATE TABLE products (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL
);

INSERT INTO products (name, category, price) VALUES
    ('USB-C Fast Charging Cable', 'Accessories', 299.00),
    ('Wireless Optical Mouse', 'Accessories', 599.00),
    ('Boat Airdopes 141', 'Audio', 1299.00),
    ('Noise ColorFit Smartwatch', 'Wearables', 1999.00),
    ('Sony WH-1000XM5 Headphones', 'Audio', 26990.00),
    ('Samsung Galaxy S24 Ultra', 'Smartphones', 129999.00),
    ('Apple iPhone 15 Pro', 'Smartphones', 134900.00),
    ('Dell XPS 15 Laptop', 'Laptops', 189990.00),
    ('Logitech Mechanical Keyboard', 'Accessories', 6499.00),
    ('iPad Air M2', 'Tablets', 59900.00);

-- TASK 1: Products sorted by price ascending (Low to High)
SELECT id, name, category, price
FROM products
ORDER BY price ASC;

-- TASK 2: Top 5 most expensive products (High to Low with LIMIT)
SELECT id, name, category, price
FROM products
ORDER BY price DESC
LIMIT 5;

-- ----------------------------------------------------------------------------
-- SCHEMA & DATA SETUP: Movies (IMDb / Streaming Simulation)
-- ----------------------------------------------------------------------------
DROP TABLE IF EXISTS movies;

CREATE TABLE movies (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title VARCHAR(100) NOT NULL,
    release_year INT NOT NULL,
    rating DECIMAL(3, 1) NOT NULL
);

INSERT INTO movies (title, release_year, rating) VALUES
    ('Dune: Part Two', 2024, 8.6),
    ('Deadpool & Wolverine', 2024, 7.9),
    ('Civil War', 2024, 7.1),
    ('Oppenheimer', 2023, 8.9),
    ('Poor Things', 2023, 7.9),
    ('Spider-Man: Across the Spider-Verse', 2023, 8.7),
    ('Top Gun: Maverick', 2022, 8.3),
    ('The Batman', 2022, 7.8),
    ('Interstellar', 2014, 8.7),
    ('Whiplash', 2014, 8.5);

-- TASK 3: Movies sorted by release_year DESC, then by rating DESC
SELECT title, release_year, rating
FROM movies
ORDER BY release_year DESC, rating DESC;

-- ----------------------------------------------------------------------------
-- SCHEMA & DATA SETUP: Restaurants (Zomato A-Z Directory Simulation)
-- ----------------------------------------------------------------------------
DROP TABLE IF EXISTS restaurants;

CREATE TABLE restaurants (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(100) NOT NULL,
    cuisine VARCHAR(50) NOT NULL,
    rating DECIMAL(2, 1) NOT NULL,
    city VARCHAR(50) NOT NULL
);

INSERT INTO restaurants (name, cuisine, rating, city) VALUES
    ('Anand Sweets', 'Sweets & Snacks', 4.3, 'Bengaluru'),
    ('Bademiya', 'Mughlai / Kebabs', 4.1, 'Mumbai'),
    ('Chai Point', 'Beverages', 4.0, 'Delhi'),
    ('Dindigul Thalappakatti', 'Biryani', 4.4, 'Chennai'),
    ('Empire Restaurant', 'North Indian', 4.2, 'Bengaluru'),
    ('Farzi Cafe', 'Modern Indian', 4.5, 'Delhi'),
    ('Glen''s Bakehouse', 'Bakery / Desserts', 4.6, 'Bengaluru'),
    ('Haldiram''s', 'North Indian / Sweets', 4.3, 'Delhi'),
    ('Indian Coffee House', 'Cafe', 4.1, 'Kolkata'),
    ('Jaffer Bhai''s Delhi Darbar', 'Mughlai', 4.4, 'Mumbai'),
    ('Karim''s', 'Mughlai', 4.5, 'Delhi'),
    ('La Pino''z Pizza', 'Italian', 4.3, 'Ahmedabad'),
    ('Mavalli Tiffin Room (MTR)', 'South Indian', 4.7, 'Bengaluru');

-- TASK 4: First 10 restaurants sorted alphabetically by name
SELECT id, name, cuisine, rating, city
FROM restaurants
ORDER BY name ASC
LIMIT 10;

-- ----------------------------------------------------------------------------
-- SCHEMA & DATA SETUP: Songs (Spotify Trending / Charts Simulation)
-- ----------------------------------------------------------------------------
DROP TABLE IF EXISTS songs;

CREATE TABLE songs (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title VARCHAR(100) NOT NULL,
    artist VARCHAR(100) NOT NULL,
    play_count INT NOT NULL,
    added_date DATE NOT NULL
);

INSERT INTO songs (title, artist, play_count, added_date) VALUES
    ('Starboy', 'The Weeknd', 5000000, '2026-09-01'),
    ('Blinding Lights', 'The Weeknd', 5000000, '2026-10-15'),  -- Tie-break target (newer)
    ('Tum Hi Ho', 'Arijit Singh', 4200000, '2026-08-10'),
    ('Brown Munde', 'AP Dhillon', 3900000, '2026-07-20'),
    ('Espresso', 'Sabrina Carpenter', 6500000, '2026-10-01');

-- TASK 5: Top 3 trending songs by play_count DESC, tie-break by added_date DESC
SELECT id, title, artist, play_count, added_date
FROM songs
ORDER BY play_count DESC, added_date DESC
LIMIT 3;
