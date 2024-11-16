{{ config(materialized='table') }}

with
    dim_customer as (
        select
            {{ dbt_utils.generate_surrogate_key(['customerid', 'businessentityid', 'fullname']) }} as sk_customer
            , *
        from {{ ref('int_customer_details') }}
    )

select *
from dim_customer