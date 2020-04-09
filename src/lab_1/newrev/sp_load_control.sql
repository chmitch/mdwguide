/****** Object:  StoredProcedure [Integration].[GetLastETLCutoffTime]    Script Date: 4/8/2020 7:20:40 PM ******/
DROP PROCEDURE [Integration].[GetLoadDate]
GO

/****** Object:  StoredProcedure [Integration].[GetLastETLCutoffTime]    Script Date: 4/8/2020 7:20:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [Integration].[GetLoadDate]
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    SELECT [Load_Date] AS LoadDate
    FROM Integration.[Load_Control];

END;
GO
