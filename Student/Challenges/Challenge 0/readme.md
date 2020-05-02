# Challenge 0 - Setup

## Pre-requisites
1. Laptop computer as Development environment
2. Azure Subscription
3. Azure SQL Server 2017 Virtual Machine
4. Azure Synapse Analytics
5. Azure Data Factory SSIS Integration Runtime


### Setup your Development Environment on your Laptop
1. [SQL Server Management Studion (Version 18.x or higher)](https://docs.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-ver15)
2. [Visual Studio 2017 with Integration Services](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/sql/virtual-machines-windows-portal-sql-server-provision#1-configure-basic-settings) 
3. [Power BI Desktop](https://www.microsoft.com/en-us/download/details.aspx?id=58494)


### Setup Azure Tenant with Services for What the Hack

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