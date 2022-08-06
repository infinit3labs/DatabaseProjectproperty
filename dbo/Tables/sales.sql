CREATE TABLE [dbo].[sales] (
    [id]               INT  IDENTITY (1, 1) NOT NULL,
    [listing_id]       INT  NOT NULL,
    [price]            INT  NULL,
    [contract_date]    DATE NOT NULL,
    [created_date]     DATE NOT NULL,
    [details_end_date] DATE NOT NULL
);


GO

