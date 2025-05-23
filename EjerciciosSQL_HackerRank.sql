-- Vamos a usar SUBCONSULTAS cuando necesito obtener datos adicionales para usar 
-- en la consulta principal
-- Filtremos con un calculo previo:
-- Si necesitamos encontrar registros basados con un valor agregado
--		min, max, avg -> dentro de un where
SELECT * FROM STATION
WHERE LAT_N = (SELECT MIN(LAT_N) FROM STATION);

--	Comparar valores en la misma table:
--		Cuando necesite comprar filas dentro de la misma table
--		Ej: Obtener estaciones cuya latitude es mayor que el promedio
--		de todas las estaciones
SELECT * FROM STATION
WHERE LAT_N > (SELECT AVG(LAT_N) FROM STATION);

--	Usar datos de otra table
--		Si quiero hacer una consulta en una table basada en valores de otra
--		sin usar JOIN.
--		Ej: Obtener empleados cuyo salario es mayor que el promedio de la
--		table salaries
SELECT * FROM EMPLEADOS
WHERE SALARIO > (SELECT AVG(SALARIO) FROM SALARIOS);

--	Evitar JOIN cuando necesito solo un valor 
--		Si necesito un solo valor de otra table y no quiero un JOIN
--		Ej: Obtener el nombre del empleado con el salario más alto
SELECT NOMBRE 
FROM EMPLEADOS
WHERE SALARIO = (SELECT MAX(SALARIO) FROM EMPLEADOS);





-- Query the total population of all cities in CITY where District is California.

select sum(population)
from city
where district = 'California';

-- Query the average population of all cities in CITY where District is California.

select avg(population)
from city 
where district = 'California';

-- Query the average population for all cities in CITY, rounded down to the nearest integer.

select floor(avg(population))
from city;

-- Query the sum of the populations for all Japanese cities in CITY. The COUNTRYCODE for Japan is JPN.

select sum(population)
from city
where countrycode = 'JPN';

-- Query the difference between the maximum and minimum populations in CITY.

select max(population) - min(population)
from city;


-- Samantha was tasked with calculating the average monthly salaries for all employees in the
-- EMPLOYEES table, but did not realize her keyboard's  key was broken until after completing
-- the calculation. She wants your help finding the difference between her miscalculation
-- (using salaries with any zeros removed), and the actual average salary.

-- Write a query calculating the amount of error (i.e.:  average monthly salaries), and round
-- it up to the next integer.

SELECT CEIL(ABS(AVG(salary) - AVG(CAST(REPLACE(CAST(salary AS CHAR), '0', '') AS UNSIGNED))))
AS error_amount
FROM EMPLOYEES;

-- We define an employee's total earnings to be their monthly  worked, and the maximum total
-- earnings to be the maximum total earnings for any employee in the Employee table. Write a
-- query to find the maximum total earnings for all employees as well as the total number of
-- employees who have maximum total earnings. Then print these values as  space-separated integers

SELECT (Salary * Months) as Earnings, Count(*)
FROM Employee 
GROUP BY Earnings 
ORDER BY Earnings DESC LIMIT 1;

-- Query the following two values from the STATION table:

-- The sum of all values in LAT_N rounded to a scale of  decimal places.
-- The sum of all values in LONG_W rounded to a scale of  decimal places.

SELECT 
    ROUND(SUM(lat_n), 2) as lat_sum,
    ROUND(SUM(long_w), 2) as long_sum
FROM station;

-- Query the sum of Northern Latitudes (LAT_N) from STATION having values greater than  and less than.
-- Truncate your answer to  decimal places.

select round(sum(lat_n), 4) as sum_lat
from station
where lat_n > 38.7880 and lat_n < 137.2345;

-- Query the greatest value of the Northern Latitudes (LAT_N) from STATION that is less than.
-- Truncate your answer to  decimal places.

select max(round(lat_n,4))
from station
where lat_n < 137.2345;

-- Query the smallest Northern Latitude (LAT_N) from STATION that is greater than.
-- Round your answer to  decimal places.

select min(round(lat_n,4))
from station
where lat_n > 38.7780;

-- Consider p1(a,b) and p2(c,d) to be two points on a 2D plane. a happens to equal the minimum
-- value in Northern Latitude (LAT_N in STATION). b happens to equal the minimum value in
-- Western Longitude (LONG_W in STATION). c happens to equal the maximum value in Northern
-- Latitude (LAT_N in STATION). d happens to equal the maximum value in Western Longitude
-- (LONG_W in STATION). Query the Manhattan Distance between points p1 and p2 and round it to a
-- scale of decimal places.

select round(abs(max(lat_n) - min(lat_n)) + abs(max(long_w) - min(long_w)),4)
from station;

-- Consider p1(a,c) and p2(b,d) to be two points on a 2D plane where (a,b) are the respective minimum 
-- and maximum values of Northern Latitude (LAT_N) and (c,d) are the respective minimum and maximum values
-- of Western Longitude (LONG_W) in STATION. 
-- Query the Euclidean Distance between points p1 and p2 and format your answer to display 4 decimal digits.

select round(sqrt(power(min(lat_n)-max(lat_n),2) + power(min(long_w)-max(long_w),2)),4)
from station;