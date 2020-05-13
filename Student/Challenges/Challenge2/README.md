# 	Challenge 2 - Data Lake integration

[< Previous Challenge](/Student/Challenges/Challenge1/readme.md)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Next Challenge>](/Student/Challenges/Challenge3/README.md)

## Introduction
WWI importers realize they need to further modernize their data warehouse and wants to proceed to the second stage.  They are starting to reach capacity constraints on their data warehouse and need to offload data files from the relational database.  Likewise, they are receiving more data in json and csv file formats.  They've been discussing re-engineering their data warehouse to accomodate larger data sets, semi-structured data and real-time ingestion of data.  They want to implement this in an agile process and plan to integrate a Data Lake into their data warehouse.  For this challenge, WWI wants us to build out the data lake and show how to load data into the lake from an on-premise data source.  

## Description
The objective of this challenge is to build a Data Lake with Azure Data Lake Store (ADLS) Gen 2.  The Data Lake will be a staging area where all our source system data files reside. We need to ensure this Data Lake is well organized and doesn't turn into a swamp. This challenge will help us organize the folder sturcture and setup security to prevent unauthorized access.  Lastly, we will extract data from the WWI OLTP platform and store it in the Data Lake.  The OLTP platform is on-premise so you will need to build a hybrid archtiecture to integrate it into Azure.

Note: This challenge is intended to build upon challenge 1, and you should try to reuse content wherever possible.

## Success Criteria
1. Deploy a new storage account resource.
2. Define directory structure to support data lake use cases including:
    - 2 parent directories created: 
        - '\In' (or Staging Data) - This will the sink location used as the landing zone for data being copied into your data lake.
        - '\Out' (or processed data) - This will be the location published to downstream systems that might consume the data once it has been processed.
    - Within each of these folders, you should consider creating a separate folder for each of the tables being loaded into your DW.
3. Configure folder level security in your new data lake storage 
    - only your ETL job should be able to write to your \IN directory
    - you should be able to grant individual access to users who may want to access your \Out directory based on AAD credentials
4. Deploy Azure Data Factory 
5. Create a pipeline to copy data into ADLS
    - Your pipeline should contain at least one copy activity that copies data from a source table in the WideWorldImporters OLTP database into a file in your new data lake
        - Your data source should leverage the [Integration].[Get[[TableName]]Updates] stored procedures that already exist in the source
        - You should parameterize the source and sink properties in your pipeline where possible so that you can re-use the same pipeline for all additional tables being copied

## Stage 2 Architecture
![The Solution diagram is described in the text following this diagram.](/images/Challenge2.png)

## Learning Resources
1. [Begin by creating a new Azure Storage account](https://docs.microsoft.com/en-us/azure/storage/common/storage-account-create?toc=%2Fazure%2Fstorage%2Fblobs%2Ftoc.json&tabs=azure-portal).
1. [Data Lake Storage Best Practices](https://docs.microsoft.com/en-us/azure/storage/blobs/data-lake-storage-best-practices)
1. [Data Lake Planning](https://www.sqlchick.com/entries/2016/7/31/data-lake-use-cases-and-planning)
1. [Naming Conventions](https://www.sqlchick.com/entries/2019/1/20/faqs-about-organizing-a-data-lake)
1. [Azure Data Factory Copy Activity](https://docs.microsoft.com/en-us/azure/data-factory/copy-activity-overview)
1. [Copy data from local on-premis SQL Server into cloud storage](https://docs.microsoft.com/en-us/azure/data-factory/tutorial-hybrid-copy-portal)
1. [Azure Data Factory Incremental Load Pattern](https://docs.microsoft.com/en-us/azure/data-factory/tutorial-incremental-copy-overview)

## Tips
1. Things to consider when creating new data lake folder structure:
    - What types of data will you need to be able to support?
    - What types of processes will you need to be able to support?
    - How will you secure access to directories?
2. In addition to using the azure portal directly, you can view and manage your new storage account using the [Azure Storage Explorer](https://azure.microsoft.com/en-us/features/storage-explorer/) 
3. In order to avoid re-loading the tables in their entirety every time our job runs, we are following an "incremental load" pattern.  Think about how you may be able to find and use start and end date parameters for each table

## Additional Challenges
1. [Deploy Azure Databricks workspace, mount your new storage and enable interactive queries and analytics!](https://docs.microsoft.com/en-us/azure/azure-databricks/databricks-extract-load-sql-data-warehouse?toc=/azure/databricks/toc.json&bc=/azure/databricks/breadcrumb/toc.json)


