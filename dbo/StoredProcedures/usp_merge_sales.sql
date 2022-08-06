CREATE PROCEDURE usp_merge_sales as
INSERT INTO sales
	(listing_id,
	 price,
	 contract_date,
	 created_date,
	 details_end_date
	 )
SELECT listing_id,
       price,
       contract_date,
       created_date,
       details_end_date
FROM (
	MERGE INTO sales AS tgt
		USING (SELECT * FROM staging_sales) AS src
			(
				listing_id ,
			    price ,
			    contract_date,
			    created_date ,
			    details_end_date
				) ON tgt.listing_id = src.listing_id and tgt.contract_date = src.contract_date
		WHEN MATCHED AND isnull(src.price , '') <> isnull(tgt.price , '')
			AND tgt.details_end_date = '9999-12-31'
			THEN
			UPDATE SET
				details_end_date = getdate() - 1
		WHEN NOT MATCHED THEN
			INSERT
				(
				 listing_id ,
				 price ,
				 contract_date ,
				 created_date ,
				 details_end_date
					)
				VALUES (src.listing_id ,
				        src.price,
				        src.contract_date ,
				        src.created_date ,
				        src.details_end_date)
		OUTPUT $action,
			src.listing_id,
			src.price,
			src.contract_date,
			src.created_date,
			src.details_end_date
) AS changes
	(
		action ,
	    listing_id ,
	    price ,
	    contract_date ,
	    created_date ,
	    details_end_date
		)
WHERE action = 'UPDATE'

GO

