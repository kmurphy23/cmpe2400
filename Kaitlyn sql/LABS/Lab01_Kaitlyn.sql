--Lab 1
--Kaitlyn Murphy
--Dec 2017

use [master]
go

if exists 
(
	select *
	from sysdatabases 
	where name = 'Lab01_kmurphy23'
)
	drop database Lab01_kmurphy23
go

create database [Lab01_kmurphy23]
go

use [Lab01_kmurphy23]
go


--class 
create table dbo.[Class]
(
	[ClassId] [nvarchar](30) not null,
	[ClassDescription] [nvarchar](50) null,
	constraint [Key_Class] primary key([ClassId])
)
go

alter table class add constraint Check_ClassDesc check(len(ClassDescription)>2)
go

--riders
create table dbo.[Riders]
(
	[RiderId] [int] identity(10,1) Not null
		constraint [Key_Riders] primary key,
	[Name][nvarchar](30) not null
		constraint Check_Name check (len([Name])>4),
	[ClassId] [nvarchar](30) null,
	constraint Foreign_Riders foreign key ([ClassId])
	references Class(ClassId) on delete no action 
)
go

--bikes
create table dbo.[Bikes]
(
	[BikeId] [nvarchar](6) not null
		constraint Check_BikeId check([BikeId]like '[0-9][0-9][0-9][A-Z]-[AP]'),
	[StableDate] [datetime] null,
	constraint [Key_Bikes] primary key ([BikeId])
)
go

--Sessions
create table dbo.[Sessions]
(
	[RiderId] [int] not null,
	[BikeId] [nvarchar](6) not null,
	[SessionDate] [datetime] not null
		default getDate()
		constraint Check_StartTime check([SessionDate]> '1 Sep 2017'),
	[Laps] [int] null
		constraint _Laps default 0,
	constraint [Key_Sessions] 
	primary key
	(
		[RiderId],
		[BikeId],
		[SessionDate]
	),
	constraint Foreign_RiderId foreign key ([RiderId])
	references Riders(RiderId) on delete no action
)
go

--no cluster
create nonclustered index NCI_Session on [Sessions] ([RiderId],[SessionDate])
alter table [Sessions] add
	constraint Foreign_S_BikeId foreign key (BikeId)
	references Bikes(BikeId) on delete no action
go