// Databricks notebook source
// MAGIC %md
// MAGIC 
// MAGIC ##Lab 5 -- Interactive Query

// COMMAND ----------

// MAGIC %md
// MAGIC 
// MAGIC Setup & Mount Blob Storage to Databricks
// MAGIC 
// MAGIC Setup Credentials w/ KeyVault
// MAGIC 
// MAGIC https://docs.microsoft.com/en-us/azure/azure-databricks/store-secrets-azure-key-vault
// MAGIC 
// MAGIC Setup Databricks CLI in Azure Cloud CLI 
// MAGIC 
// MAGIC https://docs.microsoft.com/en-us/azure/azure-databricks/databricks-cli-from-azure-cloud-shell
// MAGIC 
// MAGIC https://www.mssqltips.com/sqlservertip/6094/manage-secrets-in-azure-databricks-using-azure-key-vault/

// COMMAND ----------

val jdbcUsername = dbutils.secrets.get(scope = "Blob", key = "sqluser")
val jdbcPassword = dbutils.secrets.get(scope = "Blob", key = "sqlpass")

// COMMAND ----------

Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver")

// COMMAND ----------

// MAGIC %md 
// MAGIC 
// MAGIC Setup Connection string 
// MAGIC 
// MAGIC https://docs.databricks.com/data/data-sources/sql-databases-azure.html
// MAGIC 
// MAGIC https://spark.apache.org/docs/latest/sql-data-sources-jdbc.html

// COMMAND ----------

val jdbcHostname = "<HostName Here>"
val jdbcPort = 1433
val jdbcDatabase = "WideWorldImportersDW"

// Create the JDBC URL without passing in the user and password parameters.
val jdbcUrl = s"jdbc:sqlserver://${jdbcHostname}:${jdbcPort};database=${jdbcDatabase}"

// Create a Properties() object to hold the parameters.
import java.util.Properties
val connectionProperties = new Properties()

connectionProperties.put("user", s"${jdbcUsername}")
connectionProperties.put("password", s"${jdbcPassword}")

// COMMAND ----------

// MAGIC %md
// MAGIC Setup Drivers

// COMMAND ----------

val driverClass = "com.microsoft.sqlserver.jdbc.SQLServerDriver"
connectionProperties.setProperty("Driver", driverClass)

// COMMAND ----------

// MAGIC %md 
// MAGIC 
// MAGIC Define Table to Query
// MAGIC 
// MAGIC https://medium.com/@willvelida/databases-and-tables-in-azure-databricks-cdf49ca33702

// COMMAND ----------

val customer_table = spark.read.jdbc(jdbcUrl, "[Dimension].[Customer]", connectionProperties)

// COMMAND ----------

customer_table.printSchema

// COMMAND ----------

// MAGIC %md
// MAGIC 
// MAGIC Query Statement to customer table
// MAGIC 
// MAGIC https://spark.apache.org/docs/latest/sql-performance-tuning.html

// COMMAND ----------

display(customer_table.select("Customer Key", "Customer", "Category"))

// COMMAND ----------

// MAGIC %md 
// MAGIC 
// MAGIC ###Ad-hoc query for Lab
// MAGIC 
// MAGIC Summarzie customer clicstream activity & past sales
// MAGIC 
// MAGIC -- Click_Summary
// MAGIC 
// MAGIC -- SessiontoUser (bridge table)
// MAGIC 
// MAGIC -- Customer
// MAGIC 
// MAGIC -- Fact Sales data

// COMMAND ----------

val customer_table = spark.read.jdbc(jdbcUrl, "[Dimension].[Customer]", connectionProperties)
val sales_table = spark.read.jdbc(jdbcUrl, "[Fact].[Sale]", connectionProperties)
val bridge_table = spark.read.jdbc(jdbcUrl, "[dbo].[sessiontouser]", connectionProperties)

// COMMAND ----------

// MAGIC %md
// MAGIC 
// MAGIC Pushdown Query to database
// MAGIC 
// MAGIC Join data to DBFS clicks_summary
// MAGIC 
// MAGIC https://docs.datastax.com/en/dse/6.7/dse-dev/datastax_enterprise/spark/sparkPredicatePushdown.html
// MAGIC 
// MAGIC https://medium.com/@wx.london.cun/simple-queries-in-spark-catalyst-optimisation-2-join-and-aggregation-c03f07a1dda8
// MAGIC 
// MAGIC https://docs.microsoft.com/en-us/azure/databricks/spark/latest/spark-sql/query-watchdog?toc=https%3A%2F%2Fdocs.microsoft.com%2Fen-us%2Fazure%2Fazure-databricks%2FTOC.json&bc=https%3A%2F%2Fdocs.microsoft.com%2Fen-us%2Fazure%2Fbread%2Ftoc.json

// COMMAND ----------

customer_table.createOrReplaceTempView("Customer")
bridge_table.createOrReplaceTempView("Bridge")
sales_table.createOrReplaceTempView("Sales")

// COMMAND ----------

// MAGIC %sql
// MAGIC 
// MAGIC SELECT Customer.Customer, Customer.`Buying Group`, clicks_summary.*
// MAGIC FROM Customer, Bridge, clicks_summary
// MAGIC WHERE Customer.`Customer Key` = Bridge.`Customer Key`
// MAGIC and Bridge.SessionID = clicks_summary.SessionID
// MAGIC and Customer.`Buying Group` = "Wingtip Toys"

// COMMAND ----------

// MAGIC %sql
// MAGIC 
// MAGIC SELECT Customer.Customer, sum(clicks_summary.SessionCount) as Visits, sum(sales.`Total Including Tax`) as `Gross Sales`
// MAGIC FROM Customer, Bridge, clicks_summary, Sales
// MAGIC WHERE Customer.`Customer Key` = Bridge.`Customer Key`
// MAGIC and Bridge.SessionID = clicks_summary.SessionID
// MAGIC and Customer.`Customer Key` = Sales.`Customer Key`
// MAGIC and Customer.`Buying Group` = "Wingtip Toys"
// MAGIC Group by Customer.Customer
