-- models/marts/d_customers.sql

{{ config(materialized='table') }}


with
    dim_reason as (
        select
            {{ dbt_utils.generate_surrogate_key(['salesorderid', 'promotion_names_agg']) }} as sk_reason
            , *
        from {{ ref('int_reason_details') }}
    )


select *
from dim_reason