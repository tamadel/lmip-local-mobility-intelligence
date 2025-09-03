-- bronze.bronze_search_results definition

-- Drop table

-- DROP TABLE bronze.bronze_search_results;

CREATE TABLE bronze.bronze_search_results (
	query text NULL,
	title text NULL,
	url text NULL,
	snippet text NULL,
	"source" text NULL
);