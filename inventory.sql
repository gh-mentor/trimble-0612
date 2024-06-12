/*
This file contains a script of Transact SQL (T-SQL) command to interact with a database named 'Inventory'.
Requirements:
- SQL Server 2019 is installed and running
- database 'Inventory' already exists.
Details:
- Sets the default database to 'Inventory'.
- Creates a 'categories' table and related 'products' table if they do not already exist. There is a one to many relationship between the 'categories' and 'products' tables.
- Remove all rows from the products and categories tables (in case they already existed).
- Populates the 'Categories' table with sample data.
- Populates the 'Products' table with sample data.
Errors:
- if the database 'Inventory' does not exist, the script will print an error message and exit.
*/

-- check if the database 'Inventory' exists
IF NOT EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'Inventory')
BEGIN
    PRINT 'Database [Inventory] does not exist. Please create the database first.';
    RETURN;
END

-- Set the default database to 'Inventory' 
USE Inventory;

-- create the 'categories' table if it does not already exist.
-- The table has three columns: CategoryID, CategoryName, and Description.
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Categories')
BEGIN
    CREATE TABLE Categories (
        CategoryID INT PRIMARY KEY,
        CategoryName NVARCHAR(50) NOT NULL,
        Description NVARCHAR(255)
    );
END

-- create the 'products' table if it does not already exist.
-- The table has five columns: ProductID, ProductName, CategoryID, Price.
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Products')
BEGIN
    CREATE TABLE Products (
        ProductID INT PRIMARY KEY,
        ProductName NVARCHAR(50) NOT NULL,
        CategoryID INT NOT NULL,
        Price DECIMAL(10, 2) NOT NULL,
        FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID),
        -- add a created date column
        CreatedDate DATETIME DEFAULT GETDATE(),
        -- add a modified date column
        ModifiedDate DATETIME DEFAULT GETDATE()
    );
END

-- remove all rows from the products and categories tables (in case they already existed)
TRUNCATE TABLE Products;
TRUNCATE TABLE Categories;

-- create a stored proc to populate the 'Categories' table with 3 rows of sample data
IF OBJECT_ID('dbo.InsertCategories') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.InsertCategories;
END
GO
CREATE PROCEDURE dbo.InsertCategories
AS
BEGIN
    INSERT INTO Categories (CategoryID, CategoryName, Description) VALUES (1, 'Electronics', 'Electronic devices and accessories');
    INSERT INTO Categories (CategoryID, CategoryName, Description) VALUES (2, 'Clothing', 'Apparel and accessories');
    INSERT INTO Categories (CategoryID, CategoryName, Description) VALUES (3, 'Books', 'Books and reading materials');
    INSERT INTO Categories (CategoryID, CategoryName, Description) VALUES (4, 'Furniture', 'Home and office furniture');
    INSERT INTO Categories (CategoryID, CategoryName, Description) VALUES (5, 'Toys', 'Children''s toys and games');
END
GO

-- execute the stored proc to populate the 'Categories' table
EXEC dbo.InsertCategories;

-- create a stored proc to populate the 'Products' table with sample data
IF OBJECT_ID('dbo.InsertProducts') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.InsertProducts;
END
GO
CREATE PROCEDURE dbo.InsertProducts
AS
BEGIN
    INSERT INTO Products (ProductID, ProductName, CategoryID, Price) VALUES (1, 'Laptop', 1, 999.99);
    INSERT INTO Products (ProductID, ProductName, CategoryID, Price) VALUES (2, 'Smartphone', 1, 599.99);
    INSERT INTO Products (ProductID, ProductName, CategoryID, Price) VALUES (3, 'T-shirt', 2, 19.99);
    INSERT INTO Products (ProductID, ProductName, CategoryID, Price) VALUES (4, 'Jeans', 2, 39.99);
    INSERT INTO Products (ProductID, ProductName, CategoryID, Price) VALUES (5, 'Novel', 3, 9.99);
    INSERT INTO Products (ProductID, ProductName, CategoryID, Price) VALUES (6, 'Desk', 4, 199.99);
    INSERT INTO Products (ProductID, ProductName, CategoryID, Price) VALUES (7, 'Chair', 4, 49.99);
    INSERT INTO Products (ProductID, ProductName, CategoryID, Price) VALUES (8, 'Action Figure', 5, 14.99);
    INSERT INTO Products (ProductID, ProductName, CategoryID, Price) VALUES (9, 'Board Game', 5, 24.99);
END
GO

-- execute the stored proc to populate the 'Products' table
EXEC dbo.InsertProducts;

-- print a success message
PRINT 'Database setup completed successfully.';

