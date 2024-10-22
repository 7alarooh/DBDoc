--      SQL Day3 Lab       --

--  Part 1:

-- [1] Display (Using Union Function)
 -- The name and the gender of the dependence 
 -- that's gender is Female and depending on Female Employee
 --  And the male dependence that depends on Male Employee.
select d.Dependent_name , d.sex
from Dependent d
where d.sex='F' and d.ESSN in (select SSN from Employee where Sex='F')

union

select d.Dependent_name , d.sex
from Dependent d left join Employee e on d.ESSN=e.SSN
where d.sex='M' and d.ESSN in (select SSN from Employee where Sex='M')


--[2] For each project, list the project name and the 
--total hours per week (for all employees) spent on that project.

select p.Pname, sum(w.Hours)
from Project p inner join Works_for w 
on p.Pnumber=w.Pno group by p.Pname

--[3] Display the data of the department which has 
-- the smallest employee ID over all employees' ID.
select *
from Departments
where Dnum=(select Dnum
            from Employee
			where SSN=(select min(ssn)
			           from Employee))
--[4] For each department, retrieve the department name 
-- and the max, min and average salary of its employees.
select d.Dname,
       (select max(e.Salary)
	    from Employee e
		where e.Dno=d.Dnum) as [Max Salary],
		(select min(e.Salary)
	    from Employee e
		where e.Dno=d.Dnum) as [Min Salary],
		(select avg(e.Salary)
	    from Employee e
		where e.Dno=d.Dnum) as [Average Salary]
from Departments d

-- [5] List the full name of all managers who have no dependents.
select Fname+' '+Lname as [Full Name]
from Employee e
where e.Superssn not in (select d.ESSN from Dependent d)

-- [6] For each department-- if its average salary is less than 
--the average salary of all employees-- display its number, 
--name and number of its employees.
select d.Dnum, d.Dname,(select count(*)
                        from Employee e
						where e.Dno=d.Dnum) As [number of Employees]
from Departments d
where (select avg(Salary)
       from Employee e
	   where e.Dno=d.Dnum)<(select avg(salary) from Employee )

-- [7] Retrieve a list of employees names and the projects names
-- they are working on ordered by department number and within 
-- each department, ordered alphabetically by last name, first name.

select e.Fname+' '+e.Lname As [Full Name],
       STRING_AGG( p.Pname, ' / ') as [Projects]
from Employee e 
join
Works_for w on e.SSN=w.ESSn
join
Project p on w.Pno=p.Pnumber
group by 
e.SSN, e.Fname,e.Lname
order by  e.Lname, e.Fname 


-- [8] Try to get the max 2 salaries using subquery
select salary
from employee
where salary = (select max(salary) 
                from employee) 
union
select salary
from employee
where salary = (select max(salary) 
                from employee 
				where salary < (select max(salary) 
				                from employee))  

--[9] Get the full name of employees that is similar to any dependent name
select  e.Fname+' '+ e.Lname AS FullName
from  employee e
where  e.Fname + ' ' + e.Lname in ( select  d.Dependent_name
                                    from dependent d)




