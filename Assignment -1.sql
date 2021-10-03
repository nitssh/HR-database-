#Query1
SELECT  first_name as "First Name",  last_name as "Last Name" FROM hr.employees

#Query2
SELECT  distinct department_id from hr.employees; 

#Query3
SELECT * from hr.employees ORDER BY First_name desc;

#Query4
SELECT first_name, last_name, salary,salary*.15pf from hr.employees 

#Query5
SELECT employee_id,First_name,last_name,salary from hr.employees order by salary asc;

#Query6
select sum(salary) from hr.employees

#Query7
select max(salary),min(salary) from hr.employees

#Query8 
select avg(salary),count(*) from hr.employees

#Query9
select count(*) from hr.employees

#Query10
select count(*)job_id from hr.jobs

#Query11
select upper(first_name) from hr.employees

#Query12
select substring(first_name,1,3) from hr.employees

#Query13
select trim(first_name) from hr.employees

#Query14
select first_name,last_name, length(first_name)+ length(last_name) 'length of Names' from hr.employees 

#Query15
select * from hr.employees where first_name regexp '[0-9]';

#Query16
select first_name,last_name,salary from hr.employees where salary not between 10000 and 15000

#Query17
select first_name,last_name,department_id from hr.employees where department_id in (30,100)order by department_id asc;

#Query18
select first_name,last_name,salary,department_id from hr.employees where salary not between 10000 and 15000 and department_id in (30,100)

#Query19
select first_name,last_name,hire_date from hr.employees where year (hire_date) like '1987%'

#Query20
select first_name from hr.employees where first_name like '%b%' and first_name like '%c%'

#Query21
SELECT last_name, job_id, salary FROM hr.employees WHERE job_id IN ('IT_PROG', 'SH_CLERK') AN;

#Query22
select last_name from hr.employees where last_name like '______'

#Query23
select last_name from hr.employees where last_name like '__e%';

#Query24
SELECT job_id, GROUP_CONCAT(employee_id,' ' )  'Employees ID'  FROM hr.employees GROUP BY job_id;

#Query25
update hr.employees set phone_number = replace(phone_number,'124','999') where phone_number like '%124%';

#Query26
select * from hr.employees where length (first_name) >= 8;

#Query27
UPDATE hr.employees SET email = CONCAT(email,'@example.com');

#Query28
select right(phone_number,4) as 'Ph.No.' FROM hr.employees;

#Query29
SELECT location_id, street_address, SUBSTRING_INDEX(REPLACE(REPLACE(REPLACE(street_address,',',' '),')',' '),'(',' '),' ',-1) AS 'Last--word-of-street_address'FROM hr.locations;

#Query30
SELECT * FROM hr.locations WHERE LENGTH(street_address) <= (SELECT  MIN(LENGTH(street_address))FROM hr.locations);

#Query31
SELECT job_title, SUBSTR(job_title,1, INSTR(job_title, ' ')-1) FROM hr.jobs;

#Query32
SELECT first_name, last_name FROM hr.employees WHERE INSTR(last_name,'C') > 2;

#Query33
SELECT first_name "Name",LENGTH(first_name) "Length"FROM hr.employees WHERE first_name LIKE 'J%'OR first_name LIKE 'M%'OR first_name LIKE 'A%'ORDER BY first_name ;

#Query34
SELECT first_name, LPAD(salary, 10, '$') SALARY FROM hr.employees;

#Query35
SELECT left(first_name, 8), REPEAT('$', FLOOR(salary/1000)) 'SALARY($)', salary FROM hr.employees ORDER BY salary DESC;

#Query36
SELECT employee_id,first_name,last_name,hire_date FROM hr.employees WHERE POSITION("07" IN DATE_FORMAT(hire_date, '%d %m %Y'))>0;
