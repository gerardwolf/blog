-- --------------------------
-- Make some changes to data
-- --------------------------

-- Insert new row
INSERT INTO [dbo].[TestDeltaLake]
VALUES
	(4, 'NewValue4',SYSDATETIMEOFFSET() AT TIME ZONE 'New Zealand Standard Time', 4, 4.5678, 'C45E0228-0C06-4782-86B6-97B86575ADFE', '2001-01-01 00:00:00.000')

SELECT * FROM [dbo].[TestDeltaLake]

-- Update existing row
UPDATE	[dbo].[TestDeltaLake]
SET		[SomeNvarchar] = 'UpdateValue1'
		,[SomeDateTimeOffset] = SYSDATETIMEOFFSET() AT TIME ZONE 'New Zealand Standard Time'
		,[SomeDecimal] = 1234.5
		,[SomeDateTime] = GETDATE()
WHERE	SomeId = 1

SELECT * FROM [dbo].[TestDeltaLake]

-- Delete exisitng row
DELETE FROM [dbo].[TestDeltaLake] WHERE SomeId = 2

SELECT * FROM [dbo].[TestDeltaLake]