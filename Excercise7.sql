-- Window FUNCTIONS
-- Las Window Functions no agrupan registros, sino que realizan cálculos sobre un conjunto de filas relacionado con cada fila individual, 
-- sin perder detalles de los datos, a diferencia de GROUP BY, que agrupa y reduce el número de filas en el resultado.
-- Las WINDOW Funtion pueden ser como un FOR, recorren cada fila y hacen el calculo,
-- mientras un GROUP BY primero agrupa las filas y después hace el calculo
use db_practicas;
-- en este caso la funcion WINDOW nos sive para particionar el promedio de pago de cada una de las Clasificacion_credito
select cl.Nombre, cl.Clasificacion_credito, avg(mo.Pago) over(partition by cl.Clasificacion_credito)
from clientes cl
join morosos mo
	on cl.Nombre = mo.Nombre; 
    
-- en este caso la funcion WINDOW nos sive para particionar la suma de pago de cada una de las Clasificación_credito
select cl.Nombre, cl.Clasificacion_credito, sum(mo.Pago) over(partition by cl.Clasificacion_credito)
from clientes cl
join morosos mo
	on cl.Nombre = mo.Nombre; 

-- este query lo usamos con un row_number para asignar un ranking de cada particion que hicimos sobre Clasificacion_credito y 
-- ordenamos ese ranking por saldo de cada Clasificacion_credito de manera descendente 
-- tambien agregamos un rank, con el que si existe algun dato con el mismo valor le da el mismo ranking y salta al siguiente valor
-- posicional; es decir que si tenemos dos valores con 4000, los rankea hipoteticamente como 5 a los dos y el siguiente lugar en el 
-- ranking será 7
-- finalmente usamos un dense rank con el que contrario a rank, si hay dos registros con el mismo valor, los rankea con el mismo valor númerico 
-- y no con el posicional; es decir si tenemos dos valores con 4000, los rankea a los dos con 5 y el siguiente registro se rankea con 6

select cl.Nombre, cl.Clasificacion_credito, saldo,
row_number() over(partition by cl.Clasificacion_credito order by saldo desc) as row_num,
rank() over(partition by cl.Clasificacion_credito order by saldo desc) as rank_num,
dense_rank() over(partition by cl.Clasificacion_credito order by saldo desc) as dense_rank_num
from clientes cl
join morosos mo
	on cl.Nombre = mo.Nombre; 
    