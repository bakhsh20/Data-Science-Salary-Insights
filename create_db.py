from __future__ import print_function

import mysql.connector
from mysql.connector import errorcode
import csv

# Create database
DB_NAME = 'dsstats'

# Dictionary of tables we would like to make.
TABLES = {}

TABLES['dsstats'] = (
  "CREATE TABLE dsstatstable ("
  " id INT NOT NULL,"
  " work_year INT NOT NULL,"
  " experience CHAR(2) NOT NULL,"
  " employement_type CHAR(2) NOT NULL,"
  " job_title VARCHAR(40) NOT NULL,"
  " salary INT NOT NULL,"
  " salary_currency VARCHAR(4) NOT NULL,"
  " employee_residence VARCHAR(4) NOT NULL,"
  " remote_ratio INT NOT NULL,"
  " company_location VARCHAR(4) NOT NULL,"
  " company_size CHAR(2)"
  ") ENGINE=InnoDB")

# Try to make a connection to the database
try:
  connection = mysql.connector.connect(
      user='root',
      password='***********',
      host='127.0.0.1',
      database='dsstats'
  )
  cursor = connection.cursor()

# Handle error for a failed connection
except mysql.connector.Error as err:
  if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
      print("Access denied. Error with username or password")
  elif err.errno == errorcode.ER_BAD_DB_ERROR:
      print("Database does not exist")
  else:
      print(err)

# Create tables by iterating over number of tables we have.
for table_name in TABLES:
  table_description = TABLES[table_name]
  try:
      print("Creating table {}:".format(table_name), end='')
      cursor.execute(table_description)
  except mysql.connector.Error as err:
      if err.errno == errorcode.ER_TABLE_EXISTS_ERROR:
          print(" Table already exist. Table dropped. Re-run")
          cursor.execute("DROP TABLE dsstatstable" )
          cursor.close()
          exit()
      else:
          print(" " + err.msg)
  else:
      print(" Tables created successfully")


# Create CSV reader
filename = "ds_stats.csv"

# Open CSV file
infileVG = open(filename, 'r')

# Read all lines of CSV file
lines = infileVG.readlines()

# Loop through each line of csv file
for line in lines[1:]:
  splitLine = line.split(',')
  # Strip line break thats located on last element.
  splitLine[-1] = splitLine[-1].strip()

# Execute addition of data into MySQL server
  try:
   cursor.execute("INSERT INTO dsstatstable VALUES(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)" ,
   [splitLine[0], splitLine[1], splitLine[2], splitLine[3], splitLine[4], splitLine[5], splitLine[6], splitLine[7], splitLine[8], splitLine[9], splitLine[10]])
   connection.commit()
  # IF error occurs. print error message. Break execution
  except mysql.connector.Error as err:
    print(err)
    break


# Close all objects.  
infileVG.close()
cursor.close()
connection.close()
