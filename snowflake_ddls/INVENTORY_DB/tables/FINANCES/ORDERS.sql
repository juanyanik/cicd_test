create or replace TABLE ORDERS (
	ID NUMBER(38,0),
	NAME VARCHAR(16777216),
	CREATED_AT TIMESTAMP_NTZ(9) DEFAULT CURRENT_TIMESTAMP()
);