-- Hospital Management System: database and table definitions
-- Run only on a fresh MySQL instance/database. This does not need to be rerun
-- on the existing hospital_management database.
CREATE DATABASE IF NOT EXISTS hospital_management;
USE hospital_management;

CREATE TABLE Patients (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50),
    age INT,
    gender VARCHAR(10),
    phone VARCHAR(15),
    address VARCHAR(255)
);

CREATE TABLE Departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(100) NOT NULL,
    location VARCHAR(100),
    contact_number VARCHAR(15)
);

CREATE TABLE Doctors (
    doctor_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50),
    specialization VARCHAR(100),
    phone VARCHAR(15),
    email VARCHAR(100),
    consultation_fee DECIMAL(10,2)
);

CREATE TABLE Appointments (
    appointment_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATETIME NOT NULL,
    reason VARCHAR(255),
    status VARCHAR(30) DEFAULT 'Scheduled',
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

CREATE TABLE Billing (
    bill_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    appointment_id INT,
    total_amount DECIMAL(10,2) NOT NULL,
    payment_date DATE,
    payment_method VARCHAR(30),
    payment_status VARCHAR(30) DEFAULT 'Pending',
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id)
);

CREATE TABLE Medical_History (
    history_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    diagnosis VARCHAR(255) NOT NULL,
    diagnosis_date DATE,
    allergies VARCHAR(255),
    medical_notes TEXT,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
);

CREATE TABLE Beds (
    bed_id INT PRIMARY KEY AUTO_INCREMENT,
    department_id INT NOT NULL,
    bed_number VARCHAR(20) NOT NULL,
    bed_status VARCHAR(20) DEFAULT 'Available',
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

-- The original Doctors table was created first, then linked to Departments.
ALTER TABLE Doctors
ADD department_id INT,
ADD FOREIGN KEY (department_id) REFERENCES Departments(department_id);

CREATE TABLE Admissions (
    admission_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    department_id INT NOT NULL,
    bed_id INT NOT NULL,
    attending_doctor INT NOT NULL,
    admission_date DATE NOT NULL,
    discharge_date DATE,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (department_id) REFERENCES Departments(department_id),
    FOREIGN KEY (bed_id) REFERENCES Beds(bed_id),
    FOREIGN KEY (attending_doctor) REFERENCES Doctors(doctor_id)
);

CREATE TABLE Treatments (
    treatment_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    treatment_description VARCHAR(255),
    treatment_date DATE,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

CREATE TABLE Surgeries (
    surgery_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    surgeon_id INT NOT NULL,
    department_id INT NOT NULL,
    surgery_name VARCHAR(150),
    surgery_datetime DATETIME,
    status VARCHAR(30) DEFAULT 'Scheduled',
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (surgeon_id) REFERENCES Doctors(doctor_id),
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

CREATE TABLE Transfers (
    transfer_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    from_department INT NOT NULL,
    to_department INT NOT NULL,
    transfer_date DATETIME,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (from_department) REFERENCES Departments(department_id),
    FOREIGN KEY (to_department) REFERENCES Departments(department_id)
);
