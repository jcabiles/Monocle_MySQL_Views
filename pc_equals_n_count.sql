-- main view
USE ccgi_staging;
CREATE OR REPLACE VIEW pc_equals_n_count AS
SELECT
	cds.District,
	cds.School AS 'School',
	stu.CDS_CODE,
	COUNT(*) AS Total_Students_with_PC_N, 
	stu.filename
FROM student stu
JOIN cds_codes cds ON cds.CDSCODE = stu.CDS_CODE
WHERE stu.PARENT_CONSENT='N'
GROUP BY School, stu.PARENT_CONSENT
ORDER BY Total_Students_with_PC_N DESC;


USE ccgitranscripts;
CREATE OR REPLACE VIEW pc_equals_n_count AS
SELECT
	cds.District,
	cds.School AS 'School',
	stu.CDS_CODE,
	COUNT(*) AS Total_Students_with_PC_N, 
	stu.filename
FROM student stu
JOIN cds_codes cds ON cds.CDSCODE = stu.CDS_CODE
WHERE stu.PARENT_CONSENT='N'
GROUP BY School, stu.PARENT_CONSENT
ORDER BY Total_Students_with_PC_N DESC;


-- archived view
USE ccgi_staging;
CREATE OR REPLACE VIEW pc_equals_n_count_archived AS
SELECT
	cds.District,
	cds.School AS 'School',
	stu.CDS_CODE,
	COUNT(*) AS Total_Students_with_PC_N, 
	stu.filename
FROM archive_student stu
JOIN cds_codes cds ON cds.CDSCODE = stu.CDS_CODE
WHERE stu.PARENT_CONSENT='N'
GROUP BY School, stu.PARENT_CONSENT
ORDER BY Total_Students_with_PC_N DESC;


USE ccgitranscripts;
CREATE OR REPLACE VIEW pc_equals_n_count_archived AS
SELECT
	cds.District,
	cds.School AS 'School',
	stu.CDS_CODE,
	COUNT(*) AS Total_Students_with_PC_N, 
	stu.filename
FROM archive_student stu
JOIN cds_codes cds ON cds.CDSCODE = stu.CDS_CODE
WHERE stu.PARENT_CONSENT='N'
GROUP BY School, stu.PARENT_CONSENT
ORDER BY Total_Students_with_PC_N DESC;