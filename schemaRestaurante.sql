use restaurante;

CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    join_date DATE
);

INSERT INTO customers (name, email, phone, join_date)
VALUES
    ('Ana Torres', 'ana.torres@email.com', '555-101-1234', '2023-01-05'),
    ('Luis Pérez', 'luis.pz@email.com', '555-202-5678', '2023-01-12'),
    ('Sofía Ríos', 'sofia.r@email.com', '555-303-2468', '2023-02-01'),
    ('Carlos Díaz', 'cdiaz@email.com', '555-404-1357', '2023-02-17'),
    ('María López', 'maria.lopez@email.com', '555-505-7890', '2023-03-22'),
    ('Hugo Sánchez', 'hugo.s@email.com', '555-606-0987', '2023-04-10'),
    ('Fernanda Ruiz', 'fernanda.r@email.com', '555-707-1122', '2023-05-04'),
    ('Tomás Gutiérrez', 'tomasg@email.com', '555-808-2233', '2023-06-15'),
    ('Patricia León', 'patricia.l@email.com', '555-909-3344', '2023-07-18'),
    ('Iván Martínez', 'ivan.m@email.com', '555-111-4455', '2023-08-23'),
    ('Claudia Soto', 'claudia.s@email.com', '555-222-5566', '2023-09-29'),
    ('Andrés Ramírez', 'andres.r@email.com', '555-333-6677', '2023-10-31'),
    ('Brenda Castillo', 'brenda.c@email.com', '555-444-7788', '2023-11-08'),
    ('Pablo Herrera', 'pablo.h@email.com', '555-555-8899', '2023-12-01'),
    ('Lucía Navarro', 'lucia.n@email.com', '555-666-9900', '2024-01-10'),
    ('Jorge Aguilar', 'jorge.a@email.com', '555-777-0011', '2024-02-05'),
    ('Rebeca Jiménez', 'rebeca.j@email.com', '555-888-1122', '2024-02-25'),
    ('Diego Mendoza', 'diego.m@email.com', '555-999-2233', '2024-03-01'),
    ('Paola Salinas', 'paola.s@email.com', '555-000-3344', '2024-03-07'),
    ('Carla González', 'carla.g@email.com', '555-777-3322', '2024-03-11');
    
    CREATE TABLE menu_items (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    item_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(6,2),
    available BOOLEAN
);

INSERT INTO menu_items (item_name, category, price, available)
VALUES
    ('Ensalada César', 'Entrada', 85.00, 1),
    ('Sopa de Tortilla', 'Entrada', 70.00, 1),
    ('Hamburguesa Clásica', 'Plato Fuerte', 135.00, 1),
    ('Pizza Margarita', 'Plato Fuerte', 160.00, 1),
    ('Pasta Alfredo', 'Plato Fuerte', 140.00, 1),
    ('Brownie con Helado', 'Postre', 90.00, 1),
    ('Cheesecake de Fresa', 'Postre', 95.00, 1),
    ('Limonada Natural', 'Bebida', 45.00, 1),
    ('Agua Mineral', 'Bebida', 30.00, 1),
    ('Café Americano', 'Bebida', 40.00, 1),
    ('Tacos al Pastor', 'Plato Fuerte', 125.00, 1),
    ('Quesadillas de Queso', 'Entrada', 80.00, 1),
    ('Enchiladas Verdes', 'Plato Fuerte', 150.00, 1),
    ('Flan Napolitano', 'Postre', 85.00, 1),
    ('Jugo de Naranja', 'Bebida', 50.00, 1),
    ('Chilaquiles Rojos', 'Plato Fuerte', 120.00, 1),
    ('Panqueques con Miel', 'Postre', 95.00, 1),
    ('Bistec a la Mexicana', 'Plato Fuerte', 170.00, 1),
    ('Crema de Champiñones', 'Entrada', 75.00, 1),
    ('Malteada de Chocolate', 'Bebida', 65.00, 1);

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    item_id INT,
    order_date DATE,
    quantity INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (item_id) REFERENCES menu_items(item_id)
);

INSERT INTO orders (customer_id, item_id, order_date, quantity)
VALUES
    (1, 3, '2024-02-05', 1),
    (2, 1, '2024-02-05', 2),
    (3, 5, '2024-02-06', 1),
    (1, 8, '2024-02-06', 2),
    (4, 4, '2024-02-07', 1),
    (5, 6, '2024-02-07', 1),
    (6, 3, '2024-02-08', 1),
    (7, 12, '2024-02-08', 2),
    (8, 7, '2024-02-09', 1),
    (9, 9, '2024-02-10', 3),
    (10, 10, '2024-02-11', 1),
    (11, 11, '2024-02-11', 1),
    (12, 2, '2024-02-12', 1),
    (13, 13, '2024-02-13', 2),
    (14, 15, '2024-02-13', 1),
    (15, 14, '2024-02-14', 1),
    (16, 16, '2024-02-15', 2),
    (17, 17, '2024-02-15', 1),
    (18, 18, '2024-02-15', 1),
    (19, 19, '2024-02-16', 2),
    (20, 20, '2024-02-16', 1),
    (1, 3, '2024-02-17', 1),
    (2, 5, '2024-02-17', 1),
    (3, 6, '2024-02-18', 2),
    (4, 10, '2024-02-19', 1),
    (5, 11, '2024-02-19', 1),
    (6, 12, '2024-02-20', 1),
    (7, 7, '2024-02-20', 2),
    (8, 8, '2024-02-21', 1),
    (9, 9, '2024-02-22', 1),
    (10, 13, '2024-02-22', 1),
    (11, 4, '2024-02-23', 1),
    (12, 2, '2024-02-24', 2),
    (13, 1, '2024-02-24', 1),
    (14, 14, '2024-02-25', 1),
    (15, 15, '2024-02-26', 2),
    (16, 16, '2024-02-27', 1),
    (17, 17, '2024-02-27', 1),
    (18, 18, '2024-02-28', 1),
    (19, 19, '2024-02-29', 1),
    (20, 20, '2024-02-29', 2);

INSERT INTO orders (customer_id, item_id, order_date, quantity)
VALUES
    (15, 1, '2024-03-01', 1),
    (15, 2, '2024-03-02', 1),
    (15, 3, '2024-03-01', 1),
    (15, 4, '2024-03-02', 1),
    (15, 5, '2024-03-01', 1),
    (15, 6, '2024-03-02', 1),
    (15, 7, '2024-03-03', 1);
