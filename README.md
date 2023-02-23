# Data Science Salary Insights Project

## A Data Analyst Project on salaries of individuals in the field of data science using Python for data extraction and transformation, with SQL being used for loading the data. 

# About
The main purpose of this project was gain skills in data analytics following some of the most popular tools used in industry. The dataset that was used for this project came from Kaggle. The dataset is a CSV file of salaries in the industry of data science. 

The data set contains the following information. 
- ID
- Work Year
- Experience
- Employement Type
- Job Title
- Salary
- Salary Currency
- Employee Location (country)
- Remote Ratio
- Company Location (country)
- Company Size

With this project I created a set of questions I planned to answer and throughout the following sections I will explain the steps I took to achieve this. 

# Preparing the data
The data set that came from Kaggle was intitially formatted as a CSV. My plan was to export this CSV into a MySQL database for easier analysis through SQL queries. 

## Python
I used the MySQL connector extension for Python to connect to my RDBMS in MySQL and transport this information to the server. With Python, I connected to a database created in MySQL workbench. Using the MySQL connector extension, I created a script that created a table with columns that matches the CSV file and populates it with correctly formatted data into my MySQL database. 

## SQL
With the data now in my MySQL server, I made a series of queries that provided me with insights about the data. The following section will present those queries along with my analysis. 

In the data set it can be noticed that the salaries were in different currencies. In order to analyze the data accurately, I created a function in MySQL to convert all the currencies into USD. This could of been easily done in Python but I was interested in better understanding SQL functions therefore I chose to do it in MySQL. The code is shown below. 

<code>CREATE DEFINER=`root`@`localhost` FUNCTION `convert_to_USD`(curr_num INT, curr_type VARCHAR(4)) RETURNS decimal(10,2)
    READS SQL DATA
    DETERMINISTIC
BEGIN
	DECLARE s DECIMAL(12, 2);
    
    IF curr_type = "EUR" THEN SET s = curr_num * 1.07;
    ELSEIF curr_type = "GBP" THEN SET s = curr_num * 1.20;
    ELSEIF curr_type = "HUF" THEN SET s = curr_num * 0.0028;
    ELSEIF curr_type = "INR" THEN SET s = curr_num * 0.012;
    ELSEIF curr_type = "JPY" THEN SET s = curr_num * 0.0075;
    ELSEIF curr_type = "CNY" THEN SET s = curr_num * 0.15;
    ELSEIF curr_type = "MXN" THEN SET s = curr_num * 0.054;
    ELSEIF curr_type = "CAD" THEN SET s = curr_num * 0.74;
    ELSEIF curr_type = "DKK" THEN SET s = curr_num * 0.14;
    ELSEIF curr_type = "PLN" THEN SET s = curr_num * 0.22;
    ELSEIF curr_type = "SGD" THEN SET s = curr_num * 0.75;
    ELSEIF curr_type = "CLP" THEN SET s = curr_num * 0.0013;
    ELSEIF curr_type = "BRL" THEN SET s = curr_num * 0.19;
    ELSEIF curr_type = "TRY" THEN SET s = curr_num * 0.053;
    ELSEIF curr_type = "AUD" THEN SET s = curr_num * 0.69;
    ELSEIF curr_type = "CHF" THEN SET s = curr_num * 1.08;
    ELSE SET s = curr_num;
    END IF;
RETURN s;
END</code>

# Analysis 
![Overall dashboard created in PowerBI](/images/overall_insights.png "Data Salary Insights Dashboard")

This screenshot shows the entire PowerBI dashboard that I created. I will be going through each of these graphs individually and showing the SQL commands that corresponded with the graph and what questions I wanted to answer with each.

# What is the Top 10 average salary based on residence? 

![Avg salary by employee residence](/images/salary_by_residence.png "Bar graph of salaries based off residence")

SQL Command: SQL code find the average salary in USD of the top 10 countries and orders it from least to greatest based off the average salary. 

<code>SELECT employee_residence, AVG(convert_to_USD(salary, salary_currency)) AS avg_salary
FROM dsstats.dsstatstable
GROUP BY employee_residence
ORDER BY avg_salary DESC
LIMIT 10;</code>

In the Top 10 countries, the **greatest** salary is **Malaysia** with an average salary of **200,000 USD**. The **least** is **Jersey** with an average salary of **100,000** USD. It is determined that the top 10 countries provide a salary that is well about the averages for these nations, making these countries highly desirable for individuals who are in the field of Data Science. 





















