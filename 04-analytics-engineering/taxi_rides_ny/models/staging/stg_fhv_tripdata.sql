
{{ config(materialized='view') }}

with tripdata as 
(
  select *
    -- row_number() over(partition by dispatching_base_num, pickup_datetime) as rn
  from {{ source('staging','raw_fhv_tripdata') }}
  where dispatching_base_num is not null 
)
select
    -- identifiers
    -- {{ dbt_utils.generate_surrogate_key(['vendorid', 'lpep_pickup_datetime']) }} as tripid,
    {{ dbt.safe_cast("PUlocationid", api.Column.translate_type("integer")) }} as pickup_locationid,
    {{ dbt.safe_cast("DOlocationid", api.Column.translate_type("integer")) }} as dropoff_locationid,
    
    -- timestamps
    cast(pickup_datetime as timestamp) as pickup_datetime,
    cast(dropOff_datetime as timestamp) as dropoff_datetime,
    
    -- trip info
    dispatching_base_num,
    SR_Flag,
    Affiliated_base_number

from tripdata


-- -- dbt build --select <model_name> --vars '{'is_test_run': 'false'}'
-- {% if var('is_test_run', default=true) %}

--   limit 100

-- {% endif %}