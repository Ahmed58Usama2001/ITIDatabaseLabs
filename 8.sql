--Part 1


USE ITI

--1
create view V1(sname,cname)
as
  select [FullName]= St_Fname+' '+St_Lname , c.Crs_Name
  from Student s , Course c, Stud_Course sc
  where s.St_Id = sc.St_Id and sc.Crs_Id = c.Crs_Id and sc.Grade > 50

select * from V1


--2
create view V2(iname , cname)
with encryption
as
  select i.Ins_Name , Course.Crs_Name
  from Department d , Instructor i , Ins_Course , Course
  where d.Dept_Manager = i.Ins_Id and i.Ins_Id = Ins_Course.Ins_Id and course.Crs_Id = Ins_Course.Crs_Id

select * from V2
sp_helptext'V2'


--3
create view V3(iname,dname)
as
  select i.Ins_Name , d.Dept_Name
  from Instructor i , Department d
  where i.Dept_Id = d.Dept_Id and d.Dept_Name in('SD' , 'Java')

select * from V3


--4
create view V4
as
  select *
  from Student
  where St_Address in('alex','cairo')
with check option

select * from V4

update V4
set St_Address = 'tanta'
where St_Address = 'alex'


--5
USE SD

create view V5(pname,penum)
as
  select p.PName , count(WO.EmpNo)
  from Company.project P , Works_on WO
  where p.PNo=wo.PNo
  group by p.PName

select * from V5

--6
USE ITI

create clustered index i1
on Department(Manager_hiredate)
-- Cannot make clustered index because there is one created because of PK, each table should has only one clustered index


--7
create unique index i0
on student(st_age)
-- cannot preform --> the constraint should fit the old saved data in the column


--8
merge into lastT as ttarget
using dailyT as ssource
on xid=yid
  when matched then -- didn't add additional conditions with (and) but you can
  update
  set xvalue = yvalue
  when not matched by target then
  insert
  values(yid,yname,yvalue)
  when not matched by source then
  delete
output $action ;


-- Part 2

Use SD

--1
create view v_clerk
as
  select e.EmpNo , p.PNo , wo.Enter_Date
  from HR.Employee e , Company.project p , Works_On wo
  where e.EmpNo = wo.EmpNo and wo.PNo = p.PNo and wo.Job = 'Clerk'

select * from v_clerk


--2
create view v_without_budget
as
  select *
  from Company.project p
  where p.Budget is null

  select * from v_without_budget


--3
create view v_count
as
  select p.PName , count(wo.Job) as numofjobs
  from Company.project p , Works_On wo
  where wo.PNo=p.PNo
  group by p.PName

select * from v_count


--4
create view v_project_p2
as
  select vc.EmpNo
  from v_clerk vc , Company.project p
  where p.PNo = vc.PNo and p.PNo = 2

select * from v_project_p2


--5
alter view v_without_budget
as
  select *
  from Company.project p
  where p.Budget is null and p.PNo in(1,2)


--6
drop view v_clerk
drop view v_count


--7
create view v00
as
  select e.EmpNo , e.EmpLName
  from Company.Department d , HR.Employee e
  where e.DeptNo = d.DeptNo and d.DeptNo = 2

select * from v00


--8
select EmpLName
from v00
where EmpLName like '%j%'


--9
create view v_dept
as
  select d.DeptNo , d.DeptName
  from Company.Department d

select * from v_dept


--10
insert into v_dept
values(4 , 'Development')

select * from v_dept
select * from Company.Department


--11
create view v_2006_check
as
  select e.EmpNo , p.PNo , d.DeptName , wo.Enter_Date
  from hr.Employee e , Company.project p , Works_On wo , Company.Department d
  where e.EmpNo = wo.EmpNo and p.PNo = wo.PNo and d.DeptNo = e.DeptNo and wo.Enter_Date between '2006-01-01' and  '2006-12-31'
with check option

select * from v_2006_check