use Company_SD


--⦁	Restore Company DB then create the following Queries:


--⦁	Display all the employees Data
select *
from Employee

--⦁	Display the employee First name, last name, Salary and Department number.
select Fname, Lname, Salary, Dno 
from Employee

--⦁	Display all the projects names, locations and the department which is responsible about it.
SELECT Dnum, Pname, Plocation
FROM Project

--⦁	If you know that the company policy is to pay an annual commission for 
-- each employee with specific percent equals 10% of his/her annual salary .
-- Display each employee full name and his annual commission in an ANNUAL COMM column (alias).
select  Fname + ' '+ Lname as [full name], 
(Salary *12*0.10) As ANNUAL_COMM
from Employee

--⦁	Display the employees Id, name who earns more than 1000 LE monthly.
select SSN ,Fname + ' '+ Lname as [full name]
from Employee
where Salary>1000

--⦁	Display the employees Id, name who earns more than 10000 LE annually.
select SSN ,Fname + ' '+ Lname as [full name]
from Employee
where Salary*12>10000

--⦁	Display the names and salaries of the female employees 
select Fname + ' '+ Lname as [full name],salary 
from Employee
where sex='f'

--⦁	Display each department id, name which managed by a manager with id equals 968574
select Dnum,Dname,MGRSSN 
from Departments
where MGRSSN=968574

--⦁	Dispaly the ids, names and locations of  the pojects which controled with department 10.
SELECT       Pnumber,  Pname, Plocation
FROM            Project
where Dnum=10

--⦁	Insert your personal data to the employee table as a new employee in department 
-- number 30, SSN = 102672, Superssn = 112233, salary=3000.
insert into Employee (SSN,Fname,Lname,Dno,Superssn,Salary,Sex,Bdate)
values (102672,'Khalid', 'Salim', 30,112233,3000,'M','1997-03-04')

--⦁	Insert another employee with personal data your friend as new employee in 
-- department number 30, SSN = 102660, but don’t enter any value for salary 
-- or supervisor number to him.
insert into Employee (SSN,Fname,Lname,Dno,Sex,Bdate)
values (102660,'Aziza', 'Khalid', 30,'F','2003-03-04')

--⦁	Upgrade your salary by 20 % of its last value.
update employee
set Salary =salary * 1.20 
where SSN =102660

-----
--⦁	Joins



