--1.Create a departments table with the following constraints:
--	dept_id (Primary Key, auto-increment).
--	dept_name (Must be unique, cannot be NULL).

create table departments(
dept_id SERIAL PRIMARY KEY,
dept_name  VARCHAR(255) NOT NULL UNIQUE);

--2.Create an employees table with constraints:
--emp_id (Primary Key, auto-increment).
--emp_name (Cannot be NULL).
--email (Must be unique).
--salary (Cannot be NULL, must be positive).
--dept_id (Foreign Key referencing departments.dept_id).

create table employees(
emp_id SERIAL PRIMARY KEY,
emp_name VARCHAR(25) NOT NULL,
email VARCHAR(40) UNIQUE,
salary NUMERIC(10,2) NOT NULL CHECK(salary>0),
dept_id INT,
CONSTRAINT fk_department FOREIGN KEY(dept_id) REFERENCES departments(dept_id)
);

--3.Create a projects table:
--project_id (Primary Key, auto-increment).
--project_name (Cannot be NULL).
--dept_id (Foreign Key referencing departments.dept_id).

create table projects(
project_id SERIAL PRIMARY KEY,
project_name VARCHAR(255) NOT NULL,
dept_id INT,
CONSTRAINT fk_department FOREIGN KEY(dept_id) REFERENCES departments(dept_id)
);

SELECT * FROM DEPARTMENTS;

--4.Insert at least 5 departments, 10 employees, and 5 projects into the respective tables.
INSERT INTO departments(dept_name) 
VALUES 
('Human Resources'), 
('Finance'), 
('Marketing'), 
('Sales'), 
('IT'), 
('Customer Support'), 
('Operations'), 
('Research and Development'), 
('Legal'), 
('Administration');
INSERT INTO employees(emp_name,email,salary,dept_id) VALUES
('vignesh','vignesh@tringapps.com',20000,5),
('karthick','karthick@tringapps.com',30000,3),
('bala','bala@tringapps.com',18000,2),
('vel','vel@tringapps.com',22000,2),
('yuvan','yuvan@tringapps.com',23000,5),
('john','john@tringapps.com',30000,1),
('anand','anand@tringapps.com',23000,5),
('abdul','abdul@tringapps.com',24000,1),
('vetri','vetri@tringapps.com',45000,4),
('ajay','ajay@tringapps.com',20000,3),
('vijay','vijay@tringapps.com',20000,1),
('kumar','kumar@tringapps.com',20000,4)
;
INSERT INTO employees(emp_name,email,salary,dept_id) VALUES('kumarnew','kumarnew@tringapps.com',20000,10)

INSERT INTO projects(project_name,dept_id) VALUES
('PROJECT 1',5),
('PROJECT 2',2),
('PROJECT 3',1),
('PROJECT 4',6),
('PROJECT 5',2);

--5.INNER JOIN: List all employees along with their department names.
SELECT emp_id,emp_name,email,salary,dept_name FROM EMPLOYEES  INNER JOIN DEPARTMENTS ON EMPLOYEES.dept_id=DEPARTMENTS.dept_id;

--6.LEFT JOIN: Show all departments and employees, including departments with no employees
SELECT emp_id,emp_name,email,salary,dept_name FROM EMPLOYEES    LEFT JOIN DEPARTMENTS ON EMPLOYEES.dept_id=DEPARTMENTS.dept_id;

--7.RIGHT JOIN: Show all employees and their respective departments, including employees without a department.
SELECT emp_id,emp_name,email,salary,dept_name FROM EMPLOYEES    RIGHT JOIN DEPARTMENTS ON EMPLOYEES.dept_id=DEPARTMENTS.dept_id;

--8.FULL OUTER JOIN: List all departments and employees, even if there’s no match between them.
SELECT emp_id,emp_name,email,salary,dept_name FROM EMPLOYEES    FULL JOIN DEPARTMENTS ON EMPLOYEES.dept_id=DEPARTMENTS.dept_id;

--9.JOIN with multiple tables: List all employees along with their department name and the projects assigned to that department.
SELECT 
    e.emp_id,
    e.emp_name,
    e.email,
    e.salary,
    d.dept_name,
    p.project_id,
    p.project_name
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
LEFT JOIN projects p ON d.dept_id = p.dept_id;

--10.Count the total number of employees in each department.
SELECT count(*),dept_name FROM EMPLOYEES  INNER JOIN DEPARTMENTS ON EMPLOYEES.dept_id=DEPARTMENTS.dept_id GROUP BY dept_name;

--11.Find the total salary paid in each department.
SELECT sum(salary),dept_name FROM EMPLOYEES  INNER JOIN DEPARTMENTS ON EMPLOYEES.dept_id=DEPARTMENTS.dept_id GROUP BY dept_name;

--12.Calculate the average salary for each department.
SELECT round(avg(salary),2),dept_name FROM EMPLOYEES  INNER JOIN DEPARTMENTS ON EMPLOYEES.dept_id=DEPARTMENTS.dept_id GROUP BY dept_name

--13.Find the minimum and maximum salary in the company.
SELECT MIN(SALARY) as Minimum_salary,MAX(SALARY)  as Maximum_Salary FROM EMPLOYEES 

--14.List the total number of projects each department is handling.
SELECT COUNT(project_name),dept_name FROM PROJECTS INNER JOIN DEPARTMENTS ON PROJECTS.DEPT_ID=DEPARTMENTS.DEPT_ID GROUP BY DEPT_NAME;

--15.Show the average salary per department, but only for departments where the average salary is greater than 50,000.
SELECT round(avg(salary),2),dept_name FROM EMPLOYEES  INNER JOIN DEPARTMENTS ON EMPLOYEES.dept_id=DEPARTMENTS.dept_id GROUP BY dept_name HAVING(avg(salary)>30000);

--16.Find departments with more than 3 employees.
SELECT count(*),dept_name FROM EMPLOYEES  INNER JOIN DEPARTMENTS ON EMPLOYEES.dept_id=DEPARTMENTS.dept_id GROUP BY dept_name HAVING(COUNT(*)>3);

--17.List projects assigned to departments that have at least 2 projects.
SELECT COUNT(project_name),dept_name FROM PROJECTS INNER JOIN DEPARTMENTS ON PROJECTS.DEPT_ID=DEPARTMENTS.DEPT_ID GROUP BY DEPT_NAME HAVING(COUNT(PROJECT_NAME)>=2);

--18.Create a function to calculate bonuses .Write a PostgreSQL function that takes an employee’s salary as input and returns the bonus amount (10% of salary).Test the function by selecting all employees and displaying their bonus.

CREATE OR REPLACE FUNCTION calculate_bonus(emp_salary NUMERIC)
RETURNS INTEGER AS 
   $$
     BEGIN
        RETURN emp_salary * 0.10;  
     END;
   $$ 
   LANGUAGE plpgsql;
 SELECT *, calculate_bonus(salary) AS bonus FROM employees;
 
 --19.Create a function to count employees in a department
--Write a function that takes a dept_id as input and returns the number of employees in that department.
--Test the function by calling it for different department IDs.

  CREATE OR REPLACE FUNCTION countEmployeesByDepartment(department_id INTEGER)
    RETURNS INTEGER AS 
	$$
       DECLARE
            employee_count INTEGER;
       BEGIN
            SELECT COUNT(*) INTO employee_count
            FROM employees
            WHERE dept_id = department_id;
            RETURN employee_count;
       END;
    $$ 
	LANGUAGE plpgsql;

	
	SELECT dept_id,dept_name,countEmployeesByDepartment(dept_id) FROM DEPARTMENTS;  


--20.Create a function to check high salaries
--Write a function that takes a salary as input and returns "High Salary" if it's above 80,000, "Medium Salary" if it's between 50,000-80,000, and "Low Salary" otherwise.
--Test the function by applying it to all employees.
CREATE OR REPLACE FUNCTION checkSalaryRange(emp_salary NUMERIC)
RETURNS TEXT AS 
  $$
    BEGIN
          IF emp_salary > 80000 THEN
            RETURN 'High Salary';
          ELSIF emp_salary BETWEEN 50000 AND 80000 THEN
            RETURN 'Medium Salary';
          ELSE
            RETURN 'Low Salary';
          END IF;
     END;
  $$
  LANGUAGE plpgsql;
   
SELECT emp_name, salary, checkSalaryRange(salary) AS salary_range FROM employees;
	

