# Bookstore Sales & Inventory Analysis (SQL)

## Project overview
This beginner portfolio project uses PostgreSQL to explore bookstore products, orders, customer spending, sales by genre/author, and estimated inventory.

## Tools
- PostgreSQL
- SQL: `JOIN`, `SUM`, `COUNT`, `AVG`, `GROUP BY`, `HAVING`, `ORDER BY`, `COALESCE`, `ILIKE`

## Tables
- `Books`: book details, genre, price, stock
- `Customers`: customer details and location
- `Orders`: customer/book IDs, date, quantity, total amount

## Business questions
1. What are the most expensive Fantasy books?
2. What is the average price of Fantasy books?
3. How many books were ordered by genre and author?
4. Which books were ordered most often?
5. Which customers have placed at least two orders?
6. Which cities contain customers whose combined spending exceeds $30?
7. Who spent the most overall?
8. What is the estimated remaining inventory?
9. What revenue is recorded in the Orders table?
10. Are key book fields missing?

## How to run
1. Open PostgreSQL / pgAdmin and select your practice database.
2. Run the table-creation statements from your original SQL file if the tables do not exist.
3. Import or insert the actual dataset into all three tables.
4. Open `bookstore_sales_inventory_analysis.sql`.
5. Run each query and inspect the results.
6. Record actual findings in the report. Do not invent numbers.

## Important assumptions and limitations
- The uploaded SQL file contained table definitions and queries, but no inserted data. This project therefore does not state numerical findings yet.
- The inventory query assumes `Books.stock` is starting stock and every row in `Orders` represents fulfilled quantities. If `stock` already reflects current inventory, subtracting orders again would be incorrect.
- The spending-by-city query interprets “spent over $30” as a customer's total spending across all orders.
- `COUNT(order_id)` counts order records; `SUM(quantity)` totals the number of book units ordered.
- If orders include cancelled or pending orders, add a status filter once a status column is available.

## Findings to add after running the project
- Total revenue: [insert actual result]
- Top-selling genre: [insert actual result]
- Top-selling author: [insert actual result]
- Highest-spending customer: [insert actual result]
- Book with lowest estimated remaining stock: [insert actual result]

## Portfolio note
This is a learning project using practice data. State that clearly when sharing it. Do not include private customer information in a public repository.
