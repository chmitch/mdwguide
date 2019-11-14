# mdwguide
Modern Data Warehouse Guide Book

## Tracks

Here is the set of tracks (LABS) we plan to cover when building out our Modern Data Warehouse Guide Book.  There will be five components that are the typical workloads in a MDW architecture.
 
	1. Structured Data – ETL w/ SSIS or ADF (DBMS to DBMS)

	2. Semi-structured data – Data from flat files into relational databases

	3. Unstructured Data – Images, audio, video that we can tag and load into DW or Data Lake

	4. Streaming Data – Real-time data
	
	5. Interactive query – Ability to query data from Flat files on read
 
## Objective
These labs will help educate the community on Level 100/300 items related to MDW.  The goal will be to build out an overall reference architecture, hands-on labs, load patterns and data flow diagram to help developers get started.

## DataSet 

For us to get started, we’ve identified the Worldwide Importers as our OLTP and DW data sets.  For each use case, we will integrate this data into the WWI data set.  Here are the other data sets for each track.


 
	1. Structured WWI -- https://docs.microsoft.com/en-us/sql/samples/wide-world-importers-what-is?view=sql-server-2017 
			
	2. Semi-structured Data -- Web clickstream data https://2015.recsyschallenge.com/
	
    	3. Unstructured Data -- 

	4. Streaming Data --  
			
	5. Interactive Query -- Reuse same data sets from #1 & #2
			
Our goal is to have an end-to-end story that covers all Azure Data Services and explains common patterns so they can learn how to build it themselves (Guidebook).
