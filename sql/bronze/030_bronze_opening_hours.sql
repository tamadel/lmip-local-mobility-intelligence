-- bronze.bronze_opening_hours definition

-- Drop table

-- DROP TABLE bronze.bronze_opening_hours;

CREATE TABLE bronze.bronze_opening_hours (
	business_id int4 NULL,
	weekday text NULL,
	hours_raw text NULL
);


-- bronze.bronze_opening_hours foreign keys

ALTER TABLE bronze.bronze_opening_hours 
ADD CONSTRAINT bronze_opening_hours_business_id_fkey 
FOREIGN KEY (business_id) REFERENCES bronze.bronze_businesses(business_id);