-- Load data from Cloud Storage into BigQuery

LOAD DATA INTO trips_data_all.raw_green_tripdata
FROM FILES(
  format='CSV',
  uris=['gs://de-zoomcamp-449723-bucket-hw4/green_tripdata*']
);

LOAD DATA INTO trips_data_all.raw_yellow_tripdata
FROM FILES(
  format='CSV',
  uris=['gs://de-zoomcamp-449723-bucket-hw4/yellow_tripdata*']
);

LOAD DATA INTO trips_data_all.raw_fhv_tripdata
FROM FILES(
  format='CSV',
  uris=['gs://de-zoomcamp-449723-bucket-hw4/fhv_tripdata_2019*']
);