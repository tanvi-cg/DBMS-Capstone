-- Hospital Management System: complete sample data recovered from screenshots
-- Run after 01_Database_and_Tables.sql on a fresh database only.
-- Fictional academic demonstration records.
USE hospital_management;

INSERT INTO Departments (department_name, location, contact_number) VALUES
('Cardiology', 'Floor 1', '9876543210'),
('Neurology', 'Floor 2', '9876543211'),
('Orthopedics', 'Floor 3', '9876543212'),
('Pediatrics', 'Floor 4', '9876543213'),
('General Medicine', 'Floor 5', '9876543214');

INSERT INTO Patients (first_name, last_name, age, gender, phone, address) VALUES
('Aarav', 'Sharma', 24, 'Male', '9876543210', 'Delhi'),
('Priya', 'Verma', 28, 'Female', '9876543211', 'Noida'),
('Rahul', 'Singh', 35, 'Male', '9876543212', 'Gurgaon'),
('Ananya', 'Gupta', 22, 'Female', '9876543213', 'Delhi'),
('Rohan', 'Mehta', 30, 'Male', '9876543214', 'Noida'),
('Ishita', 'Kapoor', 26, 'Female', '9876543215', 'Greater Noida'),
('Arjun', 'Malik', 40, 'Male', '9876543216', 'Delhi');

INSERT INTO Doctors
(first_name, last_name, specialization, phone, email, consultation_fee, department_id) VALUES
('Amit', 'Kapoor', 'Cardiologist', '9811111111', 'amit@hospital.com', 800, 1),
('Neha', 'Sharma', 'Neurologist', '9822222222', 'neha@hospital.com', 900, 2),
('Raj', 'Malhotra', 'Orthopedic Surgeon', '9833333333', 'raj@hospital.com', 1000, 3),
('Simran', 'Rao', 'Pediatrician', '9844444444', 'simran@hospital.com', 700, 4),
('Karan', 'Mehta', 'Cardiac Surgeon', '9855555555', 'karan@hospital.com', 1500, 1);

INSERT INTO Beds (department_id, bed_number, bed_status) VALUES
(1, 'C101', 'Occupied'),
(1, 'C102', 'Available'),
(2, 'N101', 'Occupied'),
(2, 'N102', 'Available'),
(3, 'O101', 'Occupied'),
(3, 'O102', 'Available'),
(4, 'P101', 'Occupied'),
(5, 'G101', 'Available');

INSERT INTO Appointments
(patient_id, doctor_id, appointment_date, reason, status) VALUES
(1, 1, '2026-11-08 10:00:00', 'Heart checkup', 'Scheduled'),
(2, 2, '2026-11-08 11:00:00', 'Migraine consultation', 'Scheduled'),
(3, 3, '2026-11-09 12:00:00', 'Bone fracture', 'Completed'),
(4, 4, '2026-11-09 14:00:00', 'Child health checkup', 'Scheduled'),
(5, 5, '2026-11-10 10:00:00', 'Cardiac consultation', 'Scheduled'),
(6, 2, '2026-11-10 12:00:00', 'Neurological checkup', 'Scheduled'),
(7, 3, '2026-11-11 15:00:00', 'Joint pain', 'Scheduled');

INSERT INTO Medical_History
(patient_id, diagnosis, diagnosis_date, allergies, medical_notes) VALUES
(1, 'Heart condition', '2026-10-15', 'None', 'Regular monitoring'),
(2, 'Migraine', '2026-10-18', 'Dust', 'Recurring headaches'),
(3, 'Bone fracture', '2026-10-20', 'None', 'Under observation'),
(4, 'Seasonal infection', '2026-10-22', 'Pollen', 'Medication prescribed'),
(5, 'High blood pressure', '2026-10-25', 'None', 'BP monitoring'),
(6, 'Vitamin deficiency', '2026-10-26', 'None', 'Dietary advice'),
(7, 'Joint inflammation', '2026-10-27', 'None', 'Physiotherapy advised');

INSERT INTO Admissions
(patient_id, department_id, bed_id, attending_doctor, admission_date, discharge_date) VALUES
(1, 1, 1, 1, '2026-11-01', NULL),
(2, 2, 3, 2, '2026-11-02', NULL),
(3, 3, 5, 3, '2026-10-20', '2026-10-25'),
(4, 4, 7, 4, '2026-11-03', NULL),
(5, 1, 2, 5, '2026-10-10', '2026-10-15'),
(6, 2, 4, 2, '2026-10-15', '2026-10-20');

INSERT INTO Treatments
(patient_id, doctor_id, treatment_description, treatment_date) VALUES
(1, 1, 'Cardiac monitoring', '2026-11-01'),
(2, 2, 'Neurological assessment', '2026-11-02'),
(3, 3, 'Fracture treatment', '2026-10-21'),
(4, 4, 'Infection management', '2026-11-03'),
(5, 5, 'Blood pressure monitoring', '2026-10-11'),
(6, 2, 'Vitamin deficiency treatment', '2026-10-16'),
(7, 3, 'Physiotherapy', '2026-10-28');

INSERT INTO Surgeries
(patient_id, surgeon_id, department_id, surgery_name, surgery_datetime, status) VALUES
(1, 5, 1, 'Cardiac Surgery', '2026-11-12 09:00:00', 'Scheduled'),
(3, 3, 3, 'Bone Surgery', '2026-10-23 10:00:00', 'Completed'),
(5, 5, 1, 'Heart Surgery', '2026-11-14 11:00:00', 'Scheduled'),
(7, 3, 3, 'Joint Surgery', '2026-11-16 12:00:00', 'Scheduled');

INSERT INTO Transfers
(patient_id, from_department, to_department, transfer_date) VALUES
(1, 5, 1, '2026-11-02 10:00:00'),
(3, 3, 5, '2026-10-22 12:00:00'),
(4, 5, 4, '2026-11-04 11:00:00'),
(6, 2, 5, '2026-10-17 14:00:00');

INSERT INTO Billing
(patient_id, appointment_id, total_amount, payment_date, payment_method, payment_status) VALUES
(1, 1, 5000, '2026-11-01', 'UPI', 'Paid'),
(2, 2, 2500, '2026-11-02', 'Card', 'Paid'),
(3, 3, 8000, '2026-10-25', 'Cash', 'Paid'),
(4, 4, 1500, NULL, 'UPI', 'Pending'),
(5, 5, 3500, NULL, 'Card', 'Pending'),
(6, 6, 2000, '2026-10-20', 'UPI', 'Paid'),
(7, 7, 3000, NULL, 'Cash', 'Pending');

-- Additional readmission inserted later during the window-function work.
INSERT INTO Admissions
(patient_id, department_id, bed_id, attending_doctor, admission_date, discharge_date)
VALUES (3, 3, 6, 3, '2026-11-05', NULL);
