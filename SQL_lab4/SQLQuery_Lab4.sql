--                          SQL lab 4 

-- Note: Use ITI DB 
         use ITI

-- 1.  Create a scalar function that takes date and returns 
-- Month name of that date.
create function GetMonthName (@inputDate Date)
returns nvarchar(20)
as
begin declare @monthName nvarchar(20)
set @monthName =DATENAME(month, @inputDate)
return @monthName
end

select dbo.GetMonthName('2024-10-23')

drop function GetMonthName

-- 2.  Create a multi-statements table-valued function 
-- that takes 2 integers and returns the values between them.
create function GetValueBetween (@startNum int, @endNum int)
returns @valuesTable table (value int)
begin declare @currNum int
  set @currNum=@startNum+1

  while @currNum < @endNum
  begin insert into @valuesTable(value)
  values(@currNum)

  set @currNum=@currNum+1
end
return
end

select * from GetValueBetween(5,15)
drop function GetValueBetween

-- 3.  Create inline function that takes Student No 
-- and returns Department Name with Student full name. 
create function GetStudentAndDepartment(@studentNum int)
returns  table
as return (select s.St_Fname+' '+s.St_Lname as [Full Name],
                  d.Dept_Name as [Department Name]
           from Student s join Department d
		        on s.Dept_Id=d.Dept_Id
		   where s.St_Id=@studentNum)

select * from GetStudentAndDepartment(3)
drop function GetStudentAndDepartment
