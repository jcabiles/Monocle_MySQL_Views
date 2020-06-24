-- main view WIP
use ccgitranscripts;
CREATE OR REPLACE VIEW WIP_courses AS
WITH ENR
AS
(
select
c.District as Enrolled_District
, c.School as Enrolled_School
, s.CA_STATE_STUDENT_ID
from student s
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
        cg.filename
FROM course_grades cg
)

SELECT e.Enrolled_District
        , e.Enrolled_School
        , cds.district AS CourseTaken_District
        , cds.school AS CourseTaken_School
        , cg.term
        , cg.school_year
        , cg.grade_level
        , COUNT(DISTINCT(cg.LOCAL_COURSE_ID)) AS Total_Number_of_Graded_Courses
        , COUNT(DISTINCT(cg.CA_STATE_STUDENT_ID)) AS Total_Students_Affected
        , cg.cds_code
        , cg.filename
FROM ENR e
JOIN cg ON cg.CA_STATE_STUDENT_ID = e.CA_STATE_STUDENT_ID
JOIN cds_codes cds ON cds.cdscode = cg.cds_code
WHERE cg.work_in_progress = 'Y'
AND cg.grade_level IN ('09', '10', '11', '12')
GROUP BY e.Enrolled_District, e.Enrolled_School, cds.school, cg.grade_level, cg.term
ORDER BY school_year desc, district, Total_Students_Affected DESC, school, grade_level;

use ccgi_staging;
CREATE OR REPLACE VIEW WIP_courses AS
WITH ENR
AS
(
select
c.District as Enrolled_District
, c.School as Enrolled_School
, s.CA_STATE_STUDENT_ID
from student s
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
        cg.filename
FROM course_grades cg
)

SELECT e.Enrolled_District
        , e.Enrolled_School
        , cds.district AS CourseTaken_District
        , cds.school AS CourseTaken_School
        , cg.term
        , cg.school_year
        , cg.grade_level
        , COUNT(DISTINCT(cg.LOCAL_COURSE_ID)) AS Total_Number_of_Graded_Courses
        , COUNT(DISTINCT(cg.CA_STATE_STUDENT_ID)) AS Total_Students_Affected
        , cg.cds_code
        , cg.filename
FROM ENR e
JOIN cg ON cg.CA_STATE_STUDENT_ID = e.CA_STATE_STUDENT_ID
JOIN cds_codes cds ON cds.cdscode = cg.cds_code
WHERE cg.work_in_progress = 'Y'
AND cg.grade_level IN ('09', '10', '11', '12')
GROUP BY e.Enrolled_District, e.Enrolled_School, cds.school, cg.grade_level, cg.term
ORDER BY school_year desc, district, Total_Students_Affected DESC, school, grade_level;

-- archived view total courses
use ccgitranscripts;
CREATE OR REPLACE VIEW WIP_courses_archived AS
WITH ENR
AS
(
select
c.District as Enrolled_District
, c.School as Enrolled_School
, s.CA_STATE_STUDENT_ID
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
        cg.filename
FROM archive_course_grades cg
)

SELECT e.Enrolled_District
        , e.Enrolled_School
        , cds.district AS CourseTaken_District
        , cds.school AS CourseTaken_School
        , cg.term
        , cg.school_year
        , cg.grade_level
        , COUNT(DISTINCT(cg.LOCAL_COURSE_ID)) AS Total_Number_of_Graded_Courses
        , COUNT(DISTINCT(cg.CA_STATE_STUDENT_ID)) AS Total_Students_Affected
        , cg.cds_code
        , cg.filename
FROM ENR e
JOIN cg ON cg.CA_STATE_STUDENT_ID = e.CA_STATE_STUDENT_ID
JOIN cds_codes cds ON cds.cdscode = cg.cds_code
WHERE cg.work_in_progress = 'Y'
AND cg.grade_level IN ('09', '10', '11', '12')
GROUP BY e.Enrolled_District, e.Enrolled_School, cds.school, cg.grade_level, cg.term
ORDER BY school_year desc, district, Total_Students_Affected DESC, school, grade_level;

use ccgi_staging;
CREATE OR REPLACE VIEW WIP_courses_archived AS
WITH ENR
AS
(
select
c.District as Enrolled_District
, c.School as Enrolled_School
, s.CA_STATE_STUDENT_ID
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
        cg.filename
FROM archive_course_grades cg
)

SELECT e.Enrolled_District
        , e.Enrolled_School
        , cds.district AS CourseTaken_District
        , cds.school AS CourseTaken_School
        , cg.term
        , cg.school_year
        , cg.grade_level
        , COUNT(DISTINCT(cg.LOCAL_COURSE_ID)) AS Total_Number_of_Graded_Courses
        , COUNT(DISTINCT(cg.CA_STATE_STUDENT_ID)) AS Total_Students_Affected
        , cg.cds_code
        , cg.filename
FROM ENR e
JOIN cg ON cg.CA_STATE_STUDENT_ID = e.CA_STATE_STUDENT_ID
JOIN cds_codes cds ON cds.cdscode = cg.cds_code
WHERE cg.work_in_progress = 'Y'
AND cg.grade_level IN ('09', '10', '11', '12')
GROUP BY e.Enrolled_District, e.Enrolled_School, cds.school, cg.grade_level, cg.term
ORDER BY school_year desc, district, Total_Students_Affected DESC, school, grade_level;
