-- 1. List the following details of each employee: employee number, last name, first name, gender, and salary.
select e.emp_no, last_name, first_name, gender, salary from employees e
	left join salaries s ON
	e.emp_no = s.emp_no
	order by salary desc;
	
-- 2. List employees who were hired in 1986.
select emp_no, first_name, last_name, hire_date from employees
	where EXTRACT(Year from hire_date) = 1986
	order by hire_date;

-- 3. List the manager of each department with the following information:
--    department number, department name, the manager's employee number, 
--    last name, first name, and start and end employment dates.
select d.dept_no, dept_name, e.emp_no, first_name, last_name, from_date, to_date
	from departments d, employees e, dept_manager dm
	where d.dept_no = dm.dept_no AND
		dm.emp_no = e.emp_no;
	
-- 4. List the department of each employee with the following information:
-- employee number, last name, first name, and department name.
select e.emp_no, e.last_name, e.first_name, dp.dept_name
	from employees e, departments dp, dept_emp de
	where e.emp_no = de.emp_no AND
		de.dept_no = dp.dept_no;
	
-- 5. List all employees whose first name is "Hercules" and last names begin with "B."
select * from employees
	where first_name = 'Hercules'
	and last_name LIKE 'B%';
	
-- 6. List all employees in the Sales department, including their employee number,
--    last name, first name, and department name.
select emp_no, last_name, first_name, 'Sales' AS "Department"
	from employees
		where emp_no in(
			select emp_no
				from dept_emp
					where dept_no
					in (
						select dept_no from departments
						where dept_name = 'Sales'
					)
			);

-- 7. List all employees in the Sales and Development departments, 
-- including their employee number, last name, first name, and department name.
select e.emp_no, e.last_name, e.first_name, d.dept_name from employees e
	join dept_emp de ON
	e.emp_no = de.emp_no
		join departments d ON
		d.dept_no = de.dept_no
	where d.dept_name = 'Sales' or d.dept_name = 'Production';
	
-- 8. In descending order, list the frequency count of employee last names,
-- i.e., how many employees share each last name.
select last_name, count(last_name)
	from employees
	group by last_name
	order by count desc;
	
-- bonus: get emp_no, salary, and title
select e.emp_no, s.salary, t.title from employees e
	join salaries s ON
	e.emp_no = s.emp_no
		join titles t ON
		s.emp_no = t.emp_no;