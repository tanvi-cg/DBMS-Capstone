USE hospital_management;

-- 1. Upcoming appointments
SELECT
    a.appointment_id,
    CONCAT(p.first_name, ' ', p.last_name) AS patient_name,
    CONCAT(d.first_name, ' ', d.last_name) AS doctor_name,
    a.appointment_date,
    a.reason,
    a.status
FROM Appointments a
JOIN Patients p ON a.patient_id = p.patient_id
JOIN Doctors d ON a.doctor_id = d.doctor_id
WHERE a.appointment_date >= NOW()
ORDER BY a.appointment_date;

-- 2. Check for exact-time appointment conflicts by doctor
SELECT
    doctor_id,
    appointment_date,
    COUNT(*) AS appointment_count
FROM Appointments
GROUP BY doctor_id, appointment_date
HAVING COUNT(*) > 1;

-- 3. Scheduled surgeries
SELECT
    s.surgery_id,
    CONCAT(p.first_name, ' ', p.last_name) AS patient_name,
    CONCAT(d.first_name, ' ', d.last_name) AS surgeon_name,
    dep.department_name,
    s.surgery_name,
    s.surgery_datetime,
    s.status
FROM Surgeries s
JOIN Patients p ON s.patient_id = p.patient_id
JOIN Doctors d ON s.surgeon_id = d.doctor_id
JOIN Departments dep ON s.department_id = dep.department_id
WHERE s.status = 'Scheduled'
ORDER BY s.surgery_datetime;

-- 4. Detect exact-time surgery conflicts for the same surgeon
SELECT
    s1.surgeon_id,
    s1.surgery_id AS surgery_1,
    s2.surgery_id AS surgery_2,
    s1.surgery_datetime AS time_1,
    s2.surgery_datetime AS time_2
FROM Surgeries s1
JOIN Surgeries s2
    ON s1.surgeon_id = s2.surgeon_id
    AND s1.surgery_id < s2.surgery_id
    AND s1.surgery_datetime = s2.surgery_datetime
WHERE s1.status = 'Scheduled'
  AND s2.status = 'Scheduled';
