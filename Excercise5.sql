-- Case Statements
-- Un case nos funciona para evaluar las declaraciones hechas en un WHEN
select nombre, apellido, edad,
case
	when edad <= 30 then 'young'
    when edad between 31 and 50 then 'Old'
    when edad >= 50 then 'On death`s door'
end as Age_Bracket
from vendedor;

-- Este query va a traer los niveles de morosidad de cada cliente
-- Si su saldo de morosidad esta entre 10k-19k es 'aceptable'
-- Si su saldo de morosidad esta entre 20k-29k es 'advertencia'
-- Si su saldo de morosidad es es mayor a 30k 'riesgo'

select nombre, saldo,
case
	when saldo between 10000 and 19000 then 'aceptable'
    when saldo between 20000 and 29000 then 'advertencia'
    when saldo >= 30000 then 'riesgo'
    when saldo <= 10000 then 'sin riesgo'
end as morosidad
from morosos;