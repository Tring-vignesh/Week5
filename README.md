Creating Tables with Constraints

Create a departments table with the following constraints:
dept_id (Primary Key, auto-increment).
dept_name (Must be unique, cannot be NULL).
Create an employees table with constraints:
emp_id (Primary Key, auto-increment).
emp_name (Cannot be NULL).
email (Must be unique).
salary (Cannot be NULL, must be positive).
dept_id (Foreign Key referencing departments.dept_id).
Create a projects table:
project_id (Primary Key, auto-increment).
project_name (Cannot be NULL).
dept_id (Foreign Key referencing departments.dept_id).

Insert Sample Data

Insert at least 5 departments, 10 employees, and 5 projects into the respective tables.


Writing Queries

Answer the following questions using SQL queries.

Section A: Joins

INNER JOIN: List all employees along with their department names.
LEFT JOIN: Show all departments and employees, including departments with no employees.
RIGHT JOIN: Show all employees and their respective departments, including employees without a department.
FULL OUTER JOIN: List all departments and employees, even if there’s no match between them.
JOIN with multiple tables: List all employees along with their department name and the projects assigned to that department.


Section B: Aggregate Functions

Count the total number of employees in each department.
Find the total salary paid in each department.
Calculate the average salary for each department.
Find the minimum and maximum salary in the company.
List the total number of projects each department is handling.


Section C: GROUP BY and HAVING

Show the average salary per department, but only for departments where the average salary is greater than 50,000.
Find departments with more than 3 employees.
List projects assigned to departments that have at least 2 projects.


Custom Functions

Create a function to calculate bonuses
Write a PostgreSQL function that takes an employee’s salary as input and returns the bonus amount (10% of salary).
Test the function by selecting all employees and displaying their bonus.
Create a function to count employees in a department
Write a function that takes a dept_id as input and returns the number of employees in that department.
Test the function by calling it for different department IDs.
Create a function to check high salaries
Write a function that takes a salary as input and returns "High Salary" if it's above 80,000, "Medium Salary" if it's between 50,000-80,000, and "Low Salary" otherwise.
Test the function by applying it to all employees.








Submission Requirements:

SQL scripts for table creation, data insertion, and queries.
Query results (screenshots or text output).
