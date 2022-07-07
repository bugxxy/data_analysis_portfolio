-- query that ouptu all the contents of the table
SELECT *
FROM salaries;

-- query that returns the names of all professors 
select professor_name
from salaries;

-- query that returns all departments with no duplicates
select distinct department
from salaries;

-- query that returns numberof professors whose salary is greater than 150000
select count(professor_name)
from salaries
where salary > 150000;

-- query that returns all departments and their aggregate salaries
select department, sum(salary)
from salaries
group by department
order by department asc; 

-- query that returns the name and salary of the professor with highest salary
select professor_name, max(salary)
from salaries;

-- query that returns name and salary of the professor with the highest salary in the computer science department
select professor_name, max(salary)
from salaries
where department = 'computer Science';

-- query that returns the name and salaries of the top 5 highest earning professors
select professor_name, salary
from salaries
order by salary desc limit 5;

-- query that returns the name and salary of the lowest earning professor
SELECT professor_name, min(salary)
from salaries;

-- query that returns the department professor zaniola works in
select department
from salaries
where professor_name = 'zaniolo';

-- query that returns all the professor names that begin with the letter C 
select professor_name
from salaries
where professor_name like 'c%';

-- query that returns the third highest salary in the table. 
select distinct salary
from salaries
order by salary desc limit 1 offset 2;

-- query for all conttecnt in checked_out table 
select *
from checked_out;

-- query that returns the first and last name of people who share their last name with someone that also checked out a book
select distinct a.first_name, a.last_name
from checked_out as a, checked_out as b
where a.last_name = b.last_name and a.first_name != b.first_name;

-- query for all content in books table 
select *
from books;

-- query that returns the first and last name of all people who checked out a book by terry crews
select distinct first_name, last_name
from checked_out
inner join
books 
on checked_out.book_id = books.book_id
where author = 'terry crews';

-- query that returns the first and last names of all people who checked out 'to kill a mockingbird' by harper lee
select distinct first_name , last_name
from checked_out
inner join 
books
on checked_out.book_id = books.book_id
where author = 'harper lee' and book_name = 'to kill a mockingbird';

-- query that returns the average salary of professors in the table
select avg(salary)
from salaries;

-- each professor in the computer science department just got a 10000 dollar raise. write a query that gives
-- the name and new salaries of the computer science professor
select professor_name, salary +10000 as new_salary
from salaries
where department = 'computer science';

-- query that returns the name and salary of all professors who make more than 4 times as much as the lowest paid professor
select professor_name, salary
from salaries
where salary > (select min(salary) from salaries)*4;

-- query that returns the amount of unique authors who have written books
select count(distinct(author))
from books;

-- query that returns the name and salary of professors wo eaarn between 120000 and 250000 a year
select professor_name, salary
from salaries
where salary between 120000 and 250000;

-- query that returns all professors who either work in the anthropology dept or makes more than 150000 a year
select professor_name
from salaries
where department = 'anthropology' or salary > 150000;

-- query that returns the highest salary in the computer sciene department
select max(salary)
from salaries
where department = 'computer science';

-- query that returns the amount of professors who earn more than twice as much as the lowest paid professor in the political science dept
select count(professor_name)
from salaries
where salary > 2 * (select min(salary) from salaries where department = 'political science');

-- query that returns the names of all books checked out by justin lee
select book_name
from books
inner join
checked_out
on books.book_id = checked_out.book_id
where first_name = 'justin' and last_name = 'lee';

