USE hospital_management;

-- 1. Admission and discharge details
SELECT
    a.admission_id,
    CONCAT(p.first_name, ' ', p.last_name) AS patient_name,
    dep.department_name,
    a.admission_date,
    a.discharge_date
FROM Admissions a
JOIN Patients p ON a.patient_id = p.patient_id
JOIN Departments dep ON a.department_id = dep.department_id
ORDER BY a.admission_date;

-- 2. Length of stay for discharged patients
SELECT
    admission_id,
    patient_id,
    admission_date,
    discharge_date,
    DATEDIFF(discharge_date, admission_date) AS length_of_stay_days
FROM Admissions
WHERE discharge_date IS NOT NULL;

-- 3. Patient department transfers
SELECT
    t.transfer_id,
    CONCAT(p.first_name, ' ', p.last_name) AS patient_name,
    fd.department_name AS from_department,
    td.department_name AS to_department,
    t.transfer_date
FROM Transfers t
JOIN Patients p ON t.patient_id = p.patient_id
JOIN Departments fd ON t.from_department = fd.department_id
JOIN Departments td ON t.to_department = td.department_id
ORDER BY t.transfer_date;

-- 4. Available beds
SELECT
    bed_id,
    department_id,
    bed_number,
    bed_status
FROM Beds
WHERE bed_status = 'Available';

-- 5. Length of stay, including current admissions
SELECT
    admission_id,
    patient_id,
    admission_date,
    discharge_date,
    DATEDIFF(COALESCE(discharge_date, CURDATE()), admission_date) AS days_admitted
FROM Admissions;
