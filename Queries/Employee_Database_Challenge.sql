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

