--                           SQLServer Lab 5


-- [1] ⦁	Create a stored procedure without parameters to 
--     show the number of students per department name.
--     [use ITI DB] 
create procedure getStudentCountPerDepartment
as 
begin
    select d.Dept_Name AS DepartmentName,
           COUNT(s.St_Id) AS StudentCount
	from Department d LEFT JOIN 
         Student s on d.Dept_Id = s.Dept_Id
    group by d.Dept_Name
    order by d.Dept_Name;
end;

exec getStudentCountPerDepartment;
