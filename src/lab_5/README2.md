# 	Challenge 5 - Power BI Reports and Model

## Prerequisites

1. [Challenges 1 to 4] -- (./Coach/Lab4 final) should be done successfully.
2. Download [Power BI Desktop](https://www.microsoft.com/en-us/download/details.aspx?id=58494) 

## Introduction

WWI leadership team wants to leverage Power BI modeling capability to create anaytic data models from the data in Azure Synapse Analytics (ASA). Next, they want to empower different analysts from different organizations to use Power BI reporting capability and build out analytics reports and dashboards from those data models. The final solution needs to consider both report design as well as optimal response times.  Dashboards need to return in less 5 seconds.

## Description
The objective of this lab is to build out a tabular model and Power BI reports.  BI analysts will use Power BI Desktop to build out this model and reports.  At the beginning the performance is suboptimal and you will need to tune the model, optimize the database and redesign the reports.

## Success Criteria
1. Build out a tabular data model using Power BI Desktop. Tables to include are; FactSales, DimensionDate, DimensionCustomer, DimensionCity, DimensionEmployee and DimensionStockItems
2. Compare the performance difference between Direct Query Mode and Imported Mode 
3. Tune the environment by leveraging Power BI Composite Mode, ASA Adaptive Cache and ASA Materialized views
4. Analyze the query performance data and tune the environment to optimize queries

## Basic Hackflow
1. Open Power BI Desktop and create data connection to Azure Synapse in Direct Query Mode
1. Add FactSales, DimensionDate, DimensionCustomer, DimensionCity, DimensionEmployee and DimensionStockItems to the model and corresponding dimension tables.  Create relationship between tables
1. Create few report pages in Power BI Desktop.
1. Click on specific reports/dashboards to see query response times and record baseline
1. Turn on Peformance Analyzer in Power BI Desktop
1. Got to SSMS and run querys to Turn result cache on and off to see difference in response times
1. Tune model and report with Composite model and use performance analyzer to tune the model performance


## Learning resources

|                                            |                                                                                                                                                       |
| ------------------------------------------ | :---------------------------------------------------------------------------------------------------------------------------------------------------: |
| **Description**                            |                                                                       **Links**                                                                       |
| Tune with result set cache | <https://docs.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/performance-tuning-result-set-caching> |
| Azure Synapse Analytics & Power BI concurrency | <https://www.jamesserra.com/archive/2019/12/azure-synapse-analytics-power-bi-concurrency/> |
| Azure Synapse Analytics & Power BI performance| <https://www.jamesserra.com/archive/2019/12/azure-synapse-analytics-power-bi/> |
| Table Design in Synapse    | <https://docs.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-tables-overview>                                |
| Best practices for Synapse | <https://docs.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-best-practices> |
| Monitor resource utilization  | <https://docs.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-concept-resource-utilization-query-activity?view=azure-sqldw-latest> |
| Workload Isolation  | <https://docs.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-workload-isolation?view=azure-sqldw-latest> |

## Tips
1. Use SQL Credential when connecting to the Azure Synapse Analytics database
2. Make sure the ASA service is running in Azure Portal since it might pause based on your settings
3. Create direct query mode data model first because you can convert direct query mode to imported mode but not vice versa 
4. Use Power BI Perforamance Analyzer to check power bi query time and performance
5. [Samples reports](https://github.com/microsoft/sql-server-samples/tree/master/samples/databases/wide-world-importers/power-bi-dashboards)


## Additional Challenges
1. Setup workload management to run ETL and run Reports in parallel to see performance impact
1. Setup Power BI Embed application "App Owns Data" for users to access data
1. Setup RLS in Power BI Embed and Azure Synapse Analytics