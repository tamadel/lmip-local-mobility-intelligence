-- bronze.bronze_locations definition

-- Drop table

-- DROP TABLE bronze.bronze_locations;

CREATE TABLE bronze.bronze_locations (
	business_id int4 NULL,
	latitude float8 NULL,
	longitude float8 NULL,
	plus_code text NULL,
	google_place_id text NULL,
	geom public.geography(point, 4326) NULL,
	geo_point_lv95 public.geometry(point, 2056) NULL,
	geo_point_lv03 public.geometry(point, 21781) NULL
);


-- bronze.bronze_locations foreign keys

ALTER TABLE bronze.bronze_locations 
ADD CONSTRAINT bronze_locations_business_id_fkey 
FOREIGN KEY (business_id) 
REFERENCES bronze.bronze_businesses(business_id);