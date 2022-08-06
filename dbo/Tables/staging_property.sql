CREATE TABLE [dbo].[staging_property] (
    [address]          VARCHAR (200) NULL,
    [suburb]           VARCHAR (50)  NULL,
    [state]            VARCHAR (5)   NULL,
    [postcode]         VARCHAR (4)   NULL,
    [type]             VARCHAR (20)  NULL,
    [bedroom]          FLOAT (53)    NULL,
    [bathroom]         FLOAT (53)    NULL,
    [garage]           FLOAT (53)    NULL,
    [size]             FLOAT (53)    NULL,
    [url]              VARCHAR (200) NOT NULL,
    [listing_id]       INT           NULL,
    [created_date]     DATE          NOT NULL,
    [details_end_date] DATE          NULL
);


GO

