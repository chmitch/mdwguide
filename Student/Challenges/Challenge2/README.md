# 	Challenge 2: Data Lake integration

## Introduction

Now that WWI has migrated their DW into Azure Synapse Analytics, they are ready to proceed to second stage of their modernization which is Data Lake Integration.  This will include the creation and configuration of Azure Data Lake Storage (ADLS).  Once created, they will use this data lake for data migration activities, storage, and analytics. The objective of this challenge is to build out a new data lake, and create pipelines to transfer data from their on prem OLTP system into it.

Note: This challenge is intended to build upon challenge 1, and you should try to reuse content wherever possible.

## Success Criteria

1. Deploy a new storage account resource.
2. Define directory structure to support data lake use cases.
3. Configure folder level security in your new data lake storage
4. Deploy Azure Data Factory 
5. Create a pipeline to copy data into ADLS

## Hints

1. Things to consider when creating new data lake folder structure:
    - What types of data will you need to be able to support?
    - What types of processes will you need to be able to support?
    - How will you secure access to directories?
2. There are other tools that could be used to migrate data from local storage into Azure (such as [Azure Storage Explorer](https://azure.microsoft.com/en-us/features/storage-explorer/) or [AzCopy](https://docs.microsoft.com/en-us/azure/storage/common/storage-use-azcopy-v10), but Azure data factory is recommended for this challenge because it will be used again in future challenges.
3. Try to make package execution dynamic and resuable where possible




## Learning Resources

1. [Begin by creating a new Azure Storage account](https://docs.microsoft.com/en-us/azure/storage/common/storage-account-create?toc=%2Fazure%2Fstorage%2Fblobs%2Ftoc.json&tabs=azure-portal).

2. [Data Lake Storage Best Practices](https://docs.microsoft.com/en-us/azure/storage/blobs/data-lake-storage-best-practices)

3. [Azure Data Factory Copy Activity](https://docs.microsoft.com/en-us/azure/data-factory/copy-activity-overview)

## Additional Challenges

1. [Deploy Azure Databricks workspace, mount your new storage and enable interactive queries and analytics!](https://docs.microsoft.com/en-us/azure/azure-databricks/databricks-extract-load-sql-data-warehouse?toc=/azure/databricks/toc.json&bc=/azure/databricks/breadcrumb/toc.json)


