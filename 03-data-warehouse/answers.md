Setup:

Create and download service account key into .json.
Upload .json credentials to project directory
Create dedicated bucket in object storage
Update load_yellow_taxi_data.py to reference .json credentials and point to new bucket
Execute load_yellow_taxi_data.py to pull data and upload to new bucket

``` bash
python load_yellow_taxi_data.py
```

Create an external table using the Yellow Taxi Trip Records.


``` SQL
-- Create an external table referring to gcs path
CREATE OR REPLACE EXTERNAL TABLE `de-zoomcamp-449723.de_zoomcamp_hw3.external_yellow_tripdata`
OPTIONS (
  format = 'parquet',
  uris = ['gs://de-zoomcamp-449723-bucket_hw3/yellow_tripdata_*']
);
```

Create a (regular/materialized) table in BQ using the Yellow Taxi Trip Records (do not partition or cluster this table).

``` SQL
-- Create a non partitioned table from external table
CREATE OR REPLACE TABLE `de-zoomcamp-449723.de_zoomcamp_hw3.yellow_tripdata_non_partitioned` AS 
SELECT * FROM `de-zoomcamp-449723.de_zoomcamp_hw3.external_yellow_tripdata`;
```


### Question 1

``` SQL
SELECT COUNT(*) FROM de-zoomcamp-449723.de_zoomcamp_hw3.external_yellow_tripdata;
```


### Question 2

``` SQL
SELECT DISTINCT(PULocationID)
FROM de-zoomcamp-449723.de_zoomcamp_hw3.external_yellow_tripdata;
-- This query will process 0 B when run.


SELECT DISTINCT(PULocationID)
FROM de-zoomcamp-449723.de_zoomcamp_hw3.yellow_tripdata_non_partitioned;
-- This query will process 155.12 MB when run.
```


### Question 3

``` SQL
SELECT PULocationID
FROM de-zoomcamp-449723.de_zoomcamp_hw3.yellow_tripdata_non_partitioned;
-- This query will process 155.12 MB when run.


SELECT PULocationID, DOLocationID
FROM de-zoomcamp-449723.de_zoomcamp_hw3.yellow_tripdata_non_partitioned;
-- This query will process 310.24 MB when run.
```


### Question 4

``` SQL
SELECT COUNT(*)
FROM de-zoomcamp-449723.de_zoomcamp_hw3.yellow_tripdata_non_partitioned
WHERE fare_amount = 0;
```


### Question 5

``` SQL
-- Create a partitioned table from external table
CREATE OR REPLACE TABLE `de-zoomcamp-449723.de_zoomcamp_hw3.yellow_tripdata_partitioned_clustered`
PARTITION BY DATE(tpep_dropoff_datetime)
CLUSTER BY VendorID AS
SELECT * FROM `de-zoomcamp-449723.de_zoomcamp_hw3.external_yellow_tripdata`;
```


### Question 6

```SQL
SELECT DISTINCT(VendorID)
FROM de-zoomcamp-449723.de_zoomcamp_hw3.yellow_tripdata_non_partitioned
WHERE DATE(tpep_dropoff_datetime) BETWEEN '2024-03-01' AND '2024-03-15';
-- This query will process 310.24 MB when run.

SELECT DISTINCT(VendorID)
FROM de-zoomcamp-449723.de_zoomcamp_hw3.yellow_tripdata_partitioned_clustered
WHERE DATE(tpep_dropoff_datetime) BETWEEN '2024-03-01' AND '2024-03-15';
-- This query will process 26.84 MB when run.
```