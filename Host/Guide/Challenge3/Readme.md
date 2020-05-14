# 	Challenge 3 -- Redesign SSIS jobs into ELT with ADF

[< Previous Challenge](/Host/Challenges/Challenge2/README.md)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Next Challenge>](/Host/Challenges/Challenge4/README.md)

## Introduction
WW Importers keep missing their SLAs in terms of the nightly loads.  The loads take six hours to complete and starts each evening at 1:00AM.  They must complete by 8:00AM but frequenly these jobs are taking longer than usual.  A few critical stakeholders are asking them to provide data more frequently on an hourly basis.  Since these business units are their key stakeholders, they have the funding to help replatform their data pipelines.  Now that the OLTP data is being extracted into the data lake, the team at WWI is ready to extend  their pipelines and load this data into their Data Warehouse for Stage 3.  As stated in the previous challenge, these data pipelines must be ELT (Extract, Load & Transform) so they can quickly write the data to the cloud and scale out the compute to transform the data.  Now that the EXTRACT phase is complete, it's time to build the Transform and Load processes.

## Description
The objetive of this lab is to modernize the ELT pipeline that was originally built in SSIS.  We need to rebuild this pipeline in Azure leveraging scale-out architecture to transform this data.  In the last challenge, a pipeline was created to extract data from the OLTP database and store it in the Azure Data Lake.  In this challenge the objective is to add logic to ingest it into Azure Synapase Analytics via Polybase and then merge into final Fact and Dimension tables.  This will need to be executed on a nightly basis, so Azure Data Factory should be leveraged to orchestrate and schedule jobs.  Another key concept to keep in mind is that all of the values in the Dimension tables in this Data Warehouse are automatically assigned "surrogate keys".  These keys are then used to relate the records in the Fact tables back to corresponding dimensions.  This creates a dependency, and you will need to keep this in mind when loading data to ensure that Dimension tables are fully loaded prior to Fact tables being loaded in order to preserve data integrity.

Note: This challenge is intended to build upon the previous 2 challenges, and you should try to reuse content wherever possible

## Environment Setup

1. Add a new activity to your Azure Data Factory to load data from the new Azure Data Lake into the _Staging tables in the Data Warehouse in Azure Synapse via Polybase
    - The primary benefit of using ELT loading pattern in Azure is to take advantage of the capabilities of scale out cloud technologies to load data as quickly as possible and then leverage the power of Azure Synapse Analytics to transform that data, and finally merge it into its final destination.  In order to ingest the data that was loaded into the data lake in the previous challenge, you should add a new acitvity to the existing Azure Data Factory to load each table via Polybase.  A way to implement this dynamically would be to create parameterized stored procedures and call them using a Stored Procedure activity.  An example of how to load data via CTAS can be found [here](https://docs.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/load-data-from-azure-blob-storage-using-polybase).

    <b>NOTE:</b> This process leverages stored procedures to import the data via CTAS statements in Azure Synapse.  As mentioned, alternative approaches could be to execute Copy commands or leverage the Copy activity directly. 

1. Create another activity to merge the new data into the target Fact and Dimension tables in your DW from your _Staging tables
    - Now that your data has been loaded into the DW, you will need to merge the results into the Fact and Dimension schemas.  To accomplish this, you can use the Integration.Migrate... stored procedures that were created in Challenge 1.  In order to execute the queries via your Azure Data Factory pipeline:
        - add a new Execute Stored Proedure Activity, and configure it to execute the Integration.MigrateStagedCityData stored procedure in your Synapse DW
        <b>Note:</b> As mentioned before, you should use expressions to call the stored procedure so that the activity can be reused for each table being merged
    <b>NOTE: </b>As stated in the INtroduction above, Dimension tables will need to be fully loaded before Fact tables, so be sure to account for that when building this activity.  In the solution included, this is achieved by creating a concept of "GroupIds" in the control table.  A Foreach loop iterates over this column and completes all tables in 1 group before moving on to the next.

1. Add another new activity to your new pipeline to move the files to the \Out directory in your data lake once they have been loaded into your DW table
    - Now that you are able to load and merge the updated data, you will want to add a final activity to your pipeline that will copy the files from the \In directory in your data lake into the corresponding folder in your \Out directory.  This will let any downstream process and/or client know that it no longer needs to be loaded.  Keeping it in the \Out directory, however will allow the data to be persisted in your lake for future use.  You can refer back to challenge 2 for guidance on how to create a copy data activity inside Azure Data Factory
    <b>Note:</b> Depending on how dynamic you made the dataset for the Azure Data Lake store, you will likely need to create a 2nd dataset at this point for the archive directly.

1. Test your new Azure Data Factory Pipeline by validating that data added to the source system will flow through to final target tables
    - In order to test your new pipeline, you can modify an existing record or add a new one in the source OLTP database, and execute your new Data Factory pipeline to ensure the updated data is copied to your data lake, and ultimately updated in your data warehouse.  There are multiple ways to trigger your new pipeline, but the easiest is to just choose "Trigger Now" from within the Azure Data Factory UI as described [here](https://docs.microsoft.com/en-us/azure/data-factory/quickstart-create-data-factory-portal#trigger-the-pipeline-manually).


## SOLUTIONS
[Go to Solution](/Host/Solutions/Challenge3)

