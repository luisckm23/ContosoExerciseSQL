use tienda_chatgpt;

-- Eliminar tablas si ya existen
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS products;

-- Tabla de clientes (con nombres separados)
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    city VARCHAR(50),
    registration_date DATE
);

-- Tabla de productos
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2),
    stock INT
);

-- Tabla de órdenes
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Insertar clientes (15 registros, nombres separados)
INSERT INTO customers (first_name, last_name, email, city, registration_date) VALUES
('Ana', 'Torres', 'ana.torres@example.com', 'Monterrey', '2022-01-10'),
('Luis', 'Martínez', 'luis.mtz@example.com', 'Guadalajara', '2022-03-05'),
('Carmen', 'Vega', 'carmen.vega@example.com', 'CDMX', '2021-11-20'),
('Jorge', 'Ramírez', 'jorge.r@example.com', 'Querétaro', '2022-07-18'),
('Daniela', 'López', 'daniela.lpz@example.com', 'Puebla', '2022-08-09'),
('Carlos', 'Ruiz', 'carlos.ruiz@example.com', 'Monterrey', '2022-09-22'),
('Fernanda', 'Díaz', 'fer.diaz@example.com', 'CDMX', '2021-12-30'),
('Diego', 'Torres', 'd.torres@example.com', 'Cancún', '2023-01-12'),
('Patricia', 'Salas', 'pat.salas@example.com', 'Tijuana', '2022-06-17'),
('Hugo', 'Sánchez', 'h.sanchez@example.com', 'Toluca', '2021-10-01'),
('Isabel', 'Gómez', 'isa.gomez@example.com', 'CDMX', '2022-03-30'),
('Tomás', 'Pérez', 'tomas.p@example.com', 'León', '2023-01-25'),
('Sandra', 'Méndez', 'sandra.mz@example.com', 'Aguascalientes', '2023-02-14'),
('Miguel', 'Navarro', 'miguel.n@example.com', 'Guadalajara', '2023-03-05'),
('Lucía', 'Fuentes', 'lucia.f@example.com', 'CDMX', '2023-03-10');

-- Insertar productos (15 registros)
INSERT INTO products (product_name, category, price, stock) VALUES
('Laptop HP 15"', 'Electrónica', 14500.00, 25),
('Audífonos Bluetooth JBL', 'Accesorios', 1500.00, 100),
('Teclado Mecánico Redragon', 'Accesorios', 950.00, 40),
('Smartphone Samsung A52', 'Electrónica', 7200.00, 30),
('Monitor LG 24"', 'Electrónica', 3200.00, 20),
('Mouse Gamer Logitech', 'Accesorios', 600.00, 60),
('Tablet Huawei 10"', 'Electrónica', 4800.00, 15),
('Mochila Lenovo para Laptop', 'Accesorios', 750.00, 80),
('Cargador Portátil Anker', 'Accesorios', 1200.00, 90),
('Cable USB-C Belkin', 'Accesorios', 300.00, 150),
('Base Refrigerante para Laptop', 'Accesorios', 450.00, 70),
('Impresora Epson EcoTank', 'Electrónica', 3400.00, 10),
('Router TP-Link AC1200', 'Electrónica', 980.00, 25),
('Cámara Web Logitech C920', 'Electrónica', 1700.00, 18),
('SSD Kingston 480GB', 'Accesorios', 1100.00, 35);


-- Insertar órdenes (65 registros con fechas de 2021 a 2025)
INSERT INTO orders (customer_id, product_id, quantity, order_date) VALUES
(1, 1, 1, '2021-06-15'),
(2, 2, 2, '2021-07-20'),
(3, 4, 1, '2021-08-12'),
(4, 5, 1, '2021-09-18'),
(5, 6, 1, '2021-10-25'),
(6, 7, 1, '2021-11-30'),
(7, 8, 2, '2021-12-15'),
(8, 9, 1, '2022-01-10'),
(9, 10, 3, '2022-02-22'),
(10, 11, 2, '2022-03-05'),
(11, 12, 1, '2022-04-08'),
(12, 13, 1, '2022-05-11'),
(13, 14, 2, '2022-06-13'),
(14, 15, 1, '2022-07-17'),
(15, 1, 1, '2022-08-19'),
(1, 3, 2, '2022-09-22'),
(2, 5, 1, '2022-10-25'),
(3, 7, 1, '2022-11-27'),
(4, 9, 2, '2022-12-30'),
(5, 11, 1, '2023-01-05'),
(6, 13, 1, '2023-02-10'),
(7, 15, 1, '2023-03-14'),
(8, 2, 3, '2023-04-18'),
(9, 4, 1, '2023-05-22'),
(10, 6, 1, '2023-06-26'),
(11, 8, 2, '2023-07-30'),
(12, 10, 1, '2023-08-03'),
(13, 12, 1, '2023-09-06'),
(14, 14, 1, '2023-10-09'),
(15, 1, 1, '2023-11-12'),
(1, 2, 1, '2023-12-15'),
(2, 3, 1, '2024-01-05'),
(3, 4, 1, '2024-02-10'),
(4, 5, 2, '2024-03-15'),
(5, 6, 1, '2024-04-20'),
(6, 7, 2, '2024-05-25'),
(7, 8, 1, '2024-06-30'),
(8, 9, 1, '2024-07-04'),
(9, 10, 1, '2024-08-08'),
(10, 11, 1, '2024-09-12'),
(11, 12, 1, '2024-10-16'),
(12, 13, 1, '2024-11-20'),
(13, 14, 1, '2024-12-24'),
(14, 15, 2, '2025-01-15'),
(15, 1, 1, '2025-02-19'),
(1, 2, 2, '2025-03-23'),
(2, 3, 1, '2025-04-08'),
(3, 4, 2, '2025-04-08'),
(4, 5, 1, '2025-04-08'),
(5, 6, 1, '2025-04-08'),
(6, 7, 1, '2025-04-08'),
(7, 8, 2, '2025-04-08'),
(8, 9, 1, '2025-04-08'),
(9, 10, 1, '2025-04-08'),
(10, 11, 1, '2025-04-08'),
(11, 12, 1, '2025-04-08'),
(12, 13, 1, '2025-04-08'),
(13, 14, 1, '2025-04-08'),
(14, 15, 1, '2025-04-08'),
(15, 1, 1, '2025-04-08');

