 -- DATA CLEANING

SELECT *
FROM depression_data;

CREATE TABLE `depression_data_staging` (
  `People` text,
  `Age` int DEFAULT NULL,
  `Marital_Status` text,
  `Education_Level` text,
  `Number_of_Children` int DEFAULT NULL,
  `Smoking_Status` text,
  `Physical_Activity_Level` text,
  `Employment_Status` text,
  `Income` double DEFAULT NULL,
  `Alcohol_Consumption` text,
  `Dietary_Habits` text,
  `Sleep_Patterns` text,
  `History_of_Mental_Illness` text,
  `History_of_Substance_Abuse` text,
  `Family_History_of_Depression` text,
  `Chronic_Medical_Conditions` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO depression_data_staging
SELECT *
FROM depression_data;

SELECT *
FROM depression_data_staging;

-- CHECKING FOR DUPLICATES
WITH CTE AS 
(
SELECT *, 
ROW_NUMBER() OVER(PARTITION BY People, Age, Marital_Status, Education_Level, Number_of_Children, Smoking_Status, Physical_Activity_Level, 
Income, Alcohol_Consumption, Dietary_Habits, Sleep_Patterns, History_of_Mental_Illness, History_of_Substance_Abuse, 
Family_History_of_Depression, Chronic_Medical_Conditions) AS row_num
FROM depression_data_staging
)
SELECT *
FROM CTE
WHERE row_num > 1;

SELECT *
FROM depression_data_staging;

-- EXPLORATORY ANALYSIS


-- DO EMPLOYED PEOPLE EARN MORE THAN UNEMPLOYED?
SELECT Employment_Status, ROUND(SUM(Income), 2) AS Salary
FROM depression_data_staging
GROUP BY Employment_Status
ORDER BY 2;


SELECT *
FROM depression_data_staging;

-- AS YOU GO OLDER MORE INCOME?
SELECT Age, ROUND(SUM(Income), 2) AS salary
FROM depression_data_staging
GROUP BY Age
ORDER BY 2 DESC;

-- HIGHER EDUCATION LEVEL HIGHER PAY?
SELECT Education_Level, ROUND(SUM(Income), 2) AS Salary
FROM depression_data_staging
GROUP BY Education_Level
ORDER BY 2 DESC;

SELECT *
FROM depression_data_staging;

-- DO MORE CHILDREN MAKE PEOPLE MORE DEPRESSED
SELECT Number_of_Children, COUNT(*) AS Counter
FROM depression_data_staging
GROUP BY Number_of_Children
ORDER BY Counter DESC;

-- DOES SLEEP PATTERN AFFECT DEPRESSION
SELECT Sleep_Patterns, COUNT(*) AS counta
FROM depression_data_staging
GROUP BY Sleep_Patterns
ORDER BY 2 DESC;






