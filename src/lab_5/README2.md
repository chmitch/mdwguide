# 	Challenge 5 - Power BI Reports and Model

## Prerequisites

1. [Challenges 1 to 4] -- (./Coach/Lab4 final) should be done successfully.
2. Download [Power BI Desktop](https://www.microsoft.com/en-us/download/details.aspx?id=58494) 

## Introductions

WWI leadership team wants to leverage use Power BI modeling capability to create anaytic data models from the data in Azure Synapse Analytics (ASA). The data model need to be able to meet the high level dashboard and detailed information with good performance. Power BI reporting capability is used to build out analytics reports and dashboards from the Power BI data models. 

## Success Criteria
1. Build out an analytic data model using Power BI Desktop Including the following tables: FactSales, DimensionDate, DimensionCustomer, DimensionCity, DimensionEmployee and DimensionStockItems
2. Compare the performance difference between Direct Query Mode and Imported Mode 
3. Tune the environment by leveraging Power BI Composite Mode, ASA Adaptive Cache and ASA Meterialized view
4. Analyze the data and tune the environment to optimize queries

## Dataset
Samples reports in https://github.com/microsoft/sql-server-samples/tree/master/samples/databases/wide-world-importers/power-bi-dashboards

## Basic Hackflow
1. Open Power BI Desktop and connect your report to Azure Synapse in Direct Query Mode
1. Add Order, Sales and Transaction Fact tables to model and corresponding dimension tables.  Create relationship between tables
1. Create reports in Power BI Desktop
1. Click on specific reports/dashboards to see query response times and record baseline
1. Take longest duration query from Query monitor window and copy it to SSMS. Turn result cache on and off to see difference in response times
1. Setup Tabular model in SSDT for DevOps workflows with XMLA endpoint
1. Tune model and report with Composite model and performance analyzer
1. Setup workload management to run ETL and Reports in parallel to see perf impact



## Hints
TBD

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