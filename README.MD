Project Overview

This repository contains the solutions for CoreDataEngineers’ data engineering and analysis tasks. The project demonstrates the use of Bash scripting for ETL (Extract, Transform, Load) processes, file management, and data ingestion into PostgreSQL for subsequent analytical queries.

The project is divided into three main tasks:

ETL Process Automation

Extract: Downloads a CSV file from a given URL into a raw folder.

Transform: Renames the column Variable_code to variable_code and selects only year, Value, Units, and variable_code. The output is saved as 2023_year_finance.csv in the Transformed folder.

Load: Copies the transformed file into the Gold folder.

Automation: The ETL script is scheduled to run daily at 12:00 AM using a cron job.

CSV and JSON File Management

A Bash script moves all CSV and JSON files from any source folder into a folder named json_and_CSV.

Supports handling one or multiple files dynamically.

PostgreSQL Data Ingestion & Analysis

Bash scripts iterate over CSV files and load each into a PostgreSQL database named posey.

SQL scripts answer business questions related to orders, company data, and sales regions, including:

Retrieving orders where gloss_qty or poster_qty > 4000.

Finding orders where standard_qty = 0 and gloss_qty or poster_qty > 1000.

Listing companies starting with "C" or "W" with specific primary contact conditions.

Showing the region of each sales rep along with their associated accounts, sorted alphabetically.