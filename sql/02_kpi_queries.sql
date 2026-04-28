USE horiba_cbc;

-- Check the total number of unique diagnoses in the dataset
-- To decide whether to create a lookup table for diagnosis codes
SELECT COUNT(DISTINCT short_title) 
FROM diagnosis;

-- KPI 1: Top 10 diagnoses by frequency
-- Shows which medical conditions appear most often in the dataset
-- Useful for prioritizing which diagnoses to analyze further
SELECT short_title, 
       COUNT(*) AS count
FROM diagnosis
GROUP BY short_title
ORDER BY count DESC
LIMIT 20;


-- KPI 2: Hemoglobin and RBC levels in anemia patients vs others
-- Reason of choosing anemia NOS: Anemia is directly measurable via CBC: low Hemoglobin and low RBC. 
-- Unlike hypertension or diabetes, anemia diagnosis can be supported by CBC.
SELECT 
    c.subject_id,
    c.Hemoglobin,
    c.Red_Blood_Cells,
    c.Hematocrit,
    c.MCV,
    c.MCH,
    c.MCHC,
    c.RDW
FROM cbc_results c
JOIN diagnosis d ON c.subject_id = d.subject_id
WHERE d.short_title = 'Anemia NOS'
ORDER BY c.Hemoglobin ASC;


-- confirm 17 unique anemia patients
SELECT COUNT(DISTINCT c.subject_id)
FROM cbc_results c
JOIN diagnosis d ON c.subject_id = d.subject_id
WHERE d.short_title = 'Anemia NOS';


