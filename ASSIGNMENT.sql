DROP TABLE IF EXISTS Hospital;
CREATE TABLE Hospital(
Hospital_Name VARCHAR(100),
Location	VARCHAR(50),
department	VARCHAR(100),
Doctors_Count	INT,
Patients_Count	INT,
Admission_Date DATE ,
Discharge_Date DATE,
Medical_Expenses NUMERIC(10,2)
);

SELECT * FROM  Hospital;



COPY Hospital(Hospital_name, Location, department, Doctors_count, Patients_Count,Admission_date,
Discharge_date, Medical_Expenses)
FROM 'D:\d drive\Hospital.csv'
CSV HEADER;

--1. Total Number of Patients 
SELECT SUM (patients_count) AS total_patients
from Hospital;
 
--2. Average Number of Doctors per Hospital 

SELECT AVG(doctors_count)AS avg_doctors_per_hospital
FROM Hospital;
 
--3. Top 3 Departments with the Highest Number of Patients

SELECT department,
      SUM(patients_count) AS total_patients
	  FROM Hospital
	  GROUP BY department
	  ORDER BY total_patients DESC
	  LIMIT 3;

--4. Hospital with the Maximum Medical Expenses 
 SELECT hospital_name,medical_expenses
 FROM Hospital
 ORDER BY medical_expenses DESC
 LIMIT 1;

--5. Daily Average Medical Expenses 
SELECT hospital_name,
medical_expenses,
(discharge_date-admission_date)AS total_days,
(medical_expenses/NULLIF(discharge_date-admission_date,0)) AS daily_avg_expenses
FROM Hospital;

--6. Longest Hospital Stay 
SELECT hospital_name,
(discharge_date-admission_date) AS STAY_LENGTH
FROM Hospital
ORDER BY stay_length DESC
LIMIT 1;

--7. Total Patients Treated Per City 
SELECT location AS city,
   SUM(patients_count) AS total_patients
   FROM Hospital
   GROUP BY location
   ORDER BY total_patients DESC;

   
--8. Average Length of Stay Per Department 
SELECT department,
  AVG(discharge_date-admission_date) AS avg_stay_length
  FROM Hospital
  GROUP BY department
  ORDER BY avg_stay_length DESC;

 
--9. Identify the Department with the Lowest Number of Patients 
SELECT department,
SUM(patients_count)AS total_patients
FROM Hospital
GROUP  BY department
ORDER BY total_patients ASC
LIMIT 1;


--10. Monthly Medical Expenses Report
SELECT
DATE_TRUNC('month',admission_date) AS month,
SUM(medical_expenses) AS total_medical_expenses
FROM Hospital
GROUP BY DATE_TRUNC('month',admission_date) 
ORDER BY month;




