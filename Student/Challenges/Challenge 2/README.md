# 	Challenge 2: Data Lake integration

## Overview

The goal of this lab is to create and configure Azure Data Lake Storage (ADLS).  Once created, you will use this data lake for data migration, storage, and analytics.

Note: This challenge is intended to build upon challenge 1, and you should try to reuse content wherever possible.

## Key Objectives

1. Deploy a new storage account resource.
2. Define directory structure to support data lake use cases.
3. Configure folder level security in your new data lake storage
4. Deploy Azure Data Factory 
5. Create a pipeline to copy data into ADLS


## Suggested Guides

1. Begin by creating a new Azure Storage account.  Additional information can be found [here](https://docs.microsoft.com/en-us/azure/storage/common/storage-account-create?toc=%2Fazure%2Fstorage%2Fblobs%2Ftoc.json&tabs=azure-portal).

2. Create a container in your new storage account, and then define folder structure for your new data lake.  Some things to consider when defining this structure would be:

    * What types of data will you need to support?
    * What types of processes will you need to support?
    * How will you secure access to directories?

More information on best practices can be found [here](https://docs.microsoft.com/en-us/azure/storage/blobs/data-lake-storage-best-practices).

3. Once your data lake is created, deploy an Azure Data Factory pipeline to copy the data that you exported in challenge 1 into your new folder structure.  Additional information on how to create copy pipelines in Azure Data Factory can be found [here] (https://docs.microsoft.com/en-us/azure/data-factory/copy-activity-overview).

Note: There are other tools that could be used to migrate data from local storage into Azure (such as [Azure Storage Explorer](https://azure.microsoft.com/en-us/features/storage-explorer/) or [AzCopy](https://docs.microsoft.com/en-us/azure/storage/common/storage-use-azcopy-v10), but Azure data factory is recommended for this challenge because it will be used again in future challenges.
     

## Knowledgebase
