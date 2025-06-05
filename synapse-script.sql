-- create External File Format
CREATE EXTERNAL FILE FORMAT CsvFormat
WITH (
    FORMAT_TYPE = DELIMITEDTEXT,
    FORMAT_OPTIONS (
        FIELD_TERMINATOR = ',',
        STRING_DELIMITER = '"',
        FIRST_ROW = 2
    )
);

--  create External Data Source
CREATE EXTERNAL DATA SOURCE WaRoadData
WITH (
    LOCATION = 'abfss://..............dfs.core.windows.net'
);

-- External tables act as a virtual layer that can use SQL to query files (like CSVs) directly from Azure Data Lake.

-- create External Tables
CREATE EXTERNAL TABLE dbo.roadworks (
    x FLOAT,
    y FLOAT,
    fid INT,
    id INT,
    datestarte VARCHAR(100),
    estimatedc VARCHAR(100),
    workstatus VARCHAR(100),
    worktype VARCHAR(100),
    road VARCHAR(255),
    suburb VARCHAR(255),
    region VARCHAR(100),
    entrydate VARCHAR(100),
    globalid VARCHAR(100),
    descriptio VARCHAR(500),
    trafficimp VARCHAR(500),
    localroadname VARCHAR(255),
    ingested_at VARCHAR(100),
    start_date VARCHAR(50),
    end_date VARCHAR(50),
    work_duration_days INT,
    is_major_disruption VARCHAR(5)
)
WITH (
    LOCATION = '/transformed-data/roadworks/',
    DATA_SOURCE = WaRoadData,
    FILE_FORMAT = CsvFormat
);


CREATE EXTERNAL TABLE dbo.legal_speed_limits (
    road VARCHAR(255),
    road_name VARCHAR(255),
    common_usage_name VARCHAR(255),
    start_slk FLOAT,
    end_slk FLOAT,
    cwy VARCHAR(100),
    start_true_dist FLOAT,
    end_true_dist FLOAT,
    network_type VARCHAR(100),
    ra_no INT,
    ra_name VARCHAR(100),
    lg_no INT,
    lg_name VARCHAR(100),
    speed_limit VARCHAR(100),
    route_ne_id INT,
    objectid INT,
    globalid VARCHAR(100),
    geolocstlength FLOAT,
    ingested_at VARCHAR(100),
    is_highway VARCHAR(5),
    is_urban_limit VARCHAR(5)
)
WITH (
    LOCATION = '/transformed-data/legal_speed_limits/',
    DATA_SOURCE = WaRoadData,
    FILE_FORMAT = CsvFormat
);


CREATE EXTERNAL TABLE dbo.traffic_count (
    mi_prinx INT,
    sl_number INT,
    site_id VARCHAR(100),
    street_location VARCHAR(255),
    between_street_1 VARCHAR(255),
    between_street_2 VARCHAR(255),
    direction_bound VARCHAR(50),
    start_date VARCHAR(50),
    end_date VARCHAR(50),
    count_year INT,
    ave_weekday_traffic INT,
    adt INT,
    am_peak_8_to_9 INT,
    pm_peak_5_to_6 INT,
    percent_heavy_vehicles FLOAT,
    speed_limit INT,
    percentile_85th FLOAT,
    percent_exceed_speed_limit FLOAT,
    data_collected_by VARCHAR(100),
    longitude FLOAT,
    latitude FLOAT,
    x FLOAT,
    y FLOAT,
    ingested_at VARCHAR(100),
    traffic_volume_category VARCHAR(100),
    speeding_risk VARCHAR(100),
    is_peak_hour_high_traffic VARCHAR(5)
)
WITH (
    LOCATION = '/transformed-data/traffic_count/',
    DATA_SOURCE = WaRoadData,
    FILE_FORMAT = CsvFormat
);


CREATE EXTERNAL TABLE dbo.traffic_signal_sites (
    x FLOAT,
    y FLOAT,
    site_reference_id VARCHAR(100),
    signal_type VARCHAR(100),
    node_id INT,
    node_name INT,
    node_descr VARCHAR(255),
    service_status VARCHAR(100),
    objectid INT,
    globalid VARCHAR(100),
    ingested_at VARCHAR(100)
)
WITH (
    LOCATION = '/transformed-data/traffic_signal_sites/',
    DATA_SOURCE = WaRoadData,
    FILE_FORMAT = CsvFormat
);


-- Tableau fails on external tables due to HDFS connection limits or credential issues.
-- creating physical tables instead

CREATE TABLE dbo.traffic_count_physical
WITH (DISTRIBUTION = ROUND_ROBIN)
AS
SELECT * FROM dbo.traffic_count;

CREATE TABLE dbo.roadworks_physical
WITH (DISTRIBUTION = ROUND_ROBIN)
AS
SELECT * FROM dbo.roadworks;

CREATE TABLE dbo.legal_speed_limits_physical
WITH (DISTRIBUTION = ROUND_ROBIN)
AS
SELECT * FROM dbo.legal_speed_limits;

CREATE TABLE dbo.traffic_signal_sites_physical
WITH (DISTRIBUTION = ROUND_ROBIN)
AS
SELECT * FROM dbo.traffic_signal_sites;

