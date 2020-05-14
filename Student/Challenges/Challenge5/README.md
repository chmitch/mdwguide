# 	Challenge 5 -- Analytics Migration

[<Previous Challenge](/Student/Challenges/Challenge4/README.md)

## Introduction

WWI leadership team wants to leverage Power BI modeling capability to create analytic data models from the data in Azure Synapse Analytics (ASA). Next, they want to empower different analysts from different organizations to use Power BI reporting capability and build out analytics reports and dashboards from those data models. The final solution needs to consider both report design as well as optimal response times.  Dashboards need to return in less 5 seconds.

## Description
The objective of this lab is to build out a tabular model and Power BI reports.  BI analysts will use Power BI Desktop to build out this model and reports.  At the beginning the performance is suboptimal and you will need to tune the model, optimize the database and redesign the reports.

## Success Criteria
1. Open Power BI Desktop and create data connection to Azure Synapse in Direct Query Mode
1. Add FactSales, DimensionDate, DimensionCustomer, DimensionCity, DimensionEmployee and DimensionStockItems to the model and corresponding dimension tables.  Create relationship between tables
1. Create report similar to template in section called, "Power BI report Page 1".  Call report page "High Level Dashboard"
1. Create report similar to template in section called, "Power BI report Page 2". Call report page "Sales Detail"
1. Click on each page and record query durations.  Go to Azure Portal look for Monitoring and Query Activity.  Record baseline for each page
1. Copy each query from the Query ID field and use this query in SSMS
1. Go to SSMS and run each query from above step with and without result cache on/off.  Record new response times
1. Tune Power BI model and report with Composite model and use performance analyzer to tune the model performance

## Power BI Report Page 1
![The Power BI Report Template to recreate for Challenge 5](/images/pbipg1.png)

## Power BI Report Page 2 
![The Power BI Report Template to recreate for Challenge 5](/images/pbipg2.png)


## Learning resources

|                                            |                                                                                                                                                       |
| ------------------------------------------ | :---------------------------------------------------------------------------------------------------------------------------------------------------: |
| **Description**                            |                                                                       **Links**                                                                       |
| Tune with result set cache | <https://docs.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/performance-tuning-result-set-caching> |
| Azure Synapse Analytics & Power BI performance| <https://www.jamesserra.com/archive/2019/12/azure-synapse-analytics-power-bi/> |
| Monitor resource utilization  | <https://docs.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-concept-resource-utilization-query-activity?view=azure-sqldw-latest> |
| Performance Tuning | https://medium.com/@ian.shchoy/azure-sql-data-warehouse-deep-dive-into-data-distribution-f4cf8f1e340a |


## Tips
1. Use SQL Credential when connecting to the Azure Synapse Analytics database
2. Make sure the ASA service is running in Azure Portal since it might pause based on your settings
3. Create direct query mode data model first because you can convert direct query mode to imported mode but not vice versa 
4. Use Power BI Perforamance Analyzer to check power bi query time and performance
5. [Samples reports](https://github.com/microsoft/sql-server-samples/tree/master/samples/databases/wide-world-importers/power-bi-dashboards)


## Additional Challenges
1. [Add Indexes and Partitions to your table structures](https://docs.microsoft.com/en-us/sql/relational-databases/indexes/columnstore-indexes-design-guidance?view=sql-server-ver15)
1. [Ordered vs. Nonordered CCI](https://docs.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/performance-tuning-ordered-cci)
1. Setup workload management to run ETL and run Reports in parallel to see performance impact
1. Setup Power BI Embed application "App Owns Data" for users to access data
1. Setup RLS in Power BI Embed and Azure Synapse Analytics