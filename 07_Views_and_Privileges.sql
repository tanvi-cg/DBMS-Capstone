USE hospital_management;

-- Current inpatients view
CREATE OR REPLACE VIEW current_inpatients AS
SELECT
    p.patient_id,
    p.first_name,
    p.last_name,
    dep.department_name,
    b.bed_number,
    CONCAT(d.first_name, ' ', d.last_name) AS attending_doctor,
    a.admission_date,
    DATEDIFF(CURDATE(), a.admission_date) AS days_admitted
FROM Admissions a
JOIN Patients p ON a.patient_id = p.patient_id
JOIN Departments dep ON a.department_id = dep.department_id
JOIN Beds b ON a.bed_id = b.bed_id
JOIN Doctors d ON a.attending_doctor = d.doctor_id
WHERE a.discharge_date IS NULL;

SELECT * FROM current_inpatients;

-- Restricted front-desk view
CREATE OR REPLACE VIEW front_desk_view AS
SELECT
    patient_id,
    first_name,
    last_name,
    age,
    gender,
    phone,
    address
FROM Patients;

SELECT * FROM front_desk_view;

-- Create a limited front-desk user.
-- Set the password locally; do not commit credentials to GitHub.
CREATE USER IF NOT EXISTS 'frontdesk'@'localhost'
IDENTIFIED BY 'CHANGE_THIS_PASSWORD';

GRANT SELECT ON hospital_management.front_desk_view
TO 'frontdesk'@'localhost';

SHOW GRANTS FOR 'frontdesk'@'localhost';
