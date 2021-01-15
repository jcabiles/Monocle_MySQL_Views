use ccgitranscripts;
CREATE OR REPLACE VIEW s1_grades_s2_wip AS

WITH ENR
AS
(
select
c.District as Enrolled_District
, c.School as Enrolled_School
, s.CA_STATE_STUDENT_ID
, s.cds_code
from archive_student s
join cds_codes c on c.CDSCode = s.cds_code


),

cg AS (
SELECT cg.LOCAL_COURSE_ID,
        cg.CA_STATE_STUDENT_ID,
        cg.course_grade,
        cg.term,
        cg.school_year,
        cg.grade_level,
        cg.cds_code,
        cg.work_in_progress,
        cg.filename,
        case when cg.work_in_progress = 'N' then 1 else 0 end as graded_course,
        case when cg.work_in_progress = 'Y' then 1 else 0 end as wip_course
FROM archive_course_grades cg
WHERE 
cg.school_year = '2020-21' and
cg.grade_level IN ('09', '10', '11', '12')
), 

temp_tbl as (

SELECT 
      e.Enrolled_District, 
      e.Enrolled_School,
      e.CA_STATE_STUDENT_ID,
        cg.LOCAL_COURSE_ID,
        cg.course_grade,
        cg.term,
        cg.school_year,
        cg.grade_level,
        cg.cds_code,
        cg.work_in_progress,
        cg.filename,
      cg.graded_course,
      cg.wip_course
        

FROM ENR e
JOIN cg ON cg.CA_STATE_STUDENT_ID = e.CA_STATE_STUDENT_ID
JOIN cds_codes cds ON cds.cdscode = cg.cds_code

)



select 
        enrolled_District, 
        enrolled_School, 
        term, 
        school_year, 
        grade_level,
        count(distinct LOCAL_COURSE_ID) as unique_courses,
        sum(graded_course) as num_graded_courses, 
        sum(wip_course) as num_wip_courses,
        count(distinct CA_STATE_STUDENT_ID) as num_stu
        
        
from temp_tbl t1
GROUP BY Enrolled_District, Enrolled_School, term, school_year, grade_level
ORDER BY Enrolled_District, Enrolled_School, term, school_year, grade_level






select * from 
s1_grades_s2_wip
where enrolled_District LIKE 'Wasco%'



