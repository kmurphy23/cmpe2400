--kaitlyn murphy 
--ica 13 

--q1

if exists ( select * from sysobjects where name = 'ica13_01' )
drop procedure ica13_01
go

create procedure ica13_01
as 
select
	(LastName +
	',' +
	FirstName) as 'Name' ,
	count(distinct O.OrderID) as 'Num Orders'
from	
	NorthwindTraders.dbo.Employees as E inner join NorthwindTraders.dbo.Orders as O
	on E.employeeID = O.employeeID
group by LastName,FirstName
order by 'Num Orders' desc
go
exec ica13_01 
go


--q2
if exists ( select * from sysobjects where name = 'ica13_02' )
drop procedure ica13_02
go
create procedure ica13_02
as 
select
	(LastName +
	',' +
	FirstName) as 'Name' ,
	sum((UnitPrice*Quantity)) as 'Sales Total',
	count(OD.OrderId) as 'Detail Items'
from 
	NorthwindTraders.dbo.Employees as E left outer join NorthwindTraders.dbo.Orders as O
	on E.EmployeeID = O.EmployeeID
		left outer join NorthwindTraders.dbo.[Order Details] as OD
		on OD.OrderID = O.OrderID
group by LastName,FirstName
order by 'Sales Total' desc
go
exec ica13_02
go


--q3
if exists 
	( select * from sysobjects 
	where name = 'ica13_03' )
	drop procedure ica13_03
go

create procedure ica13_03 
@maxPrice as money = null
as 
select 
	companyname as 'Company Name',
	country as 'Country'
from NorthwindTraders.dbo.Customers

where CustomerID in
( 
	select CustomerID
	from NorthwindTraders.dbo.Orders
	where OrderID in 
	(
		select OrderID 
		from NorthwindTraders.dbo.[Order Details]
		where ((UnitPrice*Quantity)<@maxPrice)
	)
)
order by Country
go
exec ica13_03 15
go


--q4
if exists 
	( select * from sysobjects 
	where name = 'ica13_04' )
	drop procedure ica13_04
go

create procedure ica13_04
@minPrice as money = null,
@categoryName as nvarchar(max) = ''
as 

select productname as 'ProductName'
from NorthwindTraders.dbo.products as outty
where @minPrice < unitprice and 
exists
(
	select *
	from NorthwindTraders.dbo.Categories as inny 
	where outty.CategoryID=inny.CategoryID
	and
	(CategoryName like @categoryName and UnitPrice>@minPrice)

) 
order by CategoryID, ProductName
go
exec ica13_04 20, 'confections'
go

--q5
if exists 
	( select * from sysobjects 
	where name = 'ica13_05' )
	drop procedure ica13_05
go

create procedure ica13_05
@minPrice as money = null,
@country as nvarchar(max) = 'USA'

as 
select 
	s.CompanyName as 'Supplier',
	s.Country as 'Country',
	min(coalesce(unitprice,0)) as 'Min Price',
	max(coalesce(unitprice,0)) as 'Max Price'
from 
	NorthwindTraders.dbo.Suppliers as s 
	left outer join NorthwindTraders.dbo.Products as P
	on s.SupplierID = P.SupplierID
where 
	country like @country
group by s.CompanyName,s.Country
having min(coalesce(unitprice,0)) > @minPrice
order by 'Min Price'
go
exec ica13_05 15
go
exec ica13_05 @minPrice = 15
go
exec ica13_05 @minPrice = 5, @country = 'UK'
go

--q6
if exists 
	( select * from sysobjects 
	where name = 'ica13_06' )
	drop procedure ica13_06
go

create procedure ica13_06
@class_id as int =0
as 
select 
	ass_type_desc as 'Type',
	round(avg(r.score),2) as 'Raw Avg',
	round(avg(score/max_score*100),2) as 'Avg',
	round(coalesce(count(score),0),2) as 'Scores'
from 
	ClassTrak.dbo.Assignment_type AT 
	left outer join ClassTrak.dbo.Requirements Req 
	on AT.ass_type_id = Req.ass_type_id
	left outer join ClassTrak.dbo.Results R
	on R.req_id = Req.req_id
where R.class_id = @class_id
group by ass_type_desc
order by 'Type'
go
exec ica13_06 88
go
exec ica13_06 @class_id = 89
go


--q7
if exists 
	( select * from sysobjects 
	where name = 'ica13_07' )
	drop procedure ica13_07
go

create procedure ica13_07
@year as int,
@minAvg as int =50,
@minSize as int =10
as 

select 
	convert(nvarchar(24),last_name + ',' +first_name) as 'Student',
	class_desc as 'Class',
	ass_type_desc as 'Type',
	count(R.req_id) as 'Submitted',
	round(avg(score/max_score*100),1) as 'Avg'
from 
	ClassTrak.dbo.Students S 
	left outer join ClassTrak.dbo.Results R 
	on S.student_id = R.student_id
	left outer join ClassTrak.dbo.Requirements Req 
	on R.req_id = Req.req_id
	left outer join ClassTrak.dbo.Classes C
	on C.class_id = Req.class_id
	left outer join ClassTrak.dbo.Assignment_type AT
	on Req.ass_type_id = AT.ass_type_id
where 
	DATEPART(year,start_date) like @year and
	score is not null

group by last_name,first_name,class_desc,ass_type_desc
having round(avg(score/max_score*100),1) <@minAvg and
	count(score)>@minSize
order by last_name,first_name
go

exec ica13_07 @year=2011
go
exec ica13_07 @year=2011, @minAvg=40, @minSize=15
go