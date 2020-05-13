# Lab 1 -- Data Warehouse migration from On-premise to Azure Synapse Analytics

[Next Challenge>](/Host/Guide/Challenge2/Readme.md)

## Story

WWI wants to modernize their data warehouse in phases.  The first stage will be to scale-out horizontally their existing data warehouse (SQL Server OLAP) to Azure Synapse Analytics.
They like to reuse their existing ETL code and leave their source systems as-is (no migration).  This will require a Hybrid architecture for on-premise OLTP and Azrue Synapse.  This exercise will
be showcasing how to migrate your traditional SQL Server (SMP) to Azure Synapse Analytics (MPP).

## Environment Setup

WWI runs their existing database platforms on-premise with SQL Server 2017.  There are two databases samples for WWI.  The first one is for their Line of Business application (OLTP) and the second
is for their data warehouse (OLAP).  You will need to setup both environments as our starting point in the migration.

1. If you do not have a on-premise SQL Server 2017, you can provision a Azure Virtual Machine running SQL Server 2017 using this [Step by step guidance](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/sql/virtual-machines-windows-portal-sql-server-provision#1-configure-basic-settings)
2. Download both WWI databases (Enterprise Edition) to your on-premise SQL server or Azure VM you have just provisioned. [Download Link](https://github.com/Microsoft/sql-server-samples/releases/tag/wide-world-importers-v1.0). 
>The file names are WideWorldImporters-Full.bak and WideWorldImportersDW-Full.bak.  
>These two files are the OLTP and OLAP databases respectively.
3. Follow this [Install and Configuration Instrution for the OLTP database](https://docs.microsoft.com/en-us/sql/samples/wide-world-importers-oltp-install-configure?view=sql-server-ver15)
4. Follow this [Install and Configuration Instrution for the OLAP database](https://docs.microsoft.com/en-us/sql/samples/wide-world-importers-dw-install-configure?view=sql-server-ver15)
5. Review the database catalog on the data warehouse for familiarity of the schema [Reference document](https://docs.microsoft.com/en-us/sql/samples/wide-world-importers-dw-database-catalog?view=sql-server-ver15)
6. Review ETL workflow to understand the data flow and architecture [Reference document](https://docs.microsoft.com/en-us/sql/samples/wide-world-importers-perform-etl?view=sql-server-ver15)
7. Create an Azure Synapse Analytics Data Warehouse with the lowest DWU [Step by step guidance](https://docs.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/create-data-warehouse-portal)

## Tools

1. [SQL Server Management Studion (Version 18.x or higher)](https://docs.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-ver15)
2. [Visual Studio 2017 with Integration Services](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/sql/virtual-machines-windows-portal-sql-server-provision#1-configure-basic-settings) 
3. [Power BI Desktop](https://www.microsoft.com/en-us/download/details.aspx?id=58494)
4. DataWarehouseMigrationUtility.zip (Located in the current directory. This is a Learning tool and not recommended or supported for actual migrations)


## Migration Overview

The objective of this lab is to migrate the WWI DW (OLAP) to Azure Synapse Analytics.  Azure Synapse Analytics is a MPP (Massive Parallel Processing) platform that allows you to scale out your 
datawarehouse by adding new server nodes (compute) rather than adding more cores to the server.  

Reference:
1. [Architecture Document of the MPP platform](https://docs.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/massively-parallel-processing-mpp-architecture)
2. [SQL Server Database to Azure Synapse Analytics - Data Migration Guide](https://datamigration.microsoft.com/scenario/sql-to-sqldw?step=1)

There will be four different object types we'll migrate:

* Database Schema
* Database code (Store Procedure, Function, Triggers, etc)
* Data migration
* SSIS code set refactor

Guidelines will be provided below but you will have to determine how best to migrate.  At the end of the migration compare your 
end state to the one we've published into the "Host/Solutions/Challenge1" folder.  The detailed migration guide below is here for things to consider during your migration. Please follow this [outline](https://techcommunity.microsoft.com/t5/datacat/migrating-data-to-azure-sql-data-warehouse-in-practice/ba-p/305355) and cross-reference it
for a comprehensive list of items to consider during a migraiton. 

### Database Schema migration steps

Database schemas need to be migrated from SQL Server to Azure Synapse.  Due to the MPP architecture, this will be more than just a data type translation exericse.  You will need to focus
on how best to distribute the data across each table follow this [document](https://docs.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-tables-overview).  A list of unsupported data types can be found in this [article](https://docs.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-tables-data-types) and how to find the best alternative. 

As a learning tool, the Data Warehouse migration utility can be a guided approach to migrating your schemas.  I suggest you run the tool to determine incompatibilities but actually generate the scripts by hand.  Here is [a set of instructions](https://www.sqlservercentral.com/articles/azure-dwh-part-11-data-warehouse-migration-utility) to follow to use the utility.  

There are four files in this root directory that have a prefix "WideWorldImportersDW".  These are output files from the migration utility that can provide guidance on what needs to be refactored.

1. Go to Source database on the SQL Server VM and right click the WWI DW database and select "Generate Scripts".  This will export all DDL statements for the database tables and schema.
2. Create a user defined schema for each tier of the data warehouse; Integration, Dimension, Fact.
3. Items that require refactoring (You can refer to this [document](https://docs.microsoft.com/en-us/sql/t-sql/statements/create-table-azure-sql-data-warehouse?view=aps-pdw-2016-au7) for more information)
    * Data types
    * Column length
    * Replace Identity for Sequences
    * Identify which tables are hash, replicated and round-robin. Read this [document](https://docs.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-tables-distribute)
    * Determine your distribution column (HINT IDENTITY Column can not be your distribution key)
    * Some Fact Table primary key are a composite key from source system
4. Execute these scripts on the Azure Synapse Analytics database
5. Run this query to identify which columns are not supported by Azure Synapse Analytics
```
SELECT  t.[name], c.[name], c.[system_type_id], c.[user_type_id], y.[is_user_defined], y.[name]
	FROM sys.tables  t
	JOIN sys.columns c on t.[object_id]    = c.[object_id]
	JOIN sys.types   y on c.[user_type_id] = y.[user_type_id]
	WHERE y.[name] IN ('geography','geometry','hierarchyid','image','text','ntext','sql_variant','timestamp','xml')
	AND  y.[is_user_defined] = 1;
```
6. Review IDENTITY article to ensure surrogate keys are in the right sequence [Reference document](https://docs.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-tables-identity)
    

### Database code rewrite

Review the SSIS jobs that are at this [Github repo](https://github.com/Microsoft/sql-server-samples/releases/tag/wide-world-importers-v1.0) (Daily.ETL.ispac)  This job leverages
stored procedures in the Source and Target databases extensively.  This will require a refactoring of the Stored procedures for the OLAP database when you repoint the ETL
target to Azure Synapse.  There are a number of design considerations you wil need to consider when refactoring this code.  Please read this [document](https://docs.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-overview-develop
) for more detail. 
There are three patterns you can reuse across all scripts in the same family (Dimension & Fact).  

1. Rewrite Dimension T-SQL 
    1. UPDATE Statement can not leverage joins or subqueries.  Refactor code to resolve these issues.  
    2. Exec as and Return can be removed for this lab
    3. Fix Common table Expression (WITH) [Reference document](https://docs.microsoft.com/en-us/sql/t-sql/queries/with-common-table-expression-transact-sql?view=sql-server-ver15#features-and-limitations-of-common-table-expressions-in--and-)
2. Rewrite Fact T-SQL
    1. Movement T-SQL is a special fact table that leverages a MERGE Statement.  Merge is not supported today in Azure Synapse.  You will need to split it out into an Update and Insert statement.  [Merge Workaround](https://docs.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-develop-ctas#replace-merge-statements)
    2. UPDATE statement will require explicit table name and not alias
    3. [DELETE statement will require OPTION Label](https://docs.microsoft.com/en-us/sql/t-sql/statements/delete-transact-sql?view=sql-server-ver15#n-using-a-label-and-a-query-hint-with-the-delete-statement)
3. Rewrite Load control tables
    1. PopulateDateDimensionForYear -- User Defined Functions are not supported in Azure Synapse
    2. GetLastETLCutoffTime -- @@RowCount not supported
4. Rewrite Function for Date Dimension Table

### Data Migration

There are numerous strategies and tools to migrate your data from on-premise to Azure. [Reference document](https://docs.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/design-elt-data-loading) 

Due to the small size of this sample database, we will take the simplist strategy for this lab; [Bulk Copy Program](https://docs.microsoft.com/en-us/sql/tools/bcp-utility?toc=/azure/synapse-analytics/sql-data-warehouse/toc.json&bc=/azure/synapse-analytics/sql-data-warehouse/breadcrumb/toc.json&view=azure-sqldw-latest) (BCP).  You will run BCP commands from the 
SQL Server Virtual Machine that hosts the OLAP database.  BCP export will extract the data to a txt file on your local machine.  BCP import will be run from the same Virtual
machine where the text files reside.  The user name and password will need to be updated to your Azure Synapse instance.

1. Run the SQL script in this directory, "Host/Solutions/Challenge1/WideWorldImportersDW - Prereq for Export.txt" to generate a view in the OLAP database before you run BCP commands.
2. Create BCP Scripts for each dimension, staging and fact table.  Those DDL scripts where you modified the columns will require you to define the columns to extract
3. Execute BCP scripts as a batch file.  Place file in the same diretory as the flat files and open a command prompt and go to this directoy.  Run the batch file
4. Create BCP Scripts to import the data in Azure Synapse Analytics.  Due to low data volume there is no need to first migrate them to Azure
5. Review Data Skew of Distributed Tables to see if your distribution keys are accurate [Reference document](https://github.com/rgl/azure-content/blob/master/articles/sql-data-warehouse/sql-data-warehouse-manage-distributed-data-skew.md)

### SSIS Job 

Data movement in first lab will be execution of Daily.ETL.ispac job in Azure Data Factory SSIS Runtime.  This lab will reuse data pipelines to minimize migration costs.
As data volumes increase, these jobs will need to leverage a MPP platform like Databricks, Synapse, HDInsight to transform the data at scale.  This will be done in a future lab.
Setup your SSIS job following these instructions. [Reference document](https://docs.microsoft.com/en-us/sql/integration-services/lift-shift/ssis-azure-deploy-run-monitor-tutorial?view=sql-server-ver15)

1. Open SSIS package and change Source and Destination database connections. Change the login from Windows Auth to SQL Auth
2. Update each mapping that required DDL changes.
3. Unit test the jobs in SSDT before deploying them to SSIS Runtime to ensure no errors

## LOAD DATA

Congratulations!!! The migration is complete.  Run your SSIS jobs to load data from OLTP to OLAP data warehouse.  You might want to create a load control table to setup incremental loads.  This will validate you've completed all steps successfully.  Compare the results of the WWI OLAP database vs. the one you've migrated into Azure Synapse Analytics.

# SOLUTIONS
[Go to Solution](/Host/Solutions/Challenge1)