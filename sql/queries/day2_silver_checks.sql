
-------------------------------
-- Validation queries
------------------------------

-- exactly 7 rows per business
SELECT 
	count(*) 						AS n_rows
	,count(DISTINCT business_id) 	AS business
FROM 
	silver.silver_opening_hours
;
-- 24 business has 168 rows




SELECT 
	business_id
	,count(*) 		AS days
FROM 
	silver.silver_opening_hours
GROUP BY 
	business_id
HAVING 
	count(*) <> 7
;
--every business has exactally 7 days 


--How many 'closed' per weekday 
SELECT 
	weekday
	,count(*) FILTER(WHERE hours_std = 'closed') n_closed 
FROM 
	silver.silver_opening_hours
GROUP BY 
	weekday
ORDER BY 
	weekday
;
/*--------------------------
weekday n_closed
Fri	    10
Mon	    10
Sat	    4
Sun	    8
Thu	    9
Tue	    6
Wed	    6
*/--------------------------