# 	Challenge 3: Redesign SSIS jobs into ELT with ADF

## Overview

The goal of this lab is to modernize the ETL pipeline that was originally built in SSIS that designed to update the fact and dimension tables in the WideWorldImportersDW database using cloud native technologies in Azure.

Note: This challenge is intended to build upon the previous 2 challenges, and you should try to reuse content wherever possible

## Key Objectives

1. Add a new activity to your Azure Data Factory to load data from the new Azure Data Lake into the _Staging tables in the Data Warehouse in Azure Synapse via Polybase
2. Add another new activity to move the files to the \Out directory in your data lake once they have been loaded into your DW table
3. Create another activity to merge the new data into the target Fact and Dimension tables in your DW from your _Staging tables
4. Test your new Azure Data Factory Pipeline by validating that data added to the source system will flow through to final target tables


## Hints

1. There are multiple ways to load data via Polybase.  You could potentially use:
    - ["CTAS" with "External Tables"](https://docs.microsoft.com/en-us/sql/t-sql/statements/create-table-as-select-azure-sql-data-warehouse?toc=/azure/synapse-analytics/sql-data-warehouse/toc.json&bc=/azure/synapse-analytics/sql-data-warehouse/breadcrumb/toc.json&view=azure-sqldw-latest)
    - ["Copy Command"](https://docs.microsoft.com/en-us/sql/t-sql/statements/copy-into-transact-sql?view=azure-sqldw-latest) in Azure Synapse Analytics or 
    - [Copy Data task in Azure Data Factory](https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-sql-data-warehouse)
2. For MERGE process, you should reuse or replicate logic found in the Integration.MigratedStaged____Data stored procedures
3. Optimize where possible by using dynamic code, and executing tasks in parallel.


## Suggested Guides

1. [Load data into DW via Polybase](https://docs.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/load-data-from-azure-blob-storage-using-polybase)

2. [Incrementally load multiple tables in Azure Data FActory](https://docs.microsoft.com/en-us/azure/data-factory/tutorial-incremental-copy-multiple-tables-portal)

3. [Azure Data Factory Copy Activity](https://docs.microsoft.com/en-us/azure/data-factory/copy-activity-overview)


