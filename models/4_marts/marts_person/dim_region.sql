{{ config(materialized='table') }}

with
    dim_region as (
        select
            {{ dbt_utils.generate_surrogate_key(['addressid', 'addressline', 'city']) }} as sk_region
            , *
        from {{ ref('int_region_details') }}
    )

select *
from dim_region