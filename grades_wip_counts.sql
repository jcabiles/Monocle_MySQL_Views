
#####################################################

use ccgitranscripts;
CREATE OR REPLACE VIEW grades_wip_counts AS

WITH recent_files as (    
select
	substr(t1.filename, 1, 9),
	t1.filename, t1.inserted_at,
	ROW_NUMBER() OVER (	
		PARTITION BY substr(t1.filename, 1, 9)
        ORDER BY inserted_at DESC
	) row_num
from 
	(
		SELECT 
		distinct filename, inserted_at
		FROM ccgitranscripts.archive_course_grades
	) t1

ORDER BY filename, inserted_at ASC
)


, course_grade_files as (

SELECT 
	# substr(CDS_CODE, 1, 7) as district_cds_code,
    CDS_CODE,
	filename,
    inserted_at,
    school_year,
    term,
    CASE WHEN work_in_progress = 'N' THEN 1 ELSE 0 END AS GRADES,
    CASE WHEN work_in_progress = 'Y' THEN 1 ELSE 0 END AS WIP
FROM ccgitranscripts.archive_course_grades
WHERE filename IN (select filename from recent_files WHERE row_num = 1 )

### UPDATE ACADEMIC YEAR BELOW ####

AND school_year = '2020-21'

)

, agg_course_grade_files as (

	select 
		filename,
		inserted_at,
		school_year,
		term,
		sum(grades) as total_grades,
		sum(wip) as total_wip
	from course_grade_files
	group by 
		filename,
		inserted_at,
		school_year,
		term
)

, filename_to_districtname as (
	select
		cgs1.filename, 
		cgs1.cds_code as top_cds_code,
		concat(substr(cgs1.cds_code,1,7), '0000000' ) as district_cds_code,
		district_lookup.District
	from (
		select
		cg.filename, 
		cg.cds_code,
		ROW_NUMBER() OVER (	
			PARTITION BY cg.filename
			ORDER BY cg.total_courses DESC
		) row_num
		from (
			select 
				CDS_CODE, filename, sum(grades)+sum(wip) as total_courses 
			from course_grade_files
			group by CDS_CODE, filename
			order by filename, sum(grades)+sum(wip) desc
		) cg
	) cgs1 
	left join (
		SELECT 
			DISTINCT
			CDSCode,
			District
		FROM ccgitranscripts.cds_codes
		WHERE SOCType = 'No Data'
		order by CDSCode
	) district_lookup 
	on concat(substr(cgs1.cds_code,1,7), '0000000' ) = district_lookup.CDSCode
	where cgs1.row_num = 1
)

select 
	# t2.District,
    case when substr(t1.filename,1,5) = 'PUHSD' and t2.District is null then 'Perris Union High' else t2.District end as district_name,
	t1.filename,
	t1.inserted_at,
	t1.school_year,
	t1.term,
	t1.total_grades,
	t1.total_wip

from 
	agg_course_grade_files t1
left join
	filename_to_districtname t2
on t1.filename = t2.filename
order by t2.District, t1.term

;
#####################################################

