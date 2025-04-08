use tienda_chatgpt;

#Ejercicio 1. Joins
# Objetivo: Obtener el nombre completo del cliente, el nombre del producto, la cantidad comprada y la fecha del pedido.

select concat(c.first_name, ' ', c.last_name) as full_name, p.product_name, sum(o.quantity) as quantity_per_product, o.order_date
from customers c
join orders o
	on c.customer_id = o.customer_id
join products p
	on o.product_id = p.product_id
group by full_name, p.product_name
order by full_name, quantity_per_product desc;

#Ejercicio 2: CTE (Common Table Expression)
#Objetivo: Usar una CTE para calcular cuántos pedidos ha realizado cada cliente y mostrar solo aquellos que han hecho más de 3.
-- Dentro del WITH va una parte del cálculo
-- Fuera del WITH unomos la tabla temporal con la que vamos a unir

with order_x_cliente as (
	select customer_id, count(*) as total_quantity
    from orders
    group by customer_id
    
)
select c.first_name, c.last_name, oc.total_quantity, c.city
from order_x_cliente oc
join customers c
	on c.customer_id = oc.customer_id
where oc.total_quantity > 3;

# Ejercicio 3: SUBQUERY
# Objetivo: Obtener todos los productos cuyo precio es mayor que el precio promedio de todos los productos.


select  product_name, price
from products
where price > (
	select round(avg(price), 2) as avg_price
	from products
);

-- JOINS (con condición y alias)
-- Objetivo: Listar los productos que han sido vendidos al menos una vez, junto con la cantidad total vendida de cada uno.

select o.product_id, p.product_name, o.quantity, sum(o.quantity) as total_sale_per_product
from orders o
join products p
	on o.product_id = p.product_id
where o.quantity > 1
group by p.product_name
limit 5;

-- Ejercicio 5: CTE con cálculo de porcentajes
-- Objetivo: Calcular el porcentaje que representa cada cliente respecto al total de órdenes del sistema

with total_orders as(
	select count(*) as total
    from orders
), orders_by_customers as(
	select customer_id , count(*) as num_orders
    from orders
    group by customer_id
)
select c.first_name,
    c.last_name,
    oc.num_orders,
    ROUND((oc.num_orders / t.total) * 100, 2) AS porcentaje
from orders_by_customers oc
join customers c
	on oc.customer_id = c.customer_id
join total_orders t
order by porcentaje desc;


-- Ejercicio 6: SUBQUERY correlacionada
-- Objetivo: Mostrar los clientes que hayan comprado productos más caros que el promedio de precio
-- de los productos que ellos mismos han comprado

select distinct c.first_name, c.last_name
from customers c
join orders o
	on c.customer_id = o.customer_id
join products p
	on o.product_id = p.product_id
where p.price > (
	select avg(p2.price)
    from orders o2
    join products p2
		on o2.product_id = p2.product_id
	where o2.customer_id = c.customer_id
);