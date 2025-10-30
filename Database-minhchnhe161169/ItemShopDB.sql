USE [master]
GO

IF EXISTS (SELECT * FROM sys.databases WHERE name = 'ItemShopDB')
	DROP DATABASE ItemShopDB
GO

CREATE DATABASE ItemShopDB
GO

use ItemShopDB
GO

-- Table: Item
CREATE TABLE Item (
    ItemID INT IDENTITY(1,1) PRIMARY KEY,
    ItemName NVARCHAR(255) NOT NULL
);
GO

-- Table: Category
CREATE TABLE Category (
    cateID INT IDENTITY(1,1) PRIMARY KEY,
    cateName NVARCHAR(255)
);
GO

-- Table: Account
CREATE TABLE Account (
    accID VARCHAR(255) PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    name NVARCHAR(255) NOT NULL,
    role INT CHECK (role IN (0,1)) DEFAULT 0,
    phone VARCHAR(20) UNIQUE
);
GO

-- Table: Product
CREATE TABLE Product (
    productid INT IDENTITY(1,1) PRIMARY KEY,
    productName NVARCHAR(255) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    description NVARCHAR(MAX),
    cateID INT,
    ItemID INT,
    imageURL VARCHAR(500),
    discount DECIMAL(5,2) CHECK (discount BETWEEN 0 AND 100) DEFAULT 0.0,
    stock INT NOT NULL DEFAULT 0,
    FOREIGN KEY (cateID) REFERENCES Category(cateID) ON DELETE SET NULL,
    FOREIGN KEY (ItemID) REFERENCES Item(ItemID) ON DELETE SET NULL
);
GO


-- Table: Order (Bill đã được gộp vào đây)
CREATE TABLE [Order] (
    orderID INT IDENTITY(1,1) PRIMARY KEY,
    userID VARCHAR(255),
    create_at DATETIME DEFAULT GETDATE(),
    status NVARCHAR(20) DEFAULT 'pending' CHECK (status IN ('pending', 'confirmed', 'shipped', 'delivered', 'cancelled')),
    totalPrice DECIMAL(10,2) NOT NULL,
    address NVARCHAR(255) NOT NULL, 
    receiver_name NVARCHAR(255) NOT NULL,
    receiver_phone VARCHAR(20) NOT NULL, 
    FOREIGN KEY (userID) REFERENCES Account(accID) ON DELETE CASCADE
);
GO 

-- Table: OrderDetail
CREATE TABLE OrderDetail (
    orderDetailID INT IDENTITY(1,1) PRIMARY KEY,
    orderID INT,
    productID INT,
    quantity INT NOT NULL,
    FOREIGN KEY (orderID) REFERENCES [Order](orderID) ON DELETE CASCADE,
    FOREIGN KEY (productID) REFERENCES Product(productid) ON DELETE CASCADE
);
GO

-- Table: Cart
CREATE TABLE Cart (
    cartID INT IDENTITY(1,1) PRIMARY KEY,
    accID VARCHAR(255),
    productID INT,  -- Liên kết với bảng Product
    quantity INT NOT NULL,
    FOREIGN KEY (accID) REFERENCES Account(accID) ON DELETE CASCADE,
    FOREIGN KEY (productID) REFERENCES Product(productid) ON DELETE CASCADE
);
GO

-- Table: Comment
CREATE TABLE Comment (
    commentID INT IDENTITY(1,1) PRIMARY KEY,
    productid INT,
    accID VARCHAR(255),
    comment NVARCHAR(MAX),
    date DATETIME DEFAULT GETDATE(),
    rating INT CHECK (rating BETWEEN 0 AND 5) NOT NULL,
    FOREIGN KEY (productid) REFERENCES Product(productid) ON DELETE CASCADE,
    FOREIGN KEY (accID) REFERENCES Account(accID) ON DELETE CASCADE
);
GO

-- View: Product Rating
CREATE VIEW ProductRating AS
SELECT
    p.productid,
    COALESCE(AVG(c.rating), 0) AS rating
FROM Product p
LEFT JOIN Comment c ON p.productid = c.productid
GROUP BY p.productid;
GO

---------------- data insert
INSERT INTO Item (ItemName)
VALUES
    (N'Gear'),
    (N'Quần áo'),
    (N'Phụ kiện');
GO

INSERT INTO Category (cateName)
VALUES
    (N'Gear'),
    (N'Phụ Kiện'),
    (N'Đồ Chơi'),
    (N'Chăm Sóc da'),
    (N'Quần áo'),
    (N'Thiết bị');
GO

INSERT INTO Account (accID, email, password, name, role, phone)
VALUES
    ('admin1', 'admin@gmail.com', '123', 'admin', 0, '0'),
    ('user1', 'user@gmail.com', '123', 'User Lee', 1, '0192837465');
GO

-- Thêm tài khoản user mới (User Two)
INSERT INTO Account (accID, email, password, name, role, phone)
VALUES
    ('user2', 'user2@gmail.com', '123', 'User Two Nguyen', 1, '0987654321');
GO

-- Thêm tài khoản user mới (User Three)
INSERT INTO Account (accID, email, password, name, role, phone)
VALUES
    ('user3', 'user3@gmail.com', '123', 'User Three Tran', 1, '0333444555');
GO

-- Thêm tài khoản user mới (User Four)
INSERT INTO Account (accID, email, password, name, role, phone)
VALUES
    ('user4', 'user4@gmail.com', '123', 'User Four Le', 1, '0777888999');
GO

-- Thêm tài khoản user mới (User Five)
INSERT INTO Account (accID, email, password, name, role, phone)
VALUES
    ('user5', 'user5@gmail.com', '123', 'User Five Pham', 1, '0888111222');
GO


SELECT * FROM Category;
SELECT * FROM Item;

DELETE FROM ;
WHERE ;