# Challenge 1 - \Data Warehouse migration from On-premise to Azure Synapse Analytics

[< Previous Challenge](/Student/Challenges/Challenge0/readme.md)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Next Challenge>](/Student/Challenges/Challenge2/README.md)

## Introduction

WWI wants to modernize their data warehouse in phases.  The first stage will be to scale-out horizontally their existing data warehouse (SQL Server OLAP) to Azure Synapse Analytics.
They like to reuse their existing ETL code and leave their source systems as-is (no migration).  This will require a Hybrid architecture for on-premise OLTP and Azrue Synapse.  This exercise will
be showcasing how to migrate your traditional SQL Server (SMP) to Azure Synapse Analytics (MPP).


## Description

The objective of this lab is to migrate the WWI DW (OLAP) to Azure Synapse Analytics.  Azure Synapse Analytics is a MPP (Massive Parallel Processing) platform that allows you to scale out your 
datawarehouse by adding new server nodes (compute) rather than adding more cores to the server.  

There will be four different object types we'll migrate:

* Database Schemas and Tables
* Database code (Stored Procedure, Function, Triggers, etc)
* Data migration
* SSIS code set refactor

## Success Criteria
1. Migrated all schemas to Synapse
2. Created one table per schema in Synapse
    - Coach will provide remaining DDL scripts
3. Refactor one Stored Procedure per design pattern
    - Dimension Tables
    - Fact Table (Insert Only)
    - Fact Table (Merge)
    - Control tables
    - Coach will share remaining T-SQL Scripts
4. End-to-End Data migration
    - Run unit test script to confirm counts
5. Run SSIS jobs based on new mappings
    - Coach will share DailyETL package
    - Run end-to-end load in Synapse
    - Compare run counts against OLAP database

## Final State Architecture
![The Solution diagram is described in the text following this diagram.](/images/Challenge1.png)

## Learning Resources

### Overall Migration
1. [Architecture Document of the MPP platform](https://docs.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/massively-parallel-processing-mpp-architecture)
1. [SQL Server Database to Azure Synapse Analytics - Data Migration Guide](https://datamigration.microsoft.com/scenario/sql-to-sqldw?step=1)
1. [Data Migration steps](https://techcommunity.microsoft.com/t5/datacat/migrating-data-to-azure-sql-data-warehouse-in-practice/ba-p/305355) 

### Database Schema Migration
1. [Distributed Tables](https://docs.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-tables-distribute)
1. [Distribution Keys](https://docs.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-tables-overview) 
1. [Distributiion Key Best Practices](https://techcommunity.microsoft.com/t5/datacat/choosing-hash-distributed-table-vs-round-robin-distributed-table/ba-p/305247)
1. [Data Types](https://docs.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-tables-data-types)  A list of unsupported data types at this link.
1. [Table Constraints](https://docs.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-table-constraints)
1. [Unsupported Table Features](https://docs.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-tables-overview#unsupported-table-features)
1. [Create Table Syntax](https://docs.microsoft.com/en-us/sql/t-sql/statements/create-table-azure-sql-data-warehouse?view%253Daps-pdw-2016-au7=&view=aps-pdw-2016-au7)
1. [Identity Column](https://docs.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-tables-identity)
1.  [Data Migration Utility](https://www.sqlservercentral.com/articles/azure-dwh-part-11-data-warehouse-migration-utility)
    - Talk with coach for need of tool and trade-offs.

### Database code rewrite (T-SQL)
1. [Design Considerations when refactoring your code](https://docs.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-overview-develop)
1. [Migrate T-SQL Code](https://github.com/uglide/azure-content/blob/master/articles/sql-data-warehouse/sql-data-warehouse-migrate-code.md)
1. [Common table Expression (WITH)](https://docs.microsoft.com/en-us/sql/t-sql/queries/with-common-table-expression-transact-sql?view=sql-server-ver15#features-and-limitations-of-common-table-expressions-in--and-)
1. [Check your T-SQL for incompatibilies #3](https://www.blue-granite.com/blog/5-important-steps-when-migrating-to-your-scaled-out-data-warehouse)
1. [SQL Differences in T-SQL](https://docs.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-troubleshoot#differences-from-sql-database)

### Data Migration
1. [Bulk Copy Program](https://docs.microsoft.com/en-us/sql/tools/bcp-utility?toc=/azure/synapse-analytics/sql-data-warehouse/toc.json&bc=/azure/synapse-analytics/sql-data-warehouse/breadcrumb/toc.json&view=azure-sqldw-latest) 
1. [BCP Instructions](https://github.com/uglide/azure-content/blob/master/articles/sql-data-warehouse/sql-data-warehouse-load-with-bcp.md)
1. [Data migration techniques](https://github.com/uglide/azure-content/blob/master/articles/sql-data-warehouse/sql-data-warehouse-migrate-data.md)
1. [Data Skew due to Distribution Key](https://github.com/rgl/azure-content/blob/master/articles/sql-data-warehouse/sql-data-warehouse-manage-distributed-data-skew.md)

### SSIS Job
1.  [Github repo](https://github.com/Microsoft/sql-server-samples/releases/tag/wide-world-importers-v1.0) (Daily.ETL.ispac) 

## Tips
1. Determine your distribution column (HINT IDENTITY Column can not be your distribution key)
1. Some Fact Table primary key are a composite key from source system
1. Run this query to identify which columns are not supported by Azure Synapse Analytics
```
SELECT  t.[name], c.[name], c.[system_type_id], c.[user_type_id], y.[is_user_defined], y.[name]
	FROM sys.tables  t
	JOIN sys.columns c on t.[object_id]    = c.[object_id]
	JOIN sys.types   y on c.[user_type_id] = y.[user_type_id]
	WHERE y.[name] IN ('geography','geometry','hierarchyid','image','text','ntext','sql_variant','timestamp','xml')
	AND  y.[is_user_defined] = 1;
```
1. Review the SSIS jobs that are at this [Github repo](https://github.com/Microsoft/sql-server-samples/releases/tag/wide-world-importers-v1.0) (Daily.ETL.ispac)  This job leverages
stored procedures in the Source and Target databases extensively.  This will require a refactoring of the Stored procedures for the OLAP database when you repoint the ETL
target to Azure Synapse.


## Additional Challenges

*Too comfortable?  Eager to do more?  Try these additional challenges!*

1. Setup incremental loads in SSIS jobs
2. Deploy job into ADF SSIS Runtime and Catalog
3. [Generate new data and load into Synapase](https://docs.microsoft.com/en-us/sql/samples/wide-world-importers-generate-data?view=sql-server-ver15)