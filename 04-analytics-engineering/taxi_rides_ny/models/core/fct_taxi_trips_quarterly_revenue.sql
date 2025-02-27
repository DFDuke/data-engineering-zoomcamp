{{ config(materialized='table') }}

with trips_data as (
  SELECT 
    -- Revenue grouping 
    year, 
    quarter,
    year_quarter,
    service_type,

    -- Revenue calculation 
    SUM(total_amount) as quarterly_revenue_total_amount

    FROM {{ ref('fact_trips') }}
    GROUP BY 1, 2, 3, 4
)
SELECT 
  curr_year.year,
  curr_year.quarter,
  curr_year.year_quarter,
  curr_year.service_type,
  curr_year.quarterly_revenue_total_amount,
  prev_year.quarterly_revenue_total_amount as prev_quarterly_revenue_total_amount,
  (curr_year.quarterly_revenue_total_amount / prev_year.quarterly_revenue_total_amount) * 100 as growth
FROM trips_data curr_year
  left outer join trips_data prev_year
  ON  prev_year.year = curr_year.year - 1
  AND prev_year.service_type = curr_year.service_type
  AND prev_year.quarter = curr_year.quarter

