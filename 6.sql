create database SD

use SD

sp_addtype loc,'nchar(2)'

create rule r1 as @x in ('NY', 'DS', 'KW')

sp_bindrule r1,loc

create default df1 as 'NY'

sp_bindefault df1,loc

create table Department(
DeptNo int primary key,
DeptName varchar(50),
location dbo.loc
)

insert into Department
values (1,'Research','NY'),
(2,'Accounting','DS'),
(3,'Marketing','KW')


create table Employee (
EmpNo int primary key,
DeptNo int foreign key references Department(DeptNo),
Salary decimal unique,
EmpFName varchar(50) not null,
EmpLName varchar(50) not null,
)
create rule salary_rule as @x<6000

EXEC sp_bindrule 'salary_rule', 'Employee.Salary';

INSERT INTO Employee (EmpNo, EmpFName, EmpLName, DeptNo, Salary)
VALUES 
(25348, 'Mathew', 'Smith', 3, 2500),
(10102, 'Ann', 'Jones', 3, 3000),
(18316, 'John', 'Barrimore', 1, 2400),
(29346, 'James', 'James', 2, 2800),
(9031, 'Lisa', 'Bertoni', 2, 4000),
(2581, 'Elisa', 'Hansel', 2, 3600),
(28559, 'Sybl', 'Moser', 1, 2900);

INSERT INTO Project 
VALUES 
(1, 'Apollo', 120000),
(2, 'Gemini', 95000),
(3, 'Mercury', 185600)

INSERT INTO Works_on 
VALUES 
(10102, 1, 'Analyst', '2006-10-01'),
(10102, 3, 'Manager', '2012-01-01'),
(25348, 2, 'Clerk', '2007-02-15'),
(18316, 2, NULL, '2007-06-01'),
(29346, 2, NULL, '2006-12-15'),
(2581, 3, 'Analyst', '2007-10-15'),
(9031, 1, 'Manager', '2007-04-15'),
(28559, 1, NULL, '2007-08-01'),
(28559, 2, 'Clerk', '2012-02-01'),
(9031, 3, 'Clerk', '2006-11-15'),
(29346, 1, 'Clerk', '2007-01-04');

update Employee
set EmpNo=22222
where EmpNo=10102 

delete from Employee
where EmpNo=10102 

alter table Employee
add TelephoneNumber varchar(15)

alter table Employee
drop column TelephoneNumber

create schema company

alter schema company transfer department
alter schema company transfer project

create schema HR
alter schema HR transfer Employee

use SD
create synonym Emp
for HR.Employee  --It'f for HR.Employee not Employee

Select * from Employee
Select * from HR.Employee --valid
Select * from Emp --valid
Select * from HR.Emp

update company.Project
set Budget=Budget*1.1
from company.Project p inner join Works_on wo
on p.PNo=wo.PNo
where wo.EmpNo=10102  and job='Manager'

update company.department
set DeptName='Sales'
from company.department d inner join HR.Employee e
on d.DeptNo=e.DeptNo
where e.EmpFName='James'  

update Works_on 
set enter_date='2007-12-12'
from Works_on wo inner join HR.Employee e
on wo.EmpNo=e.EmpNo 
inner join company.Project p 
on p.PNo=wo.PNo
inner join company.Department d 
on d.DeptNo=e.DeptNo
where p.PNo=1 and d.DeptName='Sales'

delete from Works_on
from Works_on wo inner join HR.Employee e
on wo.EmpNo=e.EmpNo
inner join company.Department d 
on d.DeptNo=e.DeptNo
where d.location='KW'

use ITI
create schema secure
alter schema secure transfer course
alter schema secure transfer student