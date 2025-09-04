-----------------------------------
-- T2: Opening hours normalization
-----------------------------------
-- Source overview
SELECT * FROM bronze.bronze_opening_hours;


-- create a helper reference table for weekdays
DROP TABLE IF EXISTS ref_weekday;
CREATE TABLE IF NOT EXISTS silver.ref_weekday(
		idx 		int 	PRIMARY KEY
		,day_short 	text 	UNIQUE 
)
;

INSERT INTO silver.ref_weekday(idx, day_short) VALUES
		 (1, 'Mon')
		,(2, 'Tue')
		,(3, 'Wed')
		,(4, 'Thu')
		,(5, 'Fri')
		,(6, 'Sat')
		,(7, 'Sun')
;		

SELECT * FROM silver.ref_weekday;


-- Step(I): normalize separators and mark "closed"
DROP TABLE IF EXISTS silver.wrk_open_hours_norm;
CREATE TABLE silver.wrk_open_hours_norm
AS
SELECT 
	oh.business_id
	,rw.idx
	,rw.day_short 						AS weekday
	,CASE
		WHEN 
			oh.hours_raw IS NULL 
			OR 
			oh.hours_raw = ''
			OR 
			oh.hours_raw ILIKE '%closed%'
		THEN 
			NULL
		ELSE -- unify dashes and pipes: turn any " – " or " - " into "-"
			trim(regexp_replace(
						regexp_replace(
								oh.hours_raw, '[--]', '-', 'g'
						),
						'\s*\|\s*', ' | ', 'g'
				)
			)
	END									AS hours_norm
FROM
	bronze.bronze_opening_hours oh
JOIN 
	silver.ref_weekday rw
ON 
	rw.day_short = oh.weekday
;

SELECT * FROM silver.wrk_open_hours_norm;




--Step(II): Expand multi ranges per day split on "|" using LATERAL
DROP TABLE IF EXISTS silver.wrk_open_hours_expanded;
CREATE TABLE silver.wrk_open_hours_expanded
AS
SELECT 
	n.business_id
	,n.idx
	,n.weekday
	,trim(regexp_replace(rng, '\s*-\s*', '-', 'g')) 				AS range_norm
FROM 
	silver.wrk_open_hours_norm n
CROSS JOIN LATERAL 
	regexp_split_to_table(COALESCE(n.hours_norm, ''),  '\s*\|\s*') 	AS rng
WHERE 
	rng <> ''
;


--Step(III): build up the full 7 days coverage and aggregate ranges

-- Distinct business to guarantee 7 rows eac
DROP TABLE IF EXISTS silver.ref_business;
CREATE TABLE silver.ref_business 
AS
SELECT DISTINCT 
	business_id
FROM 
	bronze.bronze_opening_hours
;


DROP TABLE IF EXISTS silver.silver_opening_hours;
CREATE TABLE silver.silver_opening_hours
AS
SELECT 
	rb.business_id
	,rw.day_short 		AS weekday
	,CASE
		WHEN 
			count(e.range_norm) = 0
		THEN 
			'closed'
		ELSE 
			'[' || string_agg(DISTINCT e.range_norm, ' | ' ORDER BY e.range_norm) || ']'
	END AS hours_std
FROM 
	silver.ref_business rb
CROSS JOIN 
	silver.ref_weekday rw
LEFT JOIN
	silver.wrk_open_hours_expanded e
ON 
	e.business_id = rb.business_id
	AND 
	e.idx = rw.idx
GROUP BY 
	rb.business_id
	,rw.idx
	,rw.day_short
ORDER BY 
	rb.business_id
	,rw.idx
;	