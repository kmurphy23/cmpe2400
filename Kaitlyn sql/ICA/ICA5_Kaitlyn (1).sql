--Kaitlyn Murphy
--ICA05
--use NorthwindTraders

--q1
select * from Customers
go

--q2
select
	CustomerID as 'Customer ID',
	CompanyName as 'Company Name',
	ContactName as 'Contact Name',
	city as 'City'
from Customers
go
	
--q3
select
	orderid as 'Order ID',
	shipname as 'Ship Name',
	orderdate as 'Order Date',
	shipregion as 'Ship Region'
from Orders
where 
	ShippedDate is null and 
	ShipRegion is not null
go	

--q4
declare 
	@low as int = 10,
	@high as int = 11
select 
	productname as 'Product Name',
	unitprice as 'Unit Price',
	unitsinstock as 'Units in Stock'
from Products
where 
	UnitsOnOrder < @high and 
	UnitsInStock<@low
go

--q5
select
	companyname as 'Company Name',
	city as 'City',
	address as 'Adress'
from Customers
where 
	Country in ('Argentina', 'Brazil', 'Venezuela')
	and ContactTitle in('Owner' , 'Sales Agent')
go

--q6
select
	productname as 'Product Name',
	quantityperunit as 'Quantity per Unit',
	unitprice as 'Unit Price'
from Products
where 
	(QuantityPerUnit like('%Jars') or 
	QuantityPerUnit like('%Bottles'))
	and CategoryID not in (1,8)
go

--q7
select
	productname as 'Product Name',
	unitprice as 'Unit Price',
	unitsinstock as 'Units in Stock',
	(unitsinstock * unitprice) as 'Invertory Value'
from Products
where
	((unitsinstock * unitprice)<100 and (Discontinued <> 1))
go



