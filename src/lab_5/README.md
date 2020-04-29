# 	Challenge 5 - Power BI Reports and Model

## Prerequisites

1. [Challenges 1 to 4] -- (./Coach/Lab4 final) should be done successfully.

## Introductions

World Wide Importers wants to build out analytics reports on their data in Synapse.

## Success Criteria
1. Build out a tabular model and reports in Power BI Desktop
1. Analyze the data and tune the environment to optimize queries
1. Import Power BI Data set into SSDT for DevOps pipeline

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
| Table Design in Synapse    | <https://docs.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-tables-overview>                                |
| Best practices for Synapse | <https://docs.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-best-practices> |
| Monitor resource utilization  | <https://docs.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-concept-resource-utilization-query-activity?view=azure-sqldw-latest> |
| Workload Isolation  | <https://docs.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-workload-isolation?view=azure-sqldw-latest> |