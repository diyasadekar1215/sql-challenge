CREATE TABLE employees (
    emp_no INT PRIMARY KEY NOT NULL,
    emp_title_id VARCHAR(10) NOT NULL,
    birth_date DATE NOT NULL,
    first_name VARCHAR(35) NOT NULL,
    last_name VARCHAR(35) NOT NULL,
    sex VARCHAR(1) NOT NULL,
    hire_date DATE NOT NULL
);
CREATE TABLE departments (
    dept_no VARCHAR(8) PRIMARY KEY NOT NULL,
    dept_name VARCHAR(40) NOT NULL
);
CREATE TABLE salaries (
    emp_no INT PRIMARY KEY NOT NULL,  
    salary INT NOT NULL,               
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no)  
);
CREATE TABLE dept_emp (
    emp_no INT NOT NULL,
    dept_no VARCHAR(8) NOT NULL,
    PRIMARY KEY (emp_no, dept_no),
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);
CREATE TABLE dept_manager (
    dept_no VARCHAR(8) NOT NULL,
	emp_no INT NOT NULL,
    PRIMARY KEY (emp_no, dept_no),
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments (dept_no)
);
CREATE TABLE titles (
    title_id VARCHAR(10) PRIMARY KEY, 
    title VARCHAR(40) NOT NULL                  
);

--1
SELECT 
	e.emp_no, 
	e.last_name, 
	e.first_name, 
	e.sex, 
	s.salary
FROM employees AS e
INNER JOIN salaries AS s ON s.emp_no = e.emp_no
ORDER BY s.emp_no;

--2
SELECT 
	emp_no, 
	first_name, 
	last_name, 
	hire_date 
FROM employees 
WHERE EXTRACT(YEAR FROM hire_date) = 1986;

--3
SELECT 
    dm.emp_no, 
    e.last_name, 
    e.first_name, 
    dm.dept_no, 
    d.dept_name
FROM dept_manager dm
INNER JOIN departments d ON dm.dept_no = d.dept_no
INNER JOIN employees e ON dm.emp_no = e.emp_no
ORDER BY dm.dept_no;
	
--4
SELECT 
    e.emp_no, 
    e.last_name, 
    e.first_name, 
    de.dept_no, 
    d.dept_name
FROM employees e
INNER JOIN dept_emp de ON e.emp_no = de.emp_no
INNER JOIN departments d ON de.dept_no = d.dept_no
ORDER BY e.emp_no;
	
--5
SELECT 
    first_name, 
    last_name, 
    sex
FROM employees
WHERE first_name = 'Hercules' 
AND last_name LIKE 'B%'
ORDER BY last_name;

--6
SELECT 
    e.emp_no, 
    e.last_name, 
    e.first_name
FROM employees AS e
INNER JOIN dept_emp AS de ON e.emp_no = de.emp_no
INNER JOIN departments AS d ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales';

--7
SELECT 
    e.emp_no, 
    e.last_name, 
    e.first_name, 
    d.dept_name
FROM 
    employees e
INNER JOIN dept_emp de ON e.emp_no = de.emp_no
INNER JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name IN ('Sales', 'Development');

--8
SELECT 
	last_name, 
	COUNT(*) AS frequency
FROM employees
GROUP BY last_name
ORDER BY frequency DESC;