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

select * from GetStudentAndDepartment(5)

--drop function GetStudentAndDepartment

select * from Student
-- 4. Create a scalar function that takes Student ID and 
-- returns a message to user  
--     a. If first name and Last name are null then 
--        display 'First name & last name are null' 
--     b. If First name is null then display 'first 
--        name is null' 
--     c. If Last name is null then display 'last 
--        name is null' 
--     d. Else display 'First name & last name are not null'

create function checkStudentName (@studentNum int)
returns nvarchar(50)
as begin declare @firstName nvarchar(50)
         declare @lastName nvarchar(50)
		 declare @messageDisplay nvarchar(50)

		 select @firstName=St_Fname, @lastName=St_Lname
		 from Student
		 where St_Id=@studentNum

		 --to check
		     if @firstName is null and @lastName is null
		        set @messageDisplay ='First and last name are null !'
		else if @firstName is null 
		        set @messageDisplay ='First name is null !'
		else if @lastName is null 
		        set @messageDisplay ='Last name is null !'
        else 
		     set @messageDisplay ='First and last name are not null !'
		return @messageDisplay
end

select dbo.checkStudentName(14)

--drop function checkStudentName

select * from Student

-- 5. Create inline function that takes integer which 
-- represents manager ID and displays department 
-- name, Manager Name and hiring date 
create function getManagerDetail (@managerID int)
returns  table
as return (select d.Dept_Name as [Department Name],
                  i.Ins_Name as [Manager Name],
				  d.Manager_hiredate as[Hiring Date]
           from Department d join Instructor i on d.Dept_Id=i.Dept_Id
		   where d.Dept_Manager =@managerID
		   )

select * from getManagerDetail(15)

--drop function getManagerDetail

select * from Department