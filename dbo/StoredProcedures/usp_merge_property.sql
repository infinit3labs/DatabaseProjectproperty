create PROCEDURE usp_merge_property as
INSERT INTO property
	(address,
	 suburb,
	 state,
	 postcode,
	 type,
	 bedroom,
	 bathroom,
	 garage,
	 size,
	 url,
	 listing_id,
	 created_date,
	 details_end_date
	 )
SELECT address,
	 suburb,
	 state,
	 postcode,
	 type,
	 bedroom,
	 bathroom,
	 garage,
	 size,
	 url,
	 listing_id,
	 created_date,
	 details_end_date
FROM (
	MERGE INTO property AS tgt
		USING (SELECT * FROM staging_property) AS src
			(
				address,
	 suburb,
	 state,
	 postcode,
	 type,
	 bedroom,
	 bathroom,
	 garage,
	 size,
	 url,
	 listing_id,
	 created_date,
	 details_end_date
				) ON tgt.listing_id = src.listing_id
		WHEN MATCHED AND (isnull(src.address , '') <> isnull(tgt.address , '') OR
		                  isnull(src.suburb , '') <> isnull(tgt.suburb , '') OR
		                  isnull(src.state , '') <> isnull(tgt.state , '') OR
		                  isnull(src.postcode , '') <> isnull(tgt.postcode , '') OR
		                  isnull(src.type , '') <> isnull(tgt.type , '') OR
		                  isnull(src.bedroom , '') <> isnull(tgt.bedroom , '') OR
		                  isnull(src.bathroom , '') <> isnull(tgt.bathroom , '') OR
		                  isnull(src.garage , '') <> isnull(tgt.garage , '') OR
		                  isnull(src.size , '') <> isnull(tgt.size , ''))
			AND tgt.details_end_date = '9999-12-31'
			THEN
			UPDATE SET
				details_end_date = getdate() - 1
		WHEN NOT MATCHED THEN
			INSERT
				(
				 address,
	 suburb,
	 state,
	 postcode,
	 type,
	 bedroom,
	 bathroom,
	 garage,
	 size,
	 url,
	 listing_id,
	 created_date,
	 details_end_date
					)
				VALUES (src.address,
	 src.suburb,
	 src.state,
	 src.postcode,
	 src.type,
	 src.bedroom,
	 src.bathroom,
	 src.garage,
	 src.size,
	 src.url,
	 src.listing_id,
	 src.created_date,
	 src.details_end_date)
		OUTPUT $action,
			src.address,
	 src.suburb,
	 src.state,
	 src.postcode,
	 src.type,
	 src.bedroom,
	 src.bathroom,
	 src.garage,
	 src.size,
	 src.url,
	 src.listing_id,
	 src.created_date,
	 src.details_end_date
) AS changes
	(
		action ,
	    address,
	 suburb,
	 state,
	 postcode,
	 type,
	 bedroom,
	 bathroom,
	 garage,
	 size,
	 url,
	 listing_id,
	 created_date,
	 details_end_date
		)
WHERE action = 'UPDATE'

GO

