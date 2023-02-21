CREATE DATABASE dsstats;

USE dsstats;

-- Check query to ensure all data was added 
SELECT * FROM dsstatstable;
 
-- What are all the distinct job titles? 
SELECT DISTINCT job_title FROM dsstats.dsstatstable;

-- What is the running total of jobs based on company size?  
SELECT COUNT(company_size), company_size FROM dsstats.dsstatstable 
GROUP BY company_size;

-- What are all the unique types of currencies we have? 
SELECT DISTINCT salary_currency FROM dsstats.dsstatstable;

-- What are all the salaries converted to USD? 
SELECT salary, salary_currency, convert_to_USD(salary, salary_currency) AS converted_salary
FROM dsstats.dsstatstable;

-- What are the max salaries in USD from company locations? 
SELECT company_location, MAX(convert_to_USD(salary, salary_currency)) AS max_salary
FROM dsstats.dsstatstable
GROUP BY company_location 
ORDER BY max_salary DESC;

-- Verifying whether grouped currencies are correct.  
SELECT id FROM dsstats.dsstatstable
WHERE company_location = "US" AND salary = 600000;

-- What is the average salary for each distinct job title? 
SELECT DISTINCT job_title, AVG(convert_to_USD(salary, salary_currency)) AS avg_salary
FROM dsstats.dsstatstable
GROUP BY job_title
ORDER BY avg_salary DESC;

-- What are the top 10 most common jobs? What are their average salaries?  
SELECT job_title, COUNT(job_title) AS number_of_jobs, AVG(convert_to_USD(salary, salary_currency)) AS avg_salary
FROM dsstats.dsstatstable
GROUP BY job_title
ORDER BY number_of_jobs DESC
LIMIT 10;

-- What are the 10 highest salaries? What are the titles and how many of these jobs are there?   
SELECT job_title, MAX(convert_to_USD(salary, salary_currency)) AS max_salary, COUNT(job_title) AS num_jobs
FROM dsstats.dsstatstable
GROUP BY job_title
ORDER BY max_salary DESC
LIMIT 10;

-- What is the average salary by experience? How many job were there for these jobs? 
SELECT experience, AVG(convert_to_USD(salary, salary_currency)) AS avg_salary
FROM dsstats.dsstatstable
GROUP BY experience
ORDER BY avg_salary ASC;

-- What is the 10 best countries to work in based off salary? 
SELECT employee_residence, AVG(convert_to_USD(salary, salary_currency)) AS avg_salary
FROM dsstats.dsstatstable
GROUP BY employee_residence
ORDER BY avg_salary DESC
LIMIT 10;

-- Number of jobs based off employee_residence
SELECT employee_residence, COUNT(employee_residence)
FROM dsstats.dsstatstable
GROUP BY employee_residence;

-- Percentage of jobs based off experience
SELECT experience, (COUNT(experience) / 607 ) AS percent_jobs
FROM dsstats.dsstatstable
GROUP BY experience; 


