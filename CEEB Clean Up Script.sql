use ccgitranscripts;
CREATE OR REPLACE VIEW ceeb_counts_view AS

SELECT
        T1.CDS_CODE,
        T1.DISTRICT,
        T1.SCHOOL,
        SUM(T1.ATP_111111) AS ATP_111111_COUNT,
        SUM(T1.ATP_999999) AS ATP_999999_COUNT,
        SUM(T1.ATP_OTHER) AS ATP_OTHER_COUNT

FROM (

        SELECT 
                cg.CDS_CODE,
                c.District,
                c.School,
                CASE WHEN cg.ATP_CODE = '111111' THEN 1 ELSE 0 END AS ATP_111111,
                CASE WHEN cg.ATP_CODE = '999999' THEN 1 ELSE 0 END AS ATP_999999,
                CASE WHEN cg.ATP_CODE NOT IN ('111111','999999') THEN 1 ELSE 0 END AS ATP_OTHER

                
        FROM ccgitranscripts.archive_course_grades cg

        JOIN ccgitranscripts.cds_codes c ON cg.CDS_CODE = c.CDSCode
) T1

GROUP BY 

T1.CDS_CODE,
T1.DISTRICT,
T1.SCHOOL