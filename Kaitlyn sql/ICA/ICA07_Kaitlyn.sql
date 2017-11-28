--ICA07
--Kaitlyn Murphy 


--q1
declare @freight as int = 800
select 
	Lastname as 'Last Name',
	title as 'Title'
from employees
	where EmployeeID in
	(
		select 
			EmployeeID
		from 
			Orders
		where Freight>@freight
	) 
order by [Last Name] 
go

--q2
declare @freight as int = 800
select 
	Lastname as 'Last Name',
	title as 'Title'
from employees as outty 
where exists 
	(
		select EmployeeID
		from Orders
		where Freight > @freight and EmployeeID = outty.EmployeeID
	)
order by [Last Name]
go 

--q3
select 
	productname as 'Product Name',
	unitprice as 'Unit Price'
from products

where SupplierID in 
	(
		select Supplierid 
		
		from Suppliers

		where Country in 
		(
			'Sweden' , 'Italy'
		) 
	)
order by UnitPrice
go

--q4

select 
	productname as 'Product Name',
	unitprice as 'Unit Price'
from products as outty 
where exists
	(
		select SupplierID

		from Suppliers as inny

		where Country in 
		(
			'Sweden' , 'Italy'  
		) and 
	    outty.SupplierID = inny.SupplierID		 
	)
order by UnitPrice
go
 

--q5

declare @max as int =20
select productname as 'ProductName'
from products

where CategoryID in
(
	select CategoryID

	from Categories

	where UnitPrice in 
		(
			select UnitPrice
			from Products
			where (UnitPrice>@max)
		) and
		(CategoryName='Confections' or CategoryName='Seafood')
) 
order by CategoryID, ProductName
go

--q6
declare @max as int =20
select productname as 'ProductName'
from products

where CategoryID ex


 