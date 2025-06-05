## WA Road Analytics Project

This project is an end-to-end data engineering and analytics pipeline built using Azure Data Factory, Azure Data Lake Gen2, Azure Databricks, Azure Synapse Analytics, and Tableau. The goal of the project was to analyzes various public transport and road infrastructure datasets published on data.wa.gov.au to get insights into traffic patterns, road safety, infrastructure coverage, and roadwork disruptions across Western Australia.

## Architecture Overview

[![architecture-drawio.png](https://i.postimg.cc/prPdKwGb/architecture-drawio.png)](https://postimg.cc/hz3gB5Rp)

## Dataset

1. Traffic Count Data - Daily and peak hour counts, speed compliance, heavy vehicle ratio

2. Legal Speed Limits - Posted speed limits across roads in WA

3. Traffic Signal Sites - Coordinates and types of traffic lights across intersections

4. Roadworks Data - Current and planned maintenance/disruption sites


## Azure Components

- Azure Data Factory - Ingest raw data from GitHub (HTTP source) into the Bronze Zone (DL Gen2)

- Azure Databricks - Transform data: Clean, format, derive columns, drop nulls, validate

- Azure Data Lake Gen2 - Stores raw and curated data in structured folders

- Azure Synapse - Reads curated CSVs as External Tables → Physical Tables for querying

- Tableau - Connects to Synapse for analytics dashboards


## Key Transformations in Azure Databricks

- Cleaned messy column names and data types

- Parsed dates (MM/DD/YYYY) and standardized formatting

- Removed null heavy columns and rows with missing info

- Derived new flags such as:
    - is_major_disruption in roadworks
    - is_highway, is_urban_limit in legal speed limits
    - traffic_volume_category, is_peak_hour_high_traffic in traffic count

- Added ingested_at timestamp to all data


## Dashboard

[![Dashboard.png](https://i.postimg.cc/RVq3h6PQ/Dashboard.png)](https://postimg.cc/mtfZ6DWt)

[![Speeding-Risk-vs-Speed-Limit.png](https://i.postimg.cc/66b3k697/Speeding-Risk-vs-Speed-Limit.png)](https://postimg.cc/9zTCThwV)

