-- main views
use ccgitranscripts;

CREATE OR REPLACE VIEW test_grade_totals AS
(
SELECT 
 cds.District
,test.Test_Type

FROM archive_test_grades test
LEFT JOIN cds_codes cds ON cds.CDSCODE = test.CDS_CODE
WHERE test.CDS_CODE LIKE '33%' 
GROUP BY test.TEST_TYPE, cds.
)
