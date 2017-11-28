--Kaitlyn Murphy	
--ICA08


--q1
select top 1 
	companyname as 'Supplier Company Name',
	country as 'Country'
from Suppliers
order by Country
go

--q2
select top 1 with ties 
	companyname as 'Supplier Company Name',
	country as 'Country'
from Suppliers
order by Country
go

--q3
select top 10 percent 
	productname as 'Product Name',
	UnitsInStock as 'Units in Stock'
from products 
order by UnitsInStock desc
go

--q4
select 
	companyname as 'Customer Company Name',
	country as 'Country' 
from Customers 
	where customerid in 
	(
		select top 8 
			CustomerID
		from 
			Orders
		order by
			Freight desc 
	)
go

--q5
select  
	customerid as 'CustomerID',
	orderid as 'OrderID',
	convert(nvarchar,orderdate,106 ) as 'Order Date'
from Orders
	where OrderID in
	(
		select top 3 
			OrderID
		from 
			[Order Details]
		order by
			Quantity desc

	)
go


--q6
select  
	customerid as 'CustomerID',
	orderid as 'OrderID',
	convert(nvarchar,orderdate,106 ) as 'Order Date'
from Orders
	where OrderID in
	(
		select top 3 with ties
			OrderID
		from 
			[Order Details]
		order by
			Quantity desc

	)
go




--q7
select
	companyname as 'Supplier Company Name',
	country as 'Country'
from Suppliers
	where SupplierID in
	(
		select SupplierID

		from Products

		where ProductID in
		(
			select top 1 percent ProductID

			from [Order Details]

			order by (UnitPrice*Quantity) desc
		)
	)
go