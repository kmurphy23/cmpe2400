-- ica16
-- You will need to install a personal version of the ClassTrak database
-- The Full and Refresh scripts are on the Moodle site.
-- Once installed, you can run the refresh script to restore data that may be modified or 
--  deleted in the process of completing this ica.

use  kmurphy23_ClassTrak
go

-- q1
-- Complete an update to change all classes to have their descriptions be lower case
-- select all classes to verify your update
update Classes
set class_desc = LOWER(class_desc)

select class_desc as 'Lower Case'
from Classes
go

-- q2
-- Complete an update to change all classes that are "cmpe" courses to be upper case
-- select all classes to verify your selective update
update Classes
set class_desc= UPPER(class_desc)
where class_desc like ('%cmpe%')

select class_desc as 'Upper'
from Classes 
go

-- q3
-- For class_id = 123
-- Update the score of all results which have a real percentage of less than 50
-- The score should be increased by 10% of the max score value
-- Use ica13_06 select statement to verify pre and post update values,
-- put one select before and after your update call.
declare @ID as int = 123

select 
	ass_type_desc as 'Type',
	round(avg(r.score),2) as 'Raw Avg',
	round(avg(score/max_score*100),2) as 'Avg',
	round(coalesce(count(score),0),2) as 'Scores'
from 
	Assignment_type AT 
	inner join Requirements Req 
	on AT.ass_type_id = Req.ass_type_id
    inner join Results R
	on R.req_id = Req.req_id
where R.class_id = @ID
group by ass_type_desc
order by 'Type'

update Results
set score = score + (req.max_score/10)
from Results as res 
inner join Requirements as req
on req.req_id = res.req_id
where (res.score/req.max_score) *100 < 50

select 
	ass_type_desc as 'Type',
	round(avg(r.score),2) as 'Raw Avg',
	round(avg(score/max_score*100),2) as 'Avg',
	round(coalesce(count(score),0),2) as 'Scores'
from 
	Assignment_type AT 
	inner join Requirements Req 
	on AT.ass_type_id = Req.ass_type_id
	inner join Results R
	on R.req_id = Req.req_id
where R.class_id = @ID
group by ass_type_desc
order by 'Type'

go