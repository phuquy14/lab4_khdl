CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(255) NOT NULL,
    phone_number VARCHAR(15) UNIQUE,
    address VARCHAR(255)
);

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    price DECIMAL(10, 2) CHECK (price >= 0)
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    order_date DATE NOT NULL,
    customer_id INT,
    total_amount DECIMAL(10, 2) DEFAULT 0,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_details (
    order_id INT,
    product_id INT,
    quantity INT CHECK (quantity > 0),
    unit_price DECIMAL(10, 2) CHECK (unit_price >= 0),
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO customers (customer_name, phone_number, address) VALUES
('Nguyễn Văn A', '0901234567', '123 ABC'),
('Trần Thị B', '0912345678', '456 XYZ');

INSERT INTO products (product_id, product_name, price) VALUES
(1, 'Sữa tươi', 30000),
(2, 'Bánh mì', 15000),
(3, 'Nước ngọt', 10000),
(8, 'Nước suối Aquafina', 5000);

INSERT INTO orders (order_date, customer_id, total_amount) VALUES
('2025-10-15', 1, 75000),
('2025-10-15', 2, 66000);

INSERT INTO order_details (order_id, product_id, quantity, unit_price) VALUES
(1, 1, 2, 30000),
(1, 2, 1, 15000),
(2, 3, 5, 10000);


CREATE TABLE suppliers (
    supplier_id SERIAL PRIMARY KEY, 
    supplier_name VARCHAR(255) NOT NULL,
    contact_phone VARCHAR(15) UNIQUE
);

ALTER TABLE suppliers 
ADD COLUMN email VARCHAR(100);

ALTER TABLE products 
ADD COLUMN supplier_id INT;

ALTER TABLE products 
ADD CONSTRAINT fk_products_suppliers 
FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id);


INSERT INTO suppliers (supplier_name, contact_phone, email) VALUES
('Công ty Sữa Việt Nam', '0987654321', 'contact@vinamilk.vn'),
('Công ty Thực phẩm Á Châu', '0912345678', 'contact@acecook.vn');

UPDATE suppliers 
SET contact_phone = '0911112222' 
WHERE supplier_name = 'Công ty Thực phẩm Á Châu';

DELETE FROM products 
WHERE product_id = 8;


CREATE TABLE test_table (
    id INT
);

ALTER TABLE suppliers 
DROP COLUMN contact_phone;

DROP TABLE test_table;
