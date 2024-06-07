/*
There are 3 tables in an sql database - customers, orders and products. 
In customer table there are 3 columns - customer_ID, name and email.
In orders table there are 5 columns - order_ID, customer_ID, product_name, order_date and quantity. 
In products table there are 3 columns - product_ID, product_name and price.
We use these three tables to solve various problems. 
*/
CREATE TABLE Customers (
  CustomerID INT PRIMARY KEY,
  Name VARCHAR(50),
  Email VARCHAR(100)
);

INSERT INTO Customers (CustomerID, Name, Email)
VALUES
  (1, 'John Doe', 'johndoe@example.com'),
  (2, 'Jane Smith', 'janesmith@example.com'),
  (3, 'Robert Johnson', 'robertjohnson@example.com'),
  (4, 'Emily Brown', 'emilybrown@example.com'),
  (5, 'Michael Davis', 'michaeldavis@example.com'),
  (6, 'Sarah Wilson', 'sarahwilson@example.com'),
  (7, 'David Thompson', 'davidthompson@example.com'),
  (8, 'Jessica Lee', 'jessicalee@example.com'),
  (9, 'William Turner', 'williamturner@example.com'),
  (10, 'Olivia Martinez', 'oliviamartinez@example.com');
  
INSERT INTO Customers (CustomerID, Name, Email)
VALUES
  (11, 'Sherlock', 'sherlock@example.com');  

  
CREATE TABLE Orders (
  OrderID INT PRIMARY KEY,
  CustomerID INT,
  ProductName VARCHAR(50),
  OrderDate DATE,
  Quantity INT
);

INSERT INTO Orders (OrderID, CustomerID, ProductName, OrderDate, Quantity)
VALUES
  (1, 1, 'Product A', '2024-05-16', 5),
  (2, 2, 'Product B', '2023-01-02', 3),
  (3, 3, 'Product C', '2023-07-03', 2),
  (4, 4, 'Product A', '2023-07-04', 1),
  (5, 5, 'Product B', '2023-07-05', 4),
  (6, 6, 'Product C', '2023-07-06', 2),
  (7, 7, 'Product A', '2023-07-07', 3),
  (8, 8, 'Product B', '2023-07-08', 2),
  (9, 9, 'Product C', '2023-07-09', 5),
  (10, 10, 'Product A', '2023-07-10', 1);

INSERT INTO Orders (OrderID, CustomerID, ProductName, OrderDate, Quantity)
VALUES
  (11, 10, 'Product J', '2023-04-02', 4),
  (12, 8, 'Product D', '2023-05-13', 3),
  (13, 8, 'Product D', '2023-06-01', 5),
  (14, 2, 'Product E', '2023-07-01', 2),
  (15, 2, 'Product F', '2023-08-01', 2),
  (16, 1, 'Product B', '2023-09-05', 7),
  (17, 10, 'Product B', '2023-10-01', 6),
  (18, 7, 'Product I', '2023-11-02', 9),
  (19, 7, 'Product A', '2023-12-05', 1),
  (20, 10, 'Product J', '2023-03-06', 6),
  (21, 2, 'Product B', '2023-02-06', 6),
  (22, 3, 'Product I', '2023-12-05', 1),
  (23, 3, 'Product J', '2023-03-06', 6),
  (24, 3, 'Product F', '2023-12-05', 1),
  (25, 4, 'Product G', '2023-03-06', 6),
  (26, 4, 'Product G', '2023-12-05', 1),
  (27, 4, 'Product G', '2023-03-06', 6);

CREATE TABLE Products (
  ProductID INT PRIMARY KEY,
  ProductName VARCHAR(50),
  Price DECIMAL(10, 2)
);

INSERT INTO Products (ProductID, ProductName, Price)
VALUES
  (1, 'Product A', 10.99),
  (2, 'Product B', 8.99),
  (3, 'Product C', 5.99),
  (4, 'Product D', 12.99),
  (5, 'Product E', 7.99),
  (6, 'Product F', 6.99),
  (7, 'Product G', 9.99),
  (8, 'Product H', 11.99),
  (9, 'Product I', 14.99),
  (10, 'Product J', 4.99);

----- TASK 1 -----
-- 1.	Write a query to retrieve all records from the Customers table.
select * from Customers;

-- 2.	Write a query to retrieve the names and email addresses of customers whose names start with 'J'. 
select name, Email from Customers where name like 'J%';

-- 3.	Write a query to retrieve the order details (OrderID, ProductName, Quantity) for all orders.
select OrderID, ProductName, Quantity from Orders;

-- 4.	Write a query to calculate the total quantity of products ordered. 
select sum(Quantity) 'total Quantity' from Orders;

-- 5.	Write a query to retrieve the names of customers who have placed an order.
select name from Customers where CustomerID in (select CustomerID from Orders);

-- 6.	Write a query to retrieve the products with a price greater than $10.00. 
select ProductName from Products where price > 10.00;

-- 7.	Write a query to retrieve the customer name and order date for all orders placed on or after '2023-07-05'. 
select c.Name, o.OrderDate from Customers c 
inner join Orders o
on c.CustomerID = o.CustomerID
where OrderDate >= '2023-07-05';

-- 8.	Write a query to calculate the average price of all products. 
select avg(price) 'average price' from Products;

-- 9.	Write a query to retrieve the customer names along with the total quantity of products they have ordered. 
select c.name, ms.total_quantity from Customers c
inner join (
  select CustomerID, sum(Quantity) 'total_quantity' from Orders 
  group by CustomerID 
) ms
on c.CustomerID = ms.CustomerID
order by ms.total_quantity desc;

-- 10.	Write a query to retrieve the products that have not been ordered. 
select ProductName from Products where ProductName not in (select ProductName from Orders);


----- TASK 2 -----
---- 1.	Write a query to retrieve the top 5 customers who have placed the highest total quantity of orders.
select top 5 Name, total_quantity from (select c.Name 'Name', sum(o.Quantity) as total_quantity, row_number() over(order by sum(o.Quantity) desc) orderank 
from Customers c 
inner join Orders o
on c.CustomerID = o.CustomerID
group by c.Name) co
order by total_quantity desc;

---- 2.	Write a query to calculate the average price of products for each product category.
select ProductName, avg(Price) 'average price' from Products
group by ProductName
order by 'average price' desc;

  
---- 3.	Write a query to retrieve the customers who have not placed any orders.
select CustomerID, name from Customers where CustomerID not in (select CustomerID from Orders);

--- 4.	Write a query to retrieve the order details (OrderID, ProductName, Quantity) for orders placed by customers whose names start with 'M'. 
select OrderID, ProductName, Quantity from Orders
where CustomerID in (select CustomerID from Customers where name like 'M%');

--- 5.	Write a query to calculate the total revenue generated from all orders. 
select sum(p.price * qc.total_quantity) 'total revenue' from Products p
inner join (select ProductName, sum(Quantity) 'total_quantity' from Orders
group by ProductName) qc
on p.ProductName = qc.ProductName;

-- 6.	Write a query to retrieve the customer names along with the total revenue generated from their orders.
select c.name, cp.total_revenue from Customers c
inner join (select o.CustomerID, sum(p.Price * o.Quantity) 'total_revenue' from Products p
inner join Orders o 
on p.ProductName = o.ProductName
group by o.CustomerID) cp
on c.CustomerID = cp.CustomerID;

-- 7.	Write a query to retrieve the customers who have placed at least one order for each product category.
select name from Customers where CustomerID in (
  SELECT CustomerID
  FROM Orders o
  JOIN Products p ON o.ProductName = p.ProductName
  GROUP BY CustomerID
  HAVING COUNT(DISTINCT p.ProductName) = (SELECT COUNT(DISTINCT ProductName) FROM Products)
);

-- 8.	Write a query to retrieve the customers who have placed orders on consecutive days.
with consecutive_dates as (
  select CustomerID, OrderDate, lead(OrderDate) over(partition by CustomerID order by OrderDate) 'next_date'
  from Orders
)
select DISTINCT c.CustomerID, c.name from Customers c
join consecutive_dates cd
on c.CustomerID = cd.CustomerID
where datediff(day, cd.OrderDate, cd.next_date) = 1;

-- 9.	Write a query to retrieve the top 3 products with the highest average quantity ordered.
select top 3 * from (select ProductName, avg(Quantity) 'average_quantity' from Orders
group by ProductName) av
order by average_quantity desc;

-- 10.	Write a query to calculate the percentage of orders that have a quantity greater than the average quantity.
with cte1 as (
  select count(*) 'qval' from Orders 
  where Quantity > (select avg(Quantity) from Orders)
),
cte2 as (
  select count(*) 'qval2' from Orders 
)
select concat(qval*100 / qval2, '%') 'percentage of orders that have a quantity greater than the average quantity' from cte1, cte2;

----- TASK 3 -----
-- 1.	Write a query to retrieve the customers who have placed orders for all products.
select CustomerID, name from Customers where CustomerID in (
  select o.CustomerID from Orders o
  inner join Products p
  on o.ProductName = p.ProductName
  group by o.CustomerID
  having count(distinct p.ProductID) = (select count(distinct ProductID) from Products)
);

-- 2.	Write a query to retrieve the products that have been ordered by all customers.
select ProductName from Orders 
group by ProductName
having count(distinct CustomerID) = (select count(distinct CustomerID) from Orders);

-- 3.	Write a query to calculate the total revenue generated from orders placed in each month.
select Month, sum(sub_revenue) 'monthly_revenue' from (
  select datename(month, o.OrderDate) 'Month', (p.Price * o.quantity) 'sub_revenue' from Orders o 
  inner join Products p 
  on o.ProductName = p.ProductName
) sub group by Month
order by monthly_revenue desc;

-- 4.	Write a query to retrieve the products that have been ordered by more than 50% of the customers.
with total_customers as (
  select count(distinct CustomerID) 'customer_count' from Orders
),
product_customer as (
  select ProductName, count(DISTINCT CustomerID) 'product_customer_count' from Orders
  group by ProductName
)
select ProductName from total_customers tc, product_customer pc
where product_customer_count > customer_count / 2;

-- 5.	Write a query to retrieve the top 5 customers who have spent the highest amount of money on orders. 
with customer_amount as (
  select o.CustomerID, sum(o.quantity * p.Price) 'total_amount' from Orders o
  inner join Products p
  on o.ProductName = p.ProductName
  group by o.CustomerID
)
select top 5 c.CustomerID, c.name, ca.total_amount from Customers c
inner join customer_amount ca
on c.CustomerID = ca.CustomerID
order by total_amount desc;

-- 6.	Write a query to calculate the running total of order quantities for each customer. 
select OrderID, CustomerID, OrderDate, quantity, sum(Quantity) over (partition by CustomerID order by OrderDate, OrderID) 'running_quantity'
from Orders
order by CustomerID, OrderDate, OrderID;

-- 7.	Write a query to retrieve the top 3 most recent orders for each customer. 
with recent_orders as (
  select OrderID, CustomerID, OrderDate, Quantity, row_number() over (partition by CustomerID order by OrderDate desc) 'row_date'
  from Orders
)
select OrderID, CustomerID, OrderDate, Quantity from recent_orders
where row_date <=3
order by CustomerID, row_date;

-- 8.	Write a query to calculate the total revenue generated by each customer in the last 30 days. 
select o.CustomerID, sum(o.Quantity * p.Price) 'total_revenue' from Orders o
inner join Products p
on o.ProductName = p.ProductName
where datediff(day, o.OrderDate, getdate()) <= 30
group by o.CustomerID;

-- 9.	Write a query to retrieve the customers who have placed orders for at least two different product categories.
select name from Customers where CustomerID in (
  select CustomerID from Orders o
  inner join Products p 
  on o.ProductName = p.ProductName
  group by CustomerID
  having count(DISTINCT p.ProductName) >= 2 
);

-- 10.	Write a query to calculate the average revenue per order for each customer. 
select CustomerID, avg(o.Quantity * p.Price) 'average_revenue_per_order' from Orders o
inner join Products p 
on o.ProductName = p.ProductName
group by CustomerID;

-- 11.	Write a query to retrieve the customers who have placed orders for every month of a specific year. 
select name from Customers where CustomerID in (select CustomerID from Orders
  where year(OrderDate) = 2023
  group by CustomerID
  having count(DISTINCT month(OrderDate)) = 12
);

-- 12.	Write a query to retrieve the customers who have placed orders for a specific product in consecutive months. 
with month_cte as (
  select CustomerID, ProductName, OrderDate, 
  case when datediff(month, lag(OrderDate) over (partition by CustomerID, ProductName order by OrderDate), OrderDate) = 1
  then 1 else 0 end 'consecutive_months'
  from Orders
)
select CustomerID, name from Customers where CustomerID in (select CustomerID from month_cte
where consecutive_months = 1 
group by CustomerID, ProductName);

-- 13.	Write a query to retrieve the products that have been ordered by a specific customer at least twice. 
select o.ProductName from Orders o
inner join Products p
on o.ProductName = p.ProductName
group by o.ProductName, o.CustomerID
having count(o.CustomerID) >= 2;

select * from Customers;
select * from Orders;
select * from Products;
  

