-- bronze.bronze_reviews definition

-- Drop table

-- DROP TABLE bronze.bronze_reviews;

CREATE TABLE bronze.bronze_reviews (
	business_id int4 NULL,
	review_id text NULL,
	rating int4 NULL,
	"text" text NULL,
	review_date date NULL
);


-- bronze.bronze_reviews foreign keys

ALTER TABLE bronze.bronze_reviews 
ADD CONSTRAINT bronze_reviews_business_id_fkey 
FOREIGN KEY (business_id) REFERENCES bronze.bronze_businesses(business_id);