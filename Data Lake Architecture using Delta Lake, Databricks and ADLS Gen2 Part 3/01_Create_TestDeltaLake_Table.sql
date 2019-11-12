-- --------------------------
-- Create TestDeltaLake Table
-- --------------------------
DROP TABLE IF EXISTS [dbo].[TestDeltaLake]
GO

CREATE TABLE [dbo].[TestDeltaLake](
	[SomeId] [int]  NOT NULL,
	[SomeNvarchar] [nvarchar](20) NOT NULL,
	[SomeDateTimeOffset] [datetimeoffset] NULL,
	[SomeInt] [int] NOT NULL,
	[SomeDecimal] [decimal] (18,7) NOT NULL,
	[SomeGUID] [uniqueidentifier] NOT NULL,
	[SomeDateTime] [datetime] NULL,
	CONSTRAINT [PK_DeltaLake] PRIMARY KEY CLUSTERED ([SomeId] ASC),
)