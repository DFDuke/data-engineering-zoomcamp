{{ config(materialized='table') }}

WITH cte AS (
  SELECT
    service_type, year, month, fare_amount
  FROM 
    {{ ref('fact_trips') }}
  WHERE
        fare_amount > 0
    AND trip_distance > 0
    AND payment_type_description in ('Cash', 'Credit card')
-- ),
)
-- cte_cont_ntile as (
  SELECT
    service_type, year, month,
    PERCENTILE_CONT(fare_amount, 0.97) OVER (fare_window) as p97,
    PERCENTILE_CONT(fare_amount, 0.95) OVER (fare_window) as p95,
    PERCENTILE_CONT(fare_amount, 0.90) OVER (fare_window) as p90
  FROM cte
  QUALIFY ROW_NUMBER() OVER (fare_window) = 1
  WINDOW fare_window AS (PARTITION BY service_type, year, month)
-- )
-- SELECT service_type, year, month, p97, p95, p90, row_num
-- FROM cte_cont_ntile 
-- WHERE 1=1
--     AND row_num = 1
--     AND year = 2020
--     AND month = 4
ORDER BY service_type, year, month