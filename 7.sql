use ITI

--1
create function GetMonth(@date date)
returns varchar(10)
begin
	declare @month varchar(10)
	Select @month=MONTH(@date)
	return @month
end

select dbo.GetMonth(getdate())

--2
create Function GetValuesInBetween(@x int , @y int)
returns @t table
			(
			number int
			)
as
begin
	while(@x<@y)
	begin
		insert into @t
		select @x
		set @x=@x+1
	end
	return
end

select *
from dbo.GetValuesInBetween(5  , 10 )

--3
alter schema dbo transfer secure.student
alter schema dbo transfer secure.course


create function GetStudData(@StudNo int)
returns table
as
	return
	(
		select s.St_Fname+' '+s.St_Lname as FullName, d.Dept_Name
		from Student s inner join Department d
		on s.Dept_Id=d.Dept_Id
		where s.St_Id=@StudNo

	)

select * from GetStudData(10)

--4
CREATE FUNCTION GetStudentNameStatus (@StudentID INT)
RETURNS VARCHAR(100)
AS
BEGIN
    DECLARE @FirstName NVARCHAR(50);
    DECLARE @LastName NVARCHAR(50);
    DECLARE @Message VARCHAR(100);

    SELECT 
        @FirstName = student.St_Fname, 
        @LastName = student.St_Lname
    FROM 
        student 
    WHERE 
        student.St_Id = @StudentID;

    SET @Message = 
        CASE
            WHEN @FirstName IS NULL AND @LastName IS NULL THEN 'First name & last name are null'
            WHEN @FirstName IS NULL THEN 'First name is null'
            WHEN @LastName IS NULL THEN 'Last name is null'
            ELSE 'First name & last name are not null'
        END;

    RETURN @Message;
END;

select dbo.GetStudentNameStatus(20)


--5
create function GetManagerDate(@mgr_no int)
returns table
as
return
(
	select d.Dept_Name,i.Ins_Name,d.Manager_hiredate
	from Department d inner join Instructor i
	on d.Dept_Manager=i.Ins_Id
	where i.Ins_Id=@mgr_no
)

select *
from dbo.GetManagerDate(100)

--6
CREATE FUNCTION GetStudentNameDetails (@InputString NVARCHAR(50))
RETURNS @ResultTable TABLE (
    StudentID INT,
    Name NVARCHAR(100)
)
AS
BEGIN
    IF @InputString = 'first name'
    BEGIN
        INSERT INTO @ResultTable (StudentID, Name)
        SELECT student.St_Id, ISNULL(St_Fname, '') 
        FROM Student;
    END
    ELSE IF @InputString = 'last name'
    BEGIN
        INSERT INTO @ResultTable (StudentID, Name)
        SELECT student.St_Id, ISNULL(St_Lname, '') 
        FROM Student;
    END
    ELSE IF @InputString = 'full name'
    BEGIN
        INSERT INTO @ResultTable (StudentID, Name)
        SELECT student.St_Id, ISNULL(St_Fname, '') + ' ' + ISNULL(St_Lname, '') 
        FROM Student;
    END

    RETURN;
END;


select *
from dbo.GetStudentNameDetails(20)

--7
select St_Id,Left(St_Fname,len(St_Fname)-1)
from student

--8
delete from Stud_Course
from student s inner join stud_course sc
on s.St_id=sc.St_id
inner join department d
on d.dept_id=s.dept_id
where d.dept_name='SD'