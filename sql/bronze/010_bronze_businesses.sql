-- bronze.bronze_businesses definition

-- Drop table

-- DROP TABLE bronze.bronze_businesses;

CREATE TABLE bronze.bronze_businesses (
	business_id int4 NOT NULL,
	"name" text NULL,
	category text NULL,
	is_mobility_domain bool NULL,
	website text NULL,
	phone text NULL,
	address_full text NULL,
	city text NULL,
	postal_code text NULL,
	country text NULL,
	source_system text NULL,
	CONSTRAINT bronze_businesses_pkey PRIMARY KEY (business_id)
);