   EXPLAIN SELECT appointment_id, doctor_id, appointment_date, status
   FROM Appointments IGNORE INDEX (idx_appointment_report, idx_appointment_doctor_date)
   WHERE doctor_id = 1;

   EXPLAIN SELECT patient_id, admission_date, discharge_date
   FROM Admissions IGNORE INDEX (idx_admission_report)
   WHERE admission_date >= '2026-01-01';

   EXPLAIN SELECT patient_id, admission_date FROM Admissions
   WHERE patient_id = 1 AND admission_date >= '2026-10-01';