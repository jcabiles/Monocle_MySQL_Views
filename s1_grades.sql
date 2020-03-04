SELECT * FROM s1_grades
WHERE district LIKE '%Madera%'


-- main view total courses
use ccgitranscripts;
CREATE OR REPLACE VIEW s1_grades AS
WITH cg AS (
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
WHERE cg.school_year LIKE '%2019-20%'
)

SELECT cds.district,
        cds.school,
        cg.term,
        cg.school_year,
        cg.grade_level,
        COUNT(DISTINCT(cg.LOCAL_COURSE_ID)) AS Total_Number_of_Graded_Courses,
        COUNT(DISTINCT(cg.CA_STATE_STUDENT_ID)) AS Total_Students_Affected,
        cg.cds_code,
        cg.filename
FROM cg
JOIN cds_codes cds ON cds.cdscode = cg.cds_code
WHERE cg.work_in_progress = 'N'
AND cg.grade_level IN ('09', '10', '11', '12')
AND cg.term IN ('S1', 'Q1', 'Q2', 'T1')
GROUP BY cds.school, cg.grade_level, cg.term
ORDER BY school_year desc, district, school, grade_level;


use ccgi_staging;
CREATE OR REPLACE VIEW s1_grades AS
WITH cg AS (
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
WHERE cg.school_year LIKE '%2019-20%'
)

SELECT cds.district,
        cds.school,
        cg.term,
        cg.school_year,
        cg.grade_level,
        COUNT(DISTINCT(cg.LOCAL_COURSE_ID)) AS Total_Number_of_Graded_Courses,
        COUNT(DISTINCT(cg.CA_STATE_STUDENT_ID)) AS Total_Students_Affected,
        cg.cds_code,
        cg.filename
FROM cg
JOIN cds_codes cds ON cds.cdscode = cg.cds_code
WHERE cg.work_in_progress = 'N'
AND cg.grade_level IN ('09', '10', '11', '12')
AND cg.term IN ('S1', 'Q1', 'Q2', 'T1')
GROUP BY cds.school, cg.grade_level, cg.term
ORDER BY school_year desc, district, school, grade_level;


-- archived view total courses
use ccgitranscripts;
CREATE OR REPLACE VIEW s1_grades_archived AS
WITH cg AS (
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
WHERE cg.school_year LIKE '%2019-20%'
)

SELECT cds.district,
        cds.school,
        cg.term,
        cg.school_year,
        cg.grade_level,
        COUNT(DISTINCT(cg.LOCAL_COURSE_ID)) AS Total_Number_of_Graded_Courses,
        COUNT(DISTINCT(cg.CA_STATE_STUDENT_ID)) AS Total_Students_Affected,
        cg.cds_code,
        cg.filename
FROM cg
JOIN cds_codes cds ON cds.cdscode = cg.cds_code
WHERE cg.work_in_progress = 'N'
AND cg.grade_level IN ('09', '10', '11', '12')
AND cg.term IN ('S1', 'Q1', 'Q2', 'T1')
GROUP BY cds.school, cg.grade_level, cg.term
ORDER BY school_year desc, district, school, grade_level;


use ccgi_staging;
CREATE OR REPLACE VIEW s1_grades_archived AS
WITH cg AS (
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
WHERE cg.school_year LIKE '%2019-20%'
)

SELECT cds.district,
        cds.school,
        cg.term,
        cg.school_year,
        cg.grade_level,
        COUNT(DISTINCT(cg.LOCAL_COURSE_ID)) AS Total_Number_of_Graded_Courses,
        COUNT(DISTINCT(cg.CA_STATE_STUDENT_ID)) AS Total_Students_Affected,
        cg.cds_code,
        cg.filename
FROM cg
JOIN cds_codes cds ON cds.cdscode = cg.cds_code
WHERE cg.work_in_progress = 'N'
AND cg.grade_level IN ('09', '10', '11', '12')
AND cg.term IN ('S1', 'Q1', 'Q2', 'T1')
GROUP BY cds.school, cg.grade_level, cg.term
ORDER BY school_year desc, district, school, grade_level;
