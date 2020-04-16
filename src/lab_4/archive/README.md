# 	Lab 4 Streaming data 

## Goal
Build a streaming pipeline using Kafka on HDInsight to ingest simulated click stream data into enterprise Delta Lake via Azure Databricks.

## Dataset
Data Source: 
In order to generate the source data stream for this exercise, you will need to execute sample .Net application (see code below).  This code will randomly generate product related data, and write it to a Kafka topic.

Data Sink:
Azure Databricks will be used to consume Kafka topic, and write streaming data to Delta Lake tables stored in Azure Data Lake.

## Step by Step Guidance

**Step 1 - Deploy Kafka instance on HDInsight**
Follow Kafka quickstart instructions [here](https://docs.microsoft.com/en-us/azure/hdinsight/kafka/apache-kafka-get-started). Once up and running, install jq and create first topic per quick start instructions.

**Note:** if you don't already have one configured, be sure to create a Virtual Network in your Resource Group first so that it can be configured for your cluster.  This will be required for future steps.

**Step 2 - Update Kafka configuration settings**
Leverage instructions found [here](https://docs.microsoft.com/en-us/azure/hdinsight/kafka/apache-kafka-connect-vpn-gateway#configure-kafka-for-ip-advertising) to ensure that Kafka is configured for IP advertising.  While in Ambari management screen, take note of IP addresses for Kafka brokers.  You will need these later to configure topic publishers and consumers.  (Note: [this page](https://lenadroid.github.io/posts/kafka-hdinsight-and-spark-databricks.html) can be used as reference for this step if necessary)

**Step 3 - Set up and configure data source**
Create a Visual Studio VM in the same Resource Group as your new HDInsight cluster.  Clone stream generator repo found [here](https://github.com/alexkarasek/ClickStreamGenerator).  Once project is open in visual studio, update the necessary configuration settings and IP addresses for Kafka brokers.

**Step 4 - Deploy Azure Databricks**
Deploy Databricks Workspace and create a new cluster in the same Resource Group as above.  Once configured, be sure to peer the Databricks Virtual Network with the other virtual network that was created in steps above.  You can reference this [link] (https://docs.microsoft.com/en-us/azure/databricks/administration-guide/cloud-configurations/azure/vnet-peering) if necessary.

**Step 5 - Create Azure Data Lake Storage Account**
Create a new ADLS Gen 2 storage account in your Resource Group.  This will be used as the backend storage for Delta Lake tables created in subsequent steps.

**Step 6 - Import and Configure Databricks Notebook**
Start new Databricks Cluster and import Notebook contained in this solution.  Once imported, update configuration settings for Kafka topics and Azure Data Lake Storage.

**Step 7 - Start data stream**
Once all items above have been deployed and configured, you can log into your new Visual Studio VM, and start the solution.  This will begin writing data to the new Kafka topic.

**Step 8 - Ingest data stream**
Execute the Databricks notebook configured above to create streaming dataset, and start writing data to Delta Lake.  Once this notebook is running, you can begin to interactively query Delta Lake tables and streaming Data Frame.

##Note: Once this exercise is complete, do not forgot to stop and delete all services created in this step to avoid ongoing charges to your Azure subscription.

