-- ============================================================================
-- SQL for Data Science: Session 6 Complete Script
-- ORDER BY + Sorting (Tasks 1 to 5)
-- Dialect: Compatible with SQLite & MySQL
-- ============================================================================

-- ============================================================================
-- TASK 1: Flipkart Price Sorting - Ascending (Lowest to Highest)
-- ============================================================================
-- ASC is default if omitted, but writing explicitly ensures code readability.

SELECT id, name, category, price
FROM products
ORDER BY price ASC;

-- ============================================================================
-- TASK 2: Top 5 Most Expensive Products (DESC with LIMIT)
-- ============================================================================

SELECT id, name, category, price
FROM products
ORDER BY price DESC
LIMIT 5;

-- ============================================================================
-- TASK 3: Multi-Column Sorting: Movies by Year DESC, Rating DESC
-- Primary Sort: release_year DESC (Latest movies first)
-- Secondary Sort: rating DESC (Within the same year, highest rated first)
-- ============================================================================

SELECT title, release_year, rating
FROM movies
ORDER BY release_year DESC, rating DESC;

-- ============================================================================
-- TASK 4: Alphabetical Sorting - Zomato A-Z (First 10 Restaurants)
-- ============================================================================

SELECT id, name, cuisine, rating, city
FROM restaurants
ORDER BY name ASC
LIMIT 10;

-- ============================================================================
-- TASK 5: Top 3 Trending Songs with Tie-Breaking
-- Primary Sort: play_count DESC (Most played first)
-- Secondary Sort: added_date DESC (Tie-break: more recently added first)
-- ============================================================================

SELECT id, title, artist, play_count, added_date
FROM songs
ORDER BY play_count DESC, added_date DESC
LIMIT 3;
