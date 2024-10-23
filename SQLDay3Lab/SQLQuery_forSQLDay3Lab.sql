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
where  e.Fname + ' ' + e.Lname = ( select  d.Dependent_name
                                    from dependent d 
									where d.Dependent_name like e.Fname + ' ' + e.Lname+'%')

--[10] Display the employee number and name if at least one of them 
-- have dependents (use exists keyword) self-search
select SSN, Fname+' '+Lname as [Full Name]
from Employee
where SSN in (select ESSN
              from Dependent)

-- [11] In the department table insert new department 
-- called "DEPT IT" , with id 100, employee with 
-- SSN = 112233 as a manager for this department.
-- The start date for this manager is '1-11-2006'
insert into Departments (Dnum,Dname,MGRSSN,[MGRStart Date])
       values(100,'DEPT IT',112233,'01-11-2006')

-- [12] Do what is required if you know that : Mrs.Noha 
-- Mohamed(SSN=968574)  moved to be the manager of the 
-- new department (id = 100), and they give you(your SSN =102672) 
-- her position (Dept. 20 manager) 
----------First try to update her record in the department table
----------Update your record to be department 20 manager.
----------Update the data of employee number=102660 to be 
------------in your teamwork (he will be supervised by you)
------------(your SSN =102672)

update Departments
set MGRSSN = 968574
where Dnum=100;

update Departments
set MGRSSN = 102672
where Dnum=20;

update Employee
set Superssn = 102672
where SSN=102660;

-- [13] Unfortunately the company ended the contract with 
-- Mr. Kamel Mohamed (SSN=223344) so try to delete his data 
-- from your database in case you know that you will be temporarily 
-- in his position.
--    Hint: (Check if Mr. Kamel has dependents, works as a 
--    department manager, supervises any employees or works 
--    in any projects and handle these cases).
delete from Dependent
where ESSN=223344;

update Departments
set MGRSSN=102672
where MGRSSN=223344

update Employee
set Superssn=102672
where Superssn=223344

update Works_for
set ESSn=102672
where ESSn=223344

delete from Employee
where SSN= 223344

-- [14] Try to update all salaries of employees who work 
-- in Project ‘Al Rabwah’ by 30%
update Employee
set Salary=Salary*1.30
where SSN in (select ESSn
               from Works_for 
			   where pno=(select Pnumber
			              from Project 
						  where Pname='Al Rabwah'))



--  Part 2:

--                 Note: Use ITI DB

-- [1] Create a view that displays student full name, course name 
-- if the student has a grade more than 50. 

create view Student_Course_View 
as
select s.St_Fname+ ' '+s.St_Lname as Full_Name, c.Crs_Name as Course_Name
from Student s
join stud_Course sc on s.St_Id = sc.St_Id   
join Course c on sc.Crs_Id = c.Crs_Id       
where sc.Grade > 50;     

-- [2]  Create an Encrypted view that displays manager 
-- names and the topics they teach. 

create view Encrypted_Manager_Topic_View
as
select d.Dept_Manager as Manager_Name,
    (select t.Top_Name
     from Course c
     JOIN Topic t on c.Top_Id = t.Top_Id
     JOIN Ins_course ic on c.Crs_Id = ic.Crs_Id
     where ic.Ins_Id IN ( select i.Ins_Id
	                      from Instructor i
                          where i.Dept_Id = d.Dept_Id
     )) as Topic_Name
from Department d
where d.Dept_Manager IS NOT NULL;






