USE [WideWorldImporters]
GO
/****** Object:  StoredProcedure [Integration].[GetCityUpdates]    Script Date: 4/22/2020 4:14:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [Integration].[GetUpdates]
@TableName nvarchar(100),
@LastCutoff  nvarchar(50),
@NewCutoff  nvarchar(50)
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

  
--Determine Which Load procedure to run

--These should match source queries in original SSIS DFTs

DECLARE @SQL nvarchar(max) = N''

SET @SQL = CASE @TableName 

WHEN 'City' THEN 
'EXEC Integration.GetCityUpdates ''' + @LastCutoff  + ''', ''' +@NewCutoff   + '''
WITH RESULT SETS
(
    (
        [WWI City ID] int,
        City nvarchar(50),
        [State Province] nvarchar(50),
        Country nvarchar(50),
        Continent nvarchar(30),
        [Sales Territory] nvarchar(50),
        Region nvarchar(30),
        Subregion nvarchar(30),
        --[Location] geography,
        [Latest Recorded Population] bigint,
        [Valid From] datetime2(7),
        [Valid To] datetime2(7)
    )
);
'

WHEN 'Customer' THEN 
'EXEC Integration.GetCustomerUpdates ''' + @LastCutoff  + ''', ''' +@NewCutoff   + '''
WITH RESULT SETS
(
    (
        [WWI Customer ID] int,
        Customer nvarchar(100),
        [Bill To Customer] nvarchar(100),
        Category nvarchar(50),
        [Buying Group] nvarchar(50),
        [Primary Contact] nvarchar(50),
        [Postal Code] nvarchar(10),
        [Valid From] datetime2(7),
        [Valid To] datetime2(7)
    )
);
'

WHEN 'Employee' THEN 
'EXEC Integration.GetEmployeeUpdates ''' + @LastCutoff  + ''', ''' +@NewCutoff   + '''
WITH RESULT SETS
(
    (
		[WWI Employee ID] int, 
        Employee nvarchar(50), 
        [Preferred Name] nvarchar(50), 
        [Is Salesperson] bit, 
        Photo varbinary(max), 
        [Valid From] datetime2(7), 
        [Valid To] datetime2(7)
    )
);
'

WHEN 'Payment Method' THEN 
'EXEC Integration.[GetPaymentMethodUpdates]''' + @LastCutoff  + ''', ''' +@NewCutoff   + '''
WITH RESULT SETS
(
    (
		        [WWI Payment Method ID] int,
        [Payment Method] nvarchar(50),
        [Valid From] datetime2(7),
        [Valid To] datetime2(7)
    )
);
'

WHEN 'Stock Item' THEN 
'EXEC Integration.[GetStockItemUpdates]''' + @LastCutoff  + ''', ''' +@NewCutoff   + '''
WITH RESULT SETS
(
    (
 [WWI Stock Item ID] int, 
        [Stock Item] nvarchar(100), 
        Color nvarchar(20), 
        [Selling Package] nvarchar(50), 
        [Buying Package] nvarchar(50), 
        Brand nvarchar(50), 
        Size nvarchar(20), 
        [Lead Time Days] int, 
        [Quantity Per Outer] int, 
        [Is Chiller Stock] bit, 
        Barcode nvarchar(50), 
        [Tax Rate] decimal(18,3), 
        [Unit Price] decimal(18,2), 
        [Recommended Retail Price] decimal(18,2), 
        [Typical Weight Per Unit] decimal(18,3), 
        Photo varbinary(max), 
        [Valid From] datetime2(7), 
        [Valid To] datetime2(7)
    )
);
'

WHEN 'Supplier' THEN 
'EXEC Integration.[GetSupplierUpdates]''' + @LastCutoff  + ''', ''' +@NewCutoff   + '''
WITH RESULT SETS
(
    (
  [WWI Supplier ID] int,
        Supplier nvarchar(100),
        Category nvarchar(50),
        [Primary Contact] nvarchar(50),
        [Supplier Reference] nvarchar(20),
        [Payment Days] int,
        [Postal Code] nvarchar(10),
        [Valid From] datetime2(7),
        [Valid To] datetime2(7)
    )
);
'

WHEN 'Transaction Type' THEN 
'EXEC Integration.[GetTransactionTypeUpdates]''' + @LastCutoff  + ''', ''' +@NewCutoff   + '''
WITH RESULT SETS
(
    (
        [WWI Transaction Type ID] int,
        [Transaction Type] nvarchar(50),
        [Valid From] datetime2(7),
        [Valid To] datetime2(7)
    )
);
'

WHEN 'Movement' THEN 
'EXEC Integration.[GetMovementUpdates]''' + @LastCutoff  + ''', ''' +@NewCutoff   + '''
WITH RESULT SETS
(
    (
        [Date Key] date,
        [WWI Stock Item Transaction ID] int,
        [WWI Invoice ID] int,
        [WWI Purchase Order ID] int,
        [Quantity] int,
        [WWI Stock Item ID] int,
        [WWI Customer ID] int,
        [WWI Supplier ID] int,
        [WWI Transaction Type ID] int,
        [Last Modified When] datetime2(7)
    )
);
'


WHEN 'Order' THEN 
'EXEC Integration.[GetOrderUpdates]''' + @LastCutoff  + ''', ''' +@NewCutoff   + '''
WITH RESULT SETS
(
    (
      [Order Date Key] date,
        [Picked Date Key] date,
        [WWI Order ID] int,
        [WWI Backorder ID] int,
        [Description] nvarchar(100),
        [Package] nvarchar(50),
        Quantity int,
        [Unit Price] decimal(18,2),
        [Tax Rate] decimal(18,3),
        [Total Excluding Tax] decimal(18,2),
        [Tax Amount] decimal(18,2),
        [Total Including Tax] decimal(18,2),
        [WWI City ID] int,
        [WWI Customer ID] int,
        [WWI Stock Item ID] int,
        [WWI Salesperson ID] int,
        [WWI Picker ID] int,
        [Last Modified When] datetime2(7)
    )
);
'

WHEN 'Purchase' THEN 
'EXEC Integration.[GetPurchaseUpdates]''' + @LastCutoff  + ''', ''' +@NewCutoff   + '''
WITH RESULT SETS
(
    (
        [Date Key] date,
        [WWI Purchase Order ID] int,
        [Ordered Outers] int,
        [Ordered Quantity] int,
        [Received Outers] int,
        [Package] nvarchar(50),
        [Is Order Line Finalized] bit,
        [WWI Supplier ID] int,
        [WWI Stock Item ID] int,
        [Last Modified When] datetime2(7)
    )
);
'

WHEN 'Sale' THEN 
'EXEC Integration.[GetSaleUpdates]''' + @LastCutoff  + ''', ''' +@NewCutoff   + '''
WITH RESULT SETS
(
    (
        [Invoice Date Key] date,
        [Delivery Date Key] date,
        [WWI Invoice ID] int,
        [Description] nvarchar(100),
        [Package] nvarchar(50),
        [Quantity] int,
        [Unit Price] decimal(18,2),
        [Tax Rate] decimal(18,3),
        [Total Excluding Tax] decimal(18,2),
        [Tax Amount] decimal(18,2),
        [Profit] decimal(18,2),
        [Total Including Tax] decimal(18,2),
        [Total Dry Items] int,
        [Total Chiller Items] int,
        [WWI City ID] int,
        [WWI Customer ID] int,
        [WWI Bill To Customer ID] int,
        [WWI Stock Item ID] int,
        [WWI Salesperson ID] int,
        [Last Modified When] datetime2(7)
    )
);
'

WHEN 'Stock Holding' THEN 
'EXEC Integration.[GetStockHoldingUpdates]
WITH RESULT SETS
(
    (
        [Quantity On Hand] int,
        [Bin Location] nvarchar(20),
        [Last Stocktake Quantity] int,
        [Last Cost Price] int,
        [Reorder Level] int,
        [Target Stock Level] int,
        [WWI Stock Item ID] int
    )
);
'

WHEN 'Transaction' THEN 
'EXEC Integration.[GetTransactionUpdates]''' + @LastCutoff  + ''', ''' +@NewCutoff   + '''
WITH RESULT SETS
(
    (
                [Date Key] date,
        [WWI Customer Transaction ID] int,
        [WWI Supplier Transaction ID] int,
        [WWI Invoice ID] int,
        [WWI Purchase Order ID] int,
        [Supplier Invoice Number] nvarchar(20),
        [Total Excluding Tax] decimal(18,2),
        [Tax Amount] decimal(18,2),
        [Total Including Tax] decimal(18,2),
        [Outstanding Balance] decimal(18,2),
        [Is Finalized] bit,
        [WWI Customer ID] int,
        [WWI Bill To Customer ID] int,
        [WWI Supplier ID] int,
        [WWI Transaction Type ID] int,
        [WWI Payment Method ID] int,
        [Last Modified When] datetime2(7)
    )
);
'

END

print @sql
execute sp_executesql @sql

--select @LastCutoff as LastCutoff, @NewCutoff as NewCutoff
    RETURN 0;
END;


