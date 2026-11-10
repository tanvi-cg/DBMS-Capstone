USE hospital_management;

-- Composite index for admission lookups
CREATE INDEX idx_admission_patient_date
ON Admissions (patient_id, admission_date);

-- Composite index for doctor appointment searches
-- Note: this database schema uses appointment_date (DATETIME).
CREATE INDEX idx_appointment_doctor_date
ON Appointments (doctor_id, appointment_date);

-- Covering index for admission reports
CREATE INDEX idx_admission_report
ON Admissions (admission_date, patient_id, discharge_date);

-- Covering index for appointment reports
CREATE INDEX idx_appointment_report
ON Appointments (doctor_id, appointment_date, status);

-- Inspect index definitions
SHOW INDEX FROM Admissions;
SHOW INDEX FROM Appointments;

-- Inspect an appointment query plan
EXPLAIN
SELECT appointment_id, doctor_id, appointment_date, status
FROM Appointments
WHERE doctor_id = 1;

-- Inspect an admission query plan
EXPLAIN
SELECT patient_id, admission_date, discharge_date
FROM Admissions
WHERE patient_id = 1
ORDER BY admission_date;
