drop table if exists titles cascade;
drop table if exists employees cascade;
drop table if exists departments cascade;
drop table if exists dept_manager cascade;
drop table if exists dept_emp cascade;
drop table if exists salaries cascade;

create table titles (
	title_id varchar(50) primary key,
	title varchar(50) 
);

select * from titles;

COPY titles FROM 'C:\Program Files\PostgreSQL\15\data\titles.csv' DELIMITER ',' CSV HEADER;



create table employees (
	emp_no integer,
	emp_title_id varchar(30),
	birth_date date,
	first_name varchar(50),
	last_name varchar(50),
	sex varchar (10),
	hire_date date,
	primary key (emp_no),
	foreign key (emp_title_id) references titles(title_id)
);

select * from employees;

COPY employees FROM 'C:\Program Files\PostgreSQL\15\data\employees.csv' DELIMITER ',' CSV HEADER;

create table departments (
	dept_no varchar(50) primary key,
	dept_name varchar(50)
);

select * from departments;

COPY departments FROM 'C:\Program Files\PostgreSQL\15\data\departments.csv' DELIMITER ',' CSV HEADER;

create table dept_manager (
	dept_no varchar(50),
	emp_no integer not null,
	primary key (dept_no, emp_no),
	foreign key (emp_no) references employees(emp_no),
	foreign key (dept_no) references departments(dept_no)
);

select * from dept_manager;

COPY dept_manager FROM 'C:\Program Files\PostgreSQL\15\data\dept_manager.csv' DELIMITER ',' CSV HEADER;


create table dept_emp (
	emp_no integer not null,
	dept_no varchar(50),
	primary key (emp_no, dept_no),
	foreign key (emp_no) references employees(emp_no),
	foreign key (dept_no) references departments(dept_no)
);

select * from dept_emp;

COPY dept_emp FROM 'C:\Program Files\PostgreSQL\15\data\dept_emp.csv' DELIMITER ',' CSV HEADER;


create table salaries (
	emp_no integer,
	salary integer not null,
	primary key (emp_no),
	foreign key (emp_no) references employees(emp_no)
);

select * from salaries;

COPY salaries FROM 'C:\Program Files\PostgreSQL\15\data\salaries.csv' DELIMITER ',' CSV HEADER;


select last_name, first_name, sex, salary
from employees
left JOIN salaries ON employees.emp_no = salaries.emp_no;

SELECT first_name, last_name, hire_date  
FROM employees 
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31'
ORDER BY hire_date asc;

SELECT departments.dept_no, departments.dept_name, dept_manager.emp_no, employees.last_name, employees.first_name
FROM departments 
JOIN dept_manager ON departments.dept_no = dept_manager.dept_no
JOIN employees ON dept_manager.emp_no = employees.emp_no;

SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name, departments.dept_no
FROM employees
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
JOIN departments ON dept_emp.dept_no = departments.dept_no;

SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

SELECT employees.emp_no, employees.last_name, employees.first_name
FROM employees
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
JOIN departments ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales';

SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
JOIN departments ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name in ('Sales', 'Development');

SELECT last_name, COUNT(*) as count
FROM employees
GROUP BY last_name
ORDER BY count DESC;


