# 	Challenge 2: Data Lake integration

[< Previous Challenge](/Host/Guide/Challenge1/readme.md)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Next Challenge>](/Host/Guide/Challenge3/Readme.md)

## Introduction

Now that WWI has migrated their DW into Azure Synapse Analytics, they are ready to proceed to second stage of their modernization which is Data Lake Integration.  This will include the creation and configuration of Azure Data Lake Storage (ADLS).  Once created, they will use this data lake for data migration activities, storage, and analytics. The objective of this challenge is to build out a new data lake, and create pipelines to transfer data from their on prem OLTP system into it.

Note: This challenge is intended to build upon challenge 1, and you should try to reuse content wherever possible.


## Step By Step Guidance

1. Deploy a new storage account resource.
    - Create a new Azure Storage Account and enable Data Lake Storage Gen 2 (Note: set Hierarchical namespace property to Enabled)

2. Define directory structure to support data lake use cases.
    - Create a new Storage Container and structure folders as outlined below:

<img src="./Images/DataLakeTreeView.jpg" width="25%">

3. Configure folder level security in your new data lake storage 

4. Deploy a new Azure Data Factory resource in your subscription

5. Create a pipeline to copy data into ADLS
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
                    - Source Dataset: 
                    - Sink Dataset: 
                NOTE: by using expressions and parameters, you can make this pipeline dynamic and reuse for all tables
                
    - Create a 2nd pipeline with a ForEach Loop activity to iterate through the list of tables and execute Pipeline created above for each table
        - Activities:
            - Lookup Activity
                - query config table in DW to return list of tables
            - ForEach Activity
                - iterate over list of tables
                - Execute Pipeline task to execute pipeline create above (Note: you will need to pass in table name as parameter)

## SOLUTIONS
[Go to Solution](/Host/Solutions/Challenge2)


