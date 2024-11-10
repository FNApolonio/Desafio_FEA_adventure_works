with
    sales_order as (
        select
            salesorderid
            , salesreasonid
            , modifieddate
        from {{ source('stg_sales', 'salesorderheadersalesreason') }}
    )

select *
from sales_order