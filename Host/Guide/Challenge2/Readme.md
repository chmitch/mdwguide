# 	Challenge 2: Data Lake integration

## Introduction

Now that WWI has migrated their DW into Azure Synapse Analytics, they are ready to proceed to second stage of their modernization which is Data Lake Integration.  This will include the creation and configuration of Azure Data Lake Storage (ADLS).  Once created, they will use this data lake for data migration activities, storage, and analytics. The objective of this challenge is to build out a new data lake, and create pipelines to transfer data from their on prem OLTP system into it.  Keep in mind that the output of this exercise will become the <b>EXTRACT</b> part of WWI's new E-L-T process.  Based on requirements, it shou

Note: This challenge is intended to build upon challenge 1, and you should try to reuse content wherever possible.


## Environment Setup

1. Deploy a new storage account resource.
    - Create a new Azure Storage Account and enable Data Lake Storage Gen 2 (Note: set Hierarchical namespace property to Enabled).  Step by step directions can be found [here](https://docs.microsoft.com/en-us/azure/storage/common/storage-account-create?toc=%2Fazure%2Fstorage%2Fblobs%2Ftoc.json&tabs=azure-portal)

2. Define directory structure to support data lake use cases.  [This document](https://docs.microsoft.com/en-us/azure/storage/blobs/data-lake-storage-best-practices#batch-jobs-structure) describes this concept in more detail.

    - Create a new Storage Container and structure folders as outlined below:

        -> WWIDW
            -> In
                -> City
                -> Sale
                -> etc...
            -> Out
                -> City
                -> Sale
                -> etc...

3. Configure folder level security in your new data lake storage.  Supporting documentation for securing ADLS Gen 2 can be found [here](https://docs.microsoft.com/en-us/azure/storage/blobs/data-lake-storage-access-control). 

4. Deploy a new Azure Data Factory resource in your subscription.  You can find a similar sample explained [here](https://docs.microsoft.com/en-us/azure/data-factory/tutorial-hybrid-copy-data-tool).  Note: steps below explain how to create applicable pipelines and activities in more detail.

5. Create a pipeline to copy data into ADLS. Keep in mind that this pipeline will serve as the <b>EXTRACT</b> portion of WWI's new ELT process.  There are stored procedures already present in the OLTP database that can be used to query the source data.  This process needs 
    - Using instructions found in [here](https://docs.microsoft.com/en-us/azure/data-factory/tutorial-incremental-copy-multiple-tables-portal#create-a-data-factory), access the Azure Data Factory UI and create necessary linked services, datasets, pipelines, and activities (Note: JSON for each of the objects below can be found in the resources folder).  
        - Linked Services:
            - SQL Server connection for WideWorldImporters database
            - Azure Data Lake Gen 2
        - Datasets:
            - WideWorldImporters
            - Azure Data Lake
        - Pipeline 1:
            - Activities:
                - create a Copy acitvity with following properties
                    - Source Dataset: WideWorldImporters 
                    - Sink Dataset: 
                NOTE: by using expressions and parameters, you can make this pipeline dynamic and reuse for all tables
                
    - Create a 2nd pipeline with a ForEach Loop activity to iterate through the list of tables and execute Pipeline created above for each table
        - Activities:
            - Lookup Activity
                - query config table in DW to return list of tables
            - ForEach Activity
                - iterate over list of tables
                - Execute Pipeline task to execute pipeline create above (Note: you will need to pass in table name as parameter)



