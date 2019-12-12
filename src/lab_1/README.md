# 	Lab 1 Structured data 

## Goal
Build out data pipeline to load data from LOB application (WWI) to a data warehouse (WWIDW).  This is traditional ETL workload leveraging World Wide Importers sample database

## Dataset
World Wide Importers 
https://docs.microsoft.com/en-us/sql/samples/wide-world-importers-what-is?view=sql-server-2017  
In your demo virtual machine, please download 
1. Visual Studio 2019 with SQL Server Data tool.
2. SQL server management studio
3. SQL Server 2017 Developer version
3. World Wide Importer - Standard OLTP database from the link provided above
4. World Wide Importer - Standard OLAP database from the link provided above
5. World WIde Importer SSIS packages from the link provided above


## Main Story:
Wide World Importers (WWI) is a wholesale novelty goods importer and distributor operating from the San Francisco bay area.

As a wholesaler, WWI's customers are mostly companies who resell to individuals. WWI sells to retail customers across the United States including specialty stores, supermarkets, computing stores, tourist attraction shops, and some individuals. WWI also sells to other wholesalers via a network of agents who promote the products on WWI's behalf. While all of WWI's customers are currently based in the United States, the company is intending to push for expansion into other countries.

WWI buys goods from suppliers including novelty and toy manufacturers, and other novelty wholesalers. They stock the goods in their WWI warehouse and reorder from suppliers as needed to fulfil customer orders. They also purchase large volumes of packaging materials, and sell these in smaller quantities as a convenience for the customers.

Recently WWI started to sell a variety of edible novelties such as chilli chocolates. The company previously did not have to handle chilled items. Now, to meet food handling requirements, they must monitor the temperature in their chiller room and any of their trucks that have chiller sections.
https://docs.microsoft.com/en-us/sql/samples/wide-world-importers-oltp-database-catalog?view=sql-server-2017

Business has been growing dramatically over the past few years. The cost of IT operation has increase accordingly. Leadership of Wide World Importers team has decided to leverage cloud computing of Azure to help them with the fast growth of data. 

Currently data solutions, WW Importer has traditional OLTP data stores on premise SQL server 2017 and it has a well-defined ETL solution which leverages SSIS packages to do batch load to their data warehouse. They also have on-premise SQL server analysis services for analytic layer and SSRS report as their reporting layer.

Future data solutions, they want to move their current data solution to Azure to reduce TCO. Also, they would like to add their website click stream data to analyze their user behavior on their website with drives more sells. The Click stream data is non structured data which they want to have it load to their existing data warehouse as batch load as well as streaming data source which allows real-time analytics to their surfacing layer. 

## Step by Step challenge and guidance 
	Step 1 Migrate WWI OLTP and OLAP database from SQL Server On VM migrate to Azure SQL MI
		a. Step by Step migration tutorial: https://datamigration.microsoft.com/scenario/sql-to-azuresqldbmi?step=1
		b. Tool: Data Migration Assistant
		c. Potential Issues:
			i. From WWImporter On-Premise Full Edition to SQL DB Serverless (78 errors) 
			Analyze the error (use the Power BI tempate called 'Data Migration Assistant Analyzer' in the file attached in this repository)
			
			ii. Error during schema creation: Export the result use power bi to analyze the error
				1) Error Type: 'WITH NATIVE_COMPILATION' is not supported in this service tier of the database. See Books Online for more details on feature support in different service tiers of Windows Azure SQL Database.
				2) [Warehouse].[VehicleTemperatures] 'MEMORY_OPTIMIZED tables' is not supported in this service tier of the database. See Books Online for more details on feature support in different service tiers of Windows Azure SQL Database.
				3) Sales.CustomerTransaction and Purchase.SupplierTransaction - Partition columns for a unique index must be a subset of the index key.
			iii. After increase the target Azure SQL DB to Business Critical layer. (69 errors)
				1) However, still cannot create sales.customertransaction and purchase.suppliertransaction because the generated script did not add the partition key to the index list
				2) Store Procedure:  [InMemory].[InsertVehicleLocation],[Website].[RecordColdRoomTemperatures],[InMemory].[Insert500ThousandVehicleLocations] - Cannot ALTER a non-native module into a natively compiled module. Omit WITH NATIVE_COMPILATION or drop and recreate the module.
			iv. Change the script
				1) Added the partition key to the index list
				2) Change the alter statement of  [InMemory].[InsertVehicleLocation],[Website].[RecordColdRoomTemperatures],[InMemory].[Insert500ThousandVehicleLocations]  to drop and create statement
				
		
	Step 2 Migrate SSIS packages to Azure Data Factory

		a. Step by Step migration tutorial: https://azure.microsoft.com/mediahandler/files/resourcefiles/azure-data-factory-ssis-in-the-cloud/Azure_Data_Factory_SSIS_in_the_Cloud.pdf
		b. Tool: Update: you can use the lastes Data migration assistance to analyze the potential issues of SSIS migration and suggested solution.
		c. Potential issues: 
			i. It need to have SSISDB to store the package otherwise need to use Azure File to store and SSIS IR to call command line tool into it.
			ii. Each Azure SQL Server can have a SSISDB as long as you enable "Allow Azure Resource to access"
			iii. https://www.purplefrogsystems.com/paul/2018/01/azure-ssis-how-to-setup-deploy-execute-schedule-packages/
			iv. Allow Azure Resource connect to the SQL Server Then it has SSISDB
			v. Add Azure content pack to the SSDT
			vi. Use DMA for migration assessment 
			vii. SSIS In Azure cannot recognize OLE DB connector
			An OLE DB record is available.  Source: "Microsoft SQL Server Native Client 11.0"  Hresult: 0x80040E14  Description: "The batch could not be analyzed because of compile errors.".
			An OLE DB record is available.  Source: "Microsoft SQL Server Native Client 11.0"  Hresult: 0x80040E14  Description: "Could not find stored procedure 'Integration.GetCityUpdates
			Solution: change the connection drive to highlighted yellow then change back to SQL Server Native Client 11.0.

	Step 3 Modernlize your Data Warehouse using Azure Synapse Analytics
		a. Step by Step tutorial: https://docs.microsoft.com/en-us/azure/sql-data-warehouse/load-data-wideworldimportersdw
		b. Useful scripts: please see attached files.
