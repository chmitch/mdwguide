# 	Lab 3 Redesign SSIS jobs into ELT with ADF

## Overview

The goal of this lab is to modernize the ETL pipeline that was originally built in SSIS, and was designed to update the fact and dimension tables in the WideWorldImportersDW database using cloud native technologies in Azure.

Note: This lab is intended to build upon the previous 2 labs, and you should try to reuse content wherever possible

## Key Objectives

1. Redesign ETL Jobs in SSIS to Azure Data Factory.
2. Leverage Polybase where possible.
3. Optimize where possible by using dynamic code, and executing tasks in parallel.
4. Consider how you might extend the capabilities even further in the future as requirements evolve.


## Suggested Guides

1. Begin by building a pipeline in ADF to import a single dimension table from your local source database into Azure Data Lake storage

(https://docs.microsoft.com/en-us/azure/data-factory/tutorial-hybrid-copy-portal)

2. Load data into DW via Polybase

(https://docs.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/load-data-from-azure-blob-storage-using-polybase)

3. Modify existing steps to load all tables dynamically

(https://docs.microsoft.com/en-us/azure/data-factory/tutorial-incremental-copy-multiple-tables-portal)

## Knowledgebase

