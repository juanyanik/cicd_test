create or replace view SUMMARY_VIEW(
	ID,
	NAME,
	CREATED_AT
) as SELECT * FROM SALES_DB.FINANCES.ORDERS WHERE CREATED_AT > CURRENT_DATE - 30;