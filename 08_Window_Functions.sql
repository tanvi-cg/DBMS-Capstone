USE hospital_management;

-- 1. Rank surgeons by surgery count within each department
WITH surgeon_counts AS (
    SELECT
        d.doctor_id,
        CONCAT(d.first_name, ' ', d.last_name) AS surgeon_name,
        dep.department_id,
        dep.department_name,
        COUNT(s.surgery_id) AS surgery_count
    FROM Doctors d
    JOIN Departments dep ON d.department_id = dep.department_id
    LEFT JOIN Surgeries s ON s.surgeon_id = d.doctor_id
    GROUP BY
        d.doctor_id,
        d.first_name,
        d.last_name,
        dep.department_id,
        dep.department_name
)
SELECT
    surgeon_name,
    department_name,
    surgery_count,
    DENSE_RANK() OVER (
        PARTITION BY department_id
        ORDER BY surgery_count DESC
    ) AS department_rank
FROM surgeon_counts;

-- 2. Compare admission length of stay with department average
SELECT
    p.patient_id,
    CONCAT(p.first_name, ' ', p.last_name) AS patient_name,
    dep.department_name,
    DATEDIFF(COALESCE(a.discharge_date, CURDATE()), a.admission_date) AS days_admitted,
    AVG(
        DATEDIFF(COALESCE(a.discharge_date, CURDATE()), a.admission_date)
    ) OVER (
        PARTITION BY dep.department_id
    ) AS department_avg_stay
FROM Admissions a
JOIN Patients p ON a.patient_id = p.patient_id
JOIN Departments dep ON a.department_id = dep.department_id;

-- 3. Identify readmissions within 30 days using LAG
WITH ReadmissionCheck AS (
    SELECT
        patient_id,
        admission_date,
        discharge_date,
        LAG(discharge_date) OVER (
            PARTITION BY patient_id
            ORDER BY admission_date
        ) AS previous_discharge
    FROM Admissions
)
SELECT
    patient_id,
    previous_discharge,
    admission_date AS readmission_date,
    DATEDIFF(admission_date, previous_discharge) AS days_between_admissions
FROM ReadmissionCheck
WHERE previous_discharge IS NOT NULL
  AND DATEDIFF(admission_date, previous_discharge) BETWEEN 0 AND 30;

-- 4. Demonstrate LAG and LEAD together
SELECT
    patient_id,
    admission_date,
    discharge_date,
    LAG(discharge_date) OVER (
        PARTITION BY patient_id
        ORDER BY admission_date
    ) AS previous_discharge,
    LEAD(admission_date) OVER (
        PARTITION BY patient_id
        ORDER BY admission_date
    ) AS next_admission
FROM Admissions
ORDER BY patient_id, admission_date;
