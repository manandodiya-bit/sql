-- ============================================================================
-- SQL for Data Science: Session 2
-- Database Setup + CREATE TABLE
-- Target Dialect: SQLite 3
-- Database: foodie_app.db (Zomato Backend) & 'users' (Flipkart Backend)
-- ============================================================================

-- ----------------------------------------------------------------------------
-- TASK 3: Define 'restaurants' table in SQLite
-- Columns:
--   - id: INTEGER PRIMARY KEY AUTOINCREMENT
--   - name: VARCHAR(100) NOT NULL
--   - cuisine: VARCHAR(50) NOT NULL
--   - rating: DECIMAL(2, 1) CHECK (rating >= 0.0 AND rating <= 5.0)
--   - location: VARCHAR(100) NOT NULL
--   - created_at: TIMESTAMP DEFAULT CURRENT_TIMESTAMP
-- ----------------------------------------------------------------------------
DROP TABLE IF EXISTS restaurants;

CREATE TABLE restaurants (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(100) NOT NULL,
    cuisine VARCHAR(50) NOT NULL,
    rating DECIMAL(2, 1) CHECK (rating >= 0.0 AND rating <= 5.0),
    location VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ----------------------------------------------------------------------------
-- TASK 4: Design and create a 'users' table for Flipkart-style app
-- Design Rationale:
--   - user_id: INTEGER PRIMARY KEY AUTOINCREMENT
--   - username: VARCHAR(50) NOT NULL UNIQUE
--   - email: VARCHAR(255) NOT NULL UNIQUE (prevents multiple accounts per email)
--   - phone_number: VARCHAR(15) NOT NULL UNIQUE (VARCHAR preserves leading 0s and '+')
--   - created_at: TIMESTAMP DEFAULT CURRENT_TIMESTAMP
-- ----------------------------------------------------------------------------
DROP TABLE IF EXISTS users;

CREATE TABLE users (
    user_id INTEGER PRIMARY KEY AUTOINCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone_number VARCHAR(15) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ----------------------------------------------------------------------------
-- SEED DATA
-- ----------------------------------------------------------------------------
INSERT INTO restaurants (name, cuisine, rating, location) VALUES
    ('Haldiram''s', 'North Indian / Sweets', 4.3, 'Connaught Place, New Delhi'),
    ('Paradise Biryani', 'Hyderabadi Biryani', 4.5, 'Secunderabad, Hyderabad'),
    ('Glen''s Bakehouse', 'Bakery / Italian', 4.6, 'Indiranagar, Bengaluru'),
    ('Bademiya', 'Mughlai / Kebabs', 4.1, 'Colaba, Mumbai'),
    ('Peter Cat', 'Continental / Indian', 4.7, 'Park Street, Kolkata');

INSERT INTO users (username, email, phone_number) VALUES
    ('rahul_verma', 'rahul.verma@example.com', '+919876543210'),
    ('priya_sharma', 'priya.sharma@domain.in', '+919812345678'),
    ('amit_kumar', 'amit.k@techmail.com', '+919701234567'),
    ('neha_patel', 'neha.patel@webmail.org', '+919654321876');

-- ----------------------------------------------------------------------------
-- VERIFICATION QUERIES
-- ----------------------------------------------------------------------------
SELECT * FROM restaurants;
SELECT * FROM users;
