use db_practicas;
-- Union nos funciona para literalmente unir dos tablas, sin embargo a diferencia de un JOIN 
-- aquí no despliega las tablas de manera que estén una junto de la otra
-- si no, que simplemente pone una sobre la otra cuando se ejecuta el query

select Nombre, Pais
from clientes
UNION
select Nombre, Edad
from vendedor;

-- En este query traemos todas las personas que tienen un saldo mayor a 30,000 y los marcamos como 'Deudores' con un alias
select saldo, 'Deudor' as Moroso
from morosos
where saldo > 30000
order by saldo desc;

-- String Functions

select nombre, length(nombre)
from clientes
order by 2;

select nombre, upper(nombre)
from clientes
order by 2;

select nombre, lower(nombre)
from clientes
order by 2;

select '      sky        ' as trim;
select trim('      sky        ') as trim;
select ltrim('      sky        ') as left_trim;
select rtrim('      sky        ') as reight_trim;

select nombre, 
substr(nombre, 3,2),
left(nombre,3),
right(nombre, 3)
from clientes;

select nombre, replace(nombre, 'e','y')
from clientes;

select nombre, locate('A', nombre)
from clientes;

select nombre, apellido, concat(nombre, ' ', apellido)
from vendedor;