# Lab 1 -- Data Warehouse migration from On-premise to Azure Synapse Analytics

## Story

WWI wants to modernize their data warehouse in phases.  The first stage will be to scale-out horizontally their existing data warehouse (SQL Server OLAP) to Azure Synapse Analytics.
They like to reuse their existing ETL code and leave their source systems as-is (no migration).  This will require a Hybrid architecture for on-premise OLTP and Azrue Synapse.  This exercise will
be showcasing how to migrate your traditional SQL Server (SMP) to Azure Synapse Analytics (MPP).  Additionally, how to migrate your SSIS code set into Azure Data Factory.

## Environment Setup

WWI runs their existing database platforms on-premise with SQL Server 2017.  There are two databases samples for WWI.  The first one is for their Line of Business application (OLTP) and the second
is for their data warehouse (OLAP).  You will need to setup both environments as our starting point in the migration.

    1. Download both WWI databases (Enterprise Edition) from https://github.com/Microsoft/sql-server-samples/releases/tag/wide-world-importers-v1.0. The file names are WideWorldImporters-Full.bak
    and WideWorldImportersDW-Full.bak.  These two files are the OLTP and OLAP databases respectively.
    2. Install and Configuration instrutions for the OLTP database  https://docs.microsoft.com/en-us/sql/samples/wide-world-importers-oltp-install-configure?view=sql-server-ver15
        a. Restore database on a Azure Virtual Machine running SQL Server 2017 https://docs.microsoft.com/en-us/azure/virtual-machines/windows/sql/virtual-machines-windows-portal-sql-server-provision#1-configure-basic-settings
    3. Install and Configuration instrutions for the OLAP database https://docs.microsoft.com/en-us/sql/samples/wide-world-importers-dw-install-configure?view=sql-server-ver15
        a. Restore database on a Azure Virtual Machine running SQL Server 2017 https://docs.microsoft.com/en-us/azure/virtual-machines/windows/sql/virtual-machines-windows-portal-sql-server-provision#1-configure-basic-settings
    4. Review the database catalog on the data warehouse for familiarity of the schema.  https://docs.microsoft.com/en-us/sql/samples/wide-world-importers-dw-database-catalog?view=sql-server-ver15
    5. Review ETL workflow to understand the data flow and architecture https://docs.microsoft.com/en-us/sql/samples/wide-world-importers-perform-etl?view=sql-server-ver15
    6. Create an Azure Synapse Analytics Data Warehouse with the lowest DWU. https://docs.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/create-data-warehouse-portal

## Tools

    1. SQL Server Management Studion (Version 18.x or higher)
    2. Visual Studio 2017 with Integration Services https://docs.microsoft.com/en-us/azure/virtual-machines/windows/sql/virtual-machines-windows-portal-sql-server-provision#1-configure-basic-settings 
    3. Power BI Desktop
    4. DataWarehouseMigrationUtility.zip (Learning tool and not recommended for actual migrations)


## Migration Overview

The objective of this lab is to migrate the WWI DW (OLAP) to Azure Synapse Analytics.  Azure Synapse Analytics is a MPP (Massive Parallel Processing) platform that allows you to scale our your 
datawarehouse by adding new server nodes (compute) rather than adding more PROCS to the server.  The architecture of the platform is as follows; https://docs.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/massively-parallel-processing-mpp-architecture
Here is a data migration guide that oulines the steps required to migrate your SQL Server database to Azure Synapse.  https://datamigration.microsoft.com/scenario/sql-to-sqldw?step=1

There will be four different object types we'll migrate; 

    1. Database Schema
    2. Database code (SP, Function, Triggers, etc)
    3. Data
    4. SSIS code set refactor

This lab will have four migration sections for each object type.  Guidelines will be provided but you will have to determine how best to migrate.  At the end of the migration compare your 
end state to the one we've published into the "final" folder.  A detailed migration guide is here for things to consider during your migration.  Please follow this outline and cross-reference this
for a comprehensive list of items to consider during a migraiton.  https://techcommunity.microsoft.com/t5/datacat/migrating-data-to-azure-sql-data-warehouse-in-practice/ba-p/305355

## Database Schema migration steps

Database schemas need to be migrated from SQL Server to Azure Synapse.  Due to the MPP architecture, this will be more than just a data type translation exericse.  You will need to focus
on how best to distribute the data across each table.  https://docs.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-tables-overview.  A list of unsupported data types
can be found in this article and how to find the best alternative.  https://docs.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-tables-data-types

As a learning tool, the Data Warehouse migration utility can be a guided approach to migrating your schemas.  I suggest you run the tool to determine incompatibilities but actually generate the scripts
by hand.  Here is a set of instructions to follow to use the utility.  https://www.sqlservercentral.com/articles/azure-dwh-part-11-data-warehouse-migration-utility  
There are four files in this root directory that have a prefix "WideWorldImportersDW".  These are output files from the migration utility that can provide guidance on what needs to be refactored.

    1. Go to WWI DW database and right click on database and select "Generate Scripts".  This will export all DDL statements for the database tables and schema.
    2. Create a user defined schema for each tier of the data warehouse; Staging, Dimension, Fact.
    3. Items that require refactoring
        a. Data types
        b. Column length
        c. Replace Identity for Sequences
        d. Identify which tables are hash, replicated and round-robin
        e. Determine your distribution column (HINT IDENTITY Column can not be your distribution key)
        f. Some Fact Table primary key are a composite key from source system
    4. Execute these scripts on the Azure Synapse Analytics database
    5. Run this query to identify which columns are not supported by Azure SQL Data Warehouse
            SELECT  t.[name], c.[name], c.[system_type_id], c.[user_type_id], y.[is_user_defined], y.[name]
            FROM sys.tables  t
            JOIN sys.columns c on t.[object_id]    = c.[object_id]
            JOIN sys.types   y on c.[user_type_id] = y.[user_type_id]
            WHERE y.[name] IN ('geography','geometry','hierarchyid','image','text','ntext','sql_variant','timestamp','xml')
            AND  y.[is_user_defined] = 1;
    6. Review IDENTITY article to ensure surrogate keys are in the right sequence. https://docs.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-tables-identity
    

## Database code rewrite

Review the SSIS jobs that are at this link https://github.com/Microsoft/sql-server-samples/releases/tag/wide-world-importers-v1.0 (Daily.ETL.ispac)  This job leverages
stored procedures in the Source and Target databases extensively.  This will require a refactoring of the Stored procedures for the OLAP database when you repoint the ETL
target to Azure Synapse.  There are a number of design considerations you wil need to consider when refactoring this code.  Please read this link for more detail. https://docs.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-overview-develop

There are three patterns you can reuse across all scripts in the same family (Dimension & Fact).  

    1. Rewrite Dimension T-SQL 
        a. UPDATE Statement can not leverage joins or subqueries.  Refactor code to resolve these issues.  
        b. Exec as and Return can be removed for this lab
        c. Fix Common table Expression (WITH) https://docs.microsoft.com/en-us/sql/t-sql/queries/with-common-table-expression-transact-sql?view=sql-server-ver15#features-and-limitations-of-common-table-expressions-in--and-
    2. Rewrite Fact T-SQL -- Same applies for UPDATE Statement but DELETE statement will require modification due to join
        a. Movement T-SQL is a special fact table that leverages a MERGE Statement.  Merge is not supported today in Azure Synapse.  You will need to split it out into an Update and Insert statement
    3. Rewrite Load control tables
        a. PopulateDateDimensionForYear -- User Defined Functions are not supported in Azure Synapse
        b. GetLineageKey -- 
        c. GetLastETLCutoffTime -- @@RowCount not supported

## Data Migration

There are numerous strategies and tools to migrate your data from on-premise to Azure.  We will take the simplist strategy for this lab; Bulk Copy Program.  You will run BCP commands from the 
SQL Server Virtual Machine that hosts the OLAP database.  BCP export will extract the data to a txt file on your local machine.  BCP import will be run from the same Virtual
machine there the text files reside.  The user name and password will need to be updated to your Azure Synapse instance.

    1. Run this SQL script to generate a view in the OLAP database before you run BCP commands. WideWorldImportersDW - Prereq for Export.txt
    2. Create BCP Scripts for each dimension, staging and fact table.  Those DDL scripts where you modified the columns will require you to define the columns to extract
    3. Execute BCP scripts as a batch file.  Place file in the same diretory as the flat files and open a command prompt and go to this directoy.  Run the batch file
    4. Create BCP Scripts to import the data in Azure Synapse Analytics.  Due to low data volume there is no need to first migrate them to Azure
    5. Review Data Skew of Distributed Tables to see if your distribution keys are accurate.  https://github.com/rgl/azure-content/blob/master/articles/sql-data-warehouse/sql-data-warehouse-manage-distributed-data-skew.md

## SSIS Job 

Data movement in first lab will be execution of Daily.ETL.ispac job in Azure Data Factory SSIS Runtime.  This lab will reuse data pipelines to minimize migration costs.
As data volumes increase, these jobs will need to leverage a MPP platform like Databricks, Synapse, HDInsight to transform the data at scale.  This will be done in a future lab.
Setup your SSIS job following these instructions. https://docs.microsoft.com/en-us/sql/integration-services/lift-shift/ssis-azure-deploy-run-monitor-tutorial?view=sql-server-ver15

    1. Open SSIS package and change Source and Destination database connections. Change the login from Windows Auth to SQL Auth
    2. Update each mapping that required DDL changes.
    3. Unit test the jobs in SSDT before deploying them to SSIS Runtime to ensure no errors

## LOAD DATA

Congratulations!!! The migration is complete.  Run stored procedures in OLTP database to generate incremental data to load into the OLAP database.  This will validate you've 
completed all steps successfully.