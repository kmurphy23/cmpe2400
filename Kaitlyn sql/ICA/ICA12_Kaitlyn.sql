--ICA12 
--Kaitlyn Murphy

--q1
declare @ID as int = 88
select 
	ass_type_desc as 'Type',
	avg(r.score) as 'Raw Avg',
	avg(score/max_score*100) as 'Avg',
	coalesce(count(score),0) as 'Num'
from 
	Assignment_type AT 
	left outer join Requirements Req 
	on AT.ass_type_id = Req.ass_type_id
	left outer join Results R
	on R.req_id = Req.req_id
where R.class_id = @ID
group by ass_type_desc
order by 'Type'
go

--q2
declare @ID as int = 88
select 
	Req.ass_desc+ '('+ ass_type_desc+ ')' as 'Desc(Type)',
	round((avg(R.score/Req.max_score)*100),2) as 'Avg',
	count(Req.req_id) as 'Num Score'
from 
	Assignment_type AT 
	left outer join Requirements Req 
	on AT.ass_type_id = Req.ass_type_id
	left outer join Results R
	on R.req_id = Req.req_id
where Req.class_id = @ID
group by Req.ass_desc,ass_type_desc
having avg((R.score/Req.max_score)*100)>57
order by Req.ass_desc,AT.ass_type_desc
go

--q3
declare @ID as int = 123
select
	last_name as 'Last',
	ass_type_desc as 'ass_type_desc',
	round(min(score/max_score*100),1) as 'Low',
	round(max(score/max_score*100),1) as 'High',
	round(avg(score/max_score*100),1) as 'Avg'
from 
	Students s 
	left outer join Results R
	on s.student_id=R.student_id
	left outer join Requirements Req 
	on R.req_id = Req.req_id
	left outer join Assignment_type AT
	on Req.ass_type_id = AT.ass_type_id
where R.class_id = @ID
group by last_name, ass_type_desc
having avg((R.score/Req.max_score)*100)>70
order by AT.ass_type_desc, 'Avg'
go

--q4
select 
	last_name as 'Instructor',
	convert(nvarchar(12),start_date,106) as 'Start',
	count(class_to_student_id) as 'Num Registered',
	sum(cast(active as int)) as 'Num Active'
from 
	Instructors I 
	left outer join Classes C
	on I.instructor_id = C.instructor_id
	left outer join class_to_student CTS 
	on CTS.class_id = C.class_id
group by last_name, start_date
having count(CTS.class_to_student_id)- sum(cast(CTS.active as int))>3
order by last_name,'Start'
go


--q5
declare 
	@Year as int = 2011,
	@Avg as int = 40	
select 
	convert(nvarchar(24),last_name + ',' +first_name) as 'Student',
	class_desc as 'Class',
	ass_type_desc as 'Type',
	count(R.req_id) as 'Submitted',
	round(avg(score/max_score*100),1) as 'Avg'
from 
	Students S 
	left outer join Results R 
	on S.student_id = R.student_id
	left outer join Requirements Req 
	on R.req_id = Req.req_id
	left outer join Classes C
	on C.class_id = Req.class_id
	left outer join Assignment_type AT
	on Req.ass_type_id = AT.ass_type_id
where 
	DATEPART(year,start_date) like @Year and
	score is not null

group by last_name,first_name,class_desc,ass_type_desc
having round(avg(score/max_score*100),1) <@Avg and
	count(score)>10
order by 'Submitted'
go

	