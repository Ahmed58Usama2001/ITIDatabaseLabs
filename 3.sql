use Company_SD


--1
select d.Dnum,d.Dname,e.SSN,e.Fname+' '+e.Lname as FullName
from Departments d, Employee e
where d.MGRSSN=e.SSN

--2
select d.Dname,p.Pname
from Departments d, Project p
where d.Dnum=p.Dnum

--3
select dp.*, e.Fname+' '+e.Lname as EmployeeFullName
from Dependent dp , Employee e
where dp.ESSN=e.SSN

--4
select *
from Project
where Project.City='Cairo' or Project.City='Alex'

--5
select *
from Project
where Project.Pname like 'a%'

--6
select *
from Employee e
where e.Dno=30 and e.Salary between 1000 and 2000

--7
select e.Fname+' '+e.Lname as FullName
from Works_for wf join Project p on wf.Pno=p.Pnumber
join Employee e on e.SSN=wf.ESSn
where e.Dno=10 and wf.Hours>=10 and p.Pname='AL Rabwah'

--8
select emp.Fname+' '+emp.Lname as FullName
from Employee emp join Employee spr on emp.Superssn=spr.SSN
where spr.Fname='Kamel' and spr.Lname='Mohamed'

--9
select e.Fname+' '+e.Lname as FullName , p.Pname
from Works_for wf join Project p on wf.Pno=p.Pnumber
join Employee e on e.SSN=wf.ESSn
order by p.Pname

--10
select p.Pnumber, d.Dname, e.Lname,e.Address, e.Bdate
from Project p join Departments d on p.Dnum=d.Dnum
join Employee e on e.SSN = d.MGRSSN
where p.City = 'Cairo'


--11
select e.*
from Departments d join Employee e on e.SSN = d.MGRSSN

--12
select e.* , dep.*
from Employee e left outer join Dependent dep
on e.SSN=dep.ESSN

---------------------------------------------------------------------------

--1
insert into Employee
values ('Ahmed','Usama',102672,'2001-8-5','Kafr Kila Albal - ElSanta - Gharbia','M', 3000,112233,30)

--2
insert into Employee (Fname,Lname,SSN,Bdate,Address,Sex,Dno)
values ('Nour','Alaa',102660,'2005-11-10','Kafr Kila Albal - ElSanta - Gharbia','F',30)

--3
update Employee
set Salary = Salary + (0.2 * Salary)
where SSN=102672
