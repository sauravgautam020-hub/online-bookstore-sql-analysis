-- Create Tables
DROP TABLE IF EXISTS Books;
CREATE TABLE Books (
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);
DROP TABLE IF EXISTS customers;
CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);
DROP TABLE IF EXISTS orders;
CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);

SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;


-- Retrieve all books in the "Fiction" genre
SELECT * FROM BOOKS
WHERE genre = 'Fiction';


-- Find books published after the year 1950
SELECT * from books
where published_year > 1950;

-- List all customers from the Canada
SELECT * FROM customers
where country ='Canada';

-- Show orders placed in November 2023
select * from orders
where order_date between '2023-11-01' and '2023-11-30';


-- Retrieve the total stock of books available
select sum(stock) as total_stock from books;


-- Find the details of the most expensive book
select * from books order by price desc limit 1;


-- Show all customers who ordered more than 1 quantity of a book
select * from orders
where quantity >1;


-- Retrieve all orders where the total amount exceeds $20
select * from orders 
where total_amount > 20;


-- List all genres available in the Books table
select distinct genre from books;


-- Find the book with the lowest stock
select * from books order by stock limit 1;


-- Calculate the total revenue generated from all orders
select sum(total_amount) AS revenue from orders;


-- Retrieve the total number of books sold for each genre
SELECT b. genre, sum(o. quantity) as total_books_sold
from orders o
join books b
on o. book_id = b. book_id group by b. genre;


-- Find the average price of books in the "Fantasy" genre
SELECT AVG(price) AS Average_price 
      from books
where Genre = 'Fantasy';


select * from books;
select * from customers;
select * from orders;
-- List customers who have placed at least 2 orders

select  customer_id, COUNT(Order_id) as order_count
 from orders 
 group by customer_id
 having count(order_id) > 2;

-- Find the most frequently ordered book

select o.book_id, b.title, count(o.order_id) as order_count
from orders o
join
books b 
 on o.book_id=b.book_id
group by o.book_id, b.title
order by order_count desc limit 1;

-- Show the top 3 most expensive books of 'Fantasy' Genre 
select * from books
WHERE Genre = 'fantasy'
ORDER BY price DESC LIMIT 3;




select * from books;
select * from customers;
select * from orders;

-- Retrieve the total quantity of books sold by each author
SELECT b.author, sum(o.quantity) as books_sold
from books b
join orders o 
on b.book_id=o.book_id
group by b.author ORDER BY books_sold desc;


/*SELECT
    b.author,
    SUM(o.quantity) AS books_sold
FROM books b
JOIN orders o
    ON b.book_id = o.book_id
GROUP BY b.author
ORDER BY books_sold DESC; */



-- List the cities where customers who spent over $30 are located
SELECT DISTINCT c.city, total_amount
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.total_amount > 30;


-- Find the customer who spent the most on orders

select c.customer_id, c.name, sum(o.total_amount) AS total_spent
from orders o
join customers c
on c.customer_id=o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY total_spent desc limit 1;

-- Calculate the stock remaining after fulfilling all order

SELECT
    b.book_id,
    b.title,
    b.stock AS original_stock,
    COALESCE(SUM(o.quantity), 0) AS total_ordered,
    b.stock - COALESCE(SUM(o.quantity), 0) AS stock_remaining
FROM books b
LEFT JOIN orders o
    ON b.book_id = o.book_id
GROUP BY b.book_id, b.title, b.stock
ORDER BY b.book_id;
