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

-- [3] ⦁	Create a stored procedure that will be used in case
--      there is an old employee has left the project and a new one 
--      become instead of him. The procedure should take 3 parameters 
--      (old Emp. number, new Emp. number and the project number) and 
--      it will be used to update works_on table. [Company DB]

use Company_SD

create procedure replaceEmployeeInProject
    @OldEmpNum int,
    @NewEmpNum int,
    @ProjectNum int
as 
begin
    if  exists (select 1 
	            from Works_for 
				where ESSN = @OldEmpNum and Pno = @ProjectNum)
    begin
        -- Remove the old employee from the project
        delete from Works_for
        where ESSN = @OldEmpNum and Pno = @ProjectNum;
        -- Insert the new employee into the project with the same project number
        insert into Works_for (ESSN, Pno, Hours)
        values (@NewEmpNum, @ProjectNum, 0)  -- Defaulting hours to 0; adjust as necessary

        select 'Employee has been successfully replaced in the project.'
    end
    else
    begin
        select 'The old employee was not found in the specified project.'
    end
end

exec replaceEmployeeInProject @OldEmpNum = 102672, @NewEmpNum = 521634, @ProjectNum = 100;


