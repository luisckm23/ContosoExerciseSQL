-- Subqueries
-- Estos nos sirven para crear tablas temporales
-- Podemos usarlos para filtrar los resultados principales de la consulta en un WHERE IN ()
-- También podemos usarlo en SELECT para calcular valores adicionales en la consulta principal
-- Y hacer un subquery dentro de FROM nos sirve para que el resultado funcione como una tabla temporal 

use db_practicas;

-- Subqueries en WHERE
select *
from producto
where id_producto in (
	select id_producto
    from ventas 
    where id_cliente = 1
);

select *
from morosos
where nombre in (
	select nombre
	from clientes
	where id_cliente = 8
);

select *
from clientes
where id_cliente = 8;

select *
from ventas
where id_producto in (
	select id_producto
    from producto
    where Producto = 'Terreno'
);

select*
from producto;


-- Subqueries en SELECT
-- Un subquery en la cláusula SELECT también puede utilizarse para comparar una columna consigo misma aplicando una función de agregación.
 select id_venta, pago,
	(select round(avg(pago), 2)
    from pagos)
from pagos;
 
 select id_cliente, venta,
	(select avg(venta)
    from ventas)
 from ventas;
 
 -- Subqueries en FROM
 -- se usa para crear una tabla temporal que puede ser consultada en la consulta principal
 -- podemos hacer calculos un poco más complejos
 select *
 from (
 select 
 avg(venta) as avg_venta, 
 max(pago) as max_pago,
 min(saldo) as min_saldo
 from morosos
 ) as agg_table;
 
 
 