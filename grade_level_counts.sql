use ccgitranscripts;
CREATE OR REPLACE VIEW grade_level_counts AS

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
		FROM ccgitranscripts.archive_student
	) t1
ORDER BY filename, inserted_at ASC
)


, student_files as (
SELECT 
    District,
    filename,
    inserted_at,
    case when grade_level IN ('05', '06', '07', '08') then 1 else 0 end as less_than_9,
	case when grade_level = '09' then 1 else 0 end as grade_9,
	case when grade_level = '10' then 1 else 0 end as grade_10,
	case when grade_level = '11' then 1 else 0 end as grade_11,
	case when grade_level = '12' then 1 else 0 end as grade_12,
	case when grade_level = 'HG' then 1 else 0 end as hs_grads

FROM ccgitranscripts.archive_student
left join (
		SELECT 
			DISTINCT
			CDSCode,
			District
		FROM ccgitranscripts.cds_codes
		WHERE SOCType = 'No Data'
		order by CDSCode
	) district_lookup 
	on concat(substr(cds_code,1,7), '0000000' ) = district_lookup.CDSCode

WHERE filename IN (select filename from recent_files WHERE row_num = 1 )

)

SELECT 
	District, 
    sum(less_than_9) as less_than_9,
    sum(grade_9) as grade_9,
    sum(grade_10) as grade_10,
    sum(grade_11) as grade_11,
    sum(grade_12) as grade_12,
    sum(hs_grads) as hs_grads,
    filename,
    inserted_at
        
FROM student_files
GROUP BY District, filename, inserted_at