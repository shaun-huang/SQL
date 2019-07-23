--- Data Analysis
--1. List the following details of each employee: employee number, last name, first name, gender, and salary.
SELECT employees.emp_no AS "Employee Number", first_name AS "First Name", last_name AS "Last Name", gender, salary
FROM employees JOIN salaries
	ON employees.emp_no = salaries.emp_no;
--2. List employees who were hired in 1986.
SELECT *
FROM employees
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31'
ORDER BY hire_date; 
--3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name, and start and end employment dates.
SELECT d.dept_no AS "Department Number", d.deot_name AS "Department Name", m.emp_no AS "Employee Number", e.first_name AS "First Name", e.last_name AS "Last Name", m.from_date AS "Start Date", m.to_date AS "End Date"
FROM departments d, dept_manager m, employees e
WHERE d.dept_no = m.dept_no AND m.emp_no = e.emp_no;
--4. List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT  e.emp_no AS "Employee Number", e.last_name AS "Last Name", e.first_name AS "First Name", d.deot_name AS "Department Name"
FROM employees e, departments d, dept_emp de
WHERE d.dept_no = de.dept_no AND de.emp_no = e.emp_no;
--5. List all employees whose first name is "Hercules" and last names begin with "B."
SELECT *
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';
--6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT  e.emp_no AS "Employee Number", e.last_name AS "Last Name", e.first_name AS "First Name", d.deot_name AS "Department Name"
FROM employees e, dept_emp de, (SELECT *
								FROM departments
							    WHERE deot_name = 'Sales') d
WHERE d.dept_no = de.dept_no AND de.emp_no = e.emp_no;
--7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT  e.emp_no AS "Employee Number", e.last_name AS "Last Name", e.first_name AS "First Name", d.deot_name AS "Department Name"
FROM employees e, dept_emp de, (SELECT *
								FROM departments
							    WHERE deot_name IN ('Sales', 'Development')) d
WHERE d.dept_no = de.dept_no AND de.emp_no = e.emp_no;
--8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name AS "Last Name", count(last_name) AS "Count"
FROM employees
GROUP BY last_name
ORDER BY "Count" DESC;
-- Bonus (Optional)

--As you examine the data, you are overcome with a creeping suspicion that the dataset is fake. 
--You surmise that your boss handed you spurious data in order to test the data engineering skills of a new employee. 
--To confirm your hunch, you decide to take the following steps to generate a visualization of the data, with which you will confront your boss:

--1. Import the SQL database into Pandas. (Yes, you could read the CSVs directly in Pandas, but you are, after all, trying to prove your technical mettle.) This step may require some research. Feel free to use the code below to get started. Be sure to make any necessary modifications for your username, password, host, port, and database name:

--   ```sql
--   from sqlalchemy import create_engine
--   engine = create_engine('postgresql://localhost:5432/<your_db_name>')
--   connection = engine.connect()
--   ```