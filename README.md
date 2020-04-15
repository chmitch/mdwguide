# mdwguide
Modern Data Warehouse What the Hack

## Challenges
Here is the set of challenges we plan to cover when building out our Modern Data Warehouse.  There will be six challenges that are the typical workloads in a MDW architecture.  The challenge will focus on migration activity from an existing SQL data platform to Azure Synapse Analytics.
 
	
	1. Data Warehouse Migration – Migrate EDW from SQL Server to Azure Synapse Analytics.  Lift & Shift ETL code to SSIS Runtime

	2. Data Lake integration - Build out Staging tier in Azure Data Lake.  Architect Lake for staging, cleansed and presentation tiers with POSIX setup

	3. Data pipeline Migration – Rewrite SSIS jobs from ETL data flow  to ADF as a ELT data flow.

	4. Realtime Data pipelines – Real-time data with Kafka and Databricks
	
	5. Analytics migration  – Migrate reporting into Azure

	6. Mission Critical app -- Build out reference architecture for security, BCDR, & DevOps
 
## Objective
These challenges will help educate the community on Level 100/300 items related to MDW.  The goal will be to build out an overall reference architecture, hands-on labs, load patterns and data flow diagram to help developers get started.

## DataSet 
For us to get started, we’ve identified the Worldwide Importers as our OLTP and DW data sets.  For each use case, we will integrate this data into the WWI data set.  Here are the other data sets for each track.


	1. Structured WWI -- https://docs.microsoft.com/en-us/sql/samples/wide-world-importers-what-is?view=sql-server-2017
	
	2. Data Lake Integration -- Exported BCP files from lab one will be staged in Data Lake
	
	3. Data Pipeline Migration --  DailyETL.ispac files from WWI sample database
	
	4. Realtime Data pipeline -- Data generator to replicate web logs for sales data (TBD)
	
	5. Analytics Migration -- Reuse reports data in WWI Sample database

	6. Mission critical app -- Whiteboard session to build out reference architecture
			
Our goal is to have an end-to-end story that covers all Azure Data Services and explains common patterns so they can learn how to build it themselves.