USE hospital_management;

-- 1. Display all patients
SELECT * FROM Patients;

-- 2. Doctors with their departments
SELECT
    d.doctor_id,
    CONCAT(d.first_name, ' ', d.last_name) AS doctor_name,
    d.specialization,
    dep.department_name
FROM Doctors d
JOIN Departments dep ON d.department_id = dep.department_id;

-- 3. Current inpatients
SELECT
    a.admission_id,
    p.patient_id,
    CONCAT(p.first_name, ' ', p.last_name) AS patient_name,
    dep.department_name,
    a.admission_date
FROM Admissions a
JOIN Patients p ON a.patient_id = p.patient_id
JOIN Departments dep ON a.department_id = dep.department_id
WHERE a.discharge_date IS NULL;

-- 4. Patient medical history
SELECT
    p.patient_id,
    CONCAT(p.first_name, ' ', p.last_name) AS patient_name,
    mh.diagnosis,
    mh.diagnosis_date,
    mh.allergies,
    mh.medical_notes
FROM Patients p
JOIN Medical_History mh ON p.patient_id = mh.patient_id;

-- 5. Current patient count by department
SELECT
    dep.department_name,
    COUNT(a.admission_id) AS current_patient_count
FROM Departments dep
LEFT JOIN Admissions a
    ON dep.department_id = a.department_id
    AND a.discharge_date IS NULL
GROUP BY dep.department_id, dep.department_name
ORDER BY dep.department_name;
