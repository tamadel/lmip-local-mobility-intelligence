-----------------------------
-- T1: Address normalization
-----------------------------
-- Source overview
SELECT * FROM bronze.bronze_businesses;

DROP TABLE IF EXISTS silver.silver_businesses;
CREATE TABLE silver.silver_businesses
AS 
SELECT
	business_id 
	,"name" 
	,category 
	,is_mobility_domain 
	,website 
	,phone 
	,address_full 
	,trim(regexp_replace(split_part(address_full, ',', 1), '[0-9].*$', '')) 				AS street_name
	,substring(
				trim(split_part(address_full, ',', 1)) 
	 			FROM '([0-9]{1,5}[A-Za-z]{0,2})\s*$'
			) 																				                                  AS house_number
	,city 
	,postal_code 
	,country 
	,source_system 		
FROM
	bronze.bronze_businesses
;


--------
-- QA
--------

--% of rows with parsed house_number 
SELECT 
	count(*) FILTER(WHERE house_number IS NOT NULL)::float / count(*) AS pct_house_num
FROM 
	silver.silver_businesses
;


-- suspicious house numbers (contain words)
SELECT 
	business_id
	,address_full
	,house_number
FROM 
	silver.silver_businesses
WHERE 
	house_number !~ '^[0-9]{1,5}[A-Za-z]{0,2}$' 
	AND 
	house_number IS NOT NULL
;


-- postal code completeness
SELECT 
	COUNT(*) FILTER (WHERE postal_code ~ '^[0-9]{4}$') 	AS ok_four_digit
	,COUNT(*) 												AS total
FROM 
	silver.silver_businesses
;



