# 	Lab 5 Tuning Analytics and migrating content to Premium

## Goal
Key Modules
1. Create tabular model in Power BI Desktop in DirectQuery mode
2. Click on specific reports/dashboards to see query response times 
3. Record baseline results with results Cache off and rerun them with results cache on
4. Take one query from Query monitor window and copy it to SSMS. Tag query to monitor it 
5. Run it with and without result cache off/on
6. Setup workload management to run ETL and Reports in parallel to see perf impact
7. Tune model and report with Composite model and performance analyzer

## Dataset
Samples reports in https://github.com/microsoft/sql-server-samples/tree/master/samples/databases/wide-world-importers/power-bi-dashboards


## Knowledgebase
https://docs.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/performance-tuning-result-set-caching
https://docs.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-tables-overview#statistics
https://docs.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-best-practices#maintain-statistics
https://docs.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-develop-label?view=azure-sqldw-latest
https://docs.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-workload-isolation?view=azure-sqldw-latest
https://docs.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-concept-resource-utilization-query-activity?view=azure-sqldw-latest
https://docs.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-troubleshoot?view=azure-sqldw-latest


SELECT name, is_auto_create_stats_on FROM sys.databases

SELECT name, is_result_set_caching_on
FROM sys.databases;

ALTER DATABASE [dbname]
SET RESULT_SET_CACHING ON;