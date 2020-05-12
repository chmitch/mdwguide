# 	Challenge 2: Data Lake integration

## Introduction

Now that WWI has migrated their DW into Azure Synapse Analytics, they are ready to proceed to second stage of their modernization which is Data Lake Integration.  This will include the creation and configuration of Azure Data Lake Storage (ADLS).  Once created, they will use this data lake for data migration activities, storage, and analytics. The objective of this challenge is to build out a new data lake, and create pipelines to transfer data from their on prem OLTP system into it.

Note: This challenge is intended to build upon challenge 1, and you should try to reuse content wherever possible.

## Success Criteria

1. Deploy a new storage account resource.
2. Define directory structure to support data lake use cases including:
    - There should be at least 2 parent directories created: 
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

## Hints

1. Things to consider when creating new data lake folder structure:
    - What types of data will you need to be able to support?
    - What types of processes will you need to be able to support?
    - How will you secure access to directories?
2. In addition to using the azure portal directly, you can view and manage your new storage account using the [Azure Storage Explorer](https://azure.microsoft.com/en-us/features/storage-explorer/) 
3. In order to avoid re-loading the tables in their entirety every time our job runs, we are following an "incremental load" pattern.  Think about how you may be able to find and use start and end date parameters for each table


## Learning Resources

1. [Begin by creating a new Azure Storage account](https://docs.microsoft.com/en-us/azure/storage/common/storage-account-create?toc=%2Fazure%2Fstorage%2Fblobs%2Ftoc.json&tabs=azure-portal).

2. [Data Lake Storage Best Practices](https://docs.microsoft.com/en-us/azure/storage/blobs/data-lake-storage-best-practices)

3. [Azure Data Factory Copy Activity](https://docs.microsoft.com/en-us/azure/data-factory/copy-activity-overview)

4. [Copy data from local on-premis SQL Server into cloud storage](https://docs.microsoft.com/en-us/azure/data-factory/tutorial-hybrid-copy-portal)

5. [Azure Data Factory Incremental Load Pattern](https://docs.microsoft.com/en-us/azure/data-factory/tutorial-incremental-copy-overview)

## Additional Challenges

1. [Deploy Azure Databricks workspace, mount your new storage and enable interactive queries and analytics!](https://docs.microsoft.com/en-us/azure/azure-databricks/databricks-extract-load-sql-data-warehouse?toc=/azure/databricks/toc.json&bc=/azure/databricks/breadcrumb/toc.json)


