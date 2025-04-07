-- Encuentra el nombre del cliente que ha gastado más dinero en total.
-- Muestra el nombre del cliente (de la tabla customers) que ha realizado
-- el mayor gasto total considerando la cantidad de productos ordenados multiplicado por el precio de cada ítem.

use restaurante;

select c.name, sum(o.quantity) * m.price as total
from customers c
join orders o
	on c.customer_id = o.customer_id
join menu_items m
	on o.item_id = m.item_id
group by c.name
limit 1;

-- Encuentra el nombre y correo de los clientes que hayan pedido más de 3 tipos distintos de platillos.
-- Muestra el nombre y correo de los clientes que hayan ordenado más de 3 tipos distintos de platillos 
-- (items diferentes del menú, sin importar la cantidad de veces que los hayan pedido).

select name, email
from customers
where customer_id in (
	select customer_id
    from orders
    group by customer_id
    having count(distinct item_id) > 6
);

-- Encuentra los tres productos más vendidos (por cantidad) en el restaurante.
-- Muestra el nombre y precio de los tres productos más vendidos, ordenados por 
-- la cantidad total vendida (es decir, la suma de las cantidades pedidas por todos los clientes).

select m.item_name, sum(quantity) * price as total
from menu_items m
join orders o
	on m.item_id = o.item_id
group by item_name
order by total desc
limit 3;

-- Encuentra el nombre del cliente que ha realizado el pedido de mayor valor (cantidad * precio).
-- Muestra el nombre del cliente que ha realizado el pedido de mayor valor. El valor de cada pedido 
-- es la cantidad de ítems multiplicada por el precio de cada ítem.

select name
from customers
where customer_id = (
	select customer_id
    from orders o
    join menu_items m
		on o.item_id = m.item_id
	group by o.customer_id
	order by sum(o.quantity * m.price) desc
    limit 1
);

-- Encuentra los productos que no han sido pedidos por ningún cliente.
-- Muestra los nombres de los productos del menú que no han sido solicitados en ninguna orden. 
-- Esto es, aquellos productos que no aparecen en ninguna de las órdenes realizadas por los clientes.

select item_name
from menu_items 
where item_id not in (
	select item_id
    from orders
);

-- Clientes frecuentes
-- Objetivo: Encuentra a los clientes que han hecho más de 5 pedidos en total.
 with max_orders as(
				select customer_id, count(*) as total_orders
				from orders
				group by customer_id
                having count(*) > 5
)
select c.name, m.total_orders
from customers c
join max_orders m
	on c.customer_id = m.customer_id;


-- Productos más vendidos por categoría
-- Objetivo: Para cada categoría, muestra el producto más vendido por cantidad total.
WITH ventas_totales AS (
    SELECT m.item_id, m.item_name, m.category, SUM(o.quantity) AS total_vendida
    FROM menu_items m
    JOIN orders o ON m.item_id = o.item_id
    GROUP BY m.item_id, m.item_name, m.category
),
ranking AS (
    SELECT *, RANK() OVER (PARTITION BY category ORDER BY total_vendida DESC) AS rnk
    FROM ventas_totales
)
SELECT item_name, category, total_vendida
FROM ranking
WHERE rnk = 1;

-- Ingresos por cliente
-- Objetivo: Calcula cuánto ha gastado cada cliente en total, y muestra los que han gastado más de $500.
with t_amount as (
select o.customer_id, sum(quantity)* m.price as total_amount
from orders o
join menu_items m
	on o.item_id = m.item_id
group by o.customer_id
order by total_amount desc
)
SELECT c.name, c.email, t.total_amount
FROM t_amount t -- primero va la tabla cte
JOIN customers c ON t.customer_id = c.customer_id
WHERE t.total_amount > 500;

-- Primer platillo que ordenó cada cliente
-- Objetivo: Encuentra el primer platillo (item_name) que pidió cada cliente, mostrando también la fecha del pedido.
WITH ordenes_con_fecha AS (
    SELECT 
        o.customer_id,
        o.order_date,
        o.item_id,
        ROW_NUMBER() OVER (PARTITION BY o.customer_id ORDER BY o.order_date ASC, o.order_id ASC) AS orden_rank
    FROM orders o
)
SELECT 
    c.name AS cliente,
    m.item_name AS primer_platillo,
    ocd.order_date AS fecha_pedido
FROM ordenes_con_fecha ocd
JOIN customers c ON ocd.customer_id = c.customer_id
JOIN menu_items m ON ocd.item_id = m.item_id
WHERE ocd.orden_rank = 1;

--  Mes con más ingresos
-- Objetivo: Calcular los ingresos mensuales del restaurante y mostrar el mes con mayores ingresos.

select DATE_FORMAT(o.order_date, '%Y-%m') AS mes,
	sum(o.quantity * m.price) as total_amount
from orders o
join menu_items m
	on o.item_id = m.item_id
group by mes
order by mes asc;

--  Clientes que han ordenado más de 5 veces
-- Objetivo: Mostrar el nombre, correo y número total de órdenes de los clientes que han realizado más de 5 órdenes distintas en total.

select name, email
from customers
where customer_id in(
	select customer_id
    from orders
    group by customer_id
    having count(*) > 5    
);

select c.name, c.email, count(order_id) as total_ordenes
from customers c
join orders o
	on c.customer_id = o.customer_id
group by c.customer_id
having count(*) > 5;

-- Subconsulta
-- Objetivo: Obtener los nombres de los clientes que han ordenado el item "Hamburguesa Clásica" (item_id = 3).

select name, 'Hamburguesa Clásica' AS item_name
from customers
where customer_id in (
	select customer_id
    from orders o
    join menu_items mi
		on o.item_id = mi.item_id
	where mi.item_name = 'Hamburguesa Clásica'
);

-- CTE (Common Table Expression)
-- Objetivo: Usar un CTE para obtener los clientes que han gastado más de 
-- 500 pesos en total en sus órdenes. El resultado debe incluir el nombre del cliente y el monto total gastado.

with monto_gastado as(
	select o.customer_id,
		sum(o.quantity * mi.price) as gasto_cliente
    from orders o
    join menu_items mi 
		on o.item_id = mi.item_id
	group by o.customer_id
)
select c.name,
		g.gasto_cliente
from customers c
join monto_gastado g
	on c.customer_id = g.customer_id
where g.gasto_cliente > 500;

-- Joins
-- Objetivo: Obtener el nombre del cliente, el nombre del platillo y la 
-- cantidad de cada platillo que ha ordenado, solo para los pedidos realizados después del 1 de marzo de 2024.

select c.name, m.item_name, sum(o.quantity), o.order_date
from customers c
join orders o
	on c.customer_id = o.customer_id
join menu_items m
	on o.item_id = m.item_id
where o.order_date > '2024-03-01'
group by c.name, m.item_name;

-- Subconsulta
-- Objetivo: Obtener el nombre de los clientes que han pedido algún plato que tiene un precio mayor a 150 pesos.

select name
from customers
where customer_id in (
	select customer_id
    from orders o
	join menu_items m
		on o.item_id = m.item_id
	where m.price > 150
);

SELECT c.name, m.item_id, m.price
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN menu_items m ON o.item_id = m.item_id
WHERE m.price > 150;


-- CTE (Common Table Expression)
-- Objetivo: Crear un CTE que muestre los platillos más vendidos (por cantidad) y 
-- luego obtener los nombres de los clientes que pidieron esos platillos.

WITH TopSellingItems AS (
    SELECT o.item_id, SUM(o.quantity) AS total_quantity
    FROM orders o
    GROUP BY o.item_id
    ORDER BY total_quantity DESC
    LIMIT 3
)
SELECT c.name, m.item_name, tsi.total_quantity
FROM TopSellingItems tsi
JOIN menu_items m ON tsi.item_id = m.item_id
JOIN orders o ON o.item_id = m.item_id
JOIN customers c ON o.customer_id = c.customer_id;

-- Joins
-- Objetivo: Obtener el nombre del cliente, el nombre del platillo y 
-- la fecha del pedido, pero solo para aquellos clientes que han pedido un
-- platillo de la categoría "Plato Fuerte" en al menos dos ocasiones.

select c.name, m.item_name, o.order_date, m.category
from customers c
join orders o
	on c.customer_id = o.customer_id
join menu_items m
	on o.item_id = m.item_id
where m.category = 'Plato Fuerte'
group by c.name, m.item_name, o.order_date
having count(o.order_id) >= 2;

-- Subconsulta ajustada
-- Objetivo: Clientes que sí han pedido una "Entrada" y no han pedido un "Postre"

SELECT c.name
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM orders o
    JOIN menu_items m ON o.item_id = m.item_id
    WHERE o.customer_id = c.customer_id
    AND m.category = 'Entrada'
)
AND NOT EXISTS (
    SELECT 1
    FROM orders o
    JOIN menu_items m ON o.item_id = m.item_id
    WHERE o.customer_id = c.customer_id
    AND m.category = 'Postre'
);

--  CTE 
-- Objetivo: Clientes que han hecho pedidos en al menos 3 meses diferentes del 2024, junto con la cantidad total de pedidos.
WITH monthly_orders AS (
    SELECT customer_id, MONTH(order_date) AS month
    FROM orders
    WHERE YEAR(order_date) = 2024
    GROUP BY customer_id, MONTH(order_date)
)
SELECT c.name, COUNT(DISTINCT mo.month) AS active_months
FROM customers c
JOIN monthly_orders mo ON c.customer_id = mo.customer_id
GROUP BY c.customer_id
HAVING active_months >= 3;

-- Join
-- Ver el total de platillos pedidos por cada cliente, 
-- ordenado por mayor cantidad, pero filtrando para que solo aparezcan los que pidieron más de 2 unidades de algún platillo.

select c.name, m.item_name, sum(o.quantity) as total_quantity
from customers c
join orders o
	on c.customer_id = o.customer_id
join menu_items m
	on o.item_id = m.item_id
group by c.name, m.item_name
having count(o.quantity) > 2
order by total_quantity;


