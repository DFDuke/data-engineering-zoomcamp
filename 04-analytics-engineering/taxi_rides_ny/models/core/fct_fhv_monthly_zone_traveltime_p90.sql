{{ config(materialized='table') }}

with tripdata as 
(
  select 
    year, 
    month, 
    pickup_locationid, 
    pickup_borough, 
    pickup_zone, 
    dropoff_locationid, 
    dropoff_borough, 
    dropoff_zone, 
    TIMESTAMP_DIFF(dropoff_datetime, pickup_datetime, SECOND) as trip_duration    
  from {{ ref('dim_fhv_trips') }}
)
SELECT
    year, 
    month, 
    pickup_locationid, 
    pickup_borough, 
    pickup_zone, 
    dropoff_locationid, 
    dropoff_borough, 
    dropoff_zone, 
    trip_duration,
    PERCENTILE_CONT(trip_duration, 0.90) OVER (PARTITION BY year, month, pickup_locationid, dropoff_locationid) as p90
FROM tripdata