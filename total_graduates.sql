-- main view
use ccgi_staging;
CREATE OR REPLACE VIEW total_graduates AS
WITH total AS (
SELECT cds.district, stu.CA_STATE_STUDENT_ID AS 'SSID', COUNT(*) AS TotalStudents
FROM student stu
JOIN cds_codes cds ON cds.CDSCODE = stu.CDS_CODE
),
total_grads AS (
SELECT cds.district, stu.CA_STATE_STUDENT_ID AS 'SSID', COUNT(*) AS TotalGrads
FROM archive_student stu
JOIN cds_codes cds ON cds.CDSCODE = stu.CDS_CODE
WHERE stu.GRADE_LEVEL = 'HG'
)
SELECT t.district AS 'District', t.TotalStudents, g.TotalGrads
FROM total t
JOIN total_grads g
ON t.district = g.district;

use ccgitranscripts;
CREATE OR REPLACE VIEW total_graduates AS
WITH total AS (
SELECT cds.district, stu.CA_STATE_STUDENT_ID AS 'SSID', COUNT(*) AS TotalStudents
FROM archive_student stu
JOIN cds_codes cds ON cds.CDSCODE = stu.CDS_CODE
),
total_grads AS (
SELECT cds.district, stu.CA_STATE_STUDENT_ID AS 'SSID', COUNT(*) AS TotalGrads
FROM student stu
JOIN cds_codes cds ON cds.CDSCODE = stu.CDS_CODE
WHERE stu.GRADE_LEVEL = 'HG'
)
SELECT t.district AS 'District', t.TotalStudents, g.TotalGrads
FROM total t
JOIN total_grads g
ON t.district = g.district;

-- archived view
use ccgi_staging;
CREATE OR REPLACE VIEW total_graduates_archived AS
WITH total AS (
SELECT cds.district, stu.CA_STATE_STUDENT_ID AS 'SSID', COUNT(*) AS TotalStudents
FROM archive_student stu
JOIN cds_codes cds ON cds.CDSCODE = stu.CDS_CODE
),

total_grads AS (
SELECT cds.district, stu.CA_STATE_STUDENT_ID AS 'SSID', COUNT(*) AS TotalGrads
FROM archive_student stu
JOIN cds_codes cds ON cds.CDSCODE = stu.CDS_CODE
WHERE stu.GRADE_LEVEL = 'HG'
)

SELECT t.district AS 'District', t.TotalStudents, g.TotalGrads
FROM total t
JOIN total_grads g
ON t.district = g.district;

use ccgitranscripts;
CREATE OR REPLACE VIEW total_graduates_archived AS
WITH total AS (
SELECT cds.district, stu.CA_STATE_STUDENT_ID AS 'SSID', COUNT(*) AS TotalStudents
FROM archive_student stu
JOIN cds_codes cds ON cds.CDSCODE = stu.CDS_CODE
),

total_grads AS (
SELECT cds.district, stu.CA_STATE_STUDENT_ID AS 'SSID', COUNT(*) AS TotalGrads
FROM archive_student stu
JOIN cds_codes cds ON cds.CDSCODE = stu.CDS_CODE
WHERE stu.GRADE_LEVEL = 'HG'
)

SELECT t.district AS 'District', t.TotalStudents, g.TotalGrads
FROM total t
JOIN total_grads g
ON t.district = g.district;