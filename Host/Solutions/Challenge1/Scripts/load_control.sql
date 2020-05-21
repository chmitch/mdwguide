/****** Object:  Table [Integration].[Load_Control]    Script Date: 4/8/2020 7:12:55 PM ******/
DROP TABLE [Integration].[Load_Control]
GO

/****** Object:  Table [Integration].[Load_Control]    Script Date: 4/8/2020 7:12:55 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Integration].[Load_Control](
	[Load_Date] [datetime2](7) NOT NULL
)
GO

INSERT INTO [Integration].[Load_Control]
           ([Load_Date])
     VALUES
           ('2020-01-01 23:59:59.0000000')

--UPDATE [Integration].[Load_Control]
--   SET [Load_Date] = '2016-07-01 12:31:17.0000000'
--GO