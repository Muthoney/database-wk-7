-- answers.sql
-- Assignment: Normalization Queries
-- Author: [Your Name]
-- Date: [Date]

--------------------------------------------------------
-- Question 1: Achieving 1NF (First Normal Form)
--------------------------------------------------------
-- The Products column has multiple values (violates 1NF).
-- Solution: Split into separate rows so each row has ONE product.

-- Original Table: ProductDetail(OrderID, CustomerName, Products)

-- Create a new table for 1NF
CREATE TABLE ProductDetail_1NF (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(50)
);

-- Insert rows (each product in a separate row)
INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Product) VALUES
(101, 'John Doe', 'Laptop'),
(101, 'John Doe', 'Mouse'),
(102, 'Jane Smith', 'Tablet'),
(102, 'Jane Smith', 'Keyboard'),
(102, 'Jane Smith', 'Mouse'),
(103, 'Emily Clark', 'Phone');

-- Now each row contains a single product → Table is in 1NF.

--------------------------------------------------------
-- Question 2: Achieving 2NF (Second Normal Form)
--------------------------------------------------------
-- Current Table: OrderDetails(OrderID, CustomerName, Product, Quantity)
-- Problem: CustomerName depends only on OrderID (partial dependency).
-- Solution: Split into two tables:
--   (1) Orders (OrderID, CustomerName)
--   (2) OrderItems (OrderID, Product, Quantity)

-- Create Orders table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Insert rows (unique OrderID → CustomerName mapping)
INSERT INTO Orders (OrderID, CustomerName) VALUES
(101, 'John Doe'),
(102, 'Jane Smith'),
(103, 'Emily Clark');

-- Create OrderItems table
CREATE TABLE OrderItems (
    OrderID INT,
    Product VARCHAR(50),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Insert rows (product + quantity details for each order)
INSERT INTO OrderItems (OrderID, Product, Quantity) VALUES
(101, 'Laptop', 2),
(101, 'Mouse', 1),
(102, 'Tablet', 3),
(102, 'Keyboard', 1),
(102, 'Mouse', 2),
(103, 'Phone', 1);

-- Now CustomerName depends only on OrderID in Orders,
-- and Product/Quantity depend fully on (OrderID, Product) in OrderItems.
-- Table is now in 2NF.
