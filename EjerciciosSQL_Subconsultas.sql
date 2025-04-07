use pacientes;

# Ejercicios de subconsultas
--  Encontrar los pacientes con edades mayores que el promedio de edad de todos los pacientes.

select first_name, last_name, age
from patients
where age > (
	select avg(age) as avg_age
    from patients
);

-- Mostrar los pacientes que han tenido citas con un doctor cuyo nombre contiene "Mike".
 select first_name, last_name
 from patients
 where patient_id in (
	select patient_id
    from appointments a
    join doctors d on a.doctor_id = d.doctor_id
    where d.first_name like '%Mike%'
 );

 -- Encontrar el doctor que más citas ha atendido.
 SELECT doctor_id, COUNT(*) AS total_appointments
FROM appointments
GROUP BY doctor_id
HAVING COUNT(*) = (
    SELECT MAX(appointment_count)
    FROM (
        SELECT doctor_id, COUNT(*) AS appointment_count
        FROM appointments
        GROUP BY doctor_id
    ) AS doctor_appointments
);

-- Mostrar el nombre de los pacientes que han tenido citas después del 1 de marzo de 2024.
select first_name, last_name
from patients
where patient_id in (
	select patient_id
    from appointments
    where appointment_date > 2024-03-01
);
 
 -- Listar los doctores que han atendido a pacientes con diagnóstico de "Flu" o "Cold".
 select first_name, last_name
 from doctors
 where doctor_id in(
	select doctor_id
    from appointments ap
    join patients pa
		on ap.patient_id = pa.patient_id
    where diagnosis = 'Flu' or diagnosis = 'Cold'
 );

-- Encontrar los pacientes que han tenido citas con doctores que tienen una especialidad en "Neurology".
select first_name, last_name
from patients
where patient_id in (
	select patient_id
    from appointments ap
    join doctors doc 
		on ap.doctor_id = doc.doctor_id
	where specialty = 'Neurology'   
);

select concat(doc.first_name,' ' ,doc.last_name) as doc_name, pa.patient_id, concat(pa.first_name,' ',pa.last_name)
from doctors doc
join appointments ap
	on doc.doctor_id = ap.doctor_id
join patients pa
	on ap.patient_id = pa.patient_id
where specialty = 'Neurology';

-- Mostrar el nombre y apellido del doctor que ha atendido el paciente con el patient_id 4.
select concat(first_name, ' ', last_name) as full_name
from doctors
where doctor_id in (
	select doctor_id
    from appointments ap
    join patients pa
		on ap.patient_id = pa.patient_id
	where pa.patient_id = 4
);

-- Encontrar los pacientes que han tenido citas antes del 1 de abril de 2024 y 
-- tienen una edad mayor que el promedio de edad de todos los pacientes.
select first_name, last_name
from patients 
where age > (select avg(age) from patients)
	and patient_id in(
		select patient_id
        from appointments
        where appointment_date < '2024-04-01'
    );

-- Mostrar los doctores que han atendido al menos a un paciente que tiene "Headache" como diagnóstico.
select first_name, last_name
from doctors
where doctor_id in (
	select doctor_id
    from appointments ap
    join patients pa
		on ap.patient_id = pa.patient_id
	where diagnosis = 'Headache'
);

select d.first_name, d.last_name
from doctors d
join appointments a
	on d.doctor_id = a.doctor_id
join patients p
	on a.patient_id = p.patient_id
where diagnosis = 'Headache';

--  Mostrar los pacientes que han tenido citas después del 1 de febrero de 2024 y
-- tienen una edad mayor que el promedio de edad de los pacientes con diagnóstico "Flu".
select first_name, last_name
from patients
where age > (select avg(age) from patients where diagnosis = 'Flu')
and patient_id in(
	select patient_id
    from appointments
    where appointment_date > '2024-02-01'
);

-- Mostrar los pacientes que tienen una edad menor que el promedio de edad de los pacientes con diagnóstico "Asthma"
-- y han tenido citas con doctores cuya especialidad es "Cardiology".
select first_name, last_name
from patients
where age < ( select avg(age) from patients where diagnosis = 'Asthma') 
and patient_id in(
	select patient_id
    from appointments a
    join doctors d
		on a.doctor_id = d.doctor_id
	where specialty = 'Cardiology'
);

-- Pacientes con más de una cita y con edad mayor al paciente más joven
-- Mostrar el nombre, apellido y edad de los pacientes que tienen más de una cita
-- y cuya edad es mayor que la edad del paciente más joven
select first_name, last_name, age
from patients
where age > (
	select min(age) from patients
)and patient_id in (
	select patient_id
    from appointments
    group by patient_id
    having count(*) > 1
);

-- Doctores que han atendido a todos los pacientes con diagnóstico “Cold”
-- Mostrar el nombre de los doctores que han atendido a todos los pacientes con diagnóstico 'Cold'.
select first_name, last_name
from doctors
where doctor_id in(
	select doctor_id
    from appointments a
    join patients p
		on a.patient_id = p.patient_id
	where diagnosis = 'Cold'
);

-- Mostrar al paciente más joven que ha tenido una cita con el doctor que más pacientes ha atendido
-- Mostrar el nombre, apellido y edad del paciente más joven que tuvo cita con el doctor más popular (el que más pacientes únicos atendió).
SELECT p.first_name, p.last_name, p.age
FROM patients p
WHERE patient_id IN (
    SELECT a.patient_id
    FROM appointments a
    WHERE doctor_id = (
        SELECT doctor_id
        FROM (
            SELECT doctor_id, COUNT(DISTINCT patient_id) AS total
            FROM appointments
            GROUP BY doctor_id
            ORDER BY total DESC
            LIMIT 1
        ) AS most_popular
    )
)
ORDER BY age ASC
LIMIT 1;

-- Encontrar doctores que han atendido a pacientes con más de un diagnóstico diferente
-- Mostrar el nombre, apellido y especialidad de los doctores que han atendido a pacientes que tienen más de un diagnóstico distinto registrado

select first_name, last_name, specialty
from doctors
where doctor_id in (
	select doctor_id
    from appointments ap
    join patients pa
		on ap.patient_id = pa.patient_id
	group by doctor_id
	having count(distinct diagnosis) > 1
);

SELECT DISTINCT d.first_name, d.last_name, d.specialty
FROM doctors d
JOIN appointments a ON d.doctor_id = a.doctor_id
WHERE a.patient_id IN (
    SELECT patient_id
    FROM patients
    GROUP BY patient_id
    HAVING COUNT(DISTINCT diagnosis) > 1
);

-- Mostrar a los pacientes que nunca han tenido una cita
-- Mostrar el patient_id, first_name, y last_name de los pacientes que no aparecen en la tabla de citas (appointments).
select patient_id, first_name, last_name
from patients
where patient_id not in(
	select distinct patient_id
    from appointments
);

-- Mostrar el doctor con el mayor número de citas realizadas
-- Objetivo: Mostrar el doctor_id, first_name, last_name y la cantidad de citas del doctor que ha atendido más consultas.
select doctor_id, first_name, last_name
from ( 
	select d.doctor_id, d.first_name, d.last_name, count(*) as total_appointments
    from doctors d
    join appointments a
		on d.doctor_id = a.doctor_id
	group by d.doctor_id, d.first_name, d.last_name
    order by total_appointments
) as top_doctors;

select d.doctor_id, d.first_name, d.last_name, count(a.appointment_id)
from doctors d
join appointments a
	on d.doctor_id = a.doctor_id
group by d.doctor_id, d.first_name, d.last_name;

-- Mostrar pacientes que han tenido citas con más de un doctor diferente
-- Mostrar patient_id, first_name, y last_name de los pacientes que han sido atendidos por más de un doctor distinto.
select p.patient_id, p.first_name, p.last_name
from patients p
join appointments a
	on p.patient_id = a.patient_id
group by p.patient_id, p.first_name, p.last_name
having count(distinct a.doctor_id) > 1;

-- Pacientes atendidos por más de un doctor
-- Muestra el patient_id, first_name, y last_name de los pacientes que han tenido citas con más de un doctor diferente.

select p.patient_id, p.first_name, p.last_name
from patients p
join appointments a
	on p.patient_id = a.patient_id
group by p.patient_id, p.first_name, p.last_name
having count(a.appointment_id) > 1;

-- Doctores que no han atendido a ningún paciente
-- Muestra el doctor_id, first_name, y last_name de los doctores que no han tenido ninguna cita registrada.
select d.doctor_id, d.first_name, d.last_name
from doctors d
left join appointments a
	on d.doctor_id = a.doctor_id
where a.appointment_id is null;

-- Última cita por paciente
-- Para cada paciente que ha tenido al menos una cita, muestra su patient_id, first_name, last_name, y la fecha de su cita más reciente.
select p.patient_id, p.first_name, p.last_name, max(a.appointment_date)
from patients p
join appointments a
	on p.patient_id = a.patient_id
group by patient_id, first_name, last_name;
