-- main views
use ccgitranscripts;

CREATE OR REPLACE VIEW area_z_out_dist AS
WITH ENR
AS
(
select
c.District as Enrolled_District
, c.School as Enrolled_School
, s.CA_STATE_STUDENT_ID
from student s
join cds_codes c on c.CDSCode = s.cds_code
)
,
CG_ENR
AS
(
select
c.District as CourseTaken_District
, c.School as CourseTaken_School
, cg.LOCAL_COURSE_ID
, cg.LOCAL_COURSE_NAME_1 as 'Course_Name'
, cg.Subject_Area
, cg.CA_STATE_STUDENT_ID
from course_grades cg
join cds_codes c on c.cdscode = cg.cds_code
where cg.SUBJECT_AREA like '%z%'
)
select
e.Enrolled_District
, e.Enrolled_School
, cg.CourseTaken_District
, cg.CourseTaken_School
, cg.LOCAL_COURSE_ID
, cg.Course_Name
, count(distinct cg.CA_STATE_STUDENT_ID) as '# of Enrolled Students'
from ENR e
join CG_ENR cg on cg.CA_STATE_STUDENT_ID = e.CA_STATE_STUDENT_ID
WHERE e.Enrolled_District != cg.CourseTaken_District
group by cg.CourseTaken_District, cg.CourseTaken_School, cg.LOCAL_COURSE_ID
order by e.Enrolled_District, '# of Enrolled Students' desc, cg.Course_Name;


use ccgi_staging;

CREATE OR REPLACE VIEW area_z_out_dist AS
WITH ENR
AS
(
select
c.District as Enrolled_District
, c.School as Enrolled_School
, s.CA_STATE_STUDENT_ID
from student s
join cds_codes c on c.CDSCode = s.cds_code
)
,
CG_ENR
AS
(
select
c.District as CourseTaken_District
, c.School as CourseTaken_School
, cg.LOCAL_COURSE_ID
, cg.LOCAL_COURSE_NAME_1 as 'Course_Name'
, cg.Subject_Area
, cg.CA_STATE_STUDENT_ID
from course_grades cg
join cds_codes c on c.cdscode = cg.cds_code
where cg.SUBJECT_AREA like '%z%'
)
select
e.Enrolled_District
, e.Enrolled_School
, cg.CourseTaken_District
, cg.CourseTaken_School
, cg.LOCAL_COURSE_ID
, cg.Course_Name
, count(distinct cg.CA_STATE_STUDENT_ID) as '# of Enrolled Students'
from ENR e
join CG_ENR cg on cg.CA_STATE_STUDENT_ID = e.CA_STATE_STUDENT_ID
WHERE e.Enrolled_District != cg.CourseTaken_District
group by cg.CourseTaken_District, cg.CourseTaken_School, cg.LOCAL_COURSE_ID
order by e.Enrolled_District, '# of Enrolled Students' desc, cg.Course_Name;


-- archive views
use ccgitranscripts;

CREATE OR REPLACE VIEW area_z_out_dist_archive AS
WITH ENR
AS
(
select
c.District as Enrolled_District
, c.School as Enrolled_School
, s.CA_STATE_STUDENT_ID
from archive_student s
join cds_codes c on c.CDSCode = s.cds_code
)
,
CG_ENR
AS
(
select
c.District as CourseTaken_District
, c.School as CourseTaken_School
, cg.LOCAL_COURSE_ID
, cg.LOCAL_COURSE_NAME_1 as 'Course_Name'
, cg.Subject_Area
, cg.CA_STATE_STUDENT_ID
from archive_course_grades cg
join cds_codes c on c.cdscode = cg.cds_code
where cg.SUBJECT_AREA like '%z%'
)
select
e.Enrolled_District
, e.Enrolled_School
, cg.CourseTaken_District
, cg.CourseTaken_School
, cg.LOCAL_COURSE_ID
, cg.Course_Name
, count(distinct cg.CA_STATE_STUDENT_ID) as '# of Enrolled Students'
from ENR e
join CG_ENR cg on cg.CA_STATE_STUDENT_ID = e.CA_STATE_STUDENT_ID
WHERE e.Enrolled_District != cg.CourseTaken_District
group by cg.CourseTaken_District, cg.CourseTaken_School, cg.LOCAL_COURSE_ID
order by e.Enrolled_District, '# of Enrolled Students' desc, cg.Course_Name;


use ccgi_staging;

CREATE OR REPLACE VIEW area_z_out_dist_archive AS
WITH ENR
AS
(
select
c.District as Enrolled_District
, c.School as Enrolled_School
, s.CA_STATE_STUDENT_ID
from archive_student s
join cds_codes c on c.CDSCode = s.cds_code
)
,
CG_ENR
AS
(
select
c.District as CourseTaken_District
, c.School as CourseTaken_School
, cg.LOCAL_COURSE_ID
, cg.LOCAL_COURSE_NAME_1 as 'Course_Name'
, cg.Subject_Area
, cg.CA_STATE_STUDENT_ID
from archive_course_grades cg
join cds_codes c on c.cdscode = cg.cds_code
where cg.SUBJECT_AREA like '%z%'
)
select
e.Enrolled_District
, e.Enrolled_School
, cg.CourseTaken_District
, cg.CourseTaken_School
, cg.LOCAL_COURSE_ID
, cg.Course_Name
, count(distinct cg.CA_STATE_STUDENT_ID) as '# of Enrolled Students'
from ENR e
join CG_ENR cg on cg.CA_STATE_STUDENT_ID = e.CA_STATE_STUDENT_ID
WHERE e.Enrolled_District != cg.CourseTaken_District
group by cg.CourseTaken_District, cg.CourseTaken_School, cg.LOCAL_COURSE_ID
order by e.Enrolled_District, '# of Enrolled Students' desc, cg.Course_Name;