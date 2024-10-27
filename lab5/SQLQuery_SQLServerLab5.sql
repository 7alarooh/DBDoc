--                           SQLServer Lab 5


-- [1] ⦁	Create a stored procedure without parameters to 
--     show the number of students per department name.
--     [use ITI DB] 
use ITI

create procedure getStudentCountPerDepartment
as 
begin
    select d.Dept_Name AS DepartmentName,
           COUNT(s.St_Id) AS StudentCount
	from Department d LEFT JOIN 
         Student s on d.Dept_Id = s.Dept_Id
    group by d.Dept_Name
    order by d.Dept_Name
end

exec getStudentCountPerDepartment

-- [2] ⦁	Create a stored procedure that will check for 
--     the # of employees in the project p1 if they are 
--     more than 3 print message to the user “'The number 
--     of employees in the project p1 is 3 or more'” if they 
--     are less display a message to the user “'The following
--     employees work for the project p1'” in addition to the
--     first name and last name of each one. [Company DB] 
 use Company_SD

 create procedure checkEmployeeCountForProjectP1
as 
begin
    declare @EmployeeCount int;

    -- Count the number of employees working on project 'p1'
    select @EmployeeCount = count(*)
    from Works_for wf
    join Project p on wf.Pno = p.Pnumber
    where p.Pname = 'p1'

    -- Check if the count is 3 or more
    if @EmployeeCount >= 3
    begin
        select 'The number of employees in the project p1 is 3 or more'
    end

    else
    begin
        select 'The following employees work for the project p1:'

        -- Select the first name and last name of each employee working on 'p1'
        select e.Fname, e.Lname
        from Employee e
        join Works_for wf on e.SSN = wf.ESSN
        join Project p on wf.Pno = p.Pnumber
        WHERE p.Pname = 'p1'
    end
end

exec checkEmployeeCountForProjectP1;

