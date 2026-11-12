CREATE DATABASE IF NOT EXISTS mart_management CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE mart_management;

CREATE TABLE roles (
  role_id INT AUTO_INCREMENT PRIMARY KEY,
  role_name VARCHAR(30) NOT NULL UNIQUE
);

CREATE TABLE users (
  user_id INT AUTO_INCREMENT PRIMARY KEY,
  role_id INT NOT NULL,
  username VARCHAR(50) NOT NULL UNIQUE,
  email VARCHAR(120) UNIQUE,
  password_hash VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (role_id) REFERENCES roles(role_id)
);

CREATE TABLE employees (
  employee_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NULL,
  employee_name VARCHAR(120) NOT NULL,
  phone VARCHAR(30),
  email VARCHAR(120),
  salary DECIMAL(12,2) DEFAULT 0,
  work_schedule VARCHAR(50),
  FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE SET NULL
);

CREATE TABLE customers (
  customer_id INT AUTO_INCREMENT PRIMARY KEY,
  customer_name VARCHAR(120) NOT NULL,
  phone VARCHAR(30),
  email VARCHAR(120),
  address VARCHAR(255),
  loyalty_points INT DEFAULT 0,
  membership_info VARCHAR(100),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE categories (
  category_id INT AUTO_INCREMENT PRIMARY KEY,
  category_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE products (
  product_id INT AUTO_INCREMENT PRIMARY KEY,
  product_code VARCHAR(50) NOT NULL UNIQUE,
  product_name VARCHAR(150) NOT NULL,
  category_id INT NULL,
  brand VARCHAR(100),
  unit VARCHAR(30) DEFAULT 'pcs',
  cost_price DECIMAL(12,2) NOT NULL DEFAULT 0,
  selling_price DECIMAL(12,2) NOT NULL DEFAULT 0,
  expiry_date DATE NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (category_id) REFERENCES categories(category_id) ON DELETE SET NULL
);

CREATE TABLE promotions (
  promotion_id INT AUTO_INCREMENT PRIMARY KEY,
  product_id INT NULL,
  discount_type VARCHAR(20) NOT NULL DEFAULT 'percent',
  discount_value DECIMAL(10,2) NOT NULL DEFAULT 0,
  start_date DATE,
  end_date DATE,
  FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE
);

CREATE TABLE suppliers (
  supplier_id INT AUTO_INCREMENT PRIMARY KEY,
  company_name VARCHAR(150) NOT NULL,
  contact_person VARCHAR(120),
  phone VARCHAR(30),
  email VARCHAR(120),
  address VARCHAR(255)
);

CREATE TABLE inventory (
  inventory_id INT AUTO_INCREMENT PRIMARY KEY,
  product_id INT NOT NULL UNIQUE,
  quantity INT NOT NULL DEFAULT 0,
  stock_type VARCHAR(30) DEFAULT 'Available',
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE
);

CREATE TABLE sales (
  sale_id INT AUTO_INCREMENT PRIMARY KEY,
  customer_id INT NULL,
  employee_id INT NULL,
  sale_date DATETIME NOT NULL,
  subtotal DECIMAL(12,2) NOT NULL DEFAULT 0,
  discount DECIMAL(12,2) NOT NULL DEFAULT 0,
  tax DECIMAL(12,2) NOT NULL DEFAULT 0,
  total DECIMAL(12,2) NOT NULL DEFAULT 0,
  payment_method VARCHAR(30) DEFAULT 'Cash',
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE SET NULL,
  FOREIGN KEY (employee_id) REFERENCES users(user_id) ON DELETE SET NULL
);

CREATE TABLE sale_details (
  sale_detail_id INT AUTO_INCREMENT PRIMARY KEY,
  sale_id INT NOT NULL,
  product_id INT NOT NULL,
  quantity INT NOT NULL,
  unit_price DECIMAL(12,2) NOT NULL,
  line_total DECIMAL(12,2) NOT NULL,
  FOREIGN KEY (sale_id) REFERENCES sales(sale_id) ON DELETE CASCADE,
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE purchase_orders (
  purchase_id INT AUTO_INCREMENT PRIMARY KEY,
  supplier_id INT NULL,
  order_date DATETIME NOT NULL,
  total DECIMAL(12,2) NOT NULL DEFAULT 0,
  FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id) ON DELETE SET NULL
);

CREATE TABLE purchase_details (
  purchase_detail_id INT AUTO_INCREMENT PRIMARY KEY,
  purchase_id INT NOT NULL,
  product_id INT NOT NULL,
  quantity INT NOT NULL,
  cost_price DECIMAL(12,2) NOT NULL,
  FOREIGN KEY (purchase_id) REFERENCES purchase_orders(purchase_id) ON DELETE CASCADE,
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE expenses (
  expense_id INT AUTO_INCREMENT PRIMARY KEY,
  employee_id INT NULL,
  expense_category VARCHAR(100),
  amount DECIMAL(12,2) NOT NULL,
  expense_date DATE NOT NULL,
  note VARCHAR(255),
  FOREIGN KEY (employee_id) REFERENCES employees(employee_id) ON DELETE SET NULL
);

INSERT INTO roles(role_name) VALUES ('Admin'),('Manager'),('Cashier');

INSERT INTO categories(category_name) VALUES ('Drinks'),('Snacks'),('Food'),('Dairy'),('Bakery'),('Household');

INSERT INTO products(product_code,product_name,category_id,brand,unit,cost_price,selling_price,expiry_date) VALUES
('P001','Coca Cola',1,'Coca Cola','bottle',0.70,1.00,'2027-05-01'),
('P002',"Lay's Chips",2,"Lay's",'bag',1.00,1.50,'2027-01-15'),
('P003','Milk',4,'Local Dairy','bottle',0.70,1.00,'2026-12-01'),
('P004','Bread',5,'Fresh Bakery','pack',0.60,1.00,'2026-10-01'),
('P005','Instant Noodles',3,'Mama','pack',0.80,1.25,'2027-02-01');

INSERT INTO inventory(product_id,quantity) VALUES (1,50),(2,20),(3,5),(4,10),(5,15);

-- Demo accounts. Change these passwords after installation.
INSERT INTO users(role_id,username,email,password_hash) VALUES
(1,'admin','admin@mart.local','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC2Q5m1wK3G4Q7q1K9aS'),
(2,'manager','manager@mart.local','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC2Q5m1wK3G4Q7q1K9aS'),
(3,'cashier','cashier@mart.local','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC2Q5m1wK3G4Q7q1K9aS');

-- Demo password for the three accounts above: password
