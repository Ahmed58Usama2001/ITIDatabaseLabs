use ITI

--1
select count(St_Age) as NumOfStudents
from Student

--2
select distinct Ins_Name
from Instructor

--3
select s.St_Id,ISNULL(s.St_Fname+' '+s.St_Lname,'No Name') as FullName , ISNULL(d.Dept_Name,'No Name') as DeptName
from Student s inner join Department d
on s.Dept_Id=d.Dept_Id

--4
select i.Ins_Name,ISNULL(d.Dept_Name,'No Department') as DeptName
from Instructor i left outer join Department d
on i.Dept_Id=d.Dept_Id

--5
select s.St_Fname+' '+s.St_Lname as FullName , c.Crs_Name
from Student s inner join Stud_Course sc on s.St_Id=sc.St_Id
inner join Course c on sc.Crs_Id=c.Crs_Id
where sc.Grade is not null


--6
select t.Top_Name, count (c.Crs_Id) as NumOfCourses
from Topic t inner join Course c 
on t.Top_Id=c.Top_Id
group by t.Top_Name

--7
select min(salary) as minimumSalary,max(salary) as maximumSalary
from Instructor

--8
select *
from Instructor
where Salary< (select avg(Salary) from Instructor)

--9
select d.Dept_Name
from Department d inner join Instructor i on d.Dept_Id=i.Dept_Id
where i.Ins_Id= (SELECT top(1) Ins_Id
				FROM Instructor
				ORDER BY Salary DESC )

--10
select Salary
from (select i.* , ROW_NUMBER() over (order by salary) as RN
		from Instructor i) as NumberedTable
where RN<=2

--11


--12
select avg(salary) as AvgSalary
from Instructor

--13
select s1.St_Fname, s2.*
from Student s1 inner join Student s2
on s1.St_super=s2.St_Id

--14
select d.Dept_Name,temp.Salary
from (select i.* , ROW_NUMBER() over (partition by i.dept_id order by salary) as RN
		from Instructor i) as temp inner join Department d on temp.Dept_Id=d.Dept_Id
where RN<=2

--15
select d.Dept_Name,temp.St_Fname+' '+temp.St_Lname as FullName
from (select s.* , ROW_NUMBER() over (partition by s.dept_id order by newid()) as RN
		from Student s) as temp inner join Department d on temp.Dept_Id=d.Dept_Id
	where RN=1