with
    customer as (
        select
            customerid
            , personid
            , storeid
            , territoryid
            , modifieddate
        from {{ source('stg_sales', 'customer') }}
    )

select *
from customer