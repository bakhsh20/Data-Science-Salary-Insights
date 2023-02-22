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
- Employee Location
- Remote Ratio
- Company Location
- Company Size

With this project I created a set of questions I planned to answer and throughout the following sections I will explain the steps I took to achieve this. 

# Preparing the data
The data set that came from Kaggle was intitially formatted as a CSV. My plan was to export this CSV into a MySQL database for easier analysis through SQL queries. 

## Python
I used the MySQL connector extension for Python to connect to my RDBMS in MySQL and transport this information to the server. With Python, I connected to a database created in MySQL workbench. Using the MySQL connector extension, I created a script that created a table with columns that matches the CSV file and populates it with correctly formatted data into my MySQL database. 

## SQL
With the data now in my MySQL server, I made a series of queries that provided me with insights about the data. The following section will present those queries along with my analysis. 

# Analysis 
![Overall dashboard created in PowerBI](/images/overall_insights.png "Data Salary Insights Dashboard")

This screenshot shows the entire PowerBI dashboard that I created. I will be going through each of these graphs individually and showing the SQL commands that corresponded with the graph and what questions I wanted to answer with each.

# What is the average salary based on residence? 

![Avg salary by employee residence](/images/salary_by_residence.png "Bar graph of salaries based off residence")

SQL Command:
<code>
SELECT employee_residence, AVG(convert_to_USD(salary, salary_currency)) AS avg_salary
FROM dsstats.dsstatstable
GROUP BY employee_residence
ORDER BY avg_salary DESC
LIMIT 10;
</code>






















