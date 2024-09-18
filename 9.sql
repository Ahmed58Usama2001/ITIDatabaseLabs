--1
use ITI

create proc studnum
as
select count(s.St_Id) , d.Dept_Name
from Student s , Department d
group by d.Dept_Name

execute studnum


--2
use SD

create proc checkP3
as
declare @x int
set @x = (select count(e.EmpNo) 
         from HumanResource.Employee e , Works_On wo , Company.project p
		 where e.EmpNo = wo.EmpNo and wo.ProjectNo = p.ProjectNo and p.ProjectNo = 'p1')
if @x >=3
select 'The number of employees in the project p1 is 3 or more'
else
begin
select 'The following employees work for the project p1:' as names
union all
select [Name]= e.Emp_Fname+' '+e.Emp_Lname 
from HumanResource.Employee e , Works_On wo , Company.project p
where e.EmpNo = wo.EmpNo and wo.ProjectNo = p.ProjectNo and p.ProjectNo = 'p1'
end

exec checkP3


--3
create proc nproc @OldEmpNumber int , @NewEmpNumber int , @ProjectNumber varchar(20)
as
   update Works_On
   set EmpNo = @NewEmpNumber
   where EmpNo = @OldEmpNumber and ProjectNo = @ProjectNumber

nproc 29346,10102,'p2'


--4
create table ProjBudgetAudit
(
ProjectNo varchar(50),
UserName varchar(50),
ModificationDate date,
OldBudget int,
NewBudget int
)

create trigger ntr
on company.project
after update
as
   if update(budget)
   begin
   declare @projnumber varchar(50) , @OBud int , @NBud int
   select @projnumber = ProjectNo from deleted
   select @OBud = budget from deleted
   select @NBud = budget from inserted
   insert into ProjBudgetAudit
   values(@projnumber , suser_name() , getdate() , @OBud , @NBud)
   end

update Company.project
set Budget = 100000
where ProjectNo = 'p4'


--5
USE ITI

create trigger ntr2
on Department
instead of insert
as
   select 'You can’t insert a new record in that table'

insert into Department(Dept_Id , Dept_Name)
values(1100,'cyber')


--6
USE SD

create trigger tr100
on HumanResource.Employee
instead of insert
as
select 'not allowed'

insert into HumanResource.Employee(EmpNo) values(52112)


--7
USE ITI

create table StudentAudit
(
ServerUserName varchar(50),
Date date,
Note varchar(100)
)

create trigger ntr10
on student
after insert
as
   declare @x int 
   select @x= St_Id from inserted
   insert into StudentAudit
   values(SUSER_NAME() , GETDATE() , SUSER_NAME()+' inserted new row with key = '+convert(varchar(20) , @x) )

insert into Student(St_Id) values(125412)


--8
create trigger ntr11
on student
instead of delete
as
   declare @y int
   select @y = St_Id from deleted
   insert into StudentAudit
   values(SUSER_NAME() , GETDATE() , SUSER_NAME()+' tried to delete row with key = '+convert(varchar(20) , @y))

delete from student where St_Id = 5


--9
USE AdventureWorks2012

--A
select * from HumanResources.Employee
for xml raw('Emp') 

--B
select * from HumanResources.Employee
for xml raw('Emp') , elements


--10
USE ITI

--A
select d.Dept_Name , i.Ins_Name
from Department d , Instructor i
where i.Dept_Id = d.Dept_Id
for xml auto

--B
select d.Dept_Name "@DeptName" , i.Ins_Name
from Department d , Instructor i
where i.Dept_Id = d.Dept_Id
for xml path


--11
declare @docs xml = '<customers>
              <customer FirstName="Bob" Zipcode="91126">
                     <order ID="12221">Laptop</order>
              </customer>
              <customer FirstName="Judy" Zipcode="23235">
                     <order ID="12221">Workstation</order>
              </customer>
              <customer FirstName="Howard" Zipcode="20009">
                     <order ID="3331122">Laptop</order>
              </customer>
              <customer FirstName="Mary" Zipcode="12345">
                     <order ID="555555">Server</order>
              </customer>
       </customers>'

declare @hdocs int

Exec sp_xml_preparedocument @hdocs output, @docs

select * into Customers 
from openxml (@hdocs, '//customer') 
with (C_Fname varchar(20) '@FirstName',
      C_ZC int '@Zipcode',
	  C_OID int 'order/@ID',
	  OrderDescription varchar(50) 'order')

Exec sp_xml_removedocument @hdocs

select * from Customers


-- Bonus

--1
create proc fun1 @date date
as
   select format(@date , 'MMMM')

exec fun1 '2001-6-6'

--2
use SD

create trigger DBtr
on database
for alter_table
as
rollback

alter table works_on add lol int