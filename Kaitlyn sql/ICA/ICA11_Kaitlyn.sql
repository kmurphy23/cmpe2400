--kaitlyn Murphy
--ICA11
--q1
select
	(LastName +
	',' +
	FirstName) as 'Name' ,
	count(distinct O.OrderID) as 'Num Orders'
from	
	Employees as E inner join Orders as O
	on E.employeeID = O.employeeID
group by LastName,FirstName
order by 'Num Orders' desc
go

--q2

