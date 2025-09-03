--===================================
-- QA: Day1 Profiling
--===================================


----------------------------------------
-- T1: bronze_businesses row_count = 24
----------------------------------------
SELECT * FROM bronze.bronze_businesses;


SELECT 
	business_id
	,count(*)
FROM 
	bronze.bronze_businesses
GROUP BY 
	business_id
HAVING 
	count(*) > 1
;
-- No duplicates


SELECT 
	count(*) AS 	n_businesses
FROM 
	bronze.bronze_businesses
;
--row_count = 24


-- Source System
SELECT 
	source_system
	,count(*)
FROM 
	bronze.bronze_businesses
GROUP BY 
	source_system
ORDER BY 
	2 DESC
;
/*--------------------------------
Moneyhouse.ch	13
Search.ch		6
Google Maps		5
*/--------------------------------


-- Categories
SELECT 
	category
	,count(*)
FROM 
	bronze.bronze_businesses
GROUP BY 
	category
ORDER BY 
	2 DESC
;
/*--------------------------------
Mobility Consulting		5
Car‑Sharing Hub			5
Gym						4
Pet Store				3
E‑Scooter Rental				2
Bike Shop				2
Café					1
Public Charging Station	1
Bakery					1
*/--------------------------------


----------------------------------------
-- T2: bronze_locations row_count = 24
----------------------------------------
SELECT * FROM bronze.bronze_locations;

SELECT 
	count(*) AS 	n_locations
FROM 
	bronze.bronze_locations
;
--row_count = 24


--Basic null checks
SELECT 
	COUNT(*) 										AS n_locs
	,SUM(CASE 
			WHEN 
				geom IS NULL 
			THEN 
				1 
			ELSE 
				0 
		END) 										AS missing_geom
FROM 
	bronze.bronze_locations
;
-- all locations has geom


--------------------------------------------
-- T3: bronze_opening_hours row_count = 150
--------------------------------------------
SELECT * FROM bronze.bronze_opening_hours;

SELECT 
	count(*) AS 	n_opening_hours
FROM 
	bronze.bronze_opening_hours
;
--row_count = 150


SELECT 
	weekday
	,COUNT(*) 												AS ROWS
	,SUM(
		CASE 
			WHEN 
				hours_raw ILIKE '%closed%' 
			THEN 
				1 
			ELSE 
				0 
		END
		) 													AS n_closed
FROM 
	bronze.bronze_opening_hours
GROUP BY 
	weekday
ORDER BY 
	1 
;
/*--------------------------------
weekday	|	rows	|	n_closed
----------------------------------
Fri			21			2
Mon			20			2
Sat			22			1
Sun			22			3
Thu			22			4
Tue			23			2
Wed			20			1
*/--------------------------------

-- Business id
SELECT 
	business_id
	,COUNT(*) 			AS entries
FROM 
	bronze.bronze_opening_hours
GROUP BY 
	business_id
HAVING 
	COUNT(*) > 7
ORDER BY 
	2 DESC
;
-- every business has maximum 7 days opening hours

SELECT
	business_id
	,count(*)
	,sum(
		CASE
			WHEN  
				hours_raw = '' OR hours_raw IS NULL
			THEN 
				1
			ELSE 
				0
		END
	) 				AS num_empty_value
FROM 
	bronze.bronze_opening_hours
GROUP BY 
	business_id
ORDER BY 
	3 DESC,
	2 DESC 
;

-- there are 20 rows has no value in hours_raw by maximun 2 per business_id
	
-------------------------------------
-- T4: bronze_reviews row_count = 67
-------------------------------------
SELECT * FROM bronze.bronze_reviews;

SELECT 
	count(*) AS 	n_reviews
FROM 
	bronze.bronze_reviews
;


---------------------------------------------
-- T5: bronze_search_results row_count = 72
---------------------------------------------
SELECT * FROM bronze.bronze_search_results;

SELECT 
	count(*) AS 	n_search_results
FROM 
	bronze.bronze_search_results
;

SELECT 
	SOURCE
	,COUNT(*) 
FROM 
	bronze.bronze_search_results
GROUP BY 
	source
ORDER BY 
	2 DESC
;
/*--------------------------------
Other			33
Search.ch		24
Moneyhouse.ch	15
*/--------------------------------







