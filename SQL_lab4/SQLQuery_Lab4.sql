--                          SQL lab 4 

-- Note: Use ITI DB 

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

-- 2.  Create a multi-statements table-valued function 
-- that takes 2 integers and returns the values between them.
