/*
Project: AI-Assisted Dashboard for Safety Signal Monitoring
Description: SQL queries for data validation and safety signal analysis
Note: Dataset not included due to size and data handling considerations
Author: Nikita Shelke
*/
-- Safety data table (simulated pharmacovigilance dataset)
DROP TABLE IF EXISTS drug_safety;
-- Serious adverse events identified using keyword-based pattern matching
-- Safety Analysis Questions:
-- 1. Which drugs have the highest number of adverse events?
-- 2. Which drugs have the most serious adverse events?
-- 3. Are Rx drugs riskier than OTC?
-- 4. Do certain pregnancy categories show higher risk?
-- 5. Is there a relation between low rating and serious adverse events?
DROP TABLE IF EXISTS drug_safety;

CREATE TABLE drug_safety (
    drug_name TEXT,
    medical_condition TEXT,
    side_effects TEXT,
    generic_name TEXT,
    drug_classes TEXT,
    rx_otc TEXT,
    pregnancy_category TEXT,
    rating TEXT   
);
SELECT* FROM drug_safety;

SELECT DISTINCT rating
FROM drug_safety
LIMIT 10;
ALTER TABLE drug_safety
ADD COLUMN rating_num DOUBLE PRECISION;

UPDATE drug_safety
SET rating_num = rating::DOUBLE PRECISION
WHERE rating ~ '^[0-9]+(\.[0-9]+)?$';

SELECT rating, rating_num
FROM drug_safety
LIMIT 10;

ALTER TABLE drug_safety DROP COLUMN rating;

--1.Which drugs have the highest number of adverse events?
SELECT
    drug_name,
    COUNT(*) AS adverse_event_count
FROM drug_safety
WHERE side_effects IS NOT NULL
  AND side_effects <> ''
GROUP BY drug_name
ORDER BY adverse_event_count DESC
LIMIT 10;

--2.Which drugs have the most serious adverse events?
SELECT
    drug_name,
    COUNT(*) AS serious_ae_count
FROM drug_safety
WHERE side_effects ILIKE ANY (ARRAY[
    '%death%',
    '%hospital%',
    '%life-threatening%',
    '%severe%'
])
GROUP BY drug_name
ORDER BY serious_ae_count DESC
LIMIT 10;
--3.Are Rx drugs riskier than OTC?
SELECT
    rx_otc,
    COUNT(*) AS total_cases,
    COUNT(side_effects) AS cases_with_ae
FROM drug_safety
GROUP BY rx_otc;

--4. ️Do certain pregnancy categories show higher risk?
SELECT
    pregnancy_category,
    COUNT(*) AS total_drugs,
    COUNT(side_effects) AS drugs_with_ae
FROM drug_safety
WHERE pregnancy_category IS NOT NULL
GROUP BY pregnancy_category
ORDER BY drugs_with_ae DESC;

--5.Is there a relation between low rating & serious AEs?
SELECT
    CASE
        WHEN rating_num < 4 THEN 'Low Rating'
        WHEN rating_num BETWEEN 4 AND 7 THEN 'Medium Rating'
        ELSE 'High Rating'
    END AS rating_group,
    COUNT(*) AS serious_ae_cases
FROM drug_safety
WHERE side_effects ILIKE ANY (ARRAY[
    '%death%',
    '%hospital%',
    '%life-threatening%',
    '%severe%'
])
GROUP BY rating_group;
