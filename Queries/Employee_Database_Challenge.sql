-- DELIVERABLE 1

select * from employees;

-- Create a new table called retirement_titles
select employees.emp_no, employees.first_name, employees.last_name, 
	titles.title, titles.from_date, titles.to_date
into retirement_titles
from employees
inner join titles on employees.emp_no = titles.emp_no
where (birth_date between '1952-01-01' and '1955-12-31')
order by emp_no;

drop table retirement_titles;

select * from retirement_titles;

-- From starter code

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
rt.first_name,
rt.last_name,
rt.title

INTO unique_titles
FROM retirement_titles as rt
ORDER BY rt.emp_no, rt.to_date DESC;

select * from unique_titles;

-- Query number of employees by their most recent job title who are about to retire
select count(title) as "count"
from unique_titles;

create table retiring_titles as
select count(title) as "count", title
from unique_titles
group by title
order by count desc;

select * from retiring_titles;

-- DELIVERABLE 2

select * from mentorship_eligibility;

create table mentorship_eligibility as
select distinct on (e.emp_no) e.emp_no, e.first_name, e.last_name, e.birth_date,
	de.from_date, de.to_date, t.title
from employees as e
join dept_emp as de
on (de.emp_no = e.emp_no)
join titles as t
on (t.emp_no = de.emp_no)
where (birth_date between '1965-01-01' and '1965-12-31')
order by e.emp_no;

select * from dept_emp;

CREATE TABLE dept_emp (
    dept_no VARCHAR(4) NOT NULL,
    emp_no INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (emp_no)
);

-- DELIVERABLE 3

create table qualified_mentorship as
select distinct on (e.emp_no) e.emp_no, e.first_name, e.last_name, e.birth_date,
	de.from_date, de.to_date, t.title
from employees as e
join dept_emp as de
on (de.emp_no = e.emp_no)
join titles as t
on (t.emp_no = de.emp_no)
where (birth_date between '1965-01-01' and '1965-12-31')
and (title = 'Senior Engineer' or title = 'Staff' or title = 'Senior Staff' or title = 'Technique Leader')
order by e.emp_no;

select * from qualified_mentorship;

drop table qualified_mentorship;

select count(emp_no) from qualified_mentorship;