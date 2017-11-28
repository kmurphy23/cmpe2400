-- ICA06 
--Kaitlyn Murphy 
--use NorthwindTraders


--q1
declare @lower as float =  17.45,
		@higher as float = 19.45 

select
	productname as 'Product Name',
	unitprice as 'Unit Price'
from Products
where 
	UnitPrice between @lower and 
	@higher
go

--q2
declare @lowerrange as int = 1150,
		@higherrange as int = 5000
select
	productname as 'Product Name',
	unitprice as 'Unit Price',
	reorderlevel as 'Reorder Level',
	(ReorderLevel*UnitPrice) as 'Reorder Cost'

from Products
where
	(ReorderLevel*UnitPrice) between @lowerrange and 
	@higherrange
order by ([Reorder Cost])
go

--q3
declare @stringname as nvarchar(5) = '%ade%'
select
	productname as 'Product Name',
	quantityperunit as 'Quantity per Unit'
from Products
where ProductName like(@stringname)
order by ([Product Name])
go

--q4
declare @dis as int =1375
select
	unitprice as 'Unit Price',
	quantity as 'Quantity',
	discount as 'Discount',
	(unitprice*quantity*discount) as 'Discount Value'
from [Order Details]
where
	(unitprice*quantity*discount)>=@dis
order by ([Discount Value])desc
go

--q5
select 
	country as 'Country',
	city as 'City',
	companyname as 'Company Name'
from Customers
where
	Phone like '([1,5,9]__)%'
order by Country,City
go  

--q6
select
	customerid as 'Customer ID',
	orderid as 'Order ID',
	datediff(d,requireddate,shippeddate) as 'Delay Days'
from Orders
where
	datediff(d,requireddate,shippeddate)>7 and 
	CustomerID not like '[m-z]%'
order by ([Delay Days])
go

--q7
select 
	companyname as 'Company Name',
	city as 'City',
	postalcode as 'Postal Code'
from Customers
where
	(PostalCode like ('[A-Z][A-Z][0-9]% [0-9][A-Z][A-Z]') or
	PostalCode like ('[A-Z][0-9][A-Z] [0-9][A-Z][0-9]')) and
	companyname not like '%s'

order by city
go

--q8
select distinct 
	discount as 'Discount'
from [Order Details] 
order by([Discount])desc
go

--q9
declare @max as int = 20
select distinct 
	 productid as 'ProductID',
	 (quantity * (unitprice*(1-discount))) as 'Value'
from [Order Details]
where
	(quantity * (unitprice*(1-discount))) < @max and 
	(quantity * (unitprice*(1-discount))) = round(quantity * (unitprice*(1-discount)),0)

order by 
	(quantity * (unitprice*(1-discount)))desc,
	productid desc
go

