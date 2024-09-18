use Company_SD

--1
select Dependent_name,Sex
from Dependent
where Sex='F' and ESSN in (select SSN from Employee where sex='F')
union
select Dependent_name,Sex
from Dependent
where Sex='M' and ESSN in (select SSN from Employee where sex='M')

--2
select p.Pname,SUM(wf.Hours)
from Project p inner join Works_for wf on p.Pnumber=wf.Pno
group by p.Pname


--3
select d.*
from Departments d inner join Employee e on e.Dno=d.Dnum
where e.SSN = (select MIN(e.ssn) from Employee e)

--4
select d.Dname, MIN(e.salary) as minimumSalary,max(e.salary) as maxSalary,avg(e.salary) as AverageSalary
from Departments d inner join Employee e on e.Dno=d.Dnum
group by d.Dname

--5
select e.Lname
from Employee e inner join Departments d on e.Dno=d.Dnum and e.SSN=d.MGRSSN
where e.SSN not in (select ESSN from Dependent)

--6
select d.Dnum,d.Dname,count(e.ssn),AVG(e.salary) as NumOfEmployees
from Departments d inner join Employee e on d.Dnum=e.Dno
group by d.Dnum,d.Dname
having avg(e.salary) < (select avg(salary) from employee)

--7
select e.Fname +' '+e.Lname as FullName , p.Pname 
from Employee e inner join Works_for wf on e.SSN=wf.ESSn 
inner join Project p on wf.Pno=p.Pnumber 
order by e.Dno, e.Lname, e.Fname

--8
select max(salary) as salary
from Employee 
where salary<(select max(salary) from Employee)

union

select max(salary)
from Employee

--9
--10
update e
set salary = salary*1.3
from Employee e inner join Works_for wf on e.SSN=wf.ESSn
inner join Project p on p.Pnumber=wf.Pno
where p.Pname='Al Rabwah'

--11
select e.SSN , e.Fname+' ' +e.Lname as FullName
from Employee e
where exists(select * from Employee e inner join Dependent d on e.SSN = d.ESSN)

---------------------------------------------------------------------------------------

--1
insert into Departments
values('DEPT IT',100,112233,'2006-1-11')

--2
--a
update Departments
set Mgrssn=968574
where Dnum=100

update Employee 
set Dno=100
where ssn=968574

--b
update Departments
set Mgrssn=102672
where Dnum=20

update Employee 
set Dno=20
where ssn=102672

--c
update Employee 
set Dno=20,Superssn=102672
where ssn=102660