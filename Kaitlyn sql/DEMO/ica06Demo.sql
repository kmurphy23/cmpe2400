-- ica06 demo
use PublishersDatabase
go

-- d1 - between ** inclusive
select * from titles
where price between 19 and 20
go

-- char search
select * from stores
where zip like '[89][0-9][0-9][0-9][6]'
go

-- d3 distinct
select distinct type, pub_id
from titles
go

-- template select for order by
select title, price, ytd_sales, price*ytd_sales
from titles
where price * ytd_sales > 10000
go

-- order by column name and expression
select title, price, ytd_sales, price*ytd_sales as 'Gross'
from titles
where price * ytd_sales > 10000
order by price, price*ytd_sales
go

-- order by column alias
select title, price, ytd_sales, price*ytd_sales as 'Gross'
from titles
where price * ytd_sales > 10000
order by price, Gross -- or [Gross]
go

-- order by column header
select title, price, ytd_sales, 'Gross' = price*ytd_sales
from titles
where price * ytd_sales > 10000
order by price, Gross -- or [Gross]
go

-- order by column item number
select title, price, ytd_sales, 'Gross' = price*ytd_sales
from titles
where price * ytd_sales > 10000
order by 2 desc, 4 asc
go
