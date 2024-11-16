{{ config(materialized='table') }}


with
    dim_product as (
        select
            {{ dbt_utils.generate_surrogate_key(['productid']) }} as sk_product
            , *
        from {{ ref('int_product_details') }}
    )

select *
from dim_product