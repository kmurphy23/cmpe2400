--Kaitlyn M
--ica02

--q1
declare @Halloween as DateTime = '31 Oct 2017'
declare @diff as int =0
set @diff= DATEDIFF(day,GetDate(),@Halloween)
select
	@diff as 'Days',
	convert(nvarchar, @Halloween, 102) as 'Halloween'
go

--q2
declare @today as DateTime = GetDate()
declare @diff as int=0
set @diff = datepart(Minute,@today)
select convert(nvarchar(30),datename(month,@today) + ' '+ convert(varchar,DATEPART(day,@today))+ ' '+
convert(nvarchar,DATEPART(YEAR,@today)))  as Today,
convert(nvarchar(30),convert(nvarchar(20),dateadd(MINUTE,1000000,@today),120)) as Future 
go

--q3
declare @blH as int = (@@PACK_Received*1.00)/(@@PACK_Sent*1.00)*100 
select convert(nvarchar(12),@@LANGUAGE,9) as Lang,
convert(nvarchar(12),@@SERVERNAME,9) as Server,
 @@PACK_RECEIVED as Receieved,
@@PACK_SENT as Sent,
convert(nvarchar(4), @blH,100) + '%'  as 'Rcvd%' 
go

--q4
declare @DayWeek as int = datePart(DD, GetDate())
declare @DayName as nvarchar(24) = datename(dw,GetDate())
select @DayName +'('+Convert(nvarchar(2),@DayWeek,9)+')' as 'Name(#)',
	iif(@DayWeek%2=0, 'Even day','Odd day') as 'Day Kind',
	iif(charindex('u',@DayName)!=0, 'Yup','Nope') as 'Gotta u'

go