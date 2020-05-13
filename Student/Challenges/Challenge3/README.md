# 	Challenge 3 -- Redesign SSIS jobs into ELT with ADF

[< Previous Challenge](/Student/Challenges/Challenge2/README.md)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Next Challenge>](/Student/Challenges/Challenge4/README.md)

## Introduction
WWI importers keep missing their SLAs in terms of the nightly loads.  The loads take six hours to complete and starts each evening at 1:00AM.  They must complete by 8:00AM but frequenly these jobs are taking longer than usual.  A few critical stakeholders are asking them to provide data more frequently on an hourly basis.  Since these business units are their key stakeholders, they have the funding to help replatform their data pipelines.  WWI importers realizes they need to build a staging tier in their Data Lake and load this into their Data Warehouse for Stage 3.  These data pipelines must be ELT (Extract, Load & Transform) so they can quickly write the data to the cloud and scale out the compute to transform the data.

## Description
The objetive of this lab is to modernize the ETL pipeline that was originally built in SSIS.  We need to rebuild this pipeline in Azure leveraging scale-out architecture to transform this data.  The data flow will be to extract the data from the OLTP platform, store it in the Azure Data Lake and bulk ingest it into Azure Synapase Analytics.  This will be run on a nightly basis so leverage Azure Data Factory as a job orchestration and scheduling tool.

Note: This challenge is intended to build upon the previous 2 challenges, and you should try to reuse content wherever possible

## Success Criteria
1. Add a new activity to your Azure Data Factory to load data from the new Azure Data Lake into the _Staging tables in the Data Warehouse in Azure Synapse via Polybase
2. Add another new activity to move the files to the \Out directory in your data lake once they have been loaded into your DW table
3. Create another activity to merge the new data into the target Fact and Dimension tables in your DW from your _Staging tables
4. Test your new Azure Data Factory Pipeline by validating that data added to the source system will flow through to final target tables

## Stage 3 Architecture
![The Solution diagram is described in the text following this diagram.](/images/Challenge3.png)

## Leanring Resources
1. [Load data into DW via Polybase](https://docs.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/load-data-from-azure-blob-storage-using-polybase)
2. [Incrementally load multiple tables in Azure Data Factory](https://docs.microsoft.com/en-us/azure/data-factory/tutorial-incremental-copy-multiple-tables-portal)
3. [Azure Data Factory Copy Activity](https://docs.microsoft.com/en-us/azure/data-factory/copy-activity-overview)

## Tips
1. There are multiple ways to load data via Polybase.  You could potentially use:
    - ["CTAS" with "External Tables"](https://docs.microsoft.com/en-us/sql/t-sql/statements/create-table-as-select-azure-sql-data-warehouse?toc=/azure/synapse-analytics/sql-data-warehouse/toc.json&bc=/azure/synapse-analytics/sql-data-warehouse/breadcrumb/toc.json&view=azure-sqldw-latest)
    - ["Copy Command"](https://docs.microsoft.com/en-us/sql/t-sql/statements/copy-into-transact-sql?view=azure-sqldw-latest) in Azure Synapse Analytics or 
    - [Copy Data task in Azure Data Factory](https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-sql-data-warehouse)
2. For MERGE process, you should reuse or replicate logic found in the Integration.MigratedStaged____Data stored procedures
3. Optimize where possible by using dynamic code, and executing tasks in parallel.

## Additionally Challenges
1. Refactor the T-SQL code in Polybase to leverage Python or Scala
2. Build out these data pipelines using Azure Mapping Data Flows

