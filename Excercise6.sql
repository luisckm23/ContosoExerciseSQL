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

 select id_venta, pago,
	(select round(avg(pago), 2)
    from pagos)
from pagos;
 