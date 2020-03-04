-- main view
USE ccgi_staging;
CREATE OR REPLACE VIEW pc_equals_n_students AS
SELECT
	cds.district,
	stu.CA_STATE_STUDENT_ID AS 'SSID',
	stu.GRADE_LEVEL AS 'Grade_Level',
	cds.School AS 'School',
	stu.CDS_CODE,
	stu.PARENT_CONSENT,
	stu.filename AS 'from_file'
FROM student stu
JOIN cds_codes cds ON cds.CDSCODE = stu.CDS_CODE
WHERE stu.PARENT_CONSENT='N'
ORDER BY School, Grade_Level, SSID;


USE ccgitranscripts;
CREATE OR REPLACE VIEW pc_equals_n_students AS
SELECT
	cds.district,
	stu.CA_STATE_STUDENT_ID AS 'SSID',
	stu.GRADE_LEVEL AS 'Grade_Level',
	cds.School AS 'School',
	stu.CDS_CODE,
	stu.PARENT_CONSENT,
	stu.filename AS 'from_file'
FROM student stu
JOIN cds_codes cds ON cds.CDSCODE = stu.CDS_CODE
WHERE stu.PARENT_CONSENT='N'
ORDER BY School, Grade_Level, SSID;


-- archived view
USE ccgi_staging;
CREATE OR REPLACE VIEW pc_equals_n_students_archived AS
SELECT
	cds.district,
	stu.CA_STATE_STUDENT_ID AS 'SSID',
	stu.GRADE_LEVEL AS 'Grade_Level',
	cds.School AS 'School',
	stu.CDS_CODE,
	stu.PARENT_CONSENT,
	stu.filename AS 'from_file'
FROM archive_student stu
JOIN cds_codes cds ON cds.CDSCODE = stu.CDS_CODE
WHERE stu.PARENT_CONSENT='N'
ORDER BY School, Grade_Level, SSID;


USE ccgitranscripts;
CREATE OR REPLACE VIEW pc_equals_n_students_archived AS
SELECT
	cds.district,
	stu.CA_STATE_STUDENT_ID AS 'SSID',
	stu.GRADE_LEVEL AS 'Grade_Level',
	cds.School AS 'School',
	stu.CDS_CODE,
	stu.PARENT_CONSENT,
	stu.filename AS 'from_file'
FROM archive_student stu
JOIN cds_codes cds ON cds.CDSCODE = stu.CDS_CODE
WHERE stu.PARENT_CONSENT='N'
ORDER BY School, Grade_Level, SSID;