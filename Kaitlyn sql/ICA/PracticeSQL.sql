--Kaitlyn M
--ica02
--this is the desired format for ALL ICAs(done through an automated response machine) 

--q1
declare @firstAir as DateTime = '8 Sep 1966'
declare @diff as int =0
set @diff = DATEDIFF(day,@firstAir,GetDate())
select
	@diff as 'Days since Air',
	convert(nvarchar,@firstAir, 106) as 'Original Date'
go

--q2
select datename( dw, getdate()) + cast(23 as nvarchar(4)) as 'test',
convert(nvarchar, getdate(),111) as 'test date'
go


--q3

declare @name as nvarchar(24) = 'Fred'
select 
	@name as 'Name',
	IIF(7%2=0, 'Even', 'Odd') as 'Type',
	charindex('e', @name) as 'Index # '
go