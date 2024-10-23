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