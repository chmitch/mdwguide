# Overview

This lab is intended to build upon the previous 2 labs in this guide, and assumes that all steps have been completed to create source and target datbases.

The goal of this lab is to modernize the ETL pipeline that was originally built in SSIS, and was designed to update the fact and dimension tables in the WideWorldImportersDW database using cloud native technologies in Azure.

This exercise is designed to be a challenge based hack (as opposed to prescriptive hands on lab), but source code for the solutions has been provided here, and can be used for guidance.

## Content

### Scripts

These are supplemental scripts required to support ADF solution contained in this repository.  

1. [PopulateETLCutoffs.sql](./Scripts/PopulateEtLCutoffs.sql) - This adds additional columns and values to the existing Integration.[ETL Cutoff] table that faciliate dynamic execution of ADF pipelines
2. [PrepExternalDataSource.sql](./Scripts/PrepExternalDataSource.sql) - This builds all of the objects necessary to support Polybase/External Tables in the Azure Synapse Analytics instance
3. [proc_Integration.CreateLineageKey](./Scripts/proc_Integration.CreateLineageKey.sql) - This contains a change to the existing procedure 
4. [proc_Integration.GetUpdates_wrapper](./Scripts/proc_Integration.GetUpdates_wrapper.sql) - this procedure should be compiled in the WideWorldImporters source database.  It will be used to dynamically call the table specific source queries that will be used as the source of the ADF copy pipelines.
5. [proc_Integration.Ingest@@@Data](./Scripts/) - The remaining procedures should be compiled in the WideWorldImportersDW database.  They are used to dynamically create External tables and create and load into materialized tables in the sql pool

### Data Factory Objects

These objects can be used to deply each component required to build out your Azure Data Factory datasets and pipelines

### ARM Templates

These templates can be used to deploy resources required to complete this solution.

1. [adfMDWHack_ARM](./ARM%20Templates/adfMDWHack_ARM) - ARM Template for all objects included in Azure Data Factory including pipelines 

### Other Dependencies

In addition to items outlined above, this lab will also require an Azure Storage Account that can be used to land and store the data being ingested.

(Note: this can be the same account created and used in lab 2)

