CREATE DATABASE product_showcase;
GO
USE product_showcase;
GO

CREATE TABLE admins (
  id INT IDENTITY(1,1) PRIMARY KEY,
  username NVARCHAR(50) NOT NULL UNIQUE,
  password_hash VARCHAR(64) NOT NULL,
  created_at DATETIME DEFAULT GETDATE()
);

CREATE TABLE categories (
  id INT IDENTITY(1,1) PRIMARY KEY,
  name NVARCHAR(100) NOT NULL,
  parent_id INT DEFAULT 0,
  sort_order INT DEFAULT 0
);

CREATE TABLE products (
  id INT IDENTITY(1,1) PRIMARY KEY,
  name NVARCHAR(255) NOT NULL,
  sku NVARCHAR(100) NOT NULL,
  category_id INT,
  main_image NVARCHAR(255),
  description NVARCHAR(MAX),
  keywords NVARCHAR(255),
  selling_points NVARCHAR(MAX),
  parameters NVARCHAR(MAX),
  cert_tags NVARCHAR(255),
  stock_status NVARCHAR(50) DEFAULT N'有货',
  sort_order INT DEFAULT 0,
  is_hot BIT DEFAULT 0,
  is_active BIT DEFAULT 1,
  created_at DATETIME DEFAULT GETDATE()
);

CREATE TABLE product_images (
  id INT IDENTITY(1,1) PRIMARY KEY,
  product_id INT NOT NULL,
  image_url NVARCHAR(255) NOT NULL,
  sort_order INT DEFAULT 0
);

CREATE TABLE product_certificates (
  id INT IDENTITY(1,1) PRIMARY KEY,
  product_id INT NOT NULL,
  cert_name NVARCHAR(100) NOT NULL,
  file_url NVARCHAR(255) NOT NULL
);

CREATE TABLE banners (
  id INT IDENTITY(1,1) PRIMARY KEY,
  image_url NVARCHAR(255) NOT NULL,
  link_url NVARCHAR(255) DEFAULT '#',
  sort_order INT DEFAULT 0,
  status BIT DEFAULT 1
);

CREATE TABLE inquiries (
  id INT IDENTITY(1,1) PRIMARY KEY,
  name NVARCHAR(100),
  email NVARCHAR(100),
  phone NVARCHAR(50),
  product_id INT,
  message NVARCHAR(MAX),
  created_at DATETIME DEFAULT GETDATE(),
  status BIT DEFAULT 0
);
GO

INSERT INTO admins(username, password_hash)
VALUES('admin', CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', 'admin123'), 2));
GO
