
### Question 5: Taxi Quarterly Revenue Growth

``` SQL
SELECT 
  year_quarter,
  service_type, 
  quarterly_revenue_total_amount, 
  prev_quarterly_revenue_total_amount, 
  growth
FROM `de-zoomcamp-449723.dbt_dduke.fct_taxi_trips_quarterly_revenue`
WHERE year = 2020
ORDER BY service_type, year, quarter
```


### Question 6: P97/P95/P90 Taxi Monthly Fare

``` SQL
SELECT service_type, year, month, p97, p95, p90
FROM `de-zoomcamp-449723.dbt_dduke.fct_taxi_trips_monthly_fare_p95`
WHERE 1=1
    AND year = 2020
    AND month = 4
ORDER BY service_type, year, month;
```


### Question 7: Top #Nth longest P90 travel time Location for FHV

``` SQL

WITH cte AS (
  SELECT 
        *,
  FROM `de-zoomcamp-449723.dbt_dduke.fct_fhv_monthly_zone_traveltime_p90` 
  WHERE year = 2019
    AND month = 11
    AND pickup_locationid IN (1, 211, 262)
    AND dropoff_locationid <> 264
),
cte_drop AS (
  SELECT  
    *
  FROM    
    cte
  QUALIFY
    DENSE_RANK() OVER(PARTITION BY pickup_locationid ORDER BY p90 DESC) = 2
)
SELECT 
  *
FROM cte_drop
QUALIFY ROW_NUMBER() OVER(PARTITION BY pickup_locationid ORDER BY p90 DESC) = 1

```