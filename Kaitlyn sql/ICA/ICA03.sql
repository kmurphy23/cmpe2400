--ICA03
--Kaitlyn Murphy


--q1
declare @number as int = rand()*100+1
if(@number%3=0)
	select @number as 'Random number',
	'Yes' as 'Factor of 3'
else
	select @number as 'Random number',
	'No' as 'Factor of 3'
go

--q2
declare @time as int = rand()*60+1
 select 
	@time as 'Minutes',
	case
		when @time <15 then 'on the hour' 
		when @time <30 then 'quater past'
		when @time <45 then 'half past'
		else 'quarter to'
	end as 'Ballpark'
go


--q3
declare @today as DateTime =getdate(),
@dayname as int,
@rand as int = rand()*7
set @today=DATEADD(dd,@rand,@today)
set @dayname = datepart(dw,@today)

select
@dayname as 'Day Number', 
case @dayname
	when 1 then 'Yahoo'
	when 2 then 'Got Class'
	when 3 then 'Got Class'
	when 4 then 'Got Class'
	when 5 then 'Got Class'
	when 6 then 'Got Class'
	when 7 then 'Yahoo'
end 
as 'Status'
 
go




--q4
declare @iterations as int = rand()*10000+1,
		@count as int =0,
		@divisible2 as int=0,
		@divisible3 as int=0,
		@divisible5 as int=0
while @count<@iterations
begin
	declare @rand as  int = rand()*10+1
	if(@rand%2=0)
		set @divisible2 += 1
	if(@rand%3=0)
		set @divisible3 += 1
	if(@rand%5=0)
		set @divisible5 +=1
	set @count+=1
end
		
select 
	   @iterations as 'Number of Iterations',
	   @divisible2 as 'Factor of 2', 
	   @divisible3 as 'Factor of 3',
	   @divisible5 as 'Factor of 5'
go

--q5
declare @loop float =0,
		@in float = 0,
		@x int,
		@y int,
		@esta decimal(10,9)
while @loop <1000
begin	
	set @x = rand()*101
	set @y = rand()*101
	if(sqrt(square(@x)+square(@y))<=100)
		set @in +=1

		set @loop +=1
		set @esta = cast((4*(@in/@loop)) as decimal(10,9))
		if(abs(pi()-@esta) <=0.0002)
			break
end

select @esta as 'Estimate',
	   pi() as 'PI',
	   cast(@in as varchar(6)) as 'In',
	   cast(@loop as varchar(6)) as 'Tries'
go
			
			


	
