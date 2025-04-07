use pacientes;

CREATE TABLE patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    age INT,
    gender CHAR(1),
    diagnosis VARCHAR(100)
);

INSERT INTO patients (first_name, last_name, age, gender, diagnosis)
VALUES 
    ('John', 'Doe', 30, 'M', 'Flu'),
    ('Jane', 'Smith', 45, 'F', 'Cold'),
    ('Alice', 'Johnson', 25, 'F', 'Headache'),
    ('Bob', 'Williams', 60, 'M', 'Hypertension'),
    ('Eve', 'Davis', 35, 'F', 'Asthma');
    
INSERT INTO patients (first_name, last_name, age, gender, diagnosis)
VALUES 
    ('John', 'Doe', 30, 'M', 'VIH'),
    ('Jane', 'Smith', 45, 'F', 'Covid'),
    ('Juana', 'Johnson', 25, 'F', 'Headache');

INSERT INTO patients (first_name, last_name, age, gender, diagnosis)
VALUES 
    ('Juan', 'Doe', 30, 'M', 'Colera'),
    ('Luis', 'Smith', 45, 'F', 'Covid19'),
    ('Juana', 'Johnson', 25, 'F', 'Stomache');

CREATE TABLE doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    specialty VARCHAR(50)
);

INSERT INTO doctors (first_name, last_name, specialty)
VALUES 
    ('Dr. Mike', 'Johnson', 'Cardiology'),
    ('Dr. Sarah', 'Miller', 'Neurology'),
    ('Dr. James', 'Williams', 'Pediatrics');

CREATE TABLE appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    appointment_date DATE,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);

INSERT INTO appointments (patient_id, doctor_id, appointment_date)
VALUES 
    (1, 1, '2024-01-01'),
    (2, 2, '2024-02-15'),
    (3, 1, '2024-03-10'),
    (4, 3, '2024-03-20'),
    (5, 2, '2024-04-05'),
    (1, 3, '2024-04-10');
