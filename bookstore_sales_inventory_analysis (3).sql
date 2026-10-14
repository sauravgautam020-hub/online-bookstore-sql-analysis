-- PROJECT: Bookstore Sales & Inventory Analysis
-- TOOL: PostgreSQL
-- NOTE: The uploaded file contained table definitions and queries, but no INSERT statements/data.
-- Review column names and business assumptions before presenting results.

-- 1. Inspect the tables
SELECT * FROM books LIMIT 10;
SELECT * FROM customers LIMIT 10;
SELECT * FROM orders LIMIT 10;

-- 2. List available genres
SELECT DISTINCT genre
FROM books
ORDER BY genre;

-- 3. Find the top 3 most expensive Fantasy books (case-insensitive)
SELECT book_id, title, author, genre, price
FROM books
WHERE genre ILIKE 'Fantasy'
ORDER BY price DESC NULLS LAST
LIMIT 3;

-- 4. Average price of Fantasy books
SELECT AVG(price) AS average_fantasy_price
FROM books
WHERE genre ILIKE 'Fantasy';

-- 5. Total stock recorded in the Books table
SELECT SUM(stock) AS total_stock
FROM books;

-- 6. Total revenue recorded in Orders
SELECT SUM(total_amount) AS total_revenue
FROM orders;

-- 7. Total quantity ordered by genre
SELECT b.genre, SUM(o.quantity) AS total_books_ordered
FROM books b
JOIN orders o ON o.book_id = b.book_id
GROUP BY b.genre
ORDER BY total_books_ordered DESC;

-- 8. Total quantity ordered by author
SELECT b.author, SUM(o.quantity) AS total_books_ordered
FROM books b
JOIN orders o ON o.book_id = b.book_id
GROUP BY b.author
ORDER BY total_books_ordered DESC;

-- 9. Most frequently ordered book (by number of order rows)
SELECT b.book_id, b.title, COUNT(o.order_id) AS number_of_order_records,
       SUM(o.quantity) AS total_quantity_ordered
FROM books b
JOIN orders o ON o.book_id = b.book_id
GROUP BY b.book_id, b.title
ORDER BY total_quantity_ordered DESC NULLS LAST
LIMIT 1;

-- 10. Customers who have placed at least 2 orders
SELECT c.customer_id, c.name, COUNT(o.order_id) AS order_count
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.name
HAVING COUNT(o.order_id) >= 2
ORDER BY order_count DESC;

-- 11. Cities where customers' combined order spending exceeds $30
SELECT DISTINCT c.city
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.city
HAVING SUM(o.total_amount) > 30
ORDER BY c.city;

-- 12. Customer who spent the most overall
SELECT c.customer_id, c.name, SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.name
ORDER BY total_spent DESC
LIMIT 1;

-- 13. Remaining stock after all recorded quantities are fulfilled.
-- ASSUMPTION: books.stock is the starting stock and every order row is fulfilled.
-- If stock is already current stock, do NOT subtract orders again.
SELECT b.book_id, b.title, b.stock AS starting_stock,
       COALESCE(SUM(o.quantity), 0) AS total_quantity_ordered,
       b.stock - COALESCE(SUM(o.quantity), 0) AS estimated_stock_remaining
FROM books b
LEFT JOIN orders o ON o.book_id = b.book_id
GROUP BY b.book_id, b.title, b.stock
ORDER BY estimated_stock_remaining ASC;

-- 14. Orders placed in November 2023
SELECT *
FROM orders
WHERE order_date >= DATE '2023-11-01'
  AND order_date < DATE '2023-12-01'
ORDER BY order_date;

-- 15. Data-quality check: missing prices, stock, and genres
SELECT
  COUNT(*) FILTER (WHERE price IS NULL) AS books_missing_price,
  COUNT(*) FILTER (WHERE stock IS NULL) AS books_missing_stock,
  COUNT(*) FILTER (WHERE genre IS NULL OR BTRIM(genre) = '') AS books_missing_genre
FROM books;
